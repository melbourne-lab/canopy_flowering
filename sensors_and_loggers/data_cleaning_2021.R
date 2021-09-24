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

# Note: I previously went into the raw file, removed the space at the beginning
# of each Reading_raw, and re-exported as raw.

dataraw = read.csv('sensors_and_loggers/data/plot2_2021-09-09_2021-09-23_raw.TXT')

# Locate the problem columns
dataraw %>% filter(is.na(as.numeric(Reading_raw)))

# Okay - should be able to fix the temperature readings by removing everything after a '-'
# The moisture reading... yeah lmao I guess just set that to NA? ugh

dataraw %>% filter(grepl('\\d\\-', Reading_raw))
dataraw %>% filter(grepl('\\-\\d\\.\\d{4,}', Reading_raw))
# (note: doing just grepl for a dash gives issues with negative SP510 readings)

dataproc = dataraw %>% mutate(Reading_new = gsub('\\-\\d\\.\\d{4,}', '', Reading_raw))

dataproc %>% filter(Reading_new != Reading_raw)
# Looks good to me

# Now - the moisture issue
dataproc %>% filter(as.numeric(Reading_new) > 1e6)
# Okay - there are actually a lot of records with this problem...

# Just set them all to NA
dataproc = dataproc %>% mutate(Reading_new = ifelse(as.numeric(Reading_new) > 1e6, NA, Reading_new))

dataproc %>% filter(!(Reading_new %in% Reading_raw))
# It's possible these were during the cold spell.

dataproc = dataproc %>% 
  # Create "cleaned" column
  mutate(cleaned = !(Reading_new %in% Reading_raw)) %>%
  # Reading_raw column is now cleaned
  mutate(Reading_raw = Reading_new) %>%
  select(-Reading_new)

# Export
write.csv(dataproc, 'sensors_and_loggers/data/plot2_2021-09-09_2021-09-23_proc.TXT',
          row.names = FALSE, na = '')

###