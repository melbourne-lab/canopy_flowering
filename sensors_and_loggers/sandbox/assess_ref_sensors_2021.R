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

# Series in July
ref.sens %>%
  filter(Month_UTC %in% 7) %>%
  filter(plot %in% 'plot6') %>%
  mutate(time = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  # geom_segment(data = . %>% filter(!Minute),
  #              aes(x = time, xend = time,
  #                  y = 0, yend = 60),
  #              size = 0.25, linetype = 3) +
  geom_line() +
  scale_x_continuous(breaks = 8:17) +
  facet_wrap(~ Day_MDT) +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.minor = element_blank())


# Times in August
ref.sens %>%
  filter(Month_UTC %in% 8) %>%
  filter(plot %in% 'plot6') %>%
  mutate(time = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  # geom_segment(data = . %>% filter(!Minute),
  #              aes(x = time, xend = time,
  #                  y = 0, yend = 60),
  #              size = 0.25, linetype = 3) +
  geom_line() +
  scale_x_continuous(breaks = 9:17) +
  facet_wrap(~ Day_MDT) +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.minor = element_blank())

# Times in September
ref.sens %>%
  filter(Month_UTC %in% 9) %>%
  filter(plot %in% 'plot6') %>%
  mutate(time = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  # geom_segment(data = . %>% filter(!Minute),
  #              aes(x = time, xend = time,
  #                  y = 0, yend = 60),
  #              size = 0.25, linetype = 3) +
  geom_line() +
  scale_x_continuous(breaks = 9:17) +
  facet_wrap(~ Day_MDT) +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.minor = element_blank())

# Times in October
ref.sens %>%
  filter(Month_UTC %in% 10) %>%
  filter(plot %in% 'plot6') %>%
  mutate(time = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  # geom_segment(data = . %>% filter(!Minute),
  #              aes(x = time, xend = time,
  #                  y = 0, yend = 60),
  #              size = 0.25, linetype = 3) +
  geom_line() +
  scale_x_continuous(breaks = 9:17) +
  facet_wrap(~ Day_MDT) +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.minor = element_blank())

### Read in reference times

ref.times = read.csv('sensors_and_loggers/processed_data/sensor_reference_times_2021.csv')
# all times are MDT
# Half_hour is NA is full hour is usable, 0/30 if only a respective half hour is usable

# Add in half_hours for those that are whole hour-usable
ref.times = ref.times %>%
  filter(is.na(Half_hour)) %>%
  select(-Half_hour) %>%
  mutate(Half_hour0 = 1, Half_hour30 = 1) %>%
  gather(key = Half_hour, value = val, -c(Month, Day, Hour)) %>%
  mutate(Half_hour = as.numeric(gsub('Half\\_hour', '', Half_hour))) %>%
  select(-val) %>%
  rbind(ref.times %>% filter(!is.na(Half_hour))) %>%
  arrange(Month, Day, Hour, Half_hour)

# write.csv(file = 'sensors_and_loggers/processed_data/processed_ref_times_2021.csv',
#           row.names = FALSE,
#           x = ref.times)

### Plot these to make sure they are okay

# First, need to get the half hour from the ref sensor readings
ref.sens.times = ref.sens %>%
  ungroup() %>%
  rename(Month = Month_UTC,
         Day   = Day_MDT,
         Hour  = Hour_MDT) %>%
  mutate(Half_hour = 30 * as.numeric(Minute < 30)) %>%
  # Now merge, making sure to include all x
  merge(y = ref.times, all.x = FALSE, all.y = TRUE)

nrow(ref.sens.times)
# Hell yeah

# Now plot
ref.sens.times %>%
  mutate(time = Hour + (Minute / 60)) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line(aes(group = interaction(Month, Day, Hour, Half_hour)),
            size = 0.5) +
  scale_x_continuous(breaks = 8:17)
# okay some of these are bad

# Can use range() to catch some of these no?
# range of readings in a half hour shouldn't be greater than 10
# (lol this would have been a good screen anyway...)
ref.sens.times %>%
  group_by(Month, Day, Hour, Half_hour) %>%
  summarise(voltage.range = diff(range(volt))) %>%
  ggplot(aes(x = voltage.range)) +
  geom_histogram(binwidth = 2)
# 6 or 8 as a cutoff

ref.sens.times %>%
  group_by(Month, Day, Hour, Half_hour) %>%
  mutate(voltage.range = diff(range(volt))) %>%
  ungroup() %>%
  mutate(time = Hour + (Minute / 60)) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line(aes(group  = interaction(Month, Day, Hour, Half_hour),
                colour = voltage.range > 5),
            size = 0.5) +
  scale_x_continuous(breaks = 8:17)
  
# 5 looks like a good cutoff

ref.sens.times = ref.sens.times %>%
  group_by(Month, Day, Hour, Half_hour) %>%
  filter(diff(range(volt)) < 5) %>%
  ungroup()

nrow(ref.sens.times)

merge(x = ref.times, y = ref.sens.times,
      all.x = FALSE, all.y = TRUE) %>%
  nrow()

# 9720 minutes... still pretty good

# Export modified ref times list
merge(x = ref.times, y = ref.sens.times,
      all.x = FALSE, all.y = TRUE) %>%
  write.csv(file = 'sensors_and_loggers/processed_data/processed_ref_times_2021.csv',
            row.names = FALSE)

ref.sens.times %>%
  mutate(time = Hour + (Minute / 60)) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line(aes(group = interaction(Month, Day, Hour, Half_hour)),
            size = 0.5) +
  scale_x_continuous(breaks = 8:17)
# okay some of these are bad
