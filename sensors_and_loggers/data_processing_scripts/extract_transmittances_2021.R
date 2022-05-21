# Script for merging plot pyranometer data with reference sensor data for
# clearsky readings.
# All performed with 2021 pyranometer data
# SN - 20 May 2022 (last run: 20 May 2022)
# note: has not included final round of readings (October)

# Load packages
library(ggplot2)
library(dplyr)
library(tidyr)

# Clear namespace
rm(list = ls())

# Get reference sensor readings
ref.reads = read.csv('sensors_and_loggers/processed_data/processed_ref_times_2021.csv')

# Read in all processed plot pyranometer readings from clear sky conditions
# (see processing scripts in processing_scripts dir)
plt.reads = grep('plot\\d', dir('sensors_and_loggers/processed_data'), value = TRUE) %>%
  paste0('sensors_and_loggers/processed_data/', .) %>%
  lapply(read.csv) %>%
  do.call(what = rbind)

nrow(plt.reads)

# Get SP410 calibration factors
# (which also requires merging in SP510 IDs for each plot)

plt.reads = 
  merge(
    x = plt.reads %>% mutate(Plot = gsub('plot', '', fn))  %>% 
      select(-fn),
    y = read.csv('sensors_and_loggers/sensor_logger_masterlist_2021.csv') %>% 
      select(SP510, Plot)
  ) %>%
  mutate(SP510 = ifelse(Plot %in% 25 & Month %in% 7 | (Month %in% 8 & Day < 11),
                        1645, SP510)) %>%
  merge(
    y = read.csv('sensors_and_loggers/SP510_calibration_factors.csv') %>% 
      select(Sensor_ID, Calibration_factor_W_m..2_per_mV) %>%
      rename(SP510 = Sensor_ID, cal = Calibration_factor_W_m..2_per_mV)
  )

head(plt.reads)

# Calculate watts per square meter using sensor-specific calibration factors
plt.reads = plt.reads %>% mutate(Wm2 = volt * cal)

# Now -- get the refernce readings
# (can check the calibration factors for the ref sensor from files above)
plt.trans = plt.reads %>%
  merge(
    ref.reads %>% select(-c(Half_hour, plot)) %>% mutate(ref.Wm2 = 20.24 * volt),
    by = c("Month", "Day", "Hour", "Minute")
  ) %>%
  select(-c(Half_hour, SP510, cal, contains('volt')))

head(plt.trans)                             

str(plt.trans)

# Get transmittance
plt.trans = plt.trans %>% mutate(transm = Wm2 / ref.Wm2)        

head(plt.trans)
hist(plt.trans$transm)

# Might as well merge in coordinates for each plot/sensor right here
plt.transm = read.csv('sensors_and_loggers/elk_2021_sens_sp_2021-11-10.csv') %>%
  mutate(Plot = as.numeric(gsub('s2021_p', '', sensor))) %>%
  select(Plot, east, north) %>%
  merge(y = plt.trans) %>%
  arrange(Plot, Month, Day, Hour, Minute)

# Export
write.csv(plt.transm, row.names = FALSE,
          file = 'sensors_and_loggers/processed_data/clearsky_transm_2021.csv')
