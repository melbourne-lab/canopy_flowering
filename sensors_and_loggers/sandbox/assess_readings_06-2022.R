library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls())

data.dir = 'sensors_and_loggers/data/'

all.data = grep('2022-06', dir(data.dir), value = TRUE) %>%
  lapply(function(x) read.csv(paste0(data.dir, x)) %>% mutate(fn = x)) %>%
  do.call(what = rbind)

all.data = all.data %>%
  mutate(plot = gsub('\\_\\d{4}\\-\\d{2}-\\d{2}|raw\\.TXT|\\_', '', fn)) %>%
  select(-fn)

all.data = all.data %>% filter(!grepl('TEROS', Sensor_ID))

all.data = all.data %>%
  mutate(Day  = Day_UTC + as.logical(Hour_UTC < 6),
         Hour = (Hour_UTC - 6) %% 24) 

head(all.data)

### Solar radiation

all.solar = all.data %>% 
  filter(Sensor_ID %in% 'SP510', Reading_type %in% 'volt') %>%
  mutate(plot = as.numeric(gsub('plot', '', plot))) %>%
  merge(y = read.csv('sensors_and_loggers/sensor_logger_masterlist_2022.csv') %>%
          select(Plot, SP510),
        by.x = 'plot', by.y = 'Plot') %>%
  merge(y = read.csv('sensors_and_loggers/SP510_calibration_factors.csv') %>%
          select(Sensor_ID, Calibration_factor_W_m..2_per_mV) %>%
          rename(SP510 = Sensor_ID, cal = Calibration_factor_W_m..2_per_mV)) %>%
  mutate(wm2 = Reading_raw * cal)

all.solar %>%
  mutate(time = Hour + Minute / 60) %>%
  group_by(plot, Day, time) %>%
  summarise(mean.wm2 = mean(wm2)) %>%
  ggplot(aes(x = time, y = mean.wm2)) +
  geom_line(aes(colour = factor(plot))) +
  facet_wrap(~Day)

# looks great!

### Soil moisture

all.moist = all.data %>%
  filter(Reading_type %in% 'mois') %>%
  mutate(VWC = (3.879e-4)*Reading_raw - 0.6956)

all.moist %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_line(aes(colour = factor(plot))) +
  facet_wrap(~ Day > 14, nrow = 2, scale = 'free_x') +
  theme(legend.position = 'bottom')

# should de-noise plot 164 (sun?)

### Soil temperature

all.stemp = all.data %>% filter(grepl('^T11', Sensor_ID), Reading_type %in% 'temp')
  
all.stemp %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line(aes(colour = factor(plot))) +
  facet_wrap(~ Day > 14, nrow = 2, scale = 'free_x') +
  theme(legend.position = 'bottom')
# should also figure out a way to fix negative readings...

### Battery levels

all.batts = all.data %>% filter(grepl('batt', Sensor_ID))

all.batts %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line(aes(colour = factor(plot))) +
  facet_wrap(~ Day > 14, nrow = 2, scale = 'free_x') +
  theme(legend.position = 'bottom')

# amazing
