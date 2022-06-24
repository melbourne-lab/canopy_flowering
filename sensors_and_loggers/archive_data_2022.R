# File for reading in and copying raw data from external drive.
# Notes: 
#   - external drive path defined by 'ext.drive.path'
#   - local destination is hard coded just in case
#   - aspects of script may need to be changed if the way the data is initially stored changes

# Loading functions
library(ggplot2)
library(dplyr)
library(tidyr)

# Clear namespace
rm(list = ls())


# PATH TO EXTERNAL DRIVE (where data is stored in TXT form)
ext.drive.path  = '/Volumes/NO NAME/'
# PATH TO WHERE DATA WILL BE COPIED (in this repo)
local.dest.path = '~/repos/canopy_flowering/sensors_and_loggers/data/'

# STRING IDENTIFYING FILES
# NOTE: NEED only one file on drive with DATATEST in string
# will need to be changed if filename changes in Arduino script
filename.str  = 'SENSDATA'

# Masterlist of sensors (links TEROS to SP510 and plot)
sensor.masterlist = read.csv('sensors_and_loggers/sensor_logger_masterlist_2022.csv')

# Get full path to file to read in
(file.to.read = grep(filename.str, dir(ext.drive.path), value = TRUE) %>%
    paste0(ext.drive.path, .))

# Read in data
sensor.data = read.csv(file.to.read)

# Extract TEROS ID (full)
(teros.id = grep('^T11', sensor.data$Sensor_ID, value = TRUE) %>% unique())

# Get Numeric TEROS ID (for merging)
if (length(teros.id) == 1) {
  # If there is only one TEROS ID, get the ID in numeric form
  teros.num = teros.id %>%
    gsub('T11\\-', '', x = .) %>%
    as.numeric()
} else if (!length(teros.id)) {
  # If there is no TEROS ID, print to let us know there's a problem
  print('no TEROS id')
} else {
  # Also print if there are multiple unique IDs
  print('multiple TEROS ids')
}

# Get the info for this sensor
# (should be just one row, with Plot and SP510 as well as any notes)
(sensor.info = sensor.masterlist[sensor.masterlist$TEROS %in% teros.num,])

# Get dates of deployment (in UTC) for labeling file
data.info =  sensor.data %>% 
  distinct(Date = as.Date(paste(Month_UTC, Day_UTC), '%m %d')) %>%
  summarise(mindate = min(Date), maxdate = max(Date))

# Name of file name to copy this info to
# format: "plot_FIRSTDATE_LASTDATE_raw.TXT"
(out.filename = paste0('plot', sensor.info$Plot, '_',
                       data.info$mindate, '_', data.info$maxdate,
                       '_raw.TXT'))

# Copy files and then delete original (if file is successfully copied)
if (
  file.copy(from = file.to.read, to = paste0(local.dest.path, out.filename)) &
  file.copy(from = file.to.read, to = paste0(ext.drive.path, out.filename)) 
) {
  file.remove(file.to.read)
} else { print('file not removed')}

file.exists(paste0(local.dest.path, out.filename))
file.exists(paste0(ext.drive.path, out.filename))

##### Examine data 

# Format raw data
sensor.clean = sensor.data %>%
  # Add MDT times
  # NOTE: does not handle month changes - will need fixing
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0)) %>%
  # Get plot info and SP510
  mutate(Sensor_ID = gsub('pyran', 
                          paste0('SP510-', sensor.info$SP510, collapse = ''),
                          Sensor_ID)) %>%
  mutate(Plot = sensor.info$Plot) %>%
  select(Plot, Sensor_ID, Unixtime_UTC, Month_UTC, Day_MDT, Hour_MDT, Minute, Second, Reading_type, Reading_raw)

# Generate some plots

test.moisture = sensor.clean %>%
  filter(grepl('mois', Reading_type)) %>%
  mutate(VWC = (3.879e-4)*Reading_raw - 0.6956)

test.moisture %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_point(size = 1/4) +
  geom_line()

test.soiltem = sensor.clean %>% filter(grepl('^T11', Sensor_ID) & grepl('temp', Reading_type))

test.soiltem %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_point(size = 1/4) +
  geom_line()

test.solarwm = sensor.clean %>% filter(grepl('SP510', Sensor_ID) & grepl('volt', Reading_type)) #%>%
# should add code here to read in calibration factor

test.solarwm %>%
  ggplot() +
  geom_line(aes(x = Unixtime_UTC, y = Reading_raw))

test.battery = sensor.clean %>% filter(grepl('batt', Sensor_ID))

test.battery %>%
  ggplot() +
  geom_line(aes(x = Unixtime_UTC, y = Reading_raw))

