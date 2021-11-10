# Plots for thesis proposal and presentation

library(ggplot2)
library(dplyr)
library(tidyr)

### Plot of solar radiation estimates at three plots

# Read in solar radiation estimates from Keith M's model (apparently generated 9/21)
a = read.csv('data/solar_data/musselman_elk_2020_est-09-21.csv')

# Plot
a %>%
  filter(Plot %in% 16:18) %>%
  filter(!is.na(Rs)) %>%
  mutate(doy = factor(paste0(Month, '/', ifelse(Date > 9, Date, paste0('0', Date))))) %>%
  ggplot(aes(x = Hour + Minute/60, y = Rs)) +
  geom_line(aes(group = doy, colour = doy)) +
  labs(x = 'Hour', y = 'Estimated radiation (W/m2)') +
  facet_wrap(~ Plot) +
  guides(colour = guide_legend('')) +
  theme_minimal() +
  theme(legend.position = 'bottom')

ggsave('~/Documents/Research/boulder/fifth_semester/plots_figs/three_plots_plot.pdf',
       width = 8, height = 4)
