rm(list = ls())

phen21 = read.csv('data/processed_data/thermopsis_cleaned_2021.csv') %>%
  rename(Fl_open = Fl_Open) %>%
  mutate(Date = as.Date(Date)) %>%
  group_by(Plot, Tag) %>%
  filter(any(Fl_open > 0)) %>%
  group_by(Plot, Tag) %>%
  summarise(date.flower = min(Date[Fl_open > 0 & !is.na(Fl_open)]) - as.Date('2021-07-01')) %>%
  mutate_at(vars(contains('date.')), as.numeric) 

head(phen21)

# Merge in spatial info

phen21 = merge(
  phen21,
  read.csv('data/processed_data/phen_svf_coords_combined.csv') %>%
    filter(Year %in% 2021) %>%
    distinct(Plot, Easting, Northing, slopes, aspect, svf)
)

phen21 = merge(
  phen21,
  read.csv('data/raw_data/data_2021/seed2021_counts_post-annalise.csv') %>%
    filter(!is.na(Full__n_seeds)),
  by = "Tag"
)

nrow(phen21)
head(phen21)

m0 = stan_glmer(
  formula = cbind(Full__n_seeds, Empty_n_seeds) ~ (1 | Plot / Tag),
  data = phen21 %>% mutate(Empty_n_seeds = 15 - Full__n_seeds),
  family = 'binomial',
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 44320,
  diagnostic_file = paste0(file.path(), 'diag.csv')
)

pp_check(m0)

m1 = stan_glmer(
  formula = cbind(Full__n_seeds, Empty_n_seeds) ~ svf + (1 | Plot / Tag),
  data = phen21 %>% mutate(Empty_n_seeds = 15 - Full__n_seeds),
  family = 'binomial',
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 217189,
  diagnostic_file = paste0(tempdir(), 'diag.csv')
)

# four divergent transitions

pp_check(m1)

m2 = stan_glmer(
  formula = cbind(Full__n_seeds, Empty_n_seeds) ~ date.flower + (1 | Plot / Tag),
  data = phen21 %>% mutate(Empty_n_seeds = 15 - Full__n_seeds),
  family = 'binomial',
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 4100,
  diagnostic_file = paste0(tempdir(), 'diag.csv')
)

# insane number of divergent transitions
summary(m2, pars = 'date.flower', probs = c(0.025, 0.5, 0.975))

# lots of divergent transitions here too
# there is some issue with slope data?

pp_check(m2)

m3 = stan_glmer(
  formula = cbind(Full__n_seeds, Empty_n_seeds) ~ svf + date.flower + (1 | Plot / Tag),
  data = phen21 %>% mutate(Empty_n_seeds = 15 - Full__n_seeds),
  family = 'binomial',
  cores = 4,
  chains = 12,
  iter   = 6000,
  warmup = 2000,
  seed = 84215680,
  diagnostic_file = paste0(tempdir(), 'diag.csv')
)

pp_check(m3)

compare01 = bayesfactor(m0, m1)
compare02 = bayesfactor(m0, m2)
compare13 = bayesfactor(m1, m3)
compare23 = bayesfactor(m2, m3)

compare01
compare02
compare13
compare23

