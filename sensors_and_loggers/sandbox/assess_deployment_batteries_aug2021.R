### Script to assess battery usage in the July deployment Arduino script and the August deployment one
# There were some changes to timing and frequency of records - do these influence the battery usage?

# Load packages
library(ggplot2)
library(dplyr)

### Prep second deployment data

# Read in CSVs
ax = dir('sensors_and_loggers/data/') %>%
  grep(pattern = '08\\-26', value = TRUE) %>%
  paste0('sensors_and_loggers/data/', .) %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = as.character(x))) %>%
  do.call(what = rbind)

# Add plot column to data frame
ax = ax %>%
  mutate(plot = gsub('sensors\\_and\\_loggers\\/data\\/plot', '', fn)) %>%
  mutate(plot = gsub('\\_2021\\-\\d{2}\\-\\d{2}|\\_raw\\.TXT', '', plot)) %>%
  select(-fn)

# Add MDT columns
ax = ax %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0))

# Briefly - plot soil moisture for the three plots
ax %>%
  filter(grepl('T11', Sensor_ID), grepl('mois', Reading_type)) %>%
  mutate(vwc = (3.879e-4)*Reading_raw - 0.6956) %>%
  ggplot(aes(x = Unixtime_UTC, y = vwc, group = plot, colour = plot)) +
  geom_line()

# Plot soil temperatures
ax %>%
  filter(grepl('T11', Sensor_ID), grepl('temp', Reading_type)) %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw, group = plot, colour = plot)) +
  geom_line()

# Make data frame with battery readings only
# `normstart` field is a column giving the (approx) time since the sensor was deployed
axb = ax %>%
  filter(grepl('batt', Sensor_ID)) %>%
  group_by(plot) %>%
  mutate(normstart = Unixtime_UTC - min(Unixtime_UTC))

### Deal with old data
# to make this easy, I just take old records from plots 57 and 77

# Read in data
ay = dir('sensors_and_loggers/data/') %>%
  grep(pattern = 'plot[57]7', value = TRUE) %>%
  paste0('sensors_and_loggers/data/', .) %>%
  lapply(function(x) read.csv(x) %>% mutate(fn = as.character(x))) %>%
  do.call(what = rbind)

# Do processing - add plot numbers and MDT times
ay = ay %>%
  mutate(plot = gsub('sensors\\_and\\_loggers\\/data\\/plot', '', fn)) %>%
  mutate(plot = gsub('\\_2021\\-\\d{2}\\-\\d{2}|\\_raw\\.TXT', '', plot)) %>%
  select(-fn) %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0))

# Get the old battery data
ayb = ay %>% 
  filter(grepl('batt', Sensor_ID)) %>% 
  # Here - hacky way to try to group into battery stuff
  #   - for each plot, get a running list of readings starting from when volts > 4.6
  #   - the as.numeric(n*() < 2) is to lump together cases where there are
  #   multiple starting readings above 4.6
  #     (note: if there are more than two readings you'll want to do this multiple times...
  #     a while loop would handle this)
  group_by(plot) %>%
  mutate(started = (Reading_raw > 4.6),
         started = cumsum(started)) %>%
  group_by(plot, started) %>%
  # filter(n() > 1) %>%
  mutate(started = started + as.numeric(n() < 2)) %>%
  # there's a gap here from batteries being dislodged - just remove this group
  filter(!any(diff(Unixtime_UTC) > 100000)) %>%
  mutate(normstart = Unixtime_UTC - min(Unixtime_UTC))

# Plot
ayb %>%
  ggplot(aes(x = normstart, y = Reading_raw)) +
  geom_segment(data = data.frame(x = (60*60*24)*(1:12)),
               aes(x = x, xend = x, y = 3.2, yend = 4.4),
               size = 0.25, colour = 'gray66') +
  geom_label(data = data.frame(x = (60*60*24)*(1:12)),
             aes(x = x, y = 3.2, label = 1:12)) +
  geom_segment(aes(x = 0, xend = (60*60*24)*(13),
                   y = 3.3, yend = 3.3),
               linetype = 3) +
  geom_line(aes(group = interaction(plot, started), colour = factor(plot))) +
  geom_line(aes(group = plot, colour = factor(plot)),
            linetype = 2,
            data = axb) 

# They look similar/comparable to me. Also looks like old batteries lasted 12 days - new ones should last this long as well.
