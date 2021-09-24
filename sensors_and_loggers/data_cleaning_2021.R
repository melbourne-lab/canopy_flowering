#### Script for processing sensor data (2021)
# SN

# NOTE: this script contains all script changes
# Do not run the entire script!

library(ggplot2)
library(dplyr)
library(tidyr)

####

#### 
# Sept 24 2021
# Plot: 2, Collected: Sept 23 2021
# Issue: Reading column contains extraneous readings
# (TEROS issue - occasionally passes in too many readings)

rm(list = ls())

# Note: I previously went into the raw file, removed the space at the beginning
# of each Reading_raw, and re-exported as raw.

dataraw = read.csv('sensors_and_loggers/data/plot2_2021-09-09_2021-09-23_raw.TXT')

# Locate the problem columns
dataraw %>% filter(is.na(as.numeric(Reading_raw)))

# Looking at some of the raw data, the problem is that whenever the temperature is sub-zero
# the first part of the reading is a crazy-long slew of digits
# and the moisture and temperature stuff is combined into the temperature reading

# In this case, we can detect these is records with two decimals
dataraw %>% filter(grepl('\\.[^\\.]*\\.', Reading_raw))

# Okay - now, how to fix?
# Want to split these records and put the moisture record in where it belongs

# # Test code below - proof of concept
# t1 = dataraw %>% 
#   group_by(Unixtime_UTC) %>%
#   mutate(flag = any(grepl('\\.[^\\.]*\\.', Reading_raw))) %>%
#   mutate(Reading_new = ifelse(grepl('temp', Reading_type) & grepl('T11', Sensor_ID) & flag,
#                               gsub('\\d{4}\\.\\d{6}', '', Reading_raw[grepl('temp', Reading_type) & grepl('T11', Sensor_ID)]),
#                               Reading_raw))
# t2 = t1 %>%
#   mutate(Reading_new = ifelse(grepl('mois', Reading_type) & flag,
#                               substr(Reading_raw[grepl('temp', Reading_type) & grepl('T11', Sensor_ID)], 1, 11),
#                               Reading_new))
# t2 %>% filter(flag) %>% print(n = 20)
# t2 %>% ungroup() %>% filter(!(Reading_new %in% Reading_raw)) %>% print(n = nrow(.))
# # BEAUTIFUL

dataproc = dataraw %>%
  # Group_by time to link temperature and moisture records
    group_by(Unixtime_UTC) %>%
  # Add boolean column for antyhing with multiple decimals
  # (shown above to get all problem records and nothing else)
    mutate(flag = any(grepl('\\.[^\\.]*\\.', Reading_raw))) %>%
  # New column: Reading_new
  #   for TEROS temp records, remove the first 11 characters (the moisture reading)
  #   for all other records just copy the raw reading
    mutate(Reading_new = ifelse(grepl('temp', Reading_type) & grepl('T11', Sensor_ID) & flag,
                                gsub('\\d{4}\\.\\d{6}', '', Reading_raw[grepl('temp', Reading_type) & grepl('T11', Sensor_ID)]),
                                Reading_raw)) %>%
  #   for the moisture readings, get the first 11 digits (assuming four digits before decimal, six after)
    mutate(Reading_new = ifelse(grepl('mois', Reading_type) & flag,
                                substr(Reading_raw[grepl('temp', Reading_type) & grepl('T11', Sensor_ID)], 1, 11),
                                Reading_new)) %>%
    ungroup()

dataproc %>% filter(!(Reading_new %in% Reading_raw)) %>% print(n = nrow(.))
# Looks good to me

dataout = dataproc %>% 
  # Create "cleaned" column
  mutate(cleaned = !(Reading_new %in% Reading_raw)) %>%
  # Reading_raw column is now cleaned
  mutate(Reading_raw = Reading_new) %>%
  select(-Reading_new)

# Export
write.csv(dataout, 'sensors_and_loggers/data/plot2_2021-09-09_2021-09-23_proc.TXT',
          row.names = FALSE, na = '')

###