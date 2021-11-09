# For IPWA video

# Load libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load in data

# filenames
dir('sensors_and_loggers/data/')

# raw files
sept23 = list(
  'sensors_and_loggers/data/plot6_2021-09-23_2021-09-27_raw.TXT',
  'sensors_and_loggers/data/plot16_2021-09-09_2021-09-23_raw.TXT',
  'sensors_and_loggers/data/plot19_2021-09-09_2021-09-22_raw.TXT',
  'sensors_and_loggers/data/plot22_2021-09-14_2021-09-21_raw.TXT',
  'sensors_and_loggers/data/plot25_2021-09-09_2021-09-23_raw.TXT',
  'sensors_and_loggers/data/plot33_2021-09-14_2021-09-20_raw.TXT',
  'sensors_and_loggers/data/plot48_2021-09-09_2021-09-22_raw.TXT',
  'sensors_and_loggers/data/plot70_2021-09-14_2021-09-27_raw.TXT',
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
          select(-cleaned),
        read.csv('sensors_and_loggers/data/plot67_2021-09-14_2021-09-27_proc.TXT') %>%
          mutate(fn = 'sensors_and_loggers/data/plot67_2021-09-14_2021-09-27_proc.TXT') %>%
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
  spread(key = Reading_type, value = Reading_raw) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0))

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

head(s23.clean)

# What's the period with the most data we have?
s23.clean %>%
  group_by(Unixtime_UTC) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = Unixtime_UTC, y = n)) +
  geom_line()

# Okay a few gaps in here

s23.clean %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 9) %>%
  ungroup() %>%
  #distinct(Day_UTC, Hour_UTC)
  distinct(Day_UTC)

# Ah that's five days - actually pretty good!

s23.clean %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 9) %>%
  ungroup() %>%
  mutate(VWC = (3.879e-4)*mois - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_line(aes(group = plot, colour = plot))


s23 %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 9) %>%
  ungroup() %>%
  ggplot(aes(x = Unixtime_UTC, y = temp)) +
  geom_line(aes(group = plot, colour = plot))

# Plot groupings - what are the plots?

s23 %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 9) %>%
  ungroup() %>%
  distinct(plot)

# Open: 2, 67, 70, 75
# Pine: 16, 48
# Mixed: 25
# Aspen: 19, 22, 77, 33

data.frame()

### Some solar radiation plots

ts23 %>%
  filter(plot %in% c(2, 25, 48)) %>%
  filter(Sensor_ID %in% 'pyran', grepl('bits', Reading_type)) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) %>%
  mutate(Hour = Hour_MDT + Minute/60 + Second/(60^2)) %>%
  ggplot(aes(x = Hour, y = Reading_raw)) +
  geom_line(aes(colour = plot, group = plot)) +
  facet_wrap(~ Day_MDT)
  
ts23 %>%
  filter(plot %in% c(2, 25, 48)) %>%
  filter(Sensor_ID %in% 'pyran', grepl('bits', Reading_type)) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) %>%
  filter(Day_MDT %in% 15, Hour_MDT %in% 9:17) %>%
  mutate(Hour = Hour_MDT + Minute/60 + Second/(60^2)) %>%
  ggplot(aes(x = Hour, y = Reading_raw)) +
  geom_line(aes(colour = plot, group = plot)) +
  facet_wrap(~plot, nrow = 2)

ts23 %>%
  filter(plot %in% 2) %>%
  filter(Sensor_ID %in% 'pyran', grepl('bits', Reading_type)) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) %>%
  filter(Day_MDT %in% 15, Hour_MDT %in% 9:17) %>%
  mutate(Hour = Hour_MDT + Minute/60 + Second/(60^2)) %>%
  ggplot(aes(x = Hour, y = Reading_raw)) +
  geom_line(aes(colour = plot, group = plot)) +
  labs(x = 'Time of day', y = 'Solar radiation') +
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  theme(legend.position = 'none',
        panel.background = element_blank(),
        panel.border = element_rect(fill = NA))

ts23 %>%
  filter(plot %in% 2) %>%
  filter(Sensor_ID %in% 'pyran', grepl('bits', Reading_type)) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) %>%
  filter(Day_MDT %in% 15, Hour_MDT %in% 9:17) %>%
  mutate(Hour = Hour_MDT + Minute/60 + Second/(60^2)) %>%
  ggplot(aes(x = Hour, y = Reading_raw)) +
  geom_line(colour = 'red') +
  labs(x = 'Time of day', y = 'Solar radiation') +
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  theme(legend.position = 'none',
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.title = element_text(size = 48))

ggsave('~/Documents/Research/shade/presentations/ipwa2021/plot2_sept15.png')

ts23 %>%
  filter(plot %in% 25) %>%
  filter(Sensor_ID %in% 'pyran', grepl('bits', Reading_type)) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) %>%
  filter(Day_MDT %in% 15, Hour_MDT %in% 9:17) %>%
  mutate(Hour = Hour_MDT + Minute/60 + Second/(60^2)) %>%
  ggplot(aes(x = Hour, y = Reading_raw)) +
  geom_line(colour = 'green4') +
  labs(x = 'Time of day', y = 'Solar radiation') +
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  theme(legend.position = 'none',
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.title = element_text(size = 48))

ggsave('~/Documents/Research/shade/presentations/ipwa2021/plot25_sept15.png')

ts23 %>%
  filter(plot %in% 48) %>%
  filter(Sensor_ID %in% 'pyran', grepl('bits', Reading_type)) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) %>%
  filter(Day_MDT %in% 15, Hour_MDT %in% 9:17) %>%
  mutate(Hour = Hour_MDT + Minute/60 + Second/(60^2)) %>%
  ggplot(aes(x = Hour, y = Reading_raw)) +
  geom_line(colour = 'blue') +
  labs(x = 'Time of day', y = 'Solar radiation') +
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  theme(legend.position = 'none',
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.title = element_text(size = 48))

ggsave('~/Documents/Research/shade/presentations/ipwa2021/plot48_sept15.png')

