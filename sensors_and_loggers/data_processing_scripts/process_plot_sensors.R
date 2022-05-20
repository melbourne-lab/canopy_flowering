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
read.csv('sensors_and_loggers/sensor_logger_masterlist_2021.csv') %>% arrange(Plot)

ref.times = read.csv('sensors_and_loggers/processed_data/processed_ref_times_2021.csv')

# Some notes, observations...
# - Plot 25: note that there was an SP510 replacement during this time
# - Plot 33: the timer here got messed up - multiple times! - so Aug.
#            measurements will need adjustments
# 

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
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

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
  all.x = FALSE, all.y = FALSE
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

# Ah... haven't done the final set of readings (Sept/Oct) yet

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# Looks fine
# (albeit missing last round)

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot19_pyran_clearsky_2021.csv',
          row.names = FALSE)


#################################################################
##### Plot 22 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot22\\_', dir(sensor.dir), value = TRUE)) %>%
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

# Ah... haven't done the final set of readings (Sept/Oct) yet

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# Looks great (and probably have all of the data!)

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot22_pyran_clearsky_2021.csv',
          row.names = FALSE)


#################################################################
##### Plot 25 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot25\\_', dir(sensor.dir), value = TRUE)) %>%
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

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# hmm... some of these look strange
# 7/31, 8/3, 8/4
# (notes say there was a "hiccup" somewhere in August?)

ref.times %>%
  filter(as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d') %in%
           c(as.Date('2021-07-31', format = '%Y-%m-%d'),
             as.Date('2021-08-03', format = '%Y-%m-%d'),
             as.Date('2021-08-04', format = '%Y-%m-%d')))
# ah - no readings during this time...
# well, to be safe...

this.plot.data = this.plot.data %>%
  filter(! (as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d') %in%
              c(as.Date(paste0('2021-07-', 30:31), format = '%Y-%m-%d'),
                as.Date(paste0('2021-08-', 1:4), format = '%Y-%m-%d'))))

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)

###################################
######## OH... IMPORTANT NOTE######
###################################

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

# SP510s were swapped in here (I guess due to destruction or something?)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot25_pyran_clearsky_2021.csv',
          row.names = FALSE)


#################################################################
##### Plot 33 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot33\\_', dir(sensor.dir), value = TRUE)) %>%
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

# Okay there was some bad stuff that happened in here... let's see what it looks like
this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)

### ???? what the fuck?
# between 7/15 and 7/19 I have that the plot was "annihilated" (bear? elk?)
# plot 7.22 the plot was not properly levelled...
# ahhh... I bet this is with the messed up timer?
# wow - was the timer just totally bogus for the entire month of August?

paste0(sensor.dir, grep('plot33\\_', dir(sensor.dir), value = TRUE)) %>%
  grep(pattern = 'raw', x = ., value = TRUE) %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = x)) %>%
  do.call(what = rbind) %>%
  # Get only pyranometer readings
  filter(Sensor_ID %in% c('pyran')) %>%
  spread(key = Reading_type, value = Reading_raw) %>%
  # Add correct time
  mutate(Hour = (Hour_UTC - 6) %% 24,
         Day  = Day_UTC - as.logical(Hour > Hour_UTC)) %>%
  # Rename month column
  rename(Month = Month_UTC) %>%
  # Get rid of unnecessary columns
  select(-c(Hour_UTC, Day_UTC, Sensor_ID, ` bits`, fn)) %>%
  # Prepare voltage
  rename(volt = ` volt`) %>%
  group_by(Month, Day, Hour, Minute) %>% 
  summarise(volt = mean(as.numeric(volt))) %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)

# timer shift meant that in August and a couple of other points the measurements
# were all shifted by what looks like 12 hours...


# Only take 7/15 and 9/1 - 9/19 data 
# (we can fix the rest later)
this.plot.data = this.plot.data %>%
  filter(Month %in% c(7, 9)) %>%
  filter((as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d') %in%
            c(as.Date(paste0('2021-07-15'), format = '%Y-%m-%d'),
              as.Date(paste0('2021-09-', 1:19), format = '%Y-%m-%d'))))

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot33_pyran_clearsky_2021.csv',
          row.names = FALSE)

#################################################################
##### Plot 39 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot39\\_', dir(sensor.dir), value = TRUE)) %>%
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

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# probably all fine

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot39_pyran_clearsky_2021.csv',
          row.names = FALSE)


#################################################################
##### Plot 48 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot48\\_', dir(sensor.dir), value = TRUE)) %>%
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

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# honestly looks great

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot48_pyran_clearsky_2021.csv',
          row.names = FALSE)

#################################################################
##### Plot 57 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot57\\_', dir(sensor.dir), value = TRUE)) %>%
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

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)
# ah... I see a note saying the sensor was tipped over between the 18th and the 20th

this.plot.data = this.plot.data %>% filter(!(Month %in% 8 & Day %in% 17:20))

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot57_pyran_clearsky_2021.csv',
          row.names = FALSE)


#################################################################
##### Plot 63 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot63\\_', dir(sensor.dir), value = TRUE)) %>%
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

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)

# guess I only have one useable file...

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)
# data is data!

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot63_pyran_clearsky_2021.csv',
          row.names = FALSE)

#################################################################
##### Plot 67 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot67\\_', dir(sensor.dir), value = TRUE)) %>%
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

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)

# Take out knocked-over readings

this.plot.data = this.plot.data %>%
  # Take out July 12 - 14 (and before then - sensor may not have been at proper height )
  filter(!(Month %in% 7 & Day < 15)) %>%
  # Take out July 24 - 25
  filter(!(Month %in% 7 & Day %in% 24:25)) %>%
  # Take out July 30 - August 1
  filter(!(Month %in% 7 & Day %in% 30:31) & !(Month %in% 8 & Day %in% 1)) %>%
  # Take out September 29 - October 2
  filter(!(Month %in% 9 & Day > 28) & !(Month %in% 10 & Day < 3))

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)
# data is data!

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot67_pyran_clearsky_2021.csv',
          row.names = FALSE)


#################################################################
##### Plot 70 ###################################################
#################################################################

this.plot.data = paste0(sensor.dir, grep('plot70\\_', dir(sensor.dir), value = TRUE)) %>%
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

this.plot.data %>%
  mutate(time = Hour + Minute/60,
         Date = as.Date(paste0('2021-', Month, '-', Day), format = '%Y-%m-%d')) %>%
  ggplot(aes(x = time, y = volt)) +
  geom_line() +
  facet_wrap(~ Date)

# guess I only have two useable files...

# Remove some toppled periods
this.plot.data = this.plot.data %>%
  filter(!(Month %in% 9  & Day %in% c(4:9, 13:23, 29:30)),
         !(Month %in% 10 & Day %in% 1))

# Gewt only clearsky readings
this.plot.data = merge(
  x = this.plot.data %>% mutate(Half_hour = 30 * as.numeric(Minute < 30)),
  y = ref.times %>% distinct(Month, Day, Hour, Half_hour),
  all.x = FALSE, all.y = FALSE
)

nrow(this.plot.data)

write.csv(this.plot.data,
          file = 'sensors_and_loggers/processed_data/plot70_pyran_clearsky_2021.csv',
          row.names = FALSE)

#################################################################
##### Plot 75 ###################################################
#################################################################
