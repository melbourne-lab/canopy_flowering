

rm(list = ls())

phen21 = read.csv('data/processed_data/thermopsis_cleaned_2021.csv') %>%
  rename(Fl_open = Fl_Open) %>%
  mutate(Date = as.Date(Date),
         Emerge.date = as.Date(Emerge.date))

head(phen21)

phen21 = phen21 %>%
  group_by(Plot, Tag) %>%
  filter(any(Fl_open > 0))

phen21 = phen21 %>%
  group_by(Plot, Tag) %>%
  summarise(
    date.flower = min(Date[Fl_open > 0 & !is.na(Fl_open)]) - as.Date('2021-07-01'),
    date.emerge = Emerge.date[1] - as.Date('2021-06-01')
  ) %>%
  mutate_at(vars(contains('date.')), as.numeric) 

head(phen21)

# Merge in spatial info

phen21 = merge(
  phen21,
  read.csv('data/processed_data/phen_svf_coords_combined.csv') %>%
    filter(Year %in% 2021) %>%
    distinct(Plot, Easting, Northing, slopes, aspect, svf)
)

head(phen21)

phen21 %>%
  mutate_at(vars(contains('date.')), as.numeric) %>%
  ggplot(aes(x = Easting, y = Northing)) +
  geom_point(
    aes(fill = date.emerge), 
    shape = 21, size = 4,
    position = position_jitter(width = 5, height = 5)
  ) +
  scale_fill_viridis_c()

phen21 %>%
  mutate_at(vars(contains('date.')), as.numeric) %>%
  mutate(Plot = factor(Plot)) %>%
  ggplot(aes(x = Plot, y = date.emerge)) +
  geom_point(
    aes(fill = svf), 
    shape = 21, size = 3,
    position = position_jitter(width = .5, height = .5)
  ) +
  scale_fill_viridis_c()
# Does not look like a strong pattern

# Some plants with missing emergence dates
phen21 %>% ggplot(aes(x = date.flower)) + geom_histogram(aes(fill = is.na(date.emerge)))
# seems to be random
t.test(date.flower ~ date.missing, data = phen21 %>% mutate(date.missing = is.na(date.emerge))) 
# p = 0.78

phen21 = phen21 %>% filter(!is.na(date.emerge))

m0 = stan_lmer(
  formula = date.flower ~ slopes + (1 | Plot),
  data = phen21,
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 201,
  diagnostic_file = paste0(file.path(), 'diag.csv')
)

summary(m0)

m1 = stan_lmer(
  formula = date.flower ~ svf + slopes + (1 | Plot),
  data = phen21,
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 49105,
  diagnostic_file = paste0(file.path(), 'diag.csv')
)

m2 = stan_lmer(
  formula = date.flower ~ poly(svf, 2) + slopes + (1 | Plot),
  data = phen21,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  cores = 4,
  seed = 1644227,
  diagnostic_file = paste0(file.path(), 'diag.csv')
)

pp_check(m0)
pp_check(m1)
pp_check(m2)

summary(m1)

m3 = stan_lmer(
  formula = date.flower ~ slopes + date.emerge + (1 | Plot),
  data = phen21,
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 23500,
  diagnostic_file = paste0(file.path(), 'diag.csv')
)

m4 = stan_lmer(
  formula = date.flower ~ slopes + svf + date.emerge + (1 | Plot),
  data = phen21,
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 29,
  diagnostic_file = paste0(file.path(), 'diag.csv')
)

summary(m4, pars = c("slopes", "svf", "date.emerge"))

m5 = stan_lmer(
  formula = date.flower ~ slopes + poly(svf, 2) + date.emerge + (1 | Plot),
  data = phen21,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  cores = 4,
  seed = 31842641,
  diagnostic_file = paste0(file.path(), 'diag.csv')
)

pp_check(m3)
pp_check(m4)
pp_check(m5)

compare03 = bayesfactor(m0, m3)
compare14 = bayesfactor(m1, m4)
compare34 = bayesfactor(m3, m4)
compare01 = bayesfactor(m0, m1)

compare02 = bayesfactor(m0, m2)
compare25 = bayesfactor(m2, m5)
compare2
compare3

summary(m4, pars = c("slopes", "svf", "date.emerge"), probs = c(.025, .5, .975))
summary(m5, pars = c("slopes", "poly(svf, 2)1", "poly(svf, 2)2", "date.emerge"), probs = c(.025, .5, .975))

as.data.frame(m4)$date.emerge %>% hist()
mean(as.data.frame(m4)$date.emerge > 0)
mean(as.data.frame(m4)$date.emerge)

as.data.frame(m5)$date.emerge %>% hist()
mean(as.data.frame(m5)$date.emerge > 0)
mean(as.data.frame(m5)$date.emerge)

ggplot(phen21, aes(x = svf, y = date.emerge)) +
  geom_point(position = position_jitter(height = 1))
# This also looks quadratic, but might also be due to data sparsity

emerge.svf = stan_lmer(date.emerge ~ svf + (1 | Plot), data = phen21, cores = 4, seed = 5001)

cor.test(m1$residuals, m3$residuals)

# Flowering date on SVF
as.data.frame(m1)[,c("(Intercept)", "slopes", "svf")] %>% apply(2, mean)
pan.a = phen21 %>%
  ggplot(aes(x = svf, y = date.flower)) +
  geom_line(
    data = data.frame(svf = (2:10)/10) %>% 
      mutate(pred = -7.243749 + 31.217163*.23 - 7.005126*svf),
    aes(x = svf, y = pred),
    colour = 'blue', linewidth = 2
  ) +
  geom_point(position = position_jitter(height = 0.5), size = 1.5) +
  labs(x = 'Sky view factor', y = 'Date of flowering') +
  theme(panel.background = element_blank())

as.data.frame(m3)[,c("(Intercept)", "slopes", "date.emerge")] %>% apply(2, mean)
# Flowering date on emergence date
pan.b = phen21 %>%
  ggplot(aes(x = date.emerge, y = date.flower)) +
  geom_line(
    data = data.frame(date.emerge = c(-9, 16)) %>%
      mutate(pred = -12.9444598 + 32.7037288*.23 + 0.1329763*date.emerge),
    aes(x = date.emerge, y = pred),
    colour = 'blue', linewidth = 2
  ) +
  geom_point(position = position_jitter(width = 0.5, height = 0.5), size = 1.5) +
  labs(x = 'Date of emergence', y = 'Date of flowering') +
  theme(panel.background = element_blank())

pan.c = phen21 %>%
  ggplot(aes(x = svf, y = date.emerge)) +
  geom_point(position = position_jitter(height = 0.5), size = 1.5) +
  labs(x = 'Sky view factor', y = 'Emergence date') +
  theme(panel.background = element_blank())

pan.d = data.frame(m1.residuals = m1$residuals, m3.residuals = m3$residuals) %>%
  ggplot(aes(x = m1.residuals, y = m3.residuals)) +
  geom_point(size = 1.5) +
  labs(x = 'Residuals,\nSVF-only model', y = 'Residuals,\nemergence-only model') +
  theme(panel.background = element_blank())

plot_grid(
  pan.a, pan.b, pan.c, pan.d,
  labels = c('a)', 'b)', 'c)', 'd)')
) %>%
  save_plot(
    filename = 'analysis/figures_etc/emergence_plot.png',
    base_width = 5, base_height = 5
  )
