# Plots for thesis proposal and presentation

library(cowplot)
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

### Plot of plant phenology over the radiation gradient

library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls())

rs.sum = read.csv('data/solar_data/musselman_elk_2020_est-09-21.csv') %>%
  filter(!is.na(Rs)) %>%
  group_by(Plot) %>%
  summarise(summed.rs = sum(Rs))

# Read in Thermopsis data
therm = read.csv('data/processed_data/therm_draft_01-12-2021.csv') 

# Aggregated Thermopsis data (initiation of flowering per plant)
therm.init = therm %>%
  mutate(Infl_spread = ifelse(is.na(Infl_spread), 0, Infl_spread),
         Infl_done   = ifelse(is.na(Infl_done), 0, Infl_done)) %>%
  filter(Infl_spread + Infl_done > 0) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(Plot, Tag, Date) %>%
  merge(y = rs.sum, by = 'Plot') %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(Date = as.numeric(Date - min(Date)))

# Full data with initiation + end of flowering, number of flowers,
# and mean date of flowering
therm.allobs = therm %>%
  mutate(Infl_spread = ifelse(is.na(Infl_spread), 0, Infl_spread),
         Infl_done   = ifelse(is.na(Infl_done), 0, Infl_done),
         Date = as.numeric(as.Date(Date))) %>%
  filter(Infl_spread + Infl_done > 0) %>%
  group_by(Plot, Tag) %>%
  summarise(First.date = min(Date),
            mean.date = weighted.mean(Date, w = Infl_spread),
            last.date = max(Date[Infl_spread > 0]),
            n.fl = max(Infl_spread + Infl_done)) %>%
  merge(y = rs.sum, by = 'Plot')

therm.plot = therm.allobs %>%
  mutate(summed.rs = summed.rs / 1000) %>%
  filter(last.date > -Inf) %>%
  mutate(first.date = as.Date(First.date, origin = '1970-01-01'),
         last.date  = as.Date(last.date, origin = '1970-01-01'),
         mean.date = as.Date(mean.date, origin = '1970-01-01')) %>%
  ggplot(aes(x = summed.rs, xend = summed.rs)) +
  geom_segment(aes(y = first.date, yend = last.date),
               size = 0.5, colour =  'gold',
               position = position_dodge(width = 15)) +
  geom_point(aes(y = mean.date, size = n.fl),
             position = position_dodge(width = 15),
             fill = 'gold', shape = 21) +
  scale_size_continuous("Flowers per plant") +
  #scale_x_continuous(breaks = NULL) +
  labs(x = 'Solar radiation (kW/m2)', y = 'Date') +
  theme(panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.title = element_text(size = 16),
        axis.text  = element_text(size = 12),
        legend.position = 'bottom')

# ggsave('~/Documents/Research/boulder/fifth_semester/plots_figs/therm2020res.png')

# Campanula data
campa = read.csv('data/processed_data/campn_draft_01-12-2021.csv')

# First date of flowering only
campa.final = campa %>%
  mutate(Fl_straight = ifelse(is.na(Fl_straight), 0, Fl_straight),
         Fl_curled   = ifelse(is.na(Fl_curled), 0, Fl_curled),
         Fl_done     = ifelse(is.na(Fl_done), 0, Fl_done)) %>%
  filter(Fl_straight + Fl_curled + Fl_done > 0) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(Plot, Tag, Date) %>%
  merge(y = rs.sum, by = 'Plot')

# First, last, mean date, plus number of flowers
campa.allobs = campa %>%
  mutate(Fl_straight = ifelse(is.na(Fl_straight), 0, Fl_straight),
         Fl_curled   = ifelse(is.na(Fl_curled), 0, Fl_curled),
         Fl_done     = ifelse(is.na(Fl_done), 0, Fl_done)) %>%
  filter(Fl_straight + Fl_curled + Fl_done > 0) %>%
  mutate(Date = as.numeric(as.Date(Date))) %>%
  group_by(Plot, Tag) %>%
  summarise(first.date = min(Date),
            mean.date = weighted.mean(Date, w = (Fl_straight + Fl_curled)),
            last.date = max(Date[Fl_straight + Fl_curled > 0]),
            n.fl = max(Fl_straight + Fl_curled + Fl_done)) %>%
  merge(y = rs.sum, by = 'Plot')

campa.plot = campa.allobs %>%
  mutate(summed.rs = summed.rs / 1000) %>%
  filter(last.date > -Inf) %>%
  mutate(first.date = as.Date(first.date, origin = '1970-01-01'),
         last.date  = as.Date(last.date, origin = '1970-01-01'),
         mean.date = as.Date(mean.date, origin = '1970-01-01')) %>%
  ggplot(aes(x = summed.rs, xend = summed.rs)) +
  geom_segment(aes(y = first.date, yend = last.date),
               size = 0.5, colour =  'slateblue2',
               position = position_dodge(width = 15)) +
  geom_point(aes(y = mean.date, size = n.fl),
             position = position_dodge(width = 15),
             fill = 'slateblue2', shape = 21) +
  scale_size_continuous("Flowers per plant") +
  # scale_x_continuous(breaks = NULL) +
  labs(x = 'Solar radiation (kW/m2)', y = '') +
  theme(panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.title = element_text(size = 16),
        axis.text  = element_text(size = 12),
        legend.position = 'bottom')

# ggsave('~/Documents/Research/shade/presentations/ipwa2021/campa2020res.png')

plot_grid(therm.plot, campa.plot, nrow = 1,
          labels = c('A)', 'B)')) %>%
  save_plot(filename = '~/Documents/Research/boulder/fifth_semester/plots_figs/phen_plot.pdf',
            base_asp = 2.5)
