### First pass data wrangling for analysis

library(rstanarm)
library(ggplot2)
library(dplyr)
library(tidyr)

# Phen data

phen21 = read.csv('data/processed_data/thermopsis_cleaned_2021.csv')

head(phen21)

apply(phen21, 2, function(x) sum(is.na(x)))

phen21 %>% filter(is.na(Fl_Stems))

phen21 = phen21 %>% filter(!is.na(Fl_Stems))

apply(phen21, 2, function(x) sum(is.na(x)))

phen21 = phen21 %>%
  mutate(Date = as.Date(Date),
         Emerge.date = as.Date(Emerge.date))

# Seed set data

seed21 = read.csv('data/raw_data/data_2021/seed2021_counts_post-annalise.csv')

head(seed21)

seed21s = seed21 %>% filter(!Initials %in% 'AS', !is.na(Full__n_seeds))

seed21s %>%
  ggplot(aes(x = Full__n_seeds)) + 
  geom_histogram(binwidth = 1)
# interesting.

apply(seed21s, 2, function(x) sum(is.na(x)))

### Model 1

strt21 = phen21 %>%
  filter(Fl_Open > 0 | Fl_Done > 0) %>%
  group_by(Tag, Plot) %>%
  summarise(
    date.emerge = Emerge.date[1],
    date.start = min(Date),
    date.end   = min(Date[!Fl_Open])
  )

apply(strt21, 2, function(x) sum(is.na(x)))
# four end dates missing
# probably not a big deal though!

phenseed = merge(
  x = strt21,
  y = seed21s,
  by = 'Tag'
)

phenseed %>% group_by(Tag) %>% filter(length(unique(Plot)) > 1)
# good

##### Try a model

phenseed = phenseed %>% mutate(date.linmean = mean(c(date.start, date.end)))

lme4::glmer(
  Full__n_seeds ~ date.start + (1 | Plot / Tag),
  data = phenseed,
  family = poisson
)

testmod = rstanarm::stan_glmer(
  Full__n_seeds ~ date.start + (1 | Plot / Tag),
  data = phenseed,
  family = poisson,
  cores = 4
)

summary(testmod)

# error... not sure why there's some issue with non-positive definite matrices...

phenseed %>%
  ggplot(aes(x = date.linmean, y = Full__n_seeds)) +
  geom_point(position = position_jitter(height = 0.125)) # +
  # stat_smooth()

# lmao.

#### Phenology vs. solar radiation proxy

phen20 = read.csv('data/processed_data/therm_draft_01-12-2021.csv')

srad20 = read.csv('data/solar_data/musselman_elk_2020_est-09-21.csv')

srad20 = srad20 %>%
  filter(!is.nan(Rs)) %>%
  group_by(Plot, Month, Date) %>%
  summarise(sum.rs = sum(Rs)) %>%
  group_by(Plot) %>%
  summarise(mean.sum.rs = mean(sum.rs))

hist(srad20$mean.sum.rs)

all.20 = merge(phen20, srad20)

head(all.20)

all.20 %>% filter(grepl('mopsis', Species)) %>% head(15)

sum.20 = all.20 %>%
  filter(Infl_spread > 0) %>%
  group_by(Plot, Tag) %>%
  summarise(
    date.init = min(Date),
    date.fins = max(Date),
    mean.sum.rs = mean.sum.rs[1]
  )

sum.20 %>%
  ggplot(aes(x = mean.sum.rs, y = date.init)) +
  geom_point(position = position_jitter(height = 1, width = 100))

sum.20 %>%
  ggplot(aes(x = mean.sum.rs)) +
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = mean.sum.rs,
    ),
    position = position_jitter(width = 100)
  )

# try reading in coords...

cas.20 = read.csv('../UAV-b-solar-radiation/00_setup/elk_meadow_data/coords_asp_slp_2020.csv') %>%
  mutate(Label = gsub('^p', '', Label))

head(cas.20)

ggplot(cas.20, aes(x = X_Easting, y = Y_Northing, colour = slopes)) +
  geom_point() +
  scale_colour_viridis_c()
# lol...

all.cas.20 = merge(all.20, cas.20 %>% select(-Z_Altitude), by.x = 'Plot', by.y = 'Label')
sum.cas.20 = merge(sum.20, cas.20 %>% select(-Z_Altitude), by.x = 'Plot', by.y = 'Label')

sum.cas.20 %>%
  ggplot(aes(x = mean.sum.rs)) +
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = mean.sum.rs,
      colour = slopes
    ),
    position = position_jitter(width = 100)
  ) +
  scale_colour_viridis_c()

sum.cas.20 %>%
  ggplot(aes(x = slopes)) +
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = slopes
    ),
    position = position_jitter(width = 1)
  )

sum.cas.20 %>%
  ggplot(aes(x = aspect)) +
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = aspect
    ),
    position = position_jitter(width = 1)
  )

sum.cas.20 %>%
  ggplot(aes(x = cos(aspect * pi / 180))) +
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = cos(aspect * pi / 180),
      colour = sin(slopes * pi / 180)
    ),
    position = position_jitter(width = 0.01)
  ) +
  scale_colour_viridis_c()
# erm... am I getting aspect right? sseems like theres should be som esine...


sum.cas.20 %>%
  ggplot(aes(x = mean.sum.rs)) +
  geom_point(
    aes(
      y = 
    )
  )
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = mean.sum.rs,
      colour = sin(slopes * pi / 180)
    ),
    position = position_jitter(width = 50)
  ) +
  scale_colour_viridis_c()
  
  
  ###
  
svf = read.csv('../UAV-b-solar-radiation/02_skyview/out/elk_svf_uav_long_c1.csv')

head(svf)
hist(svf$svf)  

svf %>%
  ggplot(aes(x = easting, y = northing)) +
  geom_raster(aes(fill = svf)) +
  scale_fill_viridis_c()
# argh... some weird artifacting occurring here
# but still, seems okay

haha = merge(
  x = cas.20 %>% mutate(X_Easting = floor(X_Easting), Y_Northing = floor(Y_Northing)),
  y = svf %>% mutate(easting = floor(easting), northing = floor(northing)), 
  by.x = c("X_Easting", "Y_Northing"), by.y = c("easting", "northing")
)

head(haha)
hist(haha$svf)
# fuck... maybe should get rid of Ketih's hack...

all.cas.20 = merge(all.20, haha %>% select(-Z_Altitude), by.x = 'Plot', by.y = 'Label')
sum.cas.20 = merge(sum.20, haha %>% select(-Z_Altitude), by.x = 'Plot', by.y = 'Label')

sum.cas.20 %>%
  ggplot(aes(x = svf)) +
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = svf,
      colour = sin(slopes * pi / 180)
    ),
    position = position_jitter(width = 0.0025)
  ) +
  scale_colour_viridis_c('Slope') +
  labs(x = 'Sky view factor', y = 'Date') +
  theme(
    panel.background = element_rect(fill = 'white'),
    panel.grid.major = element_line(colour = 'gray88', linewidth = 0.25),
    legend.position = c(0.2, 0.2),
    legend.background = element_blank(),
    legend.direction = 'horizontal'
  )

sum.cas.20 %>%
  ggplot(aes(x = svf, y = date.init, colour = slopes)) +
  geom_point(size = 3, alpha = 0.25) +
  scale_colour_viridis_c()

sum.cas.20 %>%
  mutate(northing = cos(aspect * pi / 180)) %>%
  ggplot(aes(x = svf)) +
  geom_segment(
    aes(
      y = date.init, yend = date.fins,
      xend = svf,
      colour = northing
    ),
    position = position_jitter(width = 0.0025)
  ) +
  scale_colour_gradient2(low = 'red', high = 'blue', mid = 'black', midpoint = 0, 'North aspect') +
  labs(x = 'Sky view factor', y = 'Date') +
  theme(
    panel.background = element_rect(fill = 'white'),
    panel.grid.major = element_line(colour = 'gray88', linewidth = 0.25),
    legend.position = c(0.2, 0.2),
    legend.background = element_blank(),
    legend.direction = 'horizontal'
  )

### 

phen20 = read.csv('data/processed_data/therm_draft_01-12-2021.csv') %>%
  # Just Thermopsis
  filter(grepl('mopsis', Species)) %>%
  # Only records of plants with a open or finished flowers
  filter(Infl_spread > 0 | Infl_done > 0) %>%
  # Rename goofy plots
  rename(Fl_open = Infl_spread, Fl_done = Infl_done, Infl = Racemes)

# Oh... probably should get rid of the outside plants
phen20 = phen20 %>%
  group_by(Plot, Tag) %>%
  filter(!any(grepl('outside', tolower(Note)))) %>%
  ungroup()

phen20 %>% distinct(Plot, Tag) %>% nrow()
phen20 %>% distinct(Plot) %>% nrow()

spat20 = merge(
  # SVF values for whole area
  x = read.csv('../UAV-b-solar-radiation/02_skyview/out/elk_svf_uav_long_c1.csv') %>%
    mutate(easting = floor(easting), northing = floor(northing)),
  y = read.csv('../UAV-b-solar-radiation/00_setup/elk_meadow_data/coords_asp_slp_2020.csv') %>%
    mutate(X_Easting = floor(X_Easting), Y_Northing = floor(Y_Northing)) %>%
    mutate(Label = gsub('^p', '', Label)),
  by.x = c('easting', 'northing'), by.y = c('X_Easting', 'Y_Northing'),
  all.x = TRUE
) %>%
  rename(Plot = Label, altitude = Z_Altitude)

head(spat20)

all.fl.20 = phen20 %>%
  filter(Fl_open > 0) %>%
  merge(y = spat20) %>%
  mutate(Date = as.Date(Date))

all.fl.20 %>%
  ggplot(aes(x = svf, y = Date)) +
  geom_point(aes(size = Fl_open, colour = slopes), alpha = 0.25)

sum.fl.20 = all.fl.20 %>%
  group_by(Plot, Tag) %>%
  summarise(
    min.date = min(Date), 
    max.date = max(Date),
    svf = svf[1], aspect = aspect[1], slope = slopes[1]
  ) %>%
  ungroup()
  
head(sum.fl.20)

sum.fl.20 %>%
  mutate(
    svf.jitter = svf + rnorm(n = nrow(.), 0, .001),
    south.aspc = cos(aspect * pi / 180)
  ) %>%
  ggplot(aes(x = svf.jitter)) +
  geom_segment(
    aes(
      xend = svf.jitter, y = min.date, yend = max.date,
      colour = south.aspc
    )
  ) +
  geom_point(aes(y = min.date, fill = south.aspc), shape = 24) +
  geom_point(aes(y = max.date, fill = south.aspc), shape = 25) +
  scale_colour_gradient2(low = 'red', high = 'blue', mid = 'black', midpoint = 0) +
  scale_fill_gradient2(low = 'red', high = 'blue', mid = 'black', midpoint = 0)

sum.fl.20 %>%
  mutate(
    svf.jitter = svf + rnorm(n = nrow(.), 0, .001),
    south.aspc = cos(aspect * pi / 180)
  ) %>%
  ggplot(aes(x = svf.jitter)) +
  geom_point(aes(y = min.date, fill = south.aspc), shape = 24) +
  scale_fill_gradient2(low = 'red', high = 'blue', mid = 'black', midpoint = 0)

sum.fl.20 %>%
  ggplot(aes(x = Plot, y = min.date, colour = svf)) +
  geom_point(position = position_jitter(width = .25)) +
  scale_colour_viridis_c()

yaya = stan_gamm4(
  min.date ~ s(svf) + south.face + slope, random = ~ (1 | Plot / Tag),
  data = sum.fl.20 %>%
    mutate(south.face = cos(aspect * pi / 180), 
           min.date = as.numeric(min.date - mean(min.date))),
  cores = 4, chains = 4, iter = 5000
)

yaya %>% summary()
plot_nonlinear(yaya)

posterior_predict(
  yayu
  newdata = data.frame(svf = seq(.7, 1, by = .01)), 
)

yayo = stan_gamm4(
  min.date ~ s(svf) + south.face, random = ~ (1 | Plot / Tag),
  data = sum.fl.20 %>%
    mutate(south.face = cos(aspect * pi / 180), 
           min.date = as.numeric(min.date - mean(min.date))),
  cores = 4, chains = 4, iter = 5000
)

yayu = stan_gamm4(
  min.date ~ s(svf), random = ~ (1 | Plot / Tag),
  data = sum.fl.20 %>%
    mutate(min.date = as.numeric(min.date - mean(min.date))),
  cores = 4, chains = 4, iter = 5000
)

yayu %>% summary()
plot_nonlinear(yayu)

test.post.pred = posterior_predict(
  yayu,
  newdata = data.frame(svf = seq(.75, 1, by = .01)),
  draws = 100,
  re.form = NA
) %>%
  t() %>%
  as.data.frame() %>%
  mutate(svf = seq(.75, 1, by = .01)) %>%
  pivot_longer(cols = -svf) 

test.post.pred %>%
  ggplot(aes(x = svf, y = value, colour = svf)) +
  geom_point(position = position_jitter(width = 0.005), alpha = 0.1) +
  geom_point(
    data = su
  )
  scale_colour_viridis_c()

test.post.pred %>%
  group_by(svf) %>%
  summarise(mean.date = mean(value)) %>%
  ggplot(aes(x = svf, y = mean.date)) +
  geom_line() +
  geom_point() 

test.post.pred.mean = test.post.pred %>%
  group_by(svf) %>%
  summarise(mean.date = mean(value))

merged.preds = merge(spat20 %>% mutate(svf = round(svf, digits = 2)), test.post.pred.mean,
      all.x = TRUE, all.y = TRUE)

merged.preds %>%
  ggplot(aes(x = easting, y = northing, fill = mean.date)) +
  geom_raster() +
  scale_fill_viridis_c()
# bayes factor or mod comparison w-w/o svf


sum.fl.20 %>%
  mutate(
    pred = posterior_predict(
      yayu,
      draws = 100,
      re.form = NA
  ) %>% apply(2, mean)
) %>%
  ggplot(aes(x = svf)) +
  geom_point(aes(y = min.date - mean(min.date))) +
  geom_line(aes(y = pred), colour = 'blue')

