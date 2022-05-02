# exploring sensor data from 2021
# here: looking at sensors 2, 6 to assess as reference sensors
# 28 april 2022

library(ggplot2)
library(tidyr)
library(dplyr)

sensor.dir = 'sensors_and_loggers/data/'

# Read in data from sensors 2 and 6
ref.sens = paste0(sensor.dir, grep('plot[26]\\_', dir(sensor.dir), value = TRUE)) %>%
  grep(pattern = 'raw', x = ., value = TRUE) %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = x)) %>%
  do.call(what = rbind)

# Isolate pyranometer readings and MDT daylight hours
ref.sens = ref.sens %>%
  filter(Sensor_ID %in% c('pyran')) %>%
  spread(key = Reading_type, value = Reading_raw) %>%
  mutate(Hour_MDT = (Hour_UTC - 6) %% 24,
         Day_MDT  = Day_UTC - as.logical(Hour_MDT > Hour_UTC)) %>%
  filter(Hour_MDT %in% 8:17)

# Isolate plot name
ref.sens = ref.sens %>%
  mutate(fn = gsub('sensors\\_and\\_loggers\\/data\\/', '', fn),
         fn = gsub('\\-', '', fn),
         fn = gsub('\\_\\d{8}|\\_raw\\.TXT', '', fn))

# Get rid of unnecessary columns
ref.sens = ref.sens %>% select(-c(Hour_UTC, Day_UTC, Sensor_ID, ` bits`))

# Get average reading by minute
ref.sens = ref.sens %>%
  rename(volt = ` volt`) %>%
  group_by(Month_UTC, Day_MDT, Hour_MDT, Minute, fn) %>% 
  summarise(volt = mean(as.numeric(volt)))

# How many days?
ref.sens %>%
  ungroup() %>%
  distinct(Month_UTC, Day_MDT) %>%
  nrow()
# 91! woke

ref.sens %>%
  filter(Month_UTC %in% 8) %>%
  # filter(plot %in% 'plot6') %>%
  mutate(time = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line(aes(colour = fn)) +
  facet_wrap(~ Day_MDT)

# interesting... it looks like 6 is a better overall reference sensor

ref.sens = ref.sens %>% filter(fn %in% 'plot6') %>% rename(plot = fn)

ref.sens %>%
  filter(Month_UTC %in% 8) %>%
  # filter(plot %in% 'plot6') %>%
  mutate(time = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line(aes(group = Day_MDT))
# interesting/winteresting

ref.sens %>%
  filter(Month_UTC %in% 8) %>%
  filter(plot %in% 'plot6') %>%
  mutate(time = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Day_MDT)

ref.sens %>%
  filter(Month_UTC %in% 8, plot %in% 'plot6') %>%
  group_by(Day_MDT, Hour_MDT, Half_hour = Min %/% 30) %>%
  