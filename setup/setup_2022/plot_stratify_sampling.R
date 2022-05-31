# Setup script for designating (approximate) plot locations for 2022
# Reads in a first pass of aggregated solar radiation measurements
# (mean of hourly measurements each day between May 1 and June 30)
# Routine here: bin each square into deciles for total radiation
# and sample from each decile
# I take more samples from the lower deciles than the upper ones
# (e.g., from shadier places) to increase odds of seeing
# flowering plants in shadier ares
# 28 March 2022 - SN

library(ggplot2)
library(dplyr)
library(tidyr)

# Read in a first pass at getting radiation measurements across Elk Meadows
# (May 2022)
map.svf = read.csv('setup/setup_2022/elk_mean_srad_05-27-2022.csv')

# Visualize
map.svf %>%
  mutate(mean.total = mean.dir + mean.dif) %>%
  ggplot(aes(x = x, y = y)) +
  geom_raster(aes(fill = mean.total))

map.svf = map.svf %>% mutate(mean.total = mean.dir + mean.dif)

map.svf %>%
  mutate(rank.order  = order(mean.dir)) %>%
  mutate(rank.decile = round((rank.order / nrow(.)))) %>%
  ggplot(aes(x = x, y = y, fill = rank.decile)) +
  geom_raster() +
  scale_fill_viridis_c()
# okay, order is incorrect

map.svf %>%
  mutate(rank.order  = mean.total > median(mean.total)) %>%
  ggplot(aes(x = x, y = y, fill = rank.order)) +
  geom_raster() #+
  #scale_fill_viridis_c()
# well... this looks okay

# Crop out Julian's section

map.svf %>%
  ggplot(aes(x = x, y = y)) +
  geom_raster(aes(fill = svf)) +
  geom_segment(aes(x = 453775,  xend = 453775,
                   y = 4431260, yend = 4431295))
# this is good

map.svf = map.svf %>% filter(!(x > 453775 & y < 4431295))

# Crop out sunny edge

map.svf %>%
  filter(x < 453610) %>%
  ggplot(aes(x = x, y = y)) +
  geom_raster(aes(fill = svf))

map.svf = map.svf %>% filter(x > 453610)

### Now, do stratification

map.svf %>%
  arrange(mean.total) %>%
  mutate(rad.order = ceiling((1:nrow(.) / nrow(.)) * 10)) %>%
  ggplot(aes(x = x, y = y, fill = rad.order)) +
  geom_raster() +
  scale_fill_viridis_c()

map.svf = map.svf %>%
  arrange(mean.total) %>%
  mutate(rad.decile = ceiling((1:nrow(.) / nrow(.)) * 10))

map.svf %>%
  ggplot(aes(x = x, y = y, fill = rad.decile)) +
  geom_raster() +
  scale_fill_viridis_c()

set.seed(2010)

map.svf.test = map.svf %>%
  group_by(rad.decile) %>%
  sample_n(size = ifelse(rad.decile > 6, 4, 8))

ggplot() +
  geom_tile(
    data = map.svf,
    aes(x = x, y = y, fill = svf)
  ) +
  geom_point(
    data = map.svf.test,
    aes(x = x, y = y, colour = rad.decile),
    size = 5
  ) +
  scale_fill_viridis_c() +
  scale_colour_viridis_c(option = 'A')

### Get several samples

sampling.list = vector('list', 4 * 8)

set.seed(4010489)

for (test.no in 1:length(sampling.list)) {
  sampling.list[[test.no]] = map.svf %>%
    group_by(rad.decile) %>%
    sample_n(size = ifelse(rad.decile > 6, 4, 8)) %>%
    mutate(try = test.no)
}

sampling.tries = do.call(rbind, sampling.list)

ggplot() +
  geom_tile(
    data = map.svf,
    aes(x = x, y = y, fill = svf)
  ) +
  geom_label(
    data = sampling.tries %>% filter(try %in% 9:12),
    aes(x = x, y = y, label = rad.decile),
    fill = 'black', colour = 'white', alpha = 0.5, size = 6
  ) +
  scale_fill_viridis_c() +
  facet_wrap(~ try)

# 18 is a possibility
# 22 is not bad
# maybe 32...
# 3 looks good
# I kinda like 11...

sampling.tries %>%
  filter(try %in% c(3, 11, 18, 22, 32)) %>%
  ggplot(aes(x = mean.total)) +
  geom_density() +
  geom_density(data = map.svf, colour = 'blue', linetype = 2) +
  facet_wrap(~ try)

sampling.tries %>%
  filter(try %in% c(3, 11, 18, 22, 32)) %>%
  ggplot(aes(x = mean.total)) +
  geom_density(aes(colour = factor(try)), size = 3) +
  geom_density(data = map.svf, colour = 'blue', linetype = 2) +
  scale_color_brewer(palette = 'Accent')

# 11 and 18 look kinda good to me...

sampling.tries %>%
  filter(try %in% c(3, 11, 18, 22, 32)) %>%
  group_by(try, rad.decile) %>%
  mutate(xterm = (x - mean(x))^2,
         yterm = (y - mean(y))^2) %>%
  summarise(dist = sum(sqrt(xterm + yterm))) %>%
  group_by(try) %>%
  summarise(mean.dist = mean(dist))

# hmm... looks like 18 

ggplot() +
  geom_tile(
    data = map.svf,
    aes(x = x, y = y, fill = svf)
  ) +
  geom_label(
    data = sampling.tries %>% filter(try %in% 18),
    aes(x = x, y = y, label = rad.decile),
    fill = 'black', colour = 'white', alpha = 0.5, size = 6
  ) +
  scale_fill_viridis_c()
  
# I don't like it... I love it.

ggplot() +
  geom_tile(
    data = map.svf,
    aes(x = x, y = y, fill = svf)
  ) +
  geom_point(
    data = sampling.tries %>% filter(try %in% 18),
    aes(x = x, y = y, colour = mean.total),
    size = 6
  ) +
  scale_colour_viridis_c(option = 'A') +
  scale_fill_gradient(low = 'black', high = 'gray88')

# Maybe should look a little more closely at this distribution...

rad.quantiles = quantile(map.svf$mean.total, probs = (1:9)/10) %>%
  data.frame(q = .) %>%
  mutate(x = row.names(.))

map.svf %>%
  ggplot(aes(x = mean.total)) +
  geom_density() +
  geom_segment(data = rad.quantiles,
               aes(x = q, xend = q, y = 0, yend = 0.012),
               colour = 'gray44')

map.svf %>%
  ggplot(aes(x = x, y = y)) +
  geom_raster(aes(fill = rad.decile))

# whoa... cool

# maybe pick four more plots in meadow interiors...

set.seed(600626)

sunny.extra = map.svf %>%
  filter(rad.decile %in% 9:10) %>%
  sample_n(6)

head(sunny.extra)

map.svf %>%
  ggplot(aes(x = x, y = y)) +
  geom_raster(aes(fill = svf)) +
  geom_point(
    data = sunny.extra,
    colour = 'white', shape = 'square', size = 2
  ) +
  geom_point(
    data = sampling.tries %>% filter(try %in% 18),
    colour = 'white', size = 3
  )

# one of these is kinda sucky but otherwise, very cool!!!

####

plot.locs = sampling.tries %>%
  filter(try %in% 18) %>%
  rbind(sunny.extra)

###

plot.locs %>%
  ggplot(aes(x = x, y = y)) +
  geom_raster(
    data = map.svf,
    aes(fill = svf)
  ) +
  geom_point(
    shape = 22, colour = 'black', fill = 'white', alpha = 0.5, size = 9
  ) +
  # geom_label(
  #   aes(label = rad.decile),
  #   alpha = 0.25, label.size = 0.125,
  # ) +
  geom_text(
    aes(label = rad.decile),
    hjust = 1.15, vjust = 1, size = 4
  ) +
  scale_fill_gradient(low = 'black', high = 'white') +
  theme(panel.background = element_blank(),
        legend.position = 'none')

ggsave('setup/setup_2022/elk_plot_placement_2022.pdf',
       height = 11, width = 8)

# this is the one...

# plot.locs %>%
#   ggplot(aes(x = x, y = y)) +
#   geom_raster(
#     data = map.svf,
#     aes(fill = rad.decile)
#   ) +
#   geom_point(
#     shape = 22, colour = 'black', fill = 'white', alpha = 0.25, size = 9
#   ) +
#   # geom_label(
#   #   aes(label = rad.decile),
#   #   alpha = 0.25, label.size = 0.125,
#   # ) +
#   geom_text(
#     aes(label = rad.decile),
#     hjust = 1.15, vjust = 1, size = 4
#   ) +
#   scale_fill_gradient(low = 'gray55', high = 'white') +
#   theme(panel.background = element_blank())

