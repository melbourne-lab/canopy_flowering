# For looking at the distribution of solar angles over the course of a summer at
# MRS site. Helpful for stratified sampling.

##### Setup

library(ggplot2)
library(purrr)
library(dplyr)
library(tidyr)

# Read in svf
elk.svf = read.csv('data/processed_data/elk_svf.csv')

# Read in path length object (from Musselman raytrace model)
elk.plengs = read.csv('data/processed_data/elk_roi_pathlengths.csv') %>%
  mutate(PathLen = ifelse(PathLen %in% 999, NA, PathLen))
# raw.plengs = elk.plengs

# Key linking indices for ROI raytrace object to coordinates
elk.coords = read.csv('data/processed_data/elk_roi_key.csv')

# Solar angles (estimated with SPA)
sol.angles = read.csv('setup/setup_2021/summer_angles.csv')

##### Determine region of interest

elk.svf.base = ggplot(elk.svf, aes(x = Easting, y = Northing)) +
  geom_raster(aes(fill = Svf)) +
  scale_fill_viridis_c()

elk.svf.base

# Try adding in horizontal lines to confin ROI
elk.svf.base + 
  # Horz bottom
  geom_segment(
    aes(
      x = 453600,  xend = 453950,
      y = 4431275, yend = 4431275
    ),
    colour = 'red'
  ) +
  # Horz top
  geom_segment(
    aes(
      x = 453600,  xend = 453950,
      y = 4431450, yend = 4431450
    ),
    colour = 'red'
  ) +
  # Vert right
  geom_segment(
    aes(
      x = 453950, xend = 453950,
      y = 4431450, yend = 4431275
    ),
    colour = 'red'
  )

# Looks good to me

# Subset svf (for coordinates of ROI)
elk.svf.roi = elk.svf %>%
  filter((Easting < 453950) & (Northing > 4431275) & (Northing < 4431450)) %>%
  mutate(Easting  = floor(Easting),
         Northing = floor(Northing))
# 
# coords.roi = elk.coords %>%
#   filter((X_e < 453950) & (Y_n > 4431275) & (Y_n < 4431450)) %>%
#   mutate(X_e = floor(X_e),
#          Y_n = floor(Y_n))
# 
# # Merge to get path lengths (all angles) only in the ROI
# roi.plengs = merge(
#   x = plt.plengs, y = coords.roi %>% select(-Z_e),
#   by.x = "Location", by.y = "Ind", 
#   all.x = FALSE, all.y = TRUE
# )

#### Do some processing on path length input
elk.plengs = elk.plengs %>%
  mutate(Azi = Azi * 15, Zen = Zen * 5) %>%
  merge(y = elk.coords, by = 'GlobInd')

# Get the distributions of solar angles
sol.ang.distn = sol.angles %>%
  # First requires binning azimuths and zeniths (to match raytrace object)
  # In raytrace object, azimuth is binned by 15 degrees, zenith by 5
  mutate(Azi.round = (Azimuth %/% 15) * 15,
         Zen.round = (Zenith %/% 5) * 5) %>%
  # Think I'm not interested in 8am - 9am (in sampling)
  filter(Hour > 8) %>%
  # Get distribution of combinations of azimuth and zenith
  group_by(Azi.round, Zen.round) %>%
  summarize(n = n()) %>%
  ungroup() %>%
  mutate(p = n / sum(n))

# Merge to get only angles of interest
elk.angles = merge(
  x = elk.plengs, y = sol.ang.distn,
  by.x = c("Azi", "Zen"), by.y = c("Azi.round", "Zen.round"),
  all.x = FALSE, all.y = TRUE
)

nrow(elk.angles)

# # Plot for my curious and bored brain: plot path len at one angle
# elk.angles %>%
#   filter(Azi %in% 90, Zen %in% 60) %>%
#   ggplot() +
#   geom_raster(aes(x = X_e, y = Y_n, fill = PathLen)) +
#   scale_fill_viridis_c()
# # hmm...
# # anyway

# What happens if one does a frequency-weighted mean of... some index of path lenghs
# Thinking a gaussian?
plot(0:50, exp(-(0:50)^2 / 150), type = 'l')

gauss_150 = elk.angles %>%
  mutate(gauss.pl = exp(-PathLen^2 / 150),
         gauss.pl = ifelse(is.na(gauss.pl), 0, gauss.pl)) %>%
  group_by(GlobInd) %>%
  summarise(mean.gpl = sum(p * gauss.pl),
            x_e = X_e[1], y_n = Y_n[1])

ggplot(gauss_150, aes(x = x_e, y = y_n)) +
  geom_raster(aes(fill = mean.gpl))

write.csv(gauss_150, 'setup/setup_2021/spatial_pathlength_gauss150.csv')

##### Try the stratification just on SVF.

# Subset svf (for coordinates of ROI)
elk.svf.roi = elk.svf %>%
  filter((Easting < 453950) & (Northing > 4431275) & (Northing < 4431450)) %>%
  mutate(Easting  = floor(Easting),
         Northing = floor(Northing))

elk.svf.roi$Svf

elk.roi.rank = elk.svf.roi %>% 
  arrange(Svf) %>%
  mutate(svfrank = 1:nrow(.),
         svf.res = floor(((svfrank-1) / nrow(.)) * 20) ) #%>%

elk.roi.rank %>%
  group_by(svf.res) %>%
  sample_n(size = 4) %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf)
  ) +
  geom_point(
    aes(
      x = Easting, y = Northing
    ),
    colour = 'red'
  )

elk.roi.rank %>%
  mutate(svfrank = svfrank / nrow(.)) %>%
  ggplot() +
  geom_raster(
    aes(x = Easting, y = Northing, fill = svfrank)
  ) +
  scale_fill_gradient2(low = 'red', high = 'blue',
                       mid = 'white', midpoint = 0.5)

gauss_rank = gauss_150 %>%
  arrange(mean.gpl) %>%
  mutate(gplrank = 1:nrow(.),
         gpl.res = floor(((gplrank-1) / nrow(.)) * 20) ) #%>%

set.seed(200)
gauss_rank %>%
  group_by(gpl.res) %>%
  sample_n(size = 4) %>%
  ggplot() +
  geom_raster(
    data = gauss_150,
    aes(x = x_e, y = y_n, fill = mean.gpl),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ),
    colour = 'red', size = 2
  ) +
  scale_fill_viridis_c()

set.seed(299)
test_strat = gauss_rank %>%
  group_by(gpl.res) %>%
  sample_n(size = 4)

test_strat %>%
  select(gpl.res, x_e, y_n) %>%
  dist(upper = TRUE, diag = TRUE) %>%
  as.matrix() %>%
  apply(1, function(y) min(y[y>0]))

set.seed(299)
test_strat = gauss_rank %>%
  group_by(gpl.res) %>%
  sample_n(size = 4)

liszt = vector('list', 100)

for (trial in 1:100) {
  
  liszt[[trial]] = gauss_rank %>%
    group_by(gpl.res) %>%
    sample_n(size = 4)

}

lorder = liszt %>% 
  sapply(function(x) x %>% select(gpl.res, x_e, y_n) %>% dist() %>% sum()) %>%
  order(decreasing = TRUE)

lorder = liszt %>% 
  sapply(function(x) x %>% select(gpl.res, x_e, y_n) %>% dist(upper = TRUE, diag = TRUE) %>%
           as.matrix() %>% apply(1, function(y) min(y[y>0])) %>% sum()) %>%
  order(decreasing = TRUE)

liszt[[lorder[1]]] %>%
  ggplot() +
  geom_raster(
    data = gauss_rank,
    aes(x = x_e, y = y_n, fill = gpl.res),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ),
    colour = 'red', size = 2
  ) +
  scale_fill_viridis_c()

liszt[[lorder[3]]] %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ), 
    size = 5, colour = 'white'
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n, colour = gpl.res
    ), 
    size = 4
  ) +
  scale_color_viridis_c(option = 'A') +
  scale_fill_viridis_c()

#----

# Function for dispersion among groups
block.matr.max = function(X) {
  # get distance matrix
  X %>% ungroup() %>% select(x_e, y_n) %>% dist(upper = TRUE) %>% as.matrix() %>%
    # wrapper for getting the minimum element
    mean()
}

group.dispersion.sum = function(x) {
  x %>% 
    # Perform block matrix procedure for each 
    split(.$gpl.res) %>% 
    map_dbl(block.matr.max) %>%
    # get sum across groups
    sum()
}

lorder2 = sapply(liszt, group.dispersion.sum) %>% order()


liszt[[lorder2[1]]] %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ), 
    size = 5, colour = 'white'
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n, colour = mean.gpl
    ), 
    size = 4
  ) +
  scale_color_viridis_c(option = 'A') +
  scale_fill_viridis_c()

#---

set.seed(2991)
test_strat = gauss_rank %>%
  group_by(gpl.res) %>%
  sample_n(size = ifelse(gpl.res < 10, 6, 4))

list100 = vector('list', 100)

for (trial in 1:100) {
  
  list100[[trial]] = gauss_rank %>%
    group_by(gpl.res) %>%
    sample_n(size = ifelse(gpl.res < 10, 6, 4))
  
}


liszt[[1]] %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ), 
    size = 5, colour = 'white'
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n, colour = mean.gpl
    ), 
    size = 4
  ) +
  scale_color_viridis_c(option = 'A') +
  scale_fill_viridis_c()

clorder = sapply(list100, group.dispersion.sum) %>% order()

liszt[[clorder[1]]] %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ), 
    size = 5, colour = 'white'
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n, colour = mean.gpl
    ), 
    size = 4
  ) +
  scale_color_viridis_c(option = 'A') +
  scale_fill_viridis_c()

### Actual stratification:

gauss.gpl = read.csv('setup/setup_2021/spatial_pathlength_gauss150.csv')

## Do stratification

# Get rank of mean gpl for each point in ROI
gauss.rank = gauss.gpl %>%
  select(-X) %>%
  arrange(mean.gpl) %>%
  mutate(gplrank = 1:nrow(.),
         gpl.res = floor(((gplrank-1) / nrow(.)) * 20) )

set.seed(2991)

# Object to store random samples
list.strats = vector('list', 100)

# Do stratified sampling routine (100 times)
for (trial in 1:100) {
  
  list.strats[[trial]] = gauss.rank %>%
    group_by(gpl.res) %>%
    sample_n(size = ifelse(gpl.res < 5, 6, 4))
  
}

## Wrapper functions for gettng disperson

# Function for dispersion among groups
block.matr.max = function(X) {
  # get distance matrix
  X %>% ungroup() %>% select(x_e, y_n) %>% dist(upper = TRUE) %>% as.matrix() %>%
    # wrapper for getting the minimum element
    mean()
}

group.dispersion.sum = function(x) {
  x %>% 
    # Perform block matrix procedure for each 
    split(.$gpl.res) %>% 
    map_dbl(block.matr.max) %>%
    # get sum across groups
    sum()
}

# Get dispersion rank for each sample

lorder = sapply(list.strats, group.dispersion.sum) %>% order()

# Plot to inspect
# Plotting most dispersed
list.strats[[lorder[1]]] %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ), 
    size = 5, colour = 'white'
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n, colour = mean.gpl
    ), 
    size = 4
  ) +
  scale_color_viridis_c(option = 'A') +
  scale_fill_viridis_c()

# Trying second, third, etc...
list.strats[[lorder[3]]] %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ), 
    size = 5, colour = 'white'
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n, colour = mean.gpl
    ), 
    size = 4
  ) +
  scale_color_viridis_c(option = 'A') +
  scale_fill_viridis_c()
# I like this one

list.strats[[lorder[3]]] %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n
    ), 
    size = 5, colour = 'white'
  ) +
  geom_point(
    aes(
      x = x_e, y = y_n, colour = mean.gpl
    ), 
    size = 4
  ) +
  scale_color_viridis_c(option = 'A') +
  scale_fill_viridis_c()
# I like this one

plot.positions = list.strats[[lorder[3]]]

plot.positions %>%
  ggplot() +
  geom_raster(
    data = elk.svf.roi,
    aes(x = Easting, y = Northing, fill = Svf),
    alpha = 0.8
  ) +
  geom_label(
    aes(
      x = x_e, y = y_n, label = round(mean.gpl, 2)
    ), 
    size = 2, fill = 'white'
  ) +
  scale_fill_gradient(low = 'black', high = 'white') +
  theme_bw() +
  theme(legend.position = 'none') +
  ggsave('setup/setup_2021/plot_raw_full.png', width = 11, height = 8)

write.csv(plot.positions, row.names = FALSE,
          'setup/setup_2021/plot_init_coords.csv')

