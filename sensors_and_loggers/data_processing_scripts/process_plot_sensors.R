### Script for processing plot (non-reference) 2021 pyranometer scripts
# SN - 19 May 2022

# Packages
library(ggplot2)
library(dplyr)
library(tidyr)

# Clear namespace
rm(list = ls())

# save sensor directory name
sensor.dir = 'sensors_and_loggers/data/'

# Okay... let's just look at the number of loggers we have.
read.csv('sensors_and_loggers/sensor_logger_masterlist_2021.csv')

ref.times = read.csv('sensors_and_loggers/processed_data/processed_ref_times_2021.csv')

#################################################################
##### Plot 2 ####################################################
#################################################################

# Read in CSVs
this.plot.data = paste0(sensor.dir, grep('plot2\\_', dir(sensor.dir), value = TRUE)) %>%
  grep(pattern = 'raw', x = ., value = TRUE) %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = x)) %>%
  do.call(what = rbind) %>%
  # Get only pyranometer readings
  filter(Sensor_ID %in% c('pyran')) %>%
  spread(key = Reading_type, value = Reading_raw) %>%
  # Add correct time
  mutate(Hour = (Hour_UTC - 6) %% 24,
         Day  = Day_UTC - as.logical(Hour > Hour_UTC)) %>%
  # Filter to only daylight hours
  filter(Hour %in% 8:17) %>%
  # Rename month column
  rename(Month = Month_UTC) %>%
  # Add proper plot name (might not be needed)
  mutate(fn = gsub('sensors\\_and\\_loggers\\/data\\/', '', fn),
         fn = gsub('\\-', '', fn),
         fn = gsub('\\_\\d{8}|\\_raw\\.TXT', '', fn)) %>%
  # Get rid of unnecessary columns
  select(-c(Hour_UTC, Day_UTC, Sensor_ID, ` bits`)) %>%
  # Prepare voltage
  rename(volt = ` volt`) %>%
  group_by(Month, Day, Hour, Minute, fn) %>% 
  summarise(volt = mean(as.numeric(volt)))

nrow(this.plot.data)
# Very nice

# Now, should go through and remove days where sensor was knocked over
this.plot.data %>%
  mutate(time = Hour + Minute/60) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ paste0(Month, '/', Day))

# These all actually look like they would be fine.

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = TRUE
)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot2_pyran_clearsky_2021.csv',
          row.names = FALSE)

#################################################################
##### Plot 16 ###################################################
#################################################################

# Read in CSVs
this.plot.data = paste0(sensor.dir, grep('plot16\\_', dir(sensor.dir), value = TRUE)) %>%
  grep(pattern = 'raw', x = ., value = TRUE) %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = x)) %>%
  do.call(what = rbind) %>%
  # Get only pyranometer readings
  filter(Sensor_ID %in% c('pyran')) %>%
  spread(key = Reading_type, value = Reading_raw) %>%
  # Add correct time
  mutate(Hour = (Hour_UTC - 6) %% 24,
         Day  = Day_UTC - as.logical(Hour > Hour_UTC)) %>%
  # Filter to only daylight hours
  filter(Hour %in% 8:17) %>%
  # Rename month column
  rename(Month = Month_UTC) %>%
  # Add proper plot name (might not be needed)
  mutate(fn = gsub('sensors\\_and\\_loggers\\/data\\/', '', fn),
         fn = gsub('\\-', '', fn),
         fn = gsub('\\_\\d{8}|\\_raw\\.TXT', '', fn)) %>%
  # Get rid of unnecessary columns
  select(-c(Hour_UTC, Day_UTC, Sensor_ID, ` bits`)) %>%
  # Prepare voltage
  rename(volt = ` volt`) %>%
  group_by(Month, Day, Hour, Minute, fn) %>% 
  summarise(volt = mean(as.numeric(volt)))

nrow(this.plot.data)

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# Looks fine

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = TRUE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot16_pyran_clearsky_2021.csv',
          row.names = FALSE)

#################################################################
##### Plot 19 ###################################################
#################################################################

# Read in CSVs
this.plot.data = paste0(sensor.dir, grep('plot19\\_', dir(sensor.dir), value = TRUE)) %>%
  grep(pattern = 'raw', x = ., value = TRUE) %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = x)) %>%
  do.call(what = rbind) %>%
  # Get only pyranometer readings
  filter(Sensor_ID %in% c('pyran')) %>%
  spread(key = Reading_type, value = Reading_raw) %>%
  # Add correct time
  mutate(Hour = (Hour_UTC - 6) %% 24,
         Day  = Day_UTC - as.logical(Hour > Hour_UTC)) %>%
  # Filter to only daylight hours
  filter(Hour %in% 8:17) %>%
  # Rename month column
  rename(Month = Month_UTC) %>%
  # Add proper plot name (might not be needed)
  mutate(fn = gsub('sensors\\_and\\_loggers\\/data\\/', '', fn),
         fn = gsub('\\-', '', fn),
         fn = gsub('\\_\\d{8}|\\_raw\\.TXT', '', fn)) %>%
  # Get rid of unnecessary columns
  select(-c(Hour_UTC, Day_UTC, Sensor_ID, ` bits`)) %>%
  # Prepare voltage
  rename(volt = ` volt`) %>%
  group_by(Month, Day, Hour, Minute, fn) %>% 
  summarise(volt = mean(as.numeric(volt)))

head(this.plot.data)
nrow(this.plot.data)

# Ah... haven't done the 

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# Looks fine