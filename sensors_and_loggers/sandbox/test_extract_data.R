ext.drive.path  = '/Volumes/NO NAME/'
local.dest.path = '~/repos/canopy_flowering/sensors_and_loggers/data/'

filename.str  = 'DATATEST'

sensor.masterlist = read.csv('sensors_and_loggers/sensor_logger_masterlist_2021.csv')

# get list of files
file.to.read = grep(filename.str, dir(ext.drive.path), value = TRUE) %>%
  paste0(ext.drive.path, .)

# Check TEROS ID:
grep('^T11', xx$Sensor_ID, value = TRUE) %>%
  unique() %>%
  # Possibly only works with one T11...
  gsub('T11\\-', '', x = .) %>%
  as.numeric()

get.teros.id = function(fn) {
  
  teros.id = grep('^T11', xx$Sensor_ID, value = TRUE) %>% unique()
  
  if (length(teros.id) == 1) {
    teros.id %>%
      gsub('T11\\-', '', x = .) %>%
      as.numeric() %>%
      return()
  } else if (!length(teros.id)) {
    print('no TEROS id')
  } else {
    print('multiple TEROS ids')
  }
  
}

teros.num = get.teros.id(xx)
sensor.info = sensor.masterlist[sensor.masterlist$TEROS %in% teros.num,]

# get dates
data.info = xx %>% 
  distinct(Date = as.Date(paste(Month_UTC, Day_UTC), '%m %d')) %>%
  summarise(mindate = min(Date), maxdate = max(Date))

# locally duplicate file
out.filename = paste0('plot', sensor.info$Plot, '_',
                      data.info$mindate, '_', data.info$maxdate,
                      '_raw.TXT')

# write.csv(xx, file = paste0(local.dest.path, out.filename), 
#           quote = FALSE, row.names = FALSE, NA = '')
# write.csv(xx, file = paste0(ext.drive.path, out.filename), 
#           quote = FALSE, row.names = FALSE, NA = '')

if (
  file.copy(from = file.to.read, to = paste0(local.dest.path, out.filename)) &
  file.copy(from = file.to.read, to = paste0(ext.drive.path, out.filename)) 
  ) {
  file.remove(file.to.read)
} else { print('file not removed')}

# Delete old file
file.remove()

# Add MDT
xx = xx %>%
  mutate(Hour_MDT = Hour_UTC - 6) %>%
  mutate(Day_MDT  = Day_UTC - as.numeric(Hour_MDT < 0),
         Hour_MDT = Hour_MDT +24* as.numeric(Hour_MDT < 0))

xy = xx %>%
  mutate(Sensor_ID = gsub('pyran', 
                          paste0('SP510-', sensor.info$SP510, collapse = ''),
                          Sensor_ID)) %>%
  mutate(Plot = sensor.info$Plot) %>%
  select(Plot, Sensor_ID, Unixtime_UTC, Month_UTC, Day_MDT, Hour_MDT, Minute, Second, Reading_type, Reading_raw)

test.moisture = xy %>%
  filter(grepl('mois', Reading_type)) %>%
  mutate(VWC = (3.879e-4)*Reading_raw - 0.6956)

test.moisture %>%
  ggplot(aes(x = Unixtime_UTC, y = VWC)) +
  geom_line()
  
test.soiltem = xy %>% filter(grepl('^T11', Sensor_ID) & grepl('temp', Reading_type))

test.soiltem %>%
  ggplot(aes(x = Unixtime_UTC, y = Reading_raw)) +
  geom_line()

test.solarwm = xy %>% filter(grepl('SP510', Sensor_ID) & grepl('volt', Reading_type)) #%>%
  # would add calibration factor in line below (save for later)
  # mutate(calib.fac = read.csv(''))

test.solarwm %>%
  ggplot() +
  geom_line(aes(x = Unixtime_UTC, y = Reading_raw))

test.battery = xy %>% filter(grepl('batt', Sensor_ID))

test.battery %>%
  ggplot() +
  geom_line(aes(x = Unixtime_UTC, y = Reading_raw))
