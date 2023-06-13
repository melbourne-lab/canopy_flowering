library(ggplot2)
library(cowplot)
library(dplyr)
library(tidyr)

phen.all = read.csv('data/processed_data/phen_svf_coords_combined.csv')

ph.all = phen.all %>%
  group_by(JDay, Plot, Year) %>%
  summarise(
    pl.open = sum(Fl_open > 0, na.rm = TRUE),
    fl.open = sum(Fl_open, na.rm = TRUE),
    svf = svf[1]
  ) %>%
  ungroup()

ph.all = ph.all %>%
  # Add in zeros for first and last day
  rbind(
    ph.all %>%
      group_by(Year) %>%
      mutate(
        min.date = min(JDay), zero.date = min.date - 3,
        max.date = max(JDay), fina.date = max.date + 3
      ) %>%
      distinct(Plot, Year, svf, min.date, max.date, zero.date, fina.date) %>%
      pivot_longer(contains('date'), names_to = 'temp', values_to = 'JDay') %>%
      select(-temp) %>%
      mutate(pl.open = 0, fl.open = 0) %>%
      select(names(ph.all))
  ) %>%
  arrange(Plot, Year, JDay) %>%
  # ugh there are some duplicate records... no clean way to do this
  group_by(Plot, Year, JDay) %>% 
  summarise_at(vars(pl.open, fl.open, svf), list(sum, mean)) %>%
  select(-c(pl.open_fn2, fl.open_fn2, svf_fn1)) %>%
  rename(pl.open = pl.open_fn1, fl.open = fl.open_fn1, svf = svf_fn2)

pl.open.plot = ph.all %>%
  mutate(day = as.Date('05-31', format = '%m-%d') + JDay) %>%
  ggplot(aes(x = day, group = Plot)) +
  geom_line(aes(y = pl.open, colour = svf), linewidth = 1.2) +
  scale_colour_gradient(low = 'gray11', high = 'lightskyblue') +
  labs(x = '', y = 'Plants with open flowers') +
  facet_wrap( ~ Year) +
  theme(
    panel.grid = element_blank(), 
    panel.background = element_blank(),
    legend.position = 'none'
  )

fl.open.plot = ph.all %>%
  mutate(day = as.Date('05-31', format = '%m-%d') + JDay) %>%
  ggplot(aes(x = JDay, group = Plot)) +
  geom_line(aes(y = fl.open, colour = svf), linewidth = 1.2) +
  scale_colour_gradient(low = 'gray11', high = 'lightskyblue') +
  labs(x = 'Date', y = 'Number of open flowers') +
  facet_wrap( ~ Year) +
  theme(
    panel.grid = element_blank(), 
    panel.background = element_blank(),
    strip.background = element_blank(),
    strip.text = element_blank(),
    legend.position = 'none'
  )

open.legend = get_legend(
  pl.open.plot + 
    theme(legend.position = 'bottom') +
    guides(colour = guide_legend('Sky view factor'))
  )

plot_grid(
  pl.open.plot, fl.open.plot, open.legend,
  rel_heights = c(1, 1, .2),
  nrow = 3
)

ggsave('analysis/figures_etc/fig_out/flowering_schedules.png',
       width = 8, height = 5)
