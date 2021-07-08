# Sandbox script for reading in, mild processing, visualization of test data

library(ggplot2)
library(dplyr)
library(tidyr)

# Test data - collected in Brett's yard, June 20 - 24 2021
datatest = read.csv('sensors_and_loggers/data/DATATEST_2021-06-24.TXT')

nrow(datatest)

datatest = datatest %>%
  # Adding in MDT for readability
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) # %>%
  # distinct(Day_UTC, Hour_UTC, Day_MDT, Hour_MDT) # line for checking that the above worked

# Get the sensor ID for the TEROS
teros.id = grep('T11', datatest$Sensor_ID, value = TRUE)[1] %>%
  gsub(pattern = 'T11\\-0000', replacement = '')

 # Some plots

datatest %>% 
  filter(Reading_type %in% ' mois') %>%
  mutate(Reading_VWC = (3.879e-4)*Reading_raw - 0.6956) %>%
  ggplot() +
  geom_line(aes(x = Hour_MDT, y = Reading_VWC,
                group = Day_MDT, colour = factor(Day_MDT)))

datatest %>% 
  filter(Reading_type %in% ' mois') %>%
  mutate(Reading_VWC = (3.879e-4)*Reading_raw - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_VWC)) +
  geom_line() +
  geom_point(aes(colour = factor(Day_MDT))) +
  labs(x = '', y = 'VWC') +
  ggsave(filename = '~/Desktop/vwc_brettsyard.png')

datatest %>% 
  filter(Reading_type %in% ' temp') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line() +
  geom_point(aes(colour = factor(Day_MDT)))

datatest %>% 
  filter(Reading_type %in% ' temp') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line() +
  geom_point(aes(colour = factor(Day_MDT)))

datatest %>% 
  filter(Sensor_ID %in% 'pyran', Reading_type %in% ' volt') %>%
  mutate(time = chron::as.times(paste(Hour_MDT, Minute, Second, sep = ":"))) %>%
  ggplot(aes(x = time, y = Reading_raw)) +
  geom_line(aes(group = Day_MDT, colour = factor(Day_MDT)))

datatest %>%
  filter(Sensor_ID %in% 'batteries') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line()

### Datatest 2 - Jun 24 - Jun 26

datatest = read.csv('~/Desktop/DATATEST_2021-06-26.TXT')

datatest = datatest %>%
  # Adding in MDT for readability
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) # %>%
# distinct(Day_UTC, Hour_UTC, Day_MDT, Hour_MDT) # line for checking that the above worked

datatest %>% 
  filter(Reading_type %in% ' mois') %>%
  mutate(Reading_VWC = (3.879e-4)*Reading_raw - 0.6956) %>%
  ggplot() +
  geom_line(aes(x = Hour_MDT, y = Reading_VWC,
                group = Day_MDT, colour = factor(Day_MDT)))

datatest %>% 
  filter(Reading_type %in% ' mois') %>%
  mutate(Reading_VWC = (3.879e-4)*Reading_raw - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_VWC)) +
  geom_line() +
  geom_point(aes(colour = factor(Day_MDT))) +
  labs(x = '', y = 'VWC') +
  ggsave(filename = '~/Desktop/vwc_brettsyard.png')

datatest %>% 
  filter(Reading_type %in% ' temp') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line() +
  geom_point(aes(colour = factor(Day_MDT)))

datatest %>% 
  filter(grepl('T11', Sensor_ID) & Reading_type %in% ' temp') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line() +
  geom_point(aes(colour = factor(Day_MDT)))

datatest %>% 
  filter(Sensor_ID %in% 'pyran', Reading_type %in% ' volt') %>%
  mutate(time = chron::as.times(paste(Hour_MDT, Minute, Second, sep = ":"))) %>%
  ggplot(aes(x = time, y = Reading_raw)) +
  geom_line(aes(group = Day_MDT, colour = factor(Day_MDT)))

datatest %>%
  filter(Sensor_ID %in% 'batteries') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line()

datatest %>% 
  filter(!grepl('T11', Sensor_ID) & Reading_type %in% ' temp') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line() +
  geom_point(aes(colour = factor(Day_MDT)))

###

# Data collected from plot 48 july 3 - july 5

p48 = read.csv('~/Desktop/DATATEST_2021_07-07.TXT') %>%
  # crude way to handle missing sensor ID
  mutate(Sensor_ID = ifelse(Sensor_ID %in% '', 'TEROS', Sensor_ID)) %>%
  # add MDT times
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0))

p48 %>%
  filter(Reading_type %in% ' mois') %>%
  mutate(Reading_VWC = (3.879e-4)*Reading_raw - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_VWC)) +
  geom_line() +
  #geom_point(aes(colour = factor(Day_MDT))) +
  geom_label(aes(label = Hour_MDT, fill = factor(Day_MDT)), size = 3) +
  labs(x = '', y = 'VWC')

ggsave(filename = '~/Desktop/plot_48_jul3-jul5_soilwvc.pdf')

p48 %>%
  filter(grepl('T11', Sensor_ID), Reading_type %in% ' temp') %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line() +
  #geom_point(aes(colour = factor(Day_MDT))) +
  geom_label(aes(label = Hour_MDT, fill = factor(Day_MDT)), size = 3) +
  labs(y = 'Soil temperature (C)')

ggsave(filename = '~/Desktop/plot_48_jul3-jul5_soiltemp.pdf')
  
