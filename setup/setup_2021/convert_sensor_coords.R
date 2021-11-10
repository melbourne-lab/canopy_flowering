# Converting 2021 sensor locations into state plane coords
# points shot Nov. 7 2021 (SN + MB)
# points converted Nov. 10 2021 (SN)
# using this tutorial (courtesy of AIS):
# https://www.earthdatascience.org/courses/earth-analytics/spatial-data-r/reproject-vector-data/

library(raster)
library(rgdal)
library(rgeos)

rm(list = ls())

sens.lat.lon = read.csv('sensors_and_loggers/elk_2021_sens_latlon_2021nov8.csv')

head(sens.lat.lon)
tail(sens.lat.lon)

# Extract only coordinates for my sensors (others included here)
sens.lat.lon = sens.lat.lon[grep('scott', sens.lat.lon$sensor),]

# Convert coords to numeric
sens.lat.lon$lat  = as.numeric(gsub('[A-Z]', '', sens.lat.lon$lat))
sens.lat.lon$long = as.numeric(gsub('[A-Z]', '', sens.lat.lon$long)) * -1
# sens.lat.lon$long =  sens.lat.lon$long

# from rgdal::spTransform docs
coordinates(sens.lat.lon) = c("long", "lat")
# proj4string(sens.lat.lon) = CRS("+proj=longlat +ellps=WGS84")
proj4string(sens.lat.lon) = CRS("+proj=longlat +datum=WGS84 +no_defs +type=crs")

# According to AIS we want EPSG 32613 (email, Nov 8 2021)
sens.statepln = spTransform(sens.lat.lon, CRS("+proj=utm +zone=13 +datum=WGS84 +units=m +no_defs +type=crs"))

# Extract coords
sens.coords.sp = coordinates(sens.statepln)

# This looks good
plot(sens.coords.sp)

names(sens.coords.sp) = c('easting', 'northing')

sens.coords.all = cbind(as.data.frame(sens.lat.lon), sens.coords.sp)

names(sens.coords.all)

# Rename columns
# (the fact that names are duplicated is annoying here - need to do this a bad way)
names(sens.coords.all)[9:10] = c("east", "north")
names(sens.coords.all)

# Reorder columns
sens.coords.all = sens.coords.all[, c("sensor", "lat", "long", "elev", "east", "north",
                                      "hori_prec", "vert_prec", "pdop", "vdop")]

# Rename sensor column
sens.coords.all$sensor = gsub('scott\\_sen\\_', 's2021\\_p', sens.coords.all$sensor)

# Export
write.csv(sens.coords.all, 'sensors_and_loggers/elk_2021_sens_sp_2021-11-10.csv', row.names = FALSE)
write.csv(sens.coords.all, 'data/spatial/elk_2021_sens_sp_2021-11-10.csv', row.names = FALSE)
