# In May 2022 I modified the datalogger code to put sensors to sleep between readings
# In this quick-and-dirty script I'm comparing that data to some dataloggers employed
# in August 2021 (old pre-timer script), looking at battery levels

library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls())

# 2022 sensor
d22 = read.csv('~/Desktop/SENSDATA.TXT')

# 2021 sensors
d21 = read.csv('sensors_and_loggers/data/plot16_2021-08-23_2021-08-31_raw.TXT')
c21 = read.csv('sensors_and_loggers/data/plot6_2021-08-20_2021-08-31_raw.TXT')

# Get just the battery readings
b22 = d22 %>% filter(grepl('batt', Sensor_ID))
# for the 2021 sensors, can clip the times involved to just include 
# readings starting at the same time as the batteries in the 2022 sensor
# (batteries started at 4.26v in the 2022 sensor due to prior testing)
b21 = d21 %>% filter(grepl('batt', Sensor_ID)) %>% filter(Reading_raw < 4.26)
b20 = c21 %>% filter(grepl('batt', Sensor_ID)) %>% filter(Reading_raw < 4.26)

# Concatenate them
# note: start times normalized to start at time '0'
tres = rbind(
  b22 %>%
    mutate(time = Unixtime_UTC - min(Unixtime_UTC),
           s    = '2022') %>%
    select(time, s, Reading_raw),
  b21 %>%
    mutate(time = Unixtime_UTC - min(Unixtime_UTC),
           s    = '2021.16') %>%
    select(time, s, Reading_raw),
  b20 %>%
    mutate(time = Unixtime_UTC - min(Unixtime_UTC),
           s    = '2021.6') %>%
    select(time, s, Reading_raw)
) #%>%
  spread(s, Reading_raw)

# Plot
tres %>%
  ggplot(aes(x = time, y = Reading_raw)) +
  geom_line(aes(group = s, colour = s))

# booyah

b22 %>%
  select(Unixtime_UTC) %>%
  unlist() %>%
  diff() %>%
  plot(type = 'l') # ah... it's skipping some
# still skipping...

d22 %>%
  filter(grepl('^SP510', Sensor_ID)) %>%
  distinct(Day_UTC, Hour_UTC, Minute, Second, .keep_all = TRUE) %>%
  mutate(Hour = (Hour_UTC - 6) %% 24,
         Day  = Day_UTC - as.numeric(Hour_UTC < Hour)) %>%
  mutate(time = Hour + Minute / 60 + Second / (60^2)) %>%
  ggplot(aes(x = time, y = Unixtime_UTC)) +
  geom_point(size = 0.1) +
  scale_x_continuous(breaks = 3 * (2:6))

# This looks correct to me! Only taking readings between 7 and 6.

d22 %>%
  filter(grepl('^T11', Sensor_ID), grepl('mois', Reading_type)) %>%
  mutate(Hour = (Hour_UTC - 6) %% 24,
         Day  = Day_UTC - as.numeric(Hour_UTC < Hour)) %>%
  mutate(time = Hour + Minute / 60 + Second / (60^2)) %>%
  ggplot(aes(x = time, y = Unixtime_UTC)) +
  geom_point(size = 0.1) +
  scale_x_continuous(breaks = 3 * (2:6))
# oh... this is not good!!
# this seems like it is why there are missing battery readings!

d22 %>%
  filter(Month_UTC > 5, Day_UTC > 1) %>%
  filter(grepl('batt', Sensor_ID)) %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_segment(aes(x = Unixtime_UTC, xend = Unixtime_UTC,
                   y = min(Reading_raw), yend = max(Reading_raw)),
               data = . %>% filter(!Hour_UTC),
               linetype = 2, colour = 'gray55') +
  geom_point() +
  geom_line()

# Looks good to me...
