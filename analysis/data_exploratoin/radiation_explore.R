# Exploring the solar radiation data in the dataset.
# SN - Nov. 5 2020

library(ggplot2)
library(dplyr)
library(tidyr)

grid.points = read.csv('data/solar_data/elk_coords_svf.csv')

head(grid.points)

plot.points = read.csv('data/spatial/2020_plot_coords.csv') %>%
  filter(grepl('^p', Label)) %>%
  select(-Z.Altitude)

head(plot.points)

# Thinking that merging can happen by rounding?
# How much error does that introduce?

grid.points %>% 
  mutate(X_East_r = X_East - 0.5) %>%
  ggplot() +
  geom_raster(aes(x = X_East_r, y = Y_North, fill = svf)) +
  geom_point(aes(x = X_Easting, Y_Northing), col = 'white',
             data = plot.points %>%
               mutate(X_Easting = round(X.Easting),
                      Y_Northing = round(Y.Northing))) +
  geom_point(aes(x = X.Easting, Y.Northing), col = 'white', shape = 'triangle',
             data = plot.points)

# Okay, idea: Round up and down (keeping original coords), merge,
# then for each plot with multiple hits in the merge, keep the one that's closest
double.merge = plot.points %>%
  mutate(X_round = round(X.Easting), Y_round = round(Y.Northing)) %>%
  merge(
    y = grid.points %>% 
      select(ElementNo, X_East, Y_North) %>%
      mutate(x_up = ceiling(X_East), y_up = ceiling(Y_North)),
    by.x = c("X_round", "Y_round"), by.y = c("x_up", "y_up"),
    suffixes = c("", "_up"),
    all.x = TRUE
  ) %>%
  merge(
    y = grid.points %>% 
      select(ElementNo, X_East, Y_North) %>%
      mutate(x_down = floor(X_East), y_down = floor(Y_North)),
    by.x = c("X_round", "Y_round"), by.y = c("x_down", "y_down"),
    suffixes = c("", "_down"),
    all.x = TRUE
  )

nrow(double.merge)
double.merge

# double.merge %>%
#   rename(ElementNo_up = ElementNo,
#          X_East_up = X_East,
#          Y_North_up = Y_North) %>%
#   pivot_longer(cols = starts_with(c("ElementNo", "X_East")),
#                names_to = c("eldir", "xtype"),
#                names_sep = '-',
#                values_to = c("elno", "xcoord"))
#   pivot_longer(cols = starts_with(c("ElementNo", "X_East", "Y_North")),
#                names_to = c("x", "y", "z"),
#                names_sep = "-",
#                values_to = c("a","b", "c"))

solar.plots = double.merge %>%
  # Get errors introduced by rounding
  # I.e., how much are each of the grid cells (corners?) off from the coordinate of the plot
  mutate(err_up = sqrt((X_East - X.Easting)^2 + (Y_North - Y.Northing)^2),
         err_dn = sqrt((X_East_down - X.Easting)^2 + (Y_North_down - Y.Northing)^2),
         down_correct = err_dn < err_up) %>%
  select(-c(X_round, Y_round, X_East, X_East_down, 
            Y_North, Y_North_down, err_up, err_dn)) %>%
  gather(c(ElementNo, ElementNo_down), key = 'dir', value = 'ElementNo') %>%
  mutate(is_down = grepl('down$', dir)) %>%
  filter(down_correct == is_down) %>%
  select(-c(down_correct, is_down, dir)) %>%
  merge(y = grid.points, by = "ElementNo", all.x = TRUE) %>%
  rename(X_plot = X.Easting, Y_plot = Y.Northing,
         X_solr = X_East, Y_solr = Y_North) %>%
  # Rearrange cols
  # (note: removing elementno here - may be worth keeping if the df expands
  # to include more info from the solar radiation model)
  select(Label, svf, X_plot, Y_plot, X_solr, Y_solr, Z_elev)

hist(solar.plots$svf)
# hmm...

solar.plots %>%
  ggplot() +
  geom_point(aes(x = X_plot, y = Y_plot, colour = svf),
             size = 4)

solar.plots %>%
  ggplot() +
  geom_point(aes(x = X_plot, y = Y_plot, colour = svf),
             size = 4) +
  scale_color_gradient2(low = 'black', mid = 'white',
                        high = 'yellow', midpoint = 0.8)
# hmmm

median(solar.plots$svf)
# goddamnit
quantile(solar.plots$svf)

solar.plots %>%
  mutate(svf.order = order(svf)) %>%
  ggplot() +
  geom_point(aes(x = X_plot, y = Y_plot, colour = svf.order),
             size = 4) +
  scale_colour_viridis_c(option = 'B')
