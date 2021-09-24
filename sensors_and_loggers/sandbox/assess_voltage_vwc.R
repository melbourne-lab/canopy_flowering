# Little script for looking at some data collected September 23
# Here, most of the sensors had battery power run out - I look at how this
# influences the TEROS readings.
# I also look at temperature records during the first "frost" of 2021:
# around September 21 temperatures may have gone below freezing at the site.
# Were these recorded? Look at the heterogeneity.
# SN - 24 Sept 2021

# Load libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load in data

# filenames
dir('sensors_and_loggers/data/')

# raw files
sept23 = list(
  'sensors_and_loggers/data/plot16_2021-09-09_2021-09-23_raw.TXT',
  'sensors_and_loggers/data/plot19_2021-09-09_2021-09-22_raw.TXT',
  'sensors_and_loggers/data/plot22_2021-09-14_2021-09-21_raw.TXT',
  'sensors_and_loggers/data/plot25_2021-09-09_2021-09-23_raw.TXT',
  'sensors_and_loggers/data/plot33_2021-09-14_2021-09-20_raw.TXT',
  'sensors_and_loggers/data/plot48_2021-09-09_2021-09-22_raw.TXT',
  'sensors_and_loggers/data/plot75_2021-09-14_2021-09-23_raw.TXT',
  'sensors_and_loggers/data/plot77_2021-09-09_2021-09-23_raw.TXT'
)

# Read and concatenate
ts23 = sept23 %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = x)) %>%
  do.call(what = rbind)

# Read in a processed data file
# (note: this is because I need to clean scripts with sub-zero temps...)
ts23 = ts23 %>%
  rbind(read.csv('sensors_and_loggers/data/plot2_2021-09-09_2021-09-23_proc.TXT') %>%
          mutate(fn = 'sensors_and_loggers/data/plot2_2021-09-09_2021-09-23_proc.TXT') %>%
          select(-cleaned))

# Get plot info
ts23 = ts23 %>%
  mutate(plot = gsub('sensors_and_loggers\\/data\\/plot', '', fn),
         plot = gsub('\\_2021\\-09\\-\\d{2}', '', plot),
         plot = gsub('_\\D{3,4}\\.TXT', '', plot))

head(ts23)

# Just TEROS and battery readings
s23 = ts23 %>% filter(grepl('T11|batt', Sensor_ID))

# Turn to wide form
s23 = s23 %>%
  select(-c(Sensor_ID, fn)) %>%
  mutate(Reading_type = gsub('\\s', '', Reading_type)) %>%
  spread(key = Reading_type, value = Reading_raw)

s23 %>%
  ggplot(aes(x = Unixtime_UTC, y = temp)) +
  geom_line(aes(group = plot, colour = plot))

s23 %>%
  ggplot(aes(x = Unixtime_UTC, y = mois)) +
  geom_line(aes(group = plot, colour = plot)) +
  geom_point(data = s23 %>% filter(volt <= 3.34),
             shape = 'x')

# Man what on earth is the deal with these garbo readings...

s23 %>%
  group_by(plot) %>%
  mutate(mdiff = c(diff(mois)/diff(Unixtime_UTC), 0)) %>%
  ggplot(aes(x = volt, y = mdiff, colour = plot)) +
  geom_point()

# hmm...

s23 %>%
  group_by(plot) %>%
  mutate(mdiff = c(diff(mois)/diff(Unixtime_UTC), 0)) %>%
  ggplot(aes(x = volt, y = mdiff, colour = plot)) +
  geom_point() +
  facet_wrap(~ plot)

s23 %>%
  group_by(plot) %>%
  mutate(mdiff = c(diff(mois)/diff(Unixtime_UTC), 0)) %>%
  ggplot(aes(x = volt, y = mdiff, colour = plot)) +
  geom_point() +
  scale_x_continuous(limits = c(3.25, 3.5)) +
  facet_wrap(~ plot)

# Seems like this happens often with readings below 3.35 volts
# Perhaps to be safe... choose 3.4?

s23.clean = s23 %>%
  group_by(plot) %>%
  filter(!cumsum(volt < 3.4))

nrow(s23)
nrow(s23.clean)

# This looks okay but not fantastic. 
# 3.35 V appears to be a good threshold although sometimes a greater one will be needed.
s23.clean %>% 
  mutate(VWC = (3.879e-4)*mois - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_line(aes(group = plot, colour = plot))
