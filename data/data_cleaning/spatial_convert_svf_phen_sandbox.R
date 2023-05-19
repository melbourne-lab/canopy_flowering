# Testing converting a batch of coords and merging them with phen (!)

library(ggplot2)
library(dplyr)
library(tidyr)
library(rgdal)

rm(list = ls())

coords.05.16 = read.csv('data/spatial/2021-2022_plot_coords_2023-05-16.csv')

# Conversion code borrowed from:
# http://rstudio-pubs-static.s3.amazonaws.com/19879_7e13ab80d5ed416c8e235bd6bb93cf3e.html

coords.pre = SpatialPoints(coords.05.16[,c("Longitude", "Latitude")],
                           proj4string = CRS("+proj=longlat"))

# ESPG code 26913 corresponds to UTM zone that covers colorado
coords.utm = spTransform(coords.pre, CRS("+init=epsg:26913"))

coords.05.16 = coords.05.16 %>%
  select(-c(Easting, Northing)) %>%
  cbind(
    coords.utm %>%
      as.data.frame() %>%
      rename(Easting = Longitude, Northing = Latitude)
  )

phen20 = read.csv('data/processed_data/therm_draft_01-12-2021.csv')

head(phen20)

phen21 = read.csv('data/processed_data/thermopsis_cleaned_2021.csv')

head(phen21)

phen22 = read.csv('data/processed_data/thermopsis_cleaned_2022.csv')

head(phen22)

phen.all = rbind(
  phen20 %>%
    select(Date, Plot, Tag, Racemes, Infl_spread, Infl_done) %>%
    rename(N_infl = Racemes, Fl_open = Infl_spread, Fl_done = Infl_done),
  phen21 %>%
    select(Date, Plot, Tag, Fl_Stems, Fl_Open, Fl_Done) %>%
    rename(N_infl = Fl_Stems, Fl_open = Fl_Open, Fl_done = Fl_Done),
  phen22 %>%
    select(Date, Plot, Tag, N_infl, Fl_open, Fl_done)
)

head(phen.all)
str(phen.all)

phen.all = phen.all %>%
  separate(Date, into = c('Year', 'Month', 'Day'), sep = '-') %>%
  mutate(Mon_Day = paste(Month, Day, sep = '-')) %>%
  mutate(JDay    = as.Date(Mon_Day, '%m-%d') - as.Date('2023-06-01', '%Y-%m-%d')) %>%
  mutate(Plot = paste(Plot, Year, sep = '_'))

phen.fl = phen.all %>% filter(Fl_open > 0 | Fl_done > 0)

nrow(phen.fl)
length(unique(phen.fl$Plot)) # lol neat

phen.init = phen.fl %>% group_by(Plot, Tag) %>% summarise(start.date = min(JDay)) %>% ungroup()

### Load in other spatial data

spatials = read.csv('../UAV-b-solar-radiation/02_skyview/out/elk_svf_uav_long_c1.csv') %>%
  mutate(easting = floor(easting), northing = floor(northing))

spat20 = read.csv('../UAV-b-solar-radiation/00_setup/elk_meadow_data/coords_asp_slp_2020.csv') %>%
    mutate(X_Easting = floor(X_Easting), Y_Northing = round(Y_Northing)) %>%
    mutate(Label = gsub('^p', '', Label))
# hmm... I don't have slope/aspect for the other points yet. oh well

all.plot.coords = rbind(
  spat20 %>% 
    rename(Plot = Label, northing = Y_Northing, easting = X_Easting) %>% 
    select(Plot, northing, easting) %>%
    mutate(Plot = paste(Plot, '2020', sep = '_')),
  coords.05.16 %>% 
    rename(Plot = Name, easting = Easting, northing = Northing) %>% 
    select(Plot, northing, easting) %>%
    mutate(
      northing = round(northing), 
      easting = floor(easting),
      Plot = paste(Plot, ifelse(as.numeric(Plot) > 100, 2022, 2021), sep = '_')
    )
)

head(all.plot.coords)
head(phen.init)

omg = merge(phen.init, all.plot.coords) %>%
  mutate(Year = gsub('\\d{1,}\\_', '', Plot)) %>%
  merge(spatials)

head(omg)
nrow(omg)

ggplot() +
  geom_tile(
    data = spatials,
    aes(x = easting, y = northing, fill = svf)
  ) +
  geom_point(
    data = omg,
    aes(x = easting, y = northing),
    size = 2
  ) +
  geom_point(
    data = omg,
    aes(x = easting, y = northing, colour = Year),
  ) +
  scale_fill_viridis_c()

omg %>% distinct(Plot, Year) %>% group_by(Year) %>% summarise(n = n())
# lol

omg %>% ggplot(aes(x = Year, y = svf)) + geom_point()
# whoa...

omg %>%
  mutate(start.date = as.numeric(start.date)) %>%
  ggplot(aes(x = svf, y = start.date)) +
  geom_point(aes(colour = Year), alpha = 0.25)

# killaaa

omg %>% distinct(Plot) %>% nrow()
omg %>% distinct(Plot, Tag) %>% nrow()

omg %>%
  mutate(start.date = as.numeric(start.date)) %>%
  ggplot(aes(x = svf, y = start.date)) +
  geom_point(aes(colour = Year), position = position_jitter(width = 0.001), size = 3)

omg %>%
  mutate(start.date = as.numeric(start.date)) %>%
  ggplot(aes(x = svf, y = start.date)) +
  geom_point(position = position_jitter(width = 0.001), size = 3) +
  facet_wrap(~ Year)

ggplot() +
  geom_tile(
    data = spatials,
    aes(x = easting, y = northing, fill = svf)
  ) +
  geom_point(
    data = omg,
    aes(x = easting, y = northing, shape = Year),
    size = 4
  ) +
  geom_point(
    data = omg %>% mutate(start.date = as.numeric(start.date)),
    aes(x = easting, y = northing, colour = start.date, shape = Year),
    size = 3
  ) +
  scale_colour_viridis_c(option = 'B') +
  scale_fill_viridis_c()
