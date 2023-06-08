library(ggplot2)
library(dplyr)
library(tidyr)
library(rstanarm)
library(bayesplot)
library(ape)
library(cowplot)

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

### completely null model

lmer.null = stan_lmer(
  formula = date.init ~ (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 3609
)

k.null = kfold(lmer.null, K = 10, cores = 4)
lmer.null$loo = k.null

### model with only year effect

lmer.y = stan_lmer(
  formula = date.init ~ Year + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 132737
)

k.lmer.y = kfold(lmer.y, K = 10, cores = 4)
lmer.y$loo = k.lmer.y

### only aspect

lmer.a = stan_lmer(
  formula = date.init ~ aspect + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 3437
)

k.lmer.a = kfold(lmer.a, K = 10, cores = 4)
lmer.a$loo = k.lmer.a

### only slope

lmer.s = stan_lmer(
  formula = date.init ~ slopes + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 516436
)

k.lmer.s = kfold(lmer.s, K = 10, cores = 4)
lmer.s$loo = k.lmer.s

### year and aspect

lmer.y.a = stan_lmer(
  formula = date.init ~ Year + aspect + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 886318
)

k.lmer.y.a = kfold(lmer.y.a, K = 10, cores = 4)
lmer.y.a$loo = k.lmer.y.a

### year and slope

lmer.y.s = stan_lmer(
  formula = date.init ~ Year + slopes + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 199982
)

k.lmer.y.s = kfold(lmer.y.s, K = 10, cores = 4)
lmer.y.s$loo = k.lmer.y.s

### slope and aspect

lmer.a.s = stan_lmer(
  formula = date.init ~ aspect + slopes + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 57993
)

k.lmer.a.s = kfold(lmer.a.s, K = 10, cores = 4)
lmer.a.s$loo = k.lmer.a.s

### year slope and aspect

lmer.y.a.s = stan_lmer(
  formula = date.init ~ Year + aspect + slopes + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 438718
)

k.lmer.y.a.s = kfold(lmer.y.a.s, K = 10, cores = 4)
lmer.y.a.s$loo = k.lmer.a.s

### Compare with loo_compare

loo_compare(
  stanreg_list(
    lmer.null,
    lmer.y, lmer.a, lmer.s,
    lmer.y.a, lmer.y.s, lmer.a.s,
    lmer.y.a.s
  )
)

# Model comparison based on LOO-CV: 
#             elpd_diff se_diff
# lmer.s       0.0       0.0  
# lmer.y.a    -0.7       3.6  
# lmer.null   -0.9       4.1  
# lmer.a.s    -1.8       3.5  
# lmer.y.a.s  -1.8       3.5  
# lmer.y.s    -4.4       4.0  
# lmer.y      -4.9       4.3  
# lmer.a     -10.5       5.1  

# best models are lmer.s, lmer.y.a, lmer.null (...)

stanreg_list(
  lmer.null,
  lmer.y, lmer.a, lmer.s,
  lmer.y.a, lmer.y.s, lmer.a.s,
  lmer.y.a.s
) %>% 
  lapply(function(x) x$loo$estimate[1,]) %>% 
  do.call(what = rbind) %>%
  as.data.frame() %>%
  mutate(model.name = row.names(.)) %>%
  ggplot(aes(x = model.name)) +
  geom_point(aes(y = Estimate)) +
  # geom_segment(aes(xend = model.name, y = Estimate - SE, yend = Estimate + SE)) +
  theme(axis.text = element_text(angle = 90))

summary(lmer.s) # but aspect is n.s....

lmer.s.pred = posterior_predict(lmer.s, draws = 100, seed = 54)
pp_check(lmer.s)
ppc_dens_overlay_grouped(phen.open$date.init, lmer.s.pred, group = phen.open$Year) # not very good at getting 2021
ppc_scatter_avg_grouped(phen.open$date.init, lmer.s.pred, group = phen.open$Year)
ppc_intervals_grouped(
  x = phen.open$svf,
  y = phen.open$date.init,
  yrep = lmer.s.pred,
  group = phen.open$Year
) # not great at getting very early plants in 2020

### Testing some linear svf models

### svf (linear)

lmer.s.f = stan_lmer(
  formula = date.init ~ slopes + svf + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 49
)

k.lmer.s.f = kfold(lmer.s.f, K = 10, cores = 4)
lmer.s.f$loo = k.lmer.s.f

# Introducing year-intercept

lmer.s.y.f = stan_lmer(
  formula = date.init ~ slopes + svf + Year + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 138328
)

k.lmer.s.y.f = kfold(lmer.s.y.f, K = 10, cores = 4)
lmer.s.y.f$loo = k.lmer.s.y.f

### svf (linear with year-varying slope)

lmer.s.yf = stan_lmer(
  formula = date.init ~ slopes + svf * Year + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 123759
)

k.lmer.s.yf = kfold(lmer.s.yf, K = 10, cores = 4)
lmer.s.yf$loo = k.lmer.s.yf

### Model with year-only intercept

lmer.y.f = stan_lmer(
  formula = date.init ~ svf + Year + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 38999
)

k.lmer.y.f = kfold(lmer.y.f, K = 10, cores = 4, seed = 1800)
lmer.y.f$loo = k.lmer.y.f

### Model with neither sloep nor aspect but year-varying slope

lmer.yf = stan_lmer(
  formula = date.init ~ svf * Year + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 558
)

k.lmer.yf = kfold(lmer.yf, K = 10, cores = 4, seed = 1800)
lmer.yf$loo = k.lmer.yf

### Compare

loo_compare(
  stanreg_list(
    lmer.y, lmer.a, lmer.s,
    lmer.y.a, lmer.y.s, lmer.a.s,
    lmer.y.a.s,
    lmer.s.f, lmer.s.y.f, lmer.s.yf, lmer.y.f, lmer.yf
  )
)

# linear terms do improve models somewhat

pp_check(lmer.s.f)
ppc_dens_overlay_grouped(
  phen.open$date.init, 
  posterior_predict(lmer.s.f, draws = 50), 
  group = phen.open$Year
)

pp_check(lmer.yf)
ppc_dens_overlay_grouped(
  phen.open$date.init, 
  posterior_predict(lmer.yf, draws = 50), 
  group = phen.open$Year
)
# still not great at getting those erly dates in 2021

pp_check(lmer.s.yf)
ppc_dens_overlay_grouped(
  phen.open$date.init, 
  posterior_predict(lmer.s.y.f, draws = 50), 
  group = phen.open$Year
)
# these all look like they're the same...

ppc_intervals_grouped(
  x = phen.open$svf,
  y = phen.open$date.init,
  yrep = posterior_predict(lmer.s.y.f, draws = 50),
  group = phen.open$Year
) # also still really bad at getting those 2020 early dates

### Testing quadratic svf terms

lmer.s.f2 = stan_lmer(
  formula = date.init ~ slopes + poly(svf, 2) + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 999
)

k.lmer.s.f2 = kfold(lmer.s.f2, K = 10, cores = 4, seed = 9)
lmer.s.f2$loo = k.lmer.s.f2

# Intercept of year

lmer.s.y.f2 = stan_lmer(
  formula = date.init ~ slopes + Year + poly(svf, 2) + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 6744
)

k.lmer.s.y.f2 = kfold(lmer.s.y.f2, K = 10, cores = 4, seed = 90)
lmer.s.y.f2$loo = k.lmer.s.y.f2

# Intercept and slope of year

lmer.s.yf2 = stan_lmer(
  formula = date.init ~ slopes + Year * poly(svf, 2) + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 228617
)

k.lmer.s.yf2 = kfold(lmer.s.yf2, K = 10, cores = 4, seed = 90)
lmer.s.yf2$loo = k.lmer.s.yf2

# Trying the above but with no slope

lmer.y.f2 = stan_lmer(
  formula = date.init ~ Year + poly(svf, 2) + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 431116
)

k.lmer.y.f2 = kfold(lmer.y.f2, K = 10, cores = 4, seed = 30)
lmer.y.f2$loo = k.lmer.y.f2


# No topo slope but year-varying svf slopes

lmer.yf2 = stan_lmer(
  formula = date.init ~ Year * poly(svf, 2) + (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 46116
)

k.lmer.yf2 = kfold(lmer.yf2, K = 10, cores = 4, seed = 1001)
lmer.yf2$loo = k.lmer.yf2

### Compare with loo

loo_compare(
  stanreg_list(
    lmer.y, lmer.a, lmer.s,
    lmer.y.a, lmer.y.s, lmer.a.s,
    lmer.y.a.s,
    lmer.s.f, lmer.s.y.f, lmer.s.yf, lmer.y.f, lmer.yf,
    lmer.s.f2, lmer.s.y.f2, lmer.s.yf2,
    lmer.y.f2, lmer.yf2
  )
)

# Model comparison based on LOO-CV: 
#             elpd_diff se_diff
# lmer.s.yf2    0.0       0.0  
# lmer.s.y.f2  -2.4       4.2  
# lmer.s.f     -6.6       3.7  
# lmer.yf      -7.4       3.7  
# lmer.y.f2    -7.8       3.5  
# lmer.s.y.f   -8.5       4.0  
# lmer.s      -10.2       3.8  
# lmer.s.yf   -10.6       3.5  
# lmer.yf2    -11.3       4.0  
# lmer.y      -12.2       4.5  
# lmer.a.s    -12.3       3.5  
# lmer.y.a.s  -12.3       3.5  
# lmer.y.a    -12.6       4.5  
# lmer.a      -14.7       4.7  
# lmer.y.f    -15.5       4.8  
# lmer.y.s    -18.7       4.8  
# lmer.s.f2   -20.7       4.9  

# save(list = ls(), file = 'analysis/phen_lmers_gamms.RData')
load('analysis/phen_lmers_gamms.RData')

# At the very least, all of the best candidates have the sky view factor
# seems like there is an effect of slope too

lmer.s.yf2.pred = posterior_predict(lmer.s.yf2, draws = 50)
pp_check(lmer.s.yf2)
ppc_dens_overlay_grouped(phen.open$date.init, lmer.s.yf2.pred, group = phen.open$Year) # still not amazing at getting 2021
ppc_scatter_avg_grouped(phen.open$date.init, lmer.s.yf2.pred, group = phen.open$Year)
ppc_intervals_grouped(
  x = phen.open$svf,
  y = phen.open$date.init,
  yrep = lmer.s.yf2.pred,
  group = phen.open$Year
) # also not good at getting earliest days in 2020 or 2021 (random effects)
ppc_intervals_grouped(
  x = phen.open$aspect,
  y = phen.open$date.init,
  yrep = lmer.s.yf2.pred,
  group = phen.open$Year
)

summary(lmer.s.yf2)

preds.s.yf2 = expand.grid(
  slopes = (1:5)/10,
  Year = factor(2020:2022),
  svf  = (2:10)/10
) %>%
  cbind(
    .,
    mean.pred = posterior_predict(
      lmer.s.yf2,
      newdata = .,
      re.form = NA,
      draws = 200
    ) %>%
      apply(2, mean)
  )

ggplot(preds.s.yf2, aes(x = svf, y = mean.pred)) +
  geom_point(
    data = phen.open, inherit.aes = FALSE,
    aes(x = svf, y = date.init, colour = slopes),
    size = 3
  ) +
  geom_line(aes(group  = slopes, colour = slopes)) +
  facet_wrap(~ Year)
# not great... random effects doing a lot of owrk


preds.s.y.f2 = expand.grid(
  slopes = (1:5)/10,
  Year = factor(2020:2022),
  svf  = (2:10)/10
) %>%
  cbind(
    .,
    mean.pred = posterior_predict(
      lmer.s.y.f2,
      newdata = .,
      re.form = NA,
      draws = 200
    ) %>%
      apply(2, mean)
  )

ggplot(preds.s.y.f2, aes(x = svf, y = mean.pred)) +
  geom_point(
    data = phen.open, inherit.aes = FALSE,
    aes(x = svf, y = date.init, colour = slopes),
    size = 3
  ) +
  geom_line(aes(group  = slopes, colour = slopes)) +
  facet_wrap(~ Year)
# looks even worse...


preds.s.f = expand.grid(
  slopes = (1:5)/10,
  svf  = (2:10)/10
) %>%
  cbind(
    .,
    mean.pred = posterior_predict(
      lmer.s.f,
      newdata = .,
      re.form = NA,
      draws = 200
    ) %>%
      apply(2, mean)
  )

ggplot(preds.s.f, aes(x = svf, y = mean.pred)) +
  geom_point(
    data = phen.open, inherit.aes = FALSE,
    aes(x = svf, y = date.init, colour = slopes),
    size = 3
  ) +
  geom_line(aes(group  = slopes, colour = slopes))
# heteroskedastic

# Look at random effects...

ranef.s.fy2 = lmer.s.yf2 %>%
  as.data.frame() %>%
  select(contains('Plot:')) %>%
  select(contains('b')) %>%
  apply(2, mean) %>%
  data.frame(
    plot = names(.),
    values = .
  ) %>%
  mutate(plot.no = gsub('b\\[\\(Intercept\\)\\sPlot\\:|\\]', '', plot)) %>%
  merge(phen.open %>% distinct(Plot, svf, Year, Easting, Northing, aspect), 
        by.x = 'plot.no', by.y = 'Plot')

ggplot(ranef.s.fy2, aes(x = values)) +
  geom_histogram(binwidth = 1) +
  facet_wrap(~ Year)
# variance differs by year..

ranef.s.fy2 %>%
  mutate(Year = factor(Year)) %>%
  ggplot(aes(x = svf, y = values)) +
  geom_point(aes(colour = Year))
# well at least this looks normal

ranef.s.fy2 %>%
  mutate(Year = factor(Year)) %>%
  ggplot(aes(x = aspect, y = values)) +
  geom_point(aes(colour = Year))
# no pattern here (which is good)

##### Testing s(svf) terms

gamm.sf.y = stan_gamm4(
  formula = date.init ~ s(svf, k = 5) + Year + slopes,
  random = ~ (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 904481
)

# five divergent transitions
k.sf.y = kfold(gamm.sf.y, K = 10, cores = 4)
gamm.sf.y$loo = k.sf.y

### s(svf) + Year + slope

gamm.sfy = stan_gamm4(
  formula = date.init ~ s(svf, k = 5, by = Year) + Year + slopes,
  random = ~ (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 23219
)

# ZERO divergent transitions

k.sfy = kfold(gamm.sfy, K = 10, cores = 4)
gamm.sfy$loo = k.sfy

### s(svf) + slope

gamm.sf = stan_gamm4(
  formula = date.init ~ s(svf, k = 5) + slopes,
  random = ~ (1 | Plot),
  data = phen.open %>% mutate(Year = as.factor(Year)),
  cores = 4,
  chains = 4,
  iter = 2000,
  seed = 85561
)

# two divergent transitions

k.sf = kfold(gamm.sf, K = 10, cores = 4)
gamm.sf$loo = k.sf

##### Loo compare

loo_compare(
  stanreg_list(
    lmer.y, lmer.a, lmer.s,
    lmer.y.a, lmer.y.s, lmer.a.s,
    lmer.y.a.s,
    lmer.s.f, lmer.s.y.f, lmer.s.yf, lmer.y.f, lmer.yf,
    lmer.s.f2, lmer.s.y.f2, lmer.s.yf2,
    lmer.y.f2, lmer.yf2,
    gamm.sf, gamm.sf.y, gamm.sfy
  )
)

# Model comparison based on LOO-CV: 
#             elpd_diff se_diff
# lmer.s.yf2    0.0       0.0  
# lmer.s.y.f2  -2.4       4.2  
# gamm.sf.y    -3.6       3.3  
# lmer.s.f     -6.6       3.7  
# lmer.yf      -7.4       3.7  
# lmer.y.f2    -7.8       3.5  
# gamm.sfy     -7.9       3.8  
# lmer.s.y.f   -8.5       4.0  
# lmer.s      -10.2       3.8  
# lmer.s.yf   -10.6       3.5  
# gamm.sf     -10.7       3.6  
# lmer.yf2    -11.3       4.0  
# lmer.y      -12.2       4.5  
# lmer.a.s    -12.3       3.5  
# lmer.y.a.s  -12.3       3.5  
# lmer.y.a    -12.6       4.5  
# lmer.a      -14.7       4.7  
# lmer.y.f    -15.5       4.8  
# lmer.y.s    -18.7       4.8  
# lmer.s.f2   -20.7       4.9 

plot_nonlinear(gamm.sf.y)
# similar to quadratic fit

elpds = stanreg_list(
  lmer.y, lmer.a, lmer.s,
  lmer.y.a, lmer.y.s, lmer.a.s,
  lmer.y.a.s,
  lmer.s.f, lmer.s.y.f, lmer.s.yf, lmer.y.f, lmer.yf,
  lmer.s.f2, lmer.s.y.f2, lmer.s.yf2,
  lmer.y.f2, lmer.yf2,
  gamm.sf, gamm.sf.y, gamm.sfy
) %>% 
  lapply(function(x) x$loo$estimate[1,]) %>% 
  do.call(what = rbind) %>%
  as.data.frame() %>%
  mutate(model.name = row.names(.)) 

elpds %>%
  ggplot(aes(x = model.name)) +
  geom_point(aes(y = Estimate)) +
  theme(axis.text = element_text(angle = 90)) # +
  # geom_segment(aes(xend = model.name, y = Estimate - SE, yend = Estimate + SE))

##### Assess spatial autocorrelation of random effects

ranef.s.fy2 %>%
  mutate(Year = factor(Year)) %>%
  ggplot(aes(x = Easting, y = Northing)) +
  geom_point(aes(fill = values, shape = Year), size = 4) +
  scale_fill_gradient2(low = 'red', high = 'blue', mid = 'white') +
  scale_shape_manual(values = 21:23)
# some degree of patterning

ranef.dist.matrix = ranef.s.fy2 %>%
  select(Easting, Northing) %>%
  dist() %>%
  as.matrix() %>%
  (function(x) 1/x)
diag(ranef.dist.matrix) = 0

Moran.I(ranef.s.fy2$values, ranef.dist.matrix)
# p ~ 0.99? hmm...

# Autocorrelation of random effect-centered residuals

resids.s.fy2 = phen.open %>%
  cbind(
    .,
    mean.pred = posterior_predict(
      lmer.s.yf2,
      re.form = NA,
      draws = 200,
      seed = 220240
    ) %>%
      apply(2, mean)
  ) %>%
  mutate(resid = mean.pred - date.init)

resid.dist.matrix = resids.s.fy2 %>%
  select(Easting, Northing) %>%
  dist() %>%
  as.matrix() %>%
  (function(x) 1/x)
resid.dist.matrix[resid.dist.matrix == Inf] = 0

Moran.I(resids.s.fy2$resid, resid.dist.matrix)

##### Posterior plots

pp_check(lmer.s.yf2)

ci.check.s.yf2 = cbind(
  phen.open,
  posterior_predict(lmer.s.yf2, draws = 1000, seed = 1099) %>%
    apply(2, function(x) quantile(x, c(0.025, 0.975))) %>%
    t() %>%
    as.data.frame() %>%
    rename(ci.lo = `2.5%`, ci.hi = `97.5%`)
) %>%
  mutate(is.in.ci = date.init < ci.hi & date.init > ci.lo)

ci.check.s.yf2 %>%
  ggplot(aes(x = svf, y = date.init)) +
  geom_point(aes(colour = is.in.ci), size = 3) +
  facet_wrap(~ Year)

ci.check.s.yf2 %>%
  ggplot(aes(x = slopes, y = date.init)) +
  geom_point(aes(colour = is.in.ci), size = 3) +
  facet_wrap(~ Year)

mean(ci.check.s.yf2$is.in.ci) # 96%

##### Make summary plot?

plot.backbone =  expand.grid(
  svf = seq(.18, .95, by = .07),
  Year = factor(2020:2022),
  slopes = sin(c(10, 15) * pi/180)
) %>%
  mutate(svf.cent = svf - mean(svf))

# oh there's some dumb shit going on here with poly()

matr.s.yf2 = model.matrix( ~ slopes + Year * poly(svf, 2), plot.backbone)

pdraw.s.yf2 = as.data.frame(lmer.s.yf2) %>% 
  sample_n(50) %>%
  select(colnames(matr.s.yf2)) %>%
  t()

pmean.s.yf2 = matr.s.yf2 %*% pdraw.s.yf2

plot.posteriors = cbind(plot.backbone, as.data.frame(pmean.s.yf2)) %>%
  pivot_longer(starts_with("V"), names_to = 'draw', values_to = 'estm')

plot.posteriors %>%
  mutate(slopes = factor(slopes)) %>%
  ggplot(aes(x = svf.cent, y = estm)) +
  geom_line(aes(group = interaction(draw, slopes), colour = slopes), linewidth = 0.15) +
  geom_point(
    data = phen.open %>% mutate(Year = factor(Year), svf.cent = svf - mean(plot.backbone$svf)), 
    inherit.aes = FALSE,
    aes(x = svf.cent, y = date.init, fill = slopes),
    shape = 21, size = 4, alpha = 0.5
  ) +
  scale_fill_viridis_c(option = 'A') +
  scale_colour_viridis_d(option = 'A') +
  facet_wrap(~ Year) +
  theme(
    strip.background = element_rect(fill = 'gray55'),
    panel.background = element_rect(fill = 'gray55'),
    panel.grid = element_blank()
  )


### Another crack at this (less good but will work with centered vars)

lmer.pp = posterior_predict(
  object = lmer.s.yf2,
  newdata = plot.backbone,
  re.form = NA,
  draws = 4000,
  seed = 991
)

from.draws = plot.backbone %>% cbind(lmer.pp %>% t() %>% as.data.frame()) %>%
  pivot_longer(starts_with("V"), names_to = 'draw', values_to = 'estm') %>%
  group_by(svf, slopes, Year) %>%
  reframe(estm.mean = mean(estm), ci = quantile(estm, c(0.025, 0.975)), x = c('ci.lo', 'ci.hi')) %>%
  pivot_wider(names_from = x, values_from = ci) %>%
  mutate(slope.degrees = asin(slopes) * 180/pi)

from.draws %>%
  ggplot(aes(x = svf)) +
  geom_point(
    data = phen.open %>% mutate(Year = factor(Year), slope.degrees = asin(slopes) * 180/pi),
    aes(x = svf, y = date.init, fill = slope.degrees),
    shape = 21, size = 4, alpha = 0.5
  ) +
  geom_line(aes(y = estm.mean, group = slopes, colour = slope.degrees)) +
  geom_ribbon(
    aes(ymin = ci.lo, ymax = ci.hi, group = slopes, fill = slope.degrees),
    alpha = 0.1
  ) +
  scale_fill_steps(
    low = 'black', high = 'tan3',
    limits = c(5, 30), guide = 'coloursteps',
    'Topographic\nslope'
  ) +
  scale_color_steps(
    low = 'black', high = 'tan3', 
    limits = c(5, 30), guide = 'coloursteps',
    'Topographic\nslope'
  ) +
  facet_wrap(~ Year) +
  labs(x = 'Sky view factor', y = 'Date of flowering') +
  scale_y_continuous(
    breaks = 1 + (0:6)*7,
    labels = format.Date(as.Date(1 + (0:6)*7, origin = '2023-05-31'), format = '%d %b')
  ) +
  theme(
    panel.background = element_blank(),
    legend.position = 'none'
  )

# yeah that looks a lot better
# (I mean still not great)

### Summary statistics

posterior.mesh = expand.grid(
  svf = (1:999)/1000,
  Year = factor(2020:2022)
) %>%
  mutate(
    slopes = .1, # this value is needed but does not matter
    svf.cent = svf - mean(svf)
  )

matr.s.yf2 = model.matrix( ~ slopes + Year * poly(svf, 2), posterior.mesh)

pdraw.s.yf2 = as.data.frame(lmer.s.yf2) %>% 
  select(colnames(matr.s.yf2)) %>%
  t()

pmean.s.yf2 = matr.s.yf2 %*% pdraw.s.yf2

plot.posteriors = cbind(posterior.mesh, as.data.frame(pmean.s.yf2)) %>%
  pivot_longer(starts_with("V"), names_to = 'draw', values_to = 'estm')

posterior.summ = plot.posteriors %>%
  group_by(Year, draw) %>%
  summarise(
    min.estm  = min(estm),
    max.estm  = max(estm),
    curve.min = svf[which.min(estm)],
    curve.max = svf[which.max(estm)],
    curve.lef = estm[1],
    curve.rgt = estm[999]
  )

posterior.summ %>% 
  mutate(
    case = case_when(
      (curve.lef == min.estm) & (curve.rgt == max.estm) ~ 'mono.incr',
      (curve.lef == max.estm) & (curve.rgt == min.estm) ~ 'mono.decr',
      (max.estm > curve.lef)  & (max.estm > curve.rgt)  ~ 'quad.neg',
      (min.estm < curve.lef)  & (min.estm < curve.rgt)  ~ 'quad.pos',
      .default = 'oops'
    )
  ) %>%
  group_by(case) %>% summarise(n = n())

posterior.summ = posterior.summ %>%
  mutate(
    case = case_when(
      (curve.lef == min.estm) & (curve.rgt == max.estm) ~ 'mono.incr',
      (curve.lef == max.estm) & (curve.rgt == min.estm) ~ 'mono.decr',
      (max.estm > curve.lef)  & (max.estm > curve.rgt)  ~ 'quad.neg',
      (min.estm < curve.lef)  & (min.estm < curve.rgt)  ~ 'quad.pos',
      .default = 'oops'
    )
  )

posterior.summ %>% 
  group_by(Year, case) %>%
  summarise(n = n()) %>%
  group_by(Year) %>%
  mutate(p = n / sum(n)) %>%
  pivot_wider(names_from = case, values_from = c(p, n))

posterior.summ %>%
  mutate(svf.effect = (max.estm - min.estm) * ifelse(curve.max > curve.min, 1, -1)) %>%
  ggplot(aes(x = svf.effect)) +
  geom_histogram(aes(fill = svf.effect > 0), boundary = TRUE, colour = 'black', binwidth = 1) +
  scale_fill_manual(
    values = c('white', 'black'),
    labels = c('Negative', 'Positive'),
    'Effect\nsign'
  ) +
  labs(x = 'd (days)', y = 'Posterior estimates') +
  facet_wrap(~ Year) +
  theme(
    panel.background = element_blank(),
    strip.background = element_blank(),
    strip.text = element_blank(),
    legend.position = 'none'
  )

posterior.summ %>%
  mutate(svf.effect = (max.estm - min.estm) * ifelse(curve.max > curve.min, 1, -1)) %>%
  group_by(Year) %>%
  reframe(
    mean = mean(svf.effect),
    p.ng = mean(svf.effect < 0),
    quantile = quantile(svf.effect, c(0.025, 0.975)),
    x = c('ci.lo', 'ci.hi')
  ) %>%
  pivot_wider(names_from = x, values_from = quantile)
  

posterior.summ %>%
  ggplot(aes(x = curve.max)) +
  geom_histogram(aes(fill = case)) +
  facet_wrap(~ Year)

###

phen.plot = from.draws %>%
  ggplot(aes(x = svf)) +
  geom_point(
    data = phen.open %>% mutate(Year = factor(Year), slope.degrees = asin(slopes) * 180/pi),
    aes(x = svf, y = date.init, fill = slope.degrees),
    shape = 21, size = 2, alpha = 0.5
  ) +
  geom_line(aes(y = estm.mean, group = slopes, colour = slope.degrees)) +
  geom_ribbon(
    aes(ymin = ci.lo, ymax = ci.hi, group = slopes, fill = slope.degrees),
    alpha = 0.1
  ) +
  scale_fill_steps(
    low = 'black', high = 'tan3',
    limits = c(5, 30), guide = 'coloursteps',
    'Slope\n(degrees)'
  ) +
  scale_color_steps(
    low = 'black', high = 'tan3', 
    limits = c(5, 30), guide = 'coloursteps',
    'Slope\n(degrees)'
  ) +
  facet_wrap(~ Year) +
  labs(x = 'Sky view factor', y = 'Date of flowering') +
  scale_y_continuous(
    breaks = 1 + (0:6)*7,
    labels = format.Date(as.Date(1 + (0:6)*7, origin = '2023-05-31'), format = '%d %b')
  ) +
  theme(
    panel.background = element_blank(),
    legend.position = 'none'
  )

stat.plot = posterior.summ %>%
  mutate(svf.effect = (max.estm - min.estm) * ifelse(curve.max > curve.min, 1, -1)) %>%
  ggplot(aes(x = svf.effect)) +
  geom_histogram(aes(fill = svf.effect > 0), boundary = TRUE, colour = 'black', binwidth = 1) +
  scale_fill_manual(
    values = c('white', 'black'),
    labels = c('Negative', 'Positive'),
    'Effect sign'
  ) +
  labs(x = 'd (days)', y = 'Posterior estimates') +
  facet_wrap(~ Year) +
  theme(
    panel.background = element_blank(),
    strip.background = element_blank(),
    strip.text = element_blank(),
    legend.position = 'none'
  )

phen.legend = get_legend(
  phen.plot + theme(legend.position = 'right', legend.title = element_text(hjust = .5), legend.justification = 'left')
)
stat.legend = get_legend(
  stat.plot + theme(legend.position = 'right', legend.title = element_text(hjust = .5), legend.justification = 'left')
)

plot_grid(
  phen.plot, phen.legend, stat.plot, stat.legend,
  nrow = 2, rel_heights = c(1, 1, 1, 1), rel_widths = c(1, .15, 1, .15)
) %>%
  save_plot(
    filename = 'analysis/figures_etc/fig_out/phen_d_plot.png',
    base_width = 8, base_height = 5
  )
  

