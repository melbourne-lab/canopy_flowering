library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls())

rs.est = read.csv('data/solar_data/musselman_elk_2020_est-09-21.csv') %>%
  filter(!is.na(Rs))

head(rs.est)

rs.est %>%
  filter(Plot %in% 11:19) %>%
  mutate(time.dec = Hour + Minute/60) %>%
  ggplot(aes(x = time.dec, y = Rs, group = interaction(Month, Date))) +
  geom_line(aes(colour = interaction(Month, Date))) +
  facet_wrap(~ Plot)

rs.sum = rs.est %>%
  group_by(Plot) %>%
  summarise(summed.rs = sum(Rs))

rs.sum

rs.sum %>%
  ggplot(aes(summed.rs)) +
  geom_density()

rs.sum %>%
  ggplot(aes(x = Plot, y = summed.rs, label = Plot)) +
  geom_label()

therm = read.csv('data/processed_data/therm_draft_01-12-2021.csv')

# oh lmao gotta aggregate this stuff

therm.final = therm %>%
  mutate(Infl_spread = ifelse(is.na(Infl_spread), 0, Infl_spread),
         Infl_done   = ifelse(is.na(Infl_done), 0, Infl_done)) %>%
  filter(Infl_spread + Infl_done > 0) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(Plot, Tag, Date) %>%
  merge(y = rs.sum, by = 'Plot')

therm.final %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(Date = Date - min(Date)) %>%
  ggplot(aes(x = summed.rs, y = Date)) +
  geom_point(position = position_jitter(height = 0.5)) +
  stat_smooth()

therm.final = therm.final %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(Date = as.numeric(Date - min(Date)))
  
therm2 = lm(Date ~ poly(summed.rs, 2), therm.final)

summary(therm2)
plot(therm2)

therm.final %>%
  mutate(Date = as.Date(Date)) %>%
  ggplot(aes(x = summed.rs, y = Date)) +
  geom_point(shape = 21, fill = 'goldenrod', size = 4)

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

therm.allobs %>%
  # filter(Infl_spread > 0) %>%
  mutate(First.date = as.Date(First.date, origin = '1970-01-01')) %>%
  ggplot(aes(x = summed.rs, y = First.date)) +
  geom_point(aes(size = n.fl), shape = 21, fill = 'goldenrod')

therm.allobs %>%
  # filter(Infl_spread > 0) %>%
  mutate(mean.date = as.Date(mean.date, origin = '1970-01-01')) %>%
  ggplot(aes(x = summed.rs, y = mean.date)) +
  geom_point(aes(size = n.fl), shape = 21, fill = 'goldenrod')

therm.allobs %>%
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
  scale_x_continuous(breaks = NULL) +
  labs(x = 'Solar radiation (W/m2)', y = 'Date') +
  theme(panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.title = element_text(size = 16),
        axis.text  = element_text(size = 12),
        legend.position = 'bottom')

ggsave('~/Documents/Research/shade/presentations/ipwa2021/therm2020res.png')

# Hmm what's the daily variation in total Rs

rs.sum = rs.est %>%
  group_by(Plot, Month, Date) %>%
  summarise(summed.rs = sum(Rs))

rs.sum %>%
  ggplot(aes(x = Plot, y = summed.rs)) +
  geom_point(aes(colour = factor(Date)))

rs.mean = rs.sum %>%
  group_by(Plot) %>%
  summarise(meanrs = mean(summed.rs))

therm.final = therm %>%
  mutate(Infl_spread = ifelse(is.na(Infl_spread), 0, Infl_spread),
         Infl_done   = ifelse(is.na(Infl_done), 0, Infl_done)) %>%
  filter(Infl_spread + Infl_done > 0) %>%
  group_by(Plot, Tag) %>%
  select(Plot, Tag, Date) %>%
  merge(y = rs.mean, by = 'Plot')

therm.final %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(Date = Date - min(Date)) %>%
  ggplot(aes(x = meanrs, y = Date)) +
  geom_point(position = position_jitter(height = 0.5)) +
  stat_smooth()

# 

campa = read.csv('data/processed_data/campn_draft_01-12-2021.csv')

# oh lmao gotta aggregate this stuff

campa.final = campa %>%
  mutate(Fl_straight = ifelse(is.na(Fl_straight), 0, Fl_straight),
         Fl_curled   = ifelse(is.na(Fl_curled), 0, Fl_curled),
         Fl_done     = ifelse(is.na(Fl_done), 0, Fl_done)) %>%
  filter(Fl_straight + Fl_curled + Fl_done > 0) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(Plot, Tag, Date) %>%
  merge(y = rs.sum, by = 'Plot')

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

campa.final %>%
  mutate(Date = as.Date(Date)) %>%
  ggplot(aes(x = summed.rs, y = Date)) +
  geom_point(position = position_jitter(height = 0.5)) +
  stat_smooth()

campa.allobs %>%
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
  scale_x_continuous(breaks = NULL) +
  labs(x = 'Solar radiation (W/m2)', y = 'Date') +
  theme(panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.title = element_text(size = 16),
        axis.text  = element_text(size = 12),
        legend.position = 'bottom')

ggsave('~/Documents/Research/shade/presentations/ipwa2021/campa2020res.png')
