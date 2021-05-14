# For looking at the distribution of solar angles over the course of a summer at
# MRS site. Helpful for stratified sampling.

##### Setup

library(ggplot2)
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

# # Subset svf (for coordinates of ROI)
# elk.svf.roi = elk.svf %>% 
#   filter((Easting < 453950) & (Northing > 4431275) & (Northing < 4431450)) %>%
#   mutate(Easting  = floor(Easting),
#          Northing = floor(Northing))
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
