# For IPWA video - Sept/Oct plots

# Load libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load in data

# filenames
dir('sensors_and_loggers/data/')

# raw files
octo = list(
  'sensors_and_loggers/data/plot2_2021-09-23_2021-10-04_raw.TXT',
  'sensors_and_loggers/data/plot6_2021-09-23_2021-09-27_raw.TXT',
  'sensors_and_loggers/data/plot6_2021-09-27_2021-10-09_raw.TXT',
  'sensors_and_loggers/data/plot16_2021-09-23_2021-10-04_raw.TXT',
  # no plot 19 (sad)
  'sensors_and_loggers/data/plot22_2021-09-23_2021-10-04_raw.TXT',
  'sensors_and_loggers/data/plot25_2021-09-23_2021-10-04_raw.TXT',
  # 'sensors_and_loggers/data/plot33_2021-09-23_2021-10-04_raw.TXT', - timer here is messed up! awesome!
  'sensors_and_loggers/data/plot39_2021-09-23_2021-10-04_raw.TXT',
  'sensors_and_loggers/data/plot48_2021-09-23_2021-09-25_raw.TXT', # gappy - sad!
  'sensors_and_loggers/data/plot48_2021-10-04_2021-10-10_raw.TXT',
  'sensors_and_loggers/data/plot57_2021-09-27_2021-10-10_raw.TXT',
  'sensors_and_loggers/data/plot63_2021-09-27_2021-10-10_raw.TXT',
  'sensors_and_loggers/data/plot70_2021-09-27_2021-10-10_raw.TXT',
  'sensors_and_loggers/data/plot75_2021-09-23_2021-10-04_raw.TXT',
  'sensors_and_loggers/data/plot77_2021-09-23_2021-09-25_raw.TXT',
  'sensors_and_loggers/data/plot77_2021-09-26_2021-10-04_raw.TXT',
  'sensors_and_loggers/data/plot77_2021-10-04_2021-10-10_raw.TXT'
)

# Read and concatenate
octo = octo %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = gsub('sensors_and_loggers\\/data\\/plot', '', x))) %>%
  do.call(what = rbind)

# Read in a processed data file
# (note: this is because I need to clean scripts with sub-zero temps...)
octo = octo %>%
  rbind(read.csv('sensors_and_loggers/data/plot67_2021-09-27_2021-10-09_proc.TXT') %>%
          mutate(fn = '67_2021-09-27_2021-10-09_proc.TXT') %>%
          select(-cleaned))

# Get plot info
octo = octo %>%
  mutate(plot = gsub('\\_2021\\-\\d{2}\\-\\d{2}', '', fn),
         plot = gsub('_\\D{3,4}\\.TXT', '', plot))

head(octo)

# Just TEROS and battery readings
octo.teros = octo %>% filter(grepl('T11|batt', Sensor_ID))

# Turn to wide form
octo.teros = octo.teros %>%
  select(-c(Sensor_ID, fn)) %>%
  mutate(Reading_type = gsub('\\s', '', Reading_type)) %>%
  spread(key = Reading_type, value = Reading_raw) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0))

octo.smois = octo.teros %>%
  group_by(plot) %>%
  filter(!cumsum(volt < 3.4))

nrow(octo.teros)
nrow(octo.smois)

# This looks okay but not fantastic. 
octo.smois %>% 
  mutate(VWC = (3.879e-4)*mois - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_line(aes(group = plot, colour = plot))


# What's the period with the most data we have?
octo.smois %>%
  group_by(Unixtime_UTC) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = Unixtime_UTC, y = n)) +
  geom_line()

# Okay a few gaps in here

octo.smois %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 10) %>%
  ungroup() %>%
  #distinct(Day_UTC, Hour_UTC)
  distinct(Day_UTC)

# A whole week... yeet

octo.smois %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 10) %>%
  ungroup() %>%
  mutate(VWC = (3.879e-4)*mois - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_line(aes(group = plot, colour = plot))


# Temperature

octo.teros %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 10) %>%
  ungroup() %>%
  ggplot(aes(x = Unixtime_UTC, y = temp)) +
  geom_line(aes(group = plot, colour = plot))

# Plot groupings - what are the plots?

octo.teros %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 9) %>%
  ungroup() %>%
  distinct(plot)

# Open: 2, 67, 70, 75
# Pine: 16, 48, 57
# Mixed: 25, 63
# Aspen: 19, 22, 33, 39, 77

labeled.octo.teros = merge(x = octo.teros,
      y = data.frame(plot = c(2, 67, 70, 75, 16, 48, 57, 25, 63, 19, 22, 33, 39, 77),
                     type = c(rep('o', 4), rep('p', 3), rep('m', 2), rep('a', 5)))) %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 10) %>%
  ungroup() 

labeled.octo.teros %>%
  mutate(Hour = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = Hour, y = temp)) +
  geom_line(aes(group = plot, colour = type)) +
  facet_wrap(~ Day_MDT)

labeled.octo.teros %>%
  filter(Day_MDT %in% 3) %>%
  mutate(Hour = Hour_MDT + Minute/60) %>%
  ggplot(aes(x = Hour, y = temp)) +
  geom_line(aes(group = plot, colour = type),
            size = 2) +
  scale_color_manual(values = c('green2', 'purple', 'orange', 'royalblue'),
                     labels = c('Aspen', 'Mixed', 'Open', 'Pine'),
                    "Habitat type") +
  scale_x_continuous(breaks = (0:6)*4) +
  labs(x = 'Hour', y = 'Soil temperature (C)') +
  theme(panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.title = element_text(size = 16),
        axis.text  = element_text(size = 12),
        legend.position = 'bottom')

ggsave('~/Documents/Research/shade/presentations/ipwa2021/soiltems_oct32021.png', width = 8, height = 5)

###

labeled.octo.smois = merge(x = octo.smois,
                           y = data.frame(plot = c(2, 67, 70, 75, 16, 48, 57, 25, 63, 19, 22, 33, 39, 77),
                                          type = c(rep('o', 4), rep('p', 3), rep('m', 2), rep('a', 5)))) %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 10) %>%
  ungroup() 

labeled.octo.smois %>%
  group_by(Unixtime_UTC) %>%
  filter(n() > 10) %>%
  ungroup() %>%
  mutate(VWC = (3.879e-4)*mois - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_segment(data = . %>% filter(!Hour_UTC, !Minute, !Second),
               aes(x = Unixtime_UTC, xend = Unixtime_UTC, y = 0.03, yend = 0.085),
               colour = 'gray88') +
  geom_label(data = . %>% filter(!Hour_UTC, !Minute, !Second),
             aes(x = Unixtime_UTC, y = 0.03, label = paste0(Month_UTC, '/', Day_UTC)),
             hjust = 0, nudge_y = -0.001) +
  geom_line(aes(group = plot, colour = type)) +
  scale_color_manual(values = c('green2', 'purple', 'orange', 'royalblue'),
                     labels = c('Aspen', 'Mixed', 'Open', 'Pine'),
                     "Habitat type") +
  scale_x_continuous(breaks = NULL) +
  labs(x = '', y = 'Soil moisture (%)') +
  theme(panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.title = element_text(size = 16),
        axis.text  = element_text(size = 12),
        legend.position = 'bottom')

ggsave('~/Documents/Research/shade/presentations/ipwa2021/soilmois_oct32021.png', width = 8, height = 5)
