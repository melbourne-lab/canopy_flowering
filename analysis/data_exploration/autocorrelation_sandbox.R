library(ggplot2)
library(dplyr)
library(tidyr)
library(rstanarm)

rm(list = ls())
select = dplyr::select

phen.all = read.csv('data/processed_data/phen_svf_coords_combined.csv')

head(phen.all)

phen.open = phen.all %>%
  filter(Fl_open > 0) %>%
  group_by(Plot, Year, Tag) %>%
  summarise(date.init = min(JDay)) %>%
  merge(phen.all %>% distinct(Easting, Northing, Plot, Year, svf, slopes, aspect)) %>%
  mutate(Plot = paste(Plot, Year, sep = '_'))

nrow(phen.open)
length(unique(phen.open$Plot))
head(phen.open)

gamm1 = stan_gamm4(
  formula = date.init ~ s(svf, by = Year) + Year + slopes, # + aspect,
  random = ~ (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 5000,
  seed = 109
)

summary(gamm1)

gdf1 = as.data.frame(gamm1)

plot_nonlinear(gamm1)
# lmao...

init.draw.data = expand.grid(
  Year = 2020:2022,
  svf = (75:99)/100,
  slopes = seq(0, .45, length.out = 4)
)

init.draw.ests = init.draw.data %>%
  posterior_predict(
    gamm1, 
    newdata = .,
    re.form = NA,
    draws = 100,
    seed = 220240
  )

init.draw.comb = init.draw.data %>%
  cbind(
    init.draw.ests %>%
      t() %>%
      as.data.frame()
  ) %>%
  pivot_longer(-c(Year, svf, slopes), names_to = 'draw', values_to = 'estimate')

init.draw.comb %>%
  group_by(svf, Year = factor(Year)) %>%
  summarise(
    iday.bar = mean(estimate),
    iday.var = var(estimate),
    n = n()
  ) %>%
  ggplot(aes(x = svf, group = Year)) +
  geom_ribbon(
    aes(
      ymin = iday.bar - 2*sqrt(iday.var/n),
      ymax = iday.bar + 2*sqrt(iday.var/n),
      fill = Year
    ),
    alpha = 0.2
  ) +
  geom_line(aes(y = iday.bar, group = Year, colour = Year))
# oh, well...
# but ytf is the *mean* date around june 20?

phen.all %>% 
  group_by(Plot, Year, Tag) %>% 
  reframe(
    date.range = range(JDay),
    date.label = c('start', 'end'),
    svf = mean(svf), slopes = mean(slopes)
  ) %>%
  pivot_wider(names_from = date.label, values_from = date.range) %>% 
  mutate(svf.jitter = svf + rnorm(nrow(.), 0, sqrt(.001))) %>%
  ggplot(aes(x = svf.jitter)) +
  geom_segment(aes(xend = svf.jitter, y = start, yend = end, colour = slopes)) +
  geom_point(aes(y = start), colour = 'forestgreen', size = 3, alpha = 0.5) +
  scale_colour_gradient(low = 'blue', high = 'red') +
  facet_wrap(~ Year)


init.on.data = posterior_predict(
    gamm1,
    re.form = NA,
    draws = 100,
    seed = 220240
  )

init.on.data = phen.open %>%
  cbind(
    init.on.data%>%
      t() %>%
      as.data.frame()
  ) %>%
  pivot_longer(starts_with("V"), names_to = 'draw', values_to = 'estimate')

head(init.on.data)
nrow(init.on.data)


residuals.on.data = init.on.data %>%
  group_by(Plot, Year, Tag) %>%
  mutate(p.gt.resid = mean(estimate > date.init)) %>%
  distinct(Plot, Year, Tag, .keep_all = TRUE)

residuals.on.data %>%
  mutate(Year = factor(Year)) %>%
  ggplot(aes(x = Easting, y = Northing)) +
  geom_point(aes(colour = p.gt.resid, shape = Year), size = 3,
             position = position_jitter(width = 0.5, height = 0.5)) +
  scale_colour_gradient2(low = 'blue', high = 'red', mid = 'white', midpoint = 0.5)
# ugh... spatial autocorrelation abounds.
# probably should run Moran's I on this.
# actually I guess it would make more sense to look at autocorrelation of the random effects??

gamm.ranefs = gdf1 %>%
  select(contains('Plot:')) %>%
  select(contains('b')) %>%
  apply(2, mean) %>%
  data.frame(
    plot = names(.),
    values = .
  ) %>%
  mutate(plot.no = gsub('b\\[\\(Intercept\\)\\sPlot\\:|\\]', '', plot))

gamm.ranefs = gamm.ranefs %>%
  select(-plot) %>%
  rename(Plot = plot.no) %>%
  merge(phen.open %>% distinct(Plot, Easting, Northing)) 

gamm.ranefs %>%
  ggplot(aes(x = Easting, y = Northing)) +
  geom_point(aes(colour = values), size = 5) +
  scale_colour_gradient2(low = 'red', high = 'blue', mid = 'white') +
  theme(panel.background = element_rect(fill = 'black'))
# these actually don't look so bad!
# well... actually maybe not idk

ranef.dist.matrix = gamm.ranefs %>%
  select(Easting, Northing) %>%
  dist() %>%
  as.matrix() %>%
  (function(x) 1/x)
diag(ranef.dist.matrix) = 0

ape::Moran.I(gamm.ranefs$values, ranef.dist.matrix)
# wow!!! that's a relief... no autocorrelation in random effects

# now just looking at individual residuals...
residuals.on.data$residual = with(residuals.on.data, estimate - date.init)

resid.dist.matrix = residuals.on.data %>%
  ungroup() %>%
  select(Easting, Northing) %>%
  dist() %>%
  as.matrix() %>%
  (function(x) 1/x)
resid.dist.matrix[resid.dist.matrix == Inf] = 0

ape::Moran.I(residuals.on.data$residual, resid.dist.matrix)
# whoa... also no spatial autocorrelation here???
