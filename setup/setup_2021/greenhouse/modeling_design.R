library(ggplot2)
library(dplyr)
library(tidyr)
library(lme4)

# Parameters
b.0 = 10  # mean across all levels
b.t = 1   # effect of environmental variable
s.t = 0.5 # std. dev. across transects
s.f = 1.0 # std. dev. across families w/in transect
s.y = 0.2 # residual variation

design = expand.grid(transect = 1:10, family = 1:8, plant = 1:5)

set.seed(909)

# get random effects
plot.effects = data.frame(transect = 1:10, t.ref = rnorm(10, mean = 0, sd = s.t))
faml.effects = expand.grid(transect = 1:10, family = 1:8) %>%
  mutate(f.ref = rnorm(80, mean = 0, sd = s.f)) 
# ah that's how... nested: 80 draws, non-nested: 8 draws  

# fixed effect of environment
plot.fixeffs = data.frame(transect = 1:10, x = 2*(1:10)) %>%
  mutate(t.fef = x * b.t)

# Now... add it all together
simmed.data = merge(x = design, y = plot.effects) %>%
  merge(y = faml.effects) %>%
  merge(y = plot.fixeffs) %>%
  mutate(residual = rnorm(nrow(.), mean = 0, sd = s.y)) %>%
  mutate(y_i = b.0 + t.ref + f.ref + t.fef + residual)

hist(simmed.data$y_i)

# Convert transect, family and plant to  factors
simmed.data = simmed.data %>%
  mutate(transect = factor(transect),
         family = factor(family),
         plant = factor(plant))

# Now... see what a model does
lm(y_i ~ 1, data = simmed.data)

# Random effect of transect incorporated
lmer(y_i ~ (1 | transect), data = simmed.data) %>% summary()
# estimated transect-level std. dev. here is ~6
# residual variance is 1

# if we add in the fixed effect at this state
lmer(y_i ~ x + (1 | transect), data = simmed.data) %>% summary()
# now, the estimated transect-level variance is ~0.4 (it is actually 0.5)!
# remaining variation is left in residual term (resid. var in model is ~1, but actually it's 0.2)

# model without fixed effect, but with family random effect
lmer(y_i ~ (1 | transect / family), data = simmed.data) %>% summary()
# hmm... when family term is added it actually looks like estimates are good
# with the exception of transect

# just because I'm curious - try model where the family effect is not nested
lmer(y_i ~ (1 | transect) + (1 | family), data = simmed.data) %>% summary()
# ah - here, a lot of that variation is picked up by the residual instead!
# interesting! wonder what that relationship is.

# Here is the good model
lmer(y_i ~ x + (1 | transect / family), data = simmed.data) %>% summary()
# this is about right!
# Not sure what to do think about the correlation of fixed effects though!

##### Ohh... I can look at correlation here!

# Actually I'm not sure how to sim this!
