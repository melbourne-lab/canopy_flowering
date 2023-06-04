### Script for estimating transmittance of light through canopy
# Inputs: field sensor data, reference sensor data (Ameriflux),
#         estimated occupied voxel traversal at given sensor readings
# Output: parameter estimating relationship between voxel traversal and light
#         transmittance
# Procedure: fitting a beta regression model coded in Stan
# 
# SN - 4 Jun 2023
# based on script `merge_model_clearsky_transms_...`

# Load packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(rstan)

# Clear namespace
rm(list = ls())

# Make sure select function is coming from dplyr
select = dplyr::select

# Data with all of the field sensor data
proc.sensor.dir = 'sensors_and_loggers/processed_data/'

# Read in all of the processed sensor data from directory
# (n.b., so far this is just reading in 2021 data)
sen.clearsky = dir(proc.sensor.dir) %>%
  grep(pattern = 'plot\\d{1,2}', value = TRUE) %>%
  paste0(proc.sensor.dir, .) %>%
  lapply(FUN = read.csv) %>%
  do.call(what = rbind)

# Check to make sure this is good
head(sen.clearsky)

# Merge with sensor IDs (SP510s) and read in calibration factors for each
sen.clearsky = merge(
  sen.clearsky,
  read.csv('sensors_and_loggers/sensor_logger_masterlist_2021.csv') %>%
    select(SP510, Plot),
  by.x = 'plot', by.y = 'Plot'
) %>%
  # One logger was swapped halfway through the season
  mutate(SP510 = ifelse(plot %in% 25 & (Month %in% 7 | (Month %in% 8 & Day < 4)),
                        1650, SP510)) %>%
  merge(
    read.csv('sensors_and_loggers/SP510_calibration_factors.csv') %>%
      select(Sensor_ID, Calibration_factor_W_m..2_per_mV) %>%
      rename(SP510 = Sensor_ID, Cal = Calibration_factor_W_m..2_per_mV)
  ) %>% 
  # Estimate watts/m2 for each reading
  mutate(wm2 = Cal * volt)

# Check that readings are roughly between 0 and 1000 w/m2
hist(sen.clearsky$wm2)

# Merge in path length data
# (occupied voxels in discretized point cloud that light passes through for each
# sensor location at each reading time)
# (CSV is output from UAV-solar-radiation repo)
sen.clearsky = sen.clearsky %>%
  merge(read.csv('analysis/transmittance_curves/elk_isolated_raytrace_pathlens_uav.csv') %>%
          select(plot, Month, Day, Hour, Minute, Half_min, path_length),
        by = c('plot', 'Month', 'Day', 'Hour', 'Minute', 'Half_min')
  )

# Aggregate clearsky to the five-minute level, matching resolution of Ameriflux data
agg.clearsky = sen.clearsky %>%
  group_by(plot, Month, Day, Hour, Ref_min = 5 + (((Minute + 0.5*Half_min) %/% 5) * 5)) %>%
  summarise(
    # Mean transmittance and path length (voxel traversal) in each 5min window
    wm2 = mean(wm2),
    path_length = mean(path_length),
    east = east[1],
    north = north[1]
  )

# Read in Ameriflux USNR1 data
c1.tower = read.csv('sensors_and_loggers/data/niwot_USNR1_radiation_2021_5min.csv', header = FALSE) %>%
  select(paste0('V', c(2:6, 8))) %>%
  rename(Month = V2, Day = V3, Hour = V4, Minute = V5, Sec = V6, Rsw_25m = V8) %>%
  filter(Month %in% 7:10, Hour %in% 8:18)

# Check this data looks good
head(c1.tower)

# Merge together field readings and reference sensor readings
all.clearsky = merge(
  x = c1.tower %>%
    # correcting for DST
    mutate(Hour = Hour + 1) %>%
    # Match up middle minute of window
    mutate(Ref_min = Minute + 3) %>% #,
    # No need for seconds (all fields are 30)
    select(-Sec),
  y = agg.clearsky,
  by = c('Month', 'Day', 'Hour', 'Ref_min')
)

all.clearsky = all.clearsky %>%
  # Estimate transmittance (observed divided by reference readings)
  mutate(transm = wm2 / Rsw_25m) %>%
  # Some of these readings are negative or greater than one (sensor recording
  # error or misalignment)
  filter(transm > 0, transm < 1)

head(all.clearsky)
nrow(all.clearsky)

# Plot of raw data

all.clearsky %>%
  mutate(Hour = Hour + Ref_min / 60) %>%
  ggplot(aes(x = Hour, y = transm)) +
  geom_point(aes(colour = path_length)) +
  scale_colour_viridis_c(trans = 'reverse') +
  facet_wrap(~ plot)

all.clearsky %>%
  ggplot(aes(x = path_length, y = transm)) +
  geom_point(aes(colour = Hour), size = 0.2) +
  scale_colour_viridis_c() +
  facet_wrap(~ plot)

##### Prepare model fit

# Prepare data for stan model
expon.data = all.clearsky %>%
  filter(path_length > 0) %>%
  list(
    N = nrow(.),
    J = length(unique(.$plot)),
    s = as.integer(as.factor(.$plot)),
    x = .$path_length,
    y = .$transm
  )

# Fit model
expon.fit = stan(
  file = 'analysis/transmittance_curves/transmittance_multilevel_betareg.stan',
  data = expon.data,
  chains = 4,
  cores = 4,
  seed = 5705
)

# Look at output
summary(expon.fit)

expon.df = expon.fit %>% as.data.frame()

# Plot sensor-level random effects
expon.df %>%
  select(contains('beta[')) %>%
  gather() %>%
  mutate(refno = gsub('beta|\\[|\\]', '', key)) %>%
  ggplot(aes(x = refno, y = value)) +
  geom_point(position = position_jitter(width = 0.5)) +
  scale_y_log10()
# Looks good to me

# Histogram of mean transmittances
# (lognormal mean of draws from lognormal)
expon.df %>%
  select(mu_decay, sigma_j) %>%
  mutate(ln.mean = exp(mu_decay + sigma_j^2/2)) %>%
  ggplot(aes(x = ln.mean)) +
  geom_histogram(binwidth = 0.01) +
  geom_segment(
    aes(
      x    = exp(mean(mu_decay) + mean(sigma_j)^2/2),
      xend = exp(mean(mu_decay) + mean(sigma_j)^2/2),
      y = 0, yend = 500
    ),
    colour = 'red'
  )
# There is a bit of a jheavy tail here

# Bivariate plot of scale and shape parameters
# red dot is arithmetic mean
expon.df %>%
  select(mu_decay, sigma_j) %>%
  ggplot(aes(x = mu_decay, y = sigma_j)) +
  geom_point(alpha = 0.5) +
  geom_point(aes(x = mean(mu_decay), y = mean(sigma_j)), colour = 'red', size = 5)

# Get mean transmittance (mean of lognormal)
expon.df %>%
  select(mu_decay, sigma_j) %>%
  summarise(decay.rate = exp(mean(mu_decay) + mean(sigma_j)^2/2))

# Get some posterior draws for each sensor

set.seed(5012)

mean.kdraws = expon.df %>%
  select(mu_decay, sigma_j) %>%
  sample_n(200) %>%
  mutate(draw = 1:200, k = exp(mu_decay + sigma_j^2/2))

decay.draws = merge(mean.kdraws, expand.grid(draw = 1:200, path_length = 0:30)) %>%
  mutate(pred.transm = exp(-path_length * k))

beta.means = expon.df %>%
  select(contains('beta[')) %>%
  apply(2, mean) %>%
  data.frame(
    plot = names(.),
    mean.beta = .
  ) %>%
  mutate(plot = gsub('beta\\[|\\]', '', plot))

beta.curves = merge(beta.means, expand.grid(plot.id = 1:nrow(beta.means), path_length = 0:30)) %>%
  mutate(pred.transm = exp(-mean.beta * path_length))

all.clearsky %>%
  mutate(plot = as.integer(as.factor(plot))) %>%
  ggplot() +
  geom_point(
    aes(x = path_length, y = transm),
    alpha = 0.5
  ) +
  geom_line(
    data = decay.draws,
    aes(x = path_length, y = pred.transm, group = draw),
    linewidth = 0.1, colour = 'green'
  ) +
  geom_line(
    data = beta.curves,
    aes(x = path_length, y = pred.transm, group = plot.id),
    linewidth = 1.2, linetype = 2, colour = 'deepskyblue'
  ) +
  labs(x = 'Occupied voxels traversed', y = 'Transmittance') +
  facet_wrap(~ as.numeric(plot)) +
  theme(
    panel.background = element_blank()
  )

ggsave('analysis/figures_etc/fig_out/transmittance_plot.png',
       width = 8, height = 8)
