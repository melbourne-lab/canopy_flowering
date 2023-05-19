# Quick and dirty script for initial looks collecting radiation/transmittance data and modeling it.
# SN init 19 May 2023

library(ggplot2)
library(dplyr)
library(tidyr)
library(rstan)

rm(list = ls())

proc.sensor.dir = 'sensors_and_loggers/processed_data/'

sen.clearsky = dir(proc.sensor.dir) %>%
  grep(pattern = 'plot\\d{1,2}', value = TRUE) %>%
  paste0(proc.sensor.dir, .) %>%
  lapply(FUN = read.csv) %>%
  do.call(what = rbind)

head(sen.clearsky)

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
  )

sen.clearsky = sen.clearsky %>% mutate(wm2 = Cal * volt)

hist(sen.clearsky$wm2)
# good

# Merge in path lengths

sen.clearsky = sen.clearsky %>%
  merge(read.csv('../UAV-b-solar-radiation/calibration/output/elk_isolated_raytrace_pathlens_uav.csv') %>%
          select(plot, Month, Day, Hour, Minute, Half_min, path_length),
        by = c('plot', 'Month', 'Day', 'Hour', 'Minute', 'Half_min')
  )

# Probably should do some aggregation

agg.clearsky = sen.clearsky %>%
  group_by(plot, Month, Day, Hour, Ref_min = 5 + (((Minute + 0.5*Half_min) %/% 5) * 5)) %>%
  summarise(
    wm2 = mean(wm2),
    vwm = var(wm2),
    path_length = mean(path_length),
    east = east[1],
    north = north[1]
  )

# Tower data

c1.tower = read.csv('sensors_and_loggers/data/niwot_USNR1_radiation_2021_5min.csv', header = FALSE)
c1.tower = c1.tower[, c(2:6, 8, 16, 17, 28)]
names(c1.tower) = c("Month", "Day", "Hour", "Minute", "Sec", "Rsw_25m", "Rsw_sp510", "Rsw_sn50", "Rsw_sp510_V")
c1.tower = c1.tower %>% filter(Month %in% 7:10, Hour %in% 8:17)

head(c1.tower)

all.clearsky = merge(
  x = c1.tower %>%
    # correcting for DST
    mutate(Hour = Hour + 1) %>%
    mutate(Ref_min = Minute + 3) %>% #,
    select(-Sec),
  y = agg.clearsky,
  by = c('Month', 'Day', 'Hour', 'Ref_min'), 
  suffixes = c('_c1', '_sp')
)

head(all.clearsky)

all.clearsky = all.clearsky %>% mutate(transm = wm2 / Rsw_25m)

hist(all.clearsky$transm) # hmm... why are there tarnsmittances greater than 1
mean(all.clearsky$transm > 1) # nas...
sum(is.na(all.clearsky$transm))
all.clearsky %>% filter(is.na(transm))
# ah.

all.clearsky = all.clearsky %>% filter(!is.na(Rsw_25m))
all.clearsky %>% filter(transm > 1)
# curious... oh well.

# merge in solar angles and transmittances?
all.clearsky %>% nrow()
all.clearsky %>% distinct(plot) %>% nrow() # can add more!

all.clearsky %>% group_by(Month) %>% summarise(n = n())

all.clearsky %>%
  ggplot(aes(x = Hour + Minute_c1/60, y = transm)) +
  geom_point(aes(colour = Month), size = 0.1) +
  scale_colour_viridis_c(option = 'A') +
  facet_wrap(~ plot)

# ah you know what... those transms > 1 are when sensor 67 was tipped over

all.clearsky %>% filter(transm > 1) %>% distinct(plot)
# and I guess some from plot 57... not sure what's up with this

all.clearsky = all.clearsky %>% filter(transm <= 1)
  
all.clearsky %>%
  ggplot(aes(x = Hour + Ref_min/60, y = transm)) +
  geom_point(aes(colour = Month)) +
  scale_colour_viridis_c(option = 'A') +
  facet_wrap(~ plot) +
  theme_bw()

all.clearsky %>%
  ggplot(aes(x = path_length, y = transm)) +
  geom_point(aes(colour = Month)) +
  scale_colour_viridis_c(option = 'A') +
  facet_wrap(~ plot) +
  theme_bw()

expon.data = list(
  N = nrow(all.clearsky),
  J = length(unique(all.clearsky$plot)),
  s = as.integer(as.factor(all.clearsky$plot)),
  x = all.clearsky$path_length,
  y = all.clearsky$transm,
  sigma_j_scale = 0.05
)

expon.fit = stan(
  file = 'analysis/transmittance_curves/transmittance_multilevel.stan',
  data = expon.data,
  chains = 4,
  cores = 4,
  seed = 40177
)

summary(expon.fit)

expon.df = as.data.frame(expon.fit)

hist(expon.df$k)
exp(mean(expon.df$k)) # 0.151773
quantile(exp(expon.df$k), c(0.025, 0.5, 0.975))

expon.df %>%
  select(contains('beta')) %>%
  gather() %>%
  mutate(refno = gsub('beta|\\[|\\]', '', key)) %>%
  group_by(refno) %>%
  mutate(i = 1:n()) %>%
  ungroup() %>%
  ggplot(aes(x = i, y = value)) +
  geom_line() +
  facet_wrap(~ refno)

expon.df %>%
  select(contains('beta')) %>%
  gather() %>%
  mutate(refno = gsub('beta|\\[|\\]', '', key)) %>%
  ggplot(aes(x = refno, y = value)) +
  geom_point(position = position_jitter(width = 0.5)) +
  scale_y_log10()

expon.df %>%
  select(k) %>%
  mutate(i = 1:nrow(.),
         chain = 1 + (i %/% 1000),
         j = i %% 1000) %>%
  filter(chain < 5) %>%
  ggplot(aes(x = j, y = exp(k))) +
  geom_line(size = 0.5) +
  facet_wrap(~ chain)

kdraws = expon.df %>%
  select(k) %>%
  sample_n(200) %>%
  mutate(draw = 1:200) 

decay.draws = merge(kdraws, expand.grid(draw = 1:200, path_length = 0:40)) %>%
  mutate(transm = exp(-exp(k) * path_length))

all.clearsky %>%
  mutate(plot = factor(plot)) %>%
  ggplot(aes(x = path_length, y = transm)) +
  geom_line(data = decay.draws, aes(group = draw)) +
  geom_point(aes(colour = plot)) +
  theme_bw()

gauss.data = list(
  N = nrow(all.clearsky),
  J = length(unique(all.clearsky$plot)),
  s = as.integer(as.factor(all.clearsky$plot)),
  x = all.clearsky$path_length^2,
  y = all.clearsky$transm,
  sigma_j_scale = 0.05
)

gauss.fit = stan(
  file = 'analysis/transmittance_curves/transmittance_multilevel.stan',
  data = gauss.data,
  chains = 4,
  cores = 4,
  seed = 5705
)

summary(gauss.fit)

gauss.df = as.data.frame(gauss.fit)

hist(exp(gauss.df$k))
exp(mean(gauss.df$k)) # 0.02341669
quantile(exp(gauss.df$k), c(0.025, 0.5, 0.975))

gauss.df %>%
  select(contains('beta')) %>%
  gather() %>%
  mutate(refno = gsub('beta|\\[|\\]', '', key)) %>%
  ggplot(aes(x = refno, y = value)) +
  geom_point(position = position_jitter(width = 0.5)) +
  scale_y_log10()
# similar but smaller in magnitude

gauss.df %>%
  select(k) %>%
  mutate(i = 1:nrow(.),
         chain = 1 + (i %/% 1000),
         j = i %% 1000) %>%
  filter(chain < 5) %>%
  ggplot(aes(x = j, y = exp(k))) +
  geom_line(size = 0.5) +
  facet_wrap(~ chain)
# neat

kdraws = gauss.df %>%
  select(k) %>%
  sample_n(200) %>%
  mutate(draw = 1:200) 

decay.draws = merge(kdraws, expand.grid(draw = 1:200, path_length = 0:40)) %>%
  mutate(transm = exp(-exp(k) * path_length^2))

all.clearsky %>%
  mutate(plot = factor(plot)) %>%
  ggplot(aes(x = path_length, y = transm)) +
  geom_line(data = decay.draws, aes(group = draw)) +
  geom_point(aes(colour = plot)) +
  theme_bw()
# this does look better...
# but really need to get that start point varying (ugh)


gauss.intr.data = list(
  N = nrow(all.clearsky),
  J = length(unique(all.clearsky$plot)),
  s = as.integer(as.factor(all.clearsky$plot)),
  x = all.clearsky$path_length^2,
  y = all.clearsky$transm,
  sigma_g_scale = 0.05
)

gauss.fit = stan(
  file = 'analysis/transmittance_curves/transmittance_multilevel_intercepts.stan',
  data = gauss.intr.data,
  chains = 4,
  cores = 4,
  seed = 5705
)

gauss.fit # these betas look pretty shitty...
hist(as.data.frame(gauss.fit)$b) # lmao