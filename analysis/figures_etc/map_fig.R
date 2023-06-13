##### Script for creating Figure 1

##### Setup

# Load packages
library(ggplot2)
library(cowplot)
library(raster)
library(dplyr)
library(tidyr)
library(rgdal)

# Clear namespace
rm(list = ls())

# Ensure select function is correct
select = dplyr::select

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
  ungroup() %>%
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

nrow(phen.all)

##### Read in SVF data

# Load in whole SVF
svf.all = read.csv('data/spatial/elk_svf_uav_long_c1.csv')

ggplot(svf.all, aes(x = easting, y = northing)) +
  geom_tile(aes(fill = svf)) +
  scale_fill_viridis_c(option = 'A')


##### Slope and aspect data

asp = raster('data/spatial/NEON_D13_NIWO_DP3_453000_4431000_aspect.tif')

asp.df = cbind(coordinates(asp), aspect = cos(values(asp) * pi / 180)) %>% as.data.frame()

ggplot(asp.df, aes(x = x, y = y, fill = aspect)) + 
  geom_raster() +
  scale_fill_gradient2(low = 'orange', high = 'purple', mid = 'white', midpoint = 0)

slp = raster('data/spatial/NEON_D13_NIWO_DP3_453000_4431000_slope.tif')

slp.df = cbind(coordinates(slp), slopes = sin(values(slp) * pi / 180)) %>% as.data.frame()

ggplot(slp.df, aes(x = x, y = y, fill = slopes)) + geom_raster() +
  scale_fill_gradient(low = 'white', high = 'black')

##### Read in orthomosaic

ort = stack('data/spatial/2020_NIWO_4_453000_4431000_image.tif')

# Crop (I'm sure there's a better way to do this)
ex0 = extent(ort)

ex1 = ex0
ex1[1] = 453600
ex1[2] = 453975
ex1[3] = 4431250
ex1[4] = 4431475

ort = crop(ort, ex1)

odf = cbind(
  as.data.frame(coordinates(ort)),
  as.data.frame(values(ort))
) %>%
  mutate(hex = rgb(red   = X2020_NIWO_4_453000_4431000_image_1,
                   green = X2020_NIWO_4_453000_4431000_image_2,
                   blue  = X2020_NIWO_4_453000_4431000_image_3,
                   maxColorValue = 255)) 

head(odf)

odf %>%
  ggplot(aes(x = x, y = y, fill = hex)) +
  geom_raster() +
  scale_fill_identity()

##### Plot elements

pan.a = odf %>%
  ggplot(aes(x = x, y = y, fill = hex)) +
  geom_raster() +
  geom_point(
    data = coords.all,
    inherit.aes = FALSE,
    aes(x = Easting, y = Northing, shape = factor(Year)),
    size = 2, alpha = 0.4, colour = 'black', fill = 'white'
  ) +
  scale_fill_identity() +
  scale_shape_manual(values = 21:23) +
  labs(x = '', y = '') +
  theme(
    plot.margin = margin(t = -0.2, r = -0.2, b = -0.2, l = -0.2),
    panel.background = element_blank(),
    axis.text = element_text(size = 6),
    legend.position = 'none'
  )

pan.b = svf.all %>%
  ggplot(aes(x = easting, y = northing, fill = svf)) +
  geom_raster() +
  geom_point(
    data = coords.all,
    inherit.aes = FALSE,
    aes(x = Easting, y = Northing, shape = factor(Year)),
    size = 2, alpha = 0.4, colour = 'black', fill = 'white'
  ) +
  scale_fill_viridis_c(option = 'A') +
  scale_shape_manual(values = 21:23) +
  labs(x = '', y = '') +
  theme(
    plot.margin = margin(t = -0.2, r = -0.2, b = -0.2, l = -0.2),
    panel.background = element_blank(),
    axis.text = element_text(size = 6),
    legend.position = 'none'
  )

pan.c = asp.df %>%
  filter(y < 4431476, y > 4431249, x < 453976, x > 453599) %>%
  ggplot(aes(x = x, y = y, fill = aspect)) +
  geom_raster() +
  geom_point(
    data = coords.all,
    inherit.aes = FALSE,
    aes(x = Easting, y = Northing, shape = factor(Year)),
    size = 2, alpha = 0.4, colour = 'black', fill = 'white'
  ) +
  scale_fill_gradient2(low = 'orange', high = 'purple', mid = 'white') +
  scale_shape_manual(values = 21:23) +
  labs(x = '', y = '') +
  theme(
    plot.margin = margin(t = -0.2, r = -0.2, b = -0.2, l = -0.2),
    panel.background = element_blank(),
    axis.text = element_text(size = 6),
    legend.position = 'none'
  )

pan.d = slp.df %>%
  filter(y < 4431476, y > 4431249, x < 453976, x > 453599) %>%
  ggplot(aes(x = x, y = y, fill = slopes)) +
  geom_raster() +
  geom_point(
    data = coords.all,
    inherit.aes = FALSE,
    aes(x = Easting, y = Northing, shape = factor(Year)),
    size = 2, alpha = 0.4, colour = 'black', fill = 'white'
  ) +
  scale_fill_gradient(low = 'white', high = 'black') +
  scale_shape_manual(values = 21:23) +
  labs(x = '', y = '') +
  theme(
    plot.margin = margin(t = -0.2, r = -0.2, b = -0.2, l = -0.2),
    panel.background = element_blank(),
    axis.text = element_text(size = 6),
    legend.position = 'none'
  )

leg.a = get_legend(pan.a + theme(legend.position = 'right') + guides(shape = guide_legend('Year')))

leg.b = get_legend(pan.b + theme(legend.position = 'right') + guides(fill = guide_legend('SVF'), shape = 'none'))

leg.c = get_legend(pan.c + theme(legend.position = 'right') + guides(fill = guide_legend('Aspect'), shape = 'none'))

leg.d = get_legend(pan.d + theme(legend.position = 'right') + guides(fill = guide_legend('Slope'), shape = 'none'))

plot_grid(
  pan.a, leg.a, pan.b, leg.b, pan.c, leg.c, pan.d, leg.d,
  nrow = 4, rel_widths = c(1, .15, 1, .15, 1, .15, 1, .15)
) %>%
  save_plot(
    filename = 'analysis/figures_etc/fig_out/map_fig.png',
    base_width = 5, base_height = 8
  )
