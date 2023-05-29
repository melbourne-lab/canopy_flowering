##### Final script for merging together:
# - All phenology data
# - Coordinates
# - SVF
# SN 28 May 2023

##### Setup

# Load packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(rgdal)

# Clear namespae

##### Load in data

### Coordinate data (2021 - 2022 data)
coords.2122 = rbind(
  read.csv('data/spatial/2021-2022_plot_coords_2023-05-16.csv'),
  read.csv('data/spatial/2021-2022_plot_coords_2023-05-23_1.csv'),
  read.csv('data/spatial/2021-2022_plot_coords_2023-05-23_2_raw.csv'),
  read.csv('data/spatial/2021-2022_plot_coords_2023-05-28_1_raw.csv'),
  read.csv('data/spatial/2021-2022_plot_coords_2023-05-28_2_raw.csv')
)

# Check for duplicates
coords.2122 %>%
  group_by(Name) %>%
  filter(n() > 1) %>%
  select(Name, Latitude, Longitude) %>%
  arrange(Name) %>%
  as.data.frame()

coords.2122 = coords.2122 %>%
  group_by(Name) %>%
  summarise_at(vars(Latitude, Longitude), mean)

# Convert coordinates

coords.pre = SpatialPoints(coords.2122[,c("Longitude", "Latitude")],
                           proj4string = CRS("+proj=longlat"))

# ESPG code 26913 corresponds to UTM zone that covers colorado
coords.utm = spTransform(coords.pre, CRS("+init=epsg:26913"))

coords.2122 = coords.2122 %>%
  select(Name) %>%
  cbind(
    coords.utm %>%
      as.data.frame() %>%
      rename(Easting = Longitude, Northing = Latitude)
  )

### Coordinate data (2020)
coords.20 = read.csv('../UAV-b-solar-radiation/00_setup/elk_meadow_data/coords_asp_slp_2020.csv') %>%
  select(Easting = X_Easting, Northing = Y_Northing, Name = Label) %>%
  select(Name, Easting, Northing) %>%
  mutate(Name = gsub('^p', '', Name))

### Combine
# (note: gets rid of sensor coordinates, which is fine)
coords.all = rbind(
  coords.20 %>% mutate(Year = 2020),
  coords.2122 %>%
    filter(!grepl('[A-Z]', Name)) %>% 
    mutate(Year = 2021 + as.numeric(as.numeric(Name) > 100))
)

# Plot of all coordinates (in Easting/Northing)
coords.all %>% 
  mutate(Year = factor(Year)) %>%
  ggplot(aes(x = Easting, y = Northing, colour = Year)) + 
  geom_label(aes(label = Name))

##### Read in and process phenology data

phen.all = rbind(
  # Read CSVs, get relevant columns, fix column names
  read.csv('data/processed_data/therm_draft_01-12-2021.csv') %>%
    # Remove plants that are outside plot (on corner)
    group_by(Plot, Tag) %>%
    filter(!any(grepl('OUTSIDE', Note))) %>%
    ungroup() %>%
    select(Date, Plot, Tag, Racemes, Infl_spread, Infl_done, Note) %>%
    rename(N_infl = Racemes, Fl_open = Infl_spread, Fl_done = Infl_done),
  read.csv('data/processed_data/thermopsis_cleaned_2021.csv') %>%
    select(Date, Plot, Tag, Fl_Stems, Fl_Open, Fl_Done, Note) %>%
    rename(N_infl = Fl_Stems, Fl_open = Fl_Open, Fl_done = Fl_Done),
  read.csv('data/processed_data/thermopsis_cleaned_2022.csv') %>%
    select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Notes) %>%
    rename(Note = Notes)
) %>%
  # Process dates
  mutate(Year = gsub('\\-\\d{2}\\-\\d{2}', '', Date)) %>%
  mutate(JDate = as.Date(Date, format = '%Y-%m-%d') - as.Date(paste0(Year, '-05-31'), format = '%Y-%m-%d')) %>%
  # Get only records for plants with flowers
  filter(Fl_open > 0 | Fl_done > 0)

nrow(phen.all)

##### Read in SVF data

# Load in whole SVF
svf.all = read.csv('../UAV-b-solar-radiation/02_skyview/out/elk_svf_uav_long_c1.csv')

ggplot(svf.all, aes(x = easting, y = northing)) +
  geom_tile(aes(fill = svf)) +
  scale_fill_viridis_c(option = 'A')

##### Merge all together

all.data = merge(
  x = svf.all %>%
    mutate(Easting = floor(easting), Northing = floor(northing)) %>%
    select(Easting, Northing, svf),
  y = coords.all %>%
    mutate(Easting = floor(Easting), Northing = floor(Northing))
) %>%
  rename(Plot = Name) %>%
  merge(phen.all, by = c('Plot', 'Year'))

nrow(all.data) # looks like a lot! should do some data vetting.

all.data %>% distinct(Year, Plot) %>% nrow() # 95 points in space... could be much worse
all.data %>% distinct(Tag, Year, Plot) %>% nrow() # 491 plants... not bad.

##### First pass visualizations

all.data %>%
  mutate(Year = factor(Year)) %>%
  filter(Fl_open > 0) %>%
  ggplot(aes(x = svf, y = JDate)) +
  geom_point(aes(colour = Year), size = 3, alpha = 0.5)

all.data %>%
  mutate(Year = factor(Year)) %>%
  filter(Fl_open > 0) %>%
  ggplot(aes(x = svf, y = JDate)) +
  geom_point(aes(colour = Year), size = 3, alpha = 0.5)

all.data %>%
  mutate(Year = factor(Year)) %>%
  filter(Fl_open > 0) %>%
  group_by(Plot, Tag, Year) %>%
  summarise(date.open = mean(as.numeric(JDate)), svf = svf[1]) %>%
  ggplot(aes(x = svf, y = date.open)) +
  geom_point(aes(colour = Year), size = 3, alpha = 0.5)

all.data %>%
  mutate(Year = factor(Year)) %>%
  filter(Fl_open > 0) %>%
  group_by(Plot, Tag, Year) %>%
  summarise(date.open = mean(as.numeric(JDate))) %>%
  group_by(Plot, Year = factor(Year)) %>%
  summarise(mean.date.open = mean(date.open), n = n()) %>%
  merge(y = all.data %>% 
          distinct(Plot, Year, .keep_all = TRUE) %>%
          select(Plot, Year, Easting, Northing, svf)) %>%
  ggplot(aes(x = Easting, y = Northing)) +
  geom_tile(data = svf.all %>% filter(northing > 4431250, northing < 4431500), 
            aes(x = easting, y = northing, fill = svf)) +
  # geom_point(aes(colour = svf, shape = Year), size = 5) +
  geom_point(aes(colour = mean.date.open, shape = Year), size = 3) +
  scale_fill_continuous(low = 'black', high = 'white') +
  scale_colour_viridis_c(option = 'A')
# not as compelling as I was hoping... workshop this.

all.data %>%
  mutate(Year = factor(Year)) %>%
  filter(Fl_open > 0) %>%
  group_by(Plot, Tag, Year) %>%
  summarise(date.open = mean(as.numeric(JDate))) %>%
  merge(y = all.data %>% 
          distinct(Plot, Year, .keep_all = TRUE) %>%
          select(Plot, Year, Easting, Northing, svf)) %>%
  ggplot(aes(x = Easting, y = Northing)) +
  geom_tile(data = svf.all %>% filter(northing > 4431250, northing < 4431500), 
            aes(x = easting, y = northing, fill = svf)) +
  geom_point(aes(colour = date.open, shape = Year), 
             position = position_jitter(width = 3, height = 3), size = 2) +
  scale_fill_continuous(low = 'gray44', high = 'white') +
  scale_colour_viridis_c(option = 'A')
# this one might be better...

all.data %>%
  mutate(JDay = as.numeric(JDate)) %>%
  select(-JDate) %>%
  write.csv(
    file = 'data/processed_data/phen_svf_coords_combined.csv',
    row.names = FALSE, na = ''
  )
