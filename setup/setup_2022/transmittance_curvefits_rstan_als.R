# Script looking at modeling exponential decay (incl. gaussian decay)
# using Rstan 
# on ALS-derived 1m point cloud
#
# modified from UAV-b-solar-radiation script (Nov. 2021)
# SN - 22 May 2022

# Packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(rstan)

# clear namespace
rm(list = ls())

# Read in path lengths and transmittances (estimated from raytrace)

transms = read.csv('setup/setup_2022/musselman_calibration_path_lens_052122.csv')

head(transms)

str(transms)

apply(transms, 2, function(x) sum(is.na(x)))
# no NAs - very nice.


# Plot data

# Transmittance over time series
transms %>%
  mutate(Half.hour = Minute < 30,
         time = Hour + Minute / 60) %>%
  ggplot(aes(x = time, y = transm)) +
  geom_line(
    aes(
      group  = interaction(Month, Day, Hour, Half.hour),
      colour = factor(Month)
    ),
    size = 0.2
  ) +
  scale_color_brewer(palette = 'Set3') +
  facet_wrap(~ Plot)

# Okay - looks like some of the data from plots 67 and 39 are sus

transms %>%
  filter(Plot %in% 39) %>%
  ggplot(aes(x = transm)) +
  geom_density(aes(colour = factor(Month)))
# suspicious of this peak around 0.2
# 

transms %>%
  filter(Plot %in% 39) %>%
  mutate(Half.hour = Minute < 30,
         time = Hour + Minute / 60) %>%
  ggplot(aes(x = time, y = transm)) +
  geom_line(
    aes(
      group  = interaction(Month, Day, Hour, Half.hour),
      colour = factor(Month)
    ),
    size = 0.2
  )
# haha... what the heck?
# okay... looking at the raw sensor data, for some reason during the day the sensor never has readings of zero??
# probably should just remove these (nooooo!!!)

transms = transms %>% filter(!Plot %in% 39)

# Plot 67: there's one day where weird stuff is happening...

transms %>%
  filter(Plot %in% 67) %>%
  mutate(Half.hour = Minute < 30,
         time = Hour + Minute / 60) %>%
  ggplot(aes(x = time, y = transm)) +
  geom_line(
    aes(
      group  = interaction(Month, Day, Hour, Half.hour),
      colour = factor(Month)
    ),
    size = 0.2
  )
# a day in July (probably tipped over and I did a bad job of removing it

transms %>%
  filter(Plot %in% 67, Month %in% 7) %>%
  mutate(Half.hour = Minute < 30,
         time = Hour + Minute / 60) %>%
  ggplot(aes(x = time, y = transm)) +
  geom_line(
    aes(
      group  = interaction(Month, Day, Hour, Half.hour),
      colour = factor(Month)
    ),
    size = 0.2
  ) +
  facet_wrap(~ Day)
# yes - it was tipped over in the morning of July 26 and re-leveled later that day

# Remove these
transms = transms %>% filter(!(Plot %in% 67 & Month %in% 7 & Day %in% 26 & Hour < 13))

# But also - looking at this, the July/August AM readings are low, September PM readings low...
# something bizarre happening here
# Ugh... just remove it I guess.

transms = transms %>% filter(!Plot %in% 67)

# Similarly... 33 and 22 also have some instances where transmittance is greater than zero...
# OH... wait is this due to the aspens?
# Not seeing the same issue in 77? 
# If it was an aspen leaf-off issue though... would we see it in September?

transms %>%
  filter(Plot %in% 22) %>%
  mutate(Half.hour = Minute < 30,
         time = Hour + Minute / 60) %>%
ggplot(aes(x = time, y = transm)) +
  geom_line(
    aes(
      group  = interaction(Month, Day, Hour, Half.hour),
      colour = factor(Month)
    ),
    size = 0.2
  ) +
  facet_wrap(~ Month)
# hmm... not looking great...

transms %>%
  filter(Plot %in% 33) %>%
  mutate(Half.hour = Minute < 30,
         time = Hour + Minute / 60) %>%
  ggplot(aes(x = time, y = transm)) +
  geom_line(
    aes(
      group  = interaction(Month, Day, Hour, Half.hour),
      colour = factor(Month)
    ),
    size = 0.2
  ) +
  facet_wrap(~ Month)
# Also looks bad
# What was happening here?? Board temperature? Glare??

###

transms %>%
  ggplot(aes(x = path_length, y = transm)) +
  geom_point(alpha = 0.1, position = position_jitter(width = 0.25))
# Doesn't look great

# Set transmittances above 1 to be 1
transms = transms %>% mutate(transm = ifelse(transm > 1, 1, transm))

transms %>%
  ggplot(aes(x = path_length, y = transm)) +
  geom_point(alpha = 0.01, position = position_jitter(width = 0.25))
# really interesting and not reassuring...

transms %>%
  ggplot(aes(x = path_length, y = transm)) +
  geom_point(alpha = 0.1, position = position_jitter(width = 0.25)) +
  facet_wrap(~ Plot)
# also some weird artifacting in 22, 57, 70, 2, ...
# shit
# oh well

# remove negative transmittances
transms = transms %>% mutate(transm = ifelse(transm < 0, min(transm[transm > 0]), transm))

##### Model fitting in Stan

### Hierarchical guassian

transm.gauss.ml.data = list(
    N = nrow(transms),
    J = length(unique(transms$Plot)),
    s = as.integer(as.factor(transms$Plot)),
    x = transms$path_length^2,
    y = transms$transm,
    sigma_j_scale = 0.005
)

gauss.ml.fit = stan(
    file = 'setup/setup_2022/transmittance_multilevel.stan',
    data = transm.gauss.ml.data,
    chains = 4,
    cores  = 4,
    seed   = 444
)
# ahhhh man this is taking an eternity to run...
# (1650 seconds?)

# Low effective pop size - could possibly be fixed with more iterations?

gauss.ml.fit
# one of these is very bad - likely plots 25 and 75?

gauss.ml.df = as.data.frame(gauss.ml.fit)
apply(gauss.ml.df, 2, mean) %>% round(3)

gauss.ml.df %>%
    select(contains('beta')) %>%
    gather() %>%
    ggplot(aes(x = key, y = value)) +
    scale_y_log10() +
    geom_point(position = position_jitter(width = 0.25), alpha = 0.75)
# man... looking pretty bad!

# E.g., sensor 11
gauss.ml.df %>%
    select(`beta[11]`) %>%
    mutate(i = 1:4000) %>%
    ggplot(aes(x = i, y = `beta[11]`)) +
    geom_line(size = 0.1) +
    scale_x_continuous(breaks = (1:3)*1000) +
    scale_y_log10()
# Very weird. Looks like the t distribution just pulling out insanely high beta values...

gauss.param.means = gauss.ml.fit %>% 
    as.data.frame() %>%
    gather() %>% 
    group_by(key) %>% 
    summarise(mean.val = mean(value))

gauss.param.means

gauss.sensor.ests = merge(
    x = gauss.param.means %>% mutate(key = gsub('beta|\\[|\\]', '', key)),
    y = expand.grid(s = 1:14, x = 0:50),
    by.x = 'key', by.y = 's'
) %>%
    mutate(# g.rate = exp(-exp(gauss.param.means$mean.val[gauss.param.means$key %in% 'k'])),
           g.rate1 = exp(gauss.param.means$mean.val[gauss.param.means$key %in% 'k']),
           g.rate2 = gauss.ml.df %>% 
             mutate(logno.mean = exp(k + sigma_j^2 / 2)) %>% 
             summarise(mm = mean(logno.mean)) %>% 
             unlist(),
           g.pred1 = exp(-g.rate1 * x^2),
           g.pred2 = exp(-g.rate2 * x^2),
           s.pred = exp(-mean.val * x^2)) %>%
  merge(y = transms %>% select(Plot) %>% mutate(key = as.integer(as.factor(Plot))))

gauss.sensor.ests %>%
  ggplot(aes(x = x)) +
  geom_point(data = transms, aes(x = path_length, y = transm, colour = factor(Plot)),
             position = position_jitter(width = 0.5),
             alpha = 0.1) +
  geom_line(aes(y = g.pred1, group = key)) +
  geom_line(aes(y = g.pred2, group = key), linetype = 3)

gauss.sensor.ests %>%
  ggplot(aes(x = x, y = g.pred2)) +
  geom_point(
    data = transms,
    aes(x = path_length, y = transm, colour = factor(Hour)),
    alpha = 0.1
  ) +
  geom_line(
    aes(group = Plot),
    linetype = 2
  ) +
  geom_line(
    aes(x = x, y = s.pred)
  ) +
  scale_colour_brewer(palette = 'Set3') +
  facet_wrap(~ Plot)

### Hierarchical exponential

transm.expon.ml.data = list(
    N = nrow(transms),
    J = length(unique(transms$Plot)),
    s = as.integer(as.factor(transms$Plot)),
    x = transms$path_length,
    y = transms$transm,
    sigma_j_scale = 0.005
)

expon.ml.fit = stan(
    file = 'setup/setup_2022/transmittance_multilevel.stan',
    data = transm.expon.ml.data,
    chains = 4,
    cores  = 4,
    seed   = 77920
)

expon.ml.fit

expon.ml.df = as.data.frame(expon.ml.fit)
apply(expon.ml.df, 2, mean) %>% round(3)

expon.ml.df %>%
  select(contains('beta')) %>%
  gather() %>%
  ggplot(aes(x = key, y = value)) +
  scale_y_log10() +
  geom_point(position = position_jitter(width = 0.25), alpha = 0.75)
# okay there is a single high value...


expon.param.means = expon.ml.fit %>% 
  as.data.frame() %>%
  gather() %>% 
  group_by(key) %>% 
  summarise(mean.val = mean(value))

expon.sensor.ests = merge(
  x = expon.param.means %>% mutate(key = gsub('beta|\\[|\\]', '', key)),
  y = expand.grid(s = 1:14, x = 0:50),
  by.x = 'key', by.y = 's'
) %>%
  mutate(# g.rate = exp(-exp(gauss.param.means$mean.val[gauss.param.means$key %in% 'k'])),
    g.rate = exp(expon.param.means$mean.val[expon.param.means$key %in% 'k']),
    g.pred = exp(-g.rate * x^2),
    s.pred = exp(-mean.val * x^2)) %>%
  merge(y = transms %>% select(Plot) %>% mutate(key = as.integer(as.factor(Plot))))

expon.sensor.ests %>%
  ggplot(aes(x = x, y = g.pred)) +
  geom_point(data = transms, aes(x = path_length, y = transm, colour = factor(Plot)),
             position = position_jitter(width = 0.5),
             alpha = 0.1) +
  geom_line(aes(group = key))

expon.sensor.ests %>%
  ggplot(aes(x = x, y = g.pred)) +
  geom_point(
    data = transms,
    aes(x = path_length, y = transm),
    colour = 'blue', alpha = 0.1
  ) +
  geom_line(
    aes(group = Plot),
    linetype = 2
  ) +
  geom_line(
    aes(x = x, y = s.pred)
  ) +
  facet_wrap(~ Plot)

# I like the Gaussian better...
