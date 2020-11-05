# Exploring the solar radiation data in the dataset.
# SN - Nov. 5 2020

library(ggplot2)
library(dplyr)
library(tidyr)

grid.points = read.csv('data/solar_data/elk_coords_svf.csv')

head(grid.points)

plot.points = read.csv('data/spatial/2020_plot_coords.csv') %>%
  filter(grepl('^p', Label))

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


