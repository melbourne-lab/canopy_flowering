library(ggplot2)
library(dplyr)
library(tidyr)
library(lme4)

n.plants = 10

design = expand.grid(
  timep = 1:3,
  plant = 1:n.plants,
  shade = 1:3,
  flowr = 1:3,
  addtn = c(TRUE, FALSE)
)

##### Study without time or shade effects

b0 = log(3)
b1 = log(6) - log(3)

design1 = design %>%
  mutate(seeds = rpois(n = nrow(.), lambda = exp(b0 + b1*addtn)))

# Model
glm(seeds ~ addtn, design1, family = 'poisson') %>%
  summary()

##### Study with plant-level random effects

plant.sd = 0.15
plant.ranef = expand.grid(timep = 1:3, plant = 1:n.plants, shade = 1:3) %>%
  mutate(planef = rnorm(nrow(.), 0, plant.sd))

design2 = design %>%
  merge(y = plant.ranef) %>%
  mutate(plant = plant + (n.plants*(timep-1))) %>%
  mutate(seeds  = rpois(n = nrow(.), lambda = exp(b0 + b1*addtn + planef)))

glmer(seeds ~ addtn + (1 | plant), design2, family = 'poisson') %>% summary()

##### Now, thinking about time-varying effects.

# Effect on *overall* seed set
b2 = -1/2
# Effect of pollen limitation over time
b3 = 1/4

# Interaction with the addition treatment?
design3 = design %>%
  merge(y = plant.ranef) %>%
  mutate(plant = plant + (n.plants*(timep-1))) %>%
  mutate(lambda = exp(b0 + b1 * addtn + b2 * timep + (b3 * addtn * timep) + planef),
         seeds  = rpois(n = nrow(.), lambda = lambda))

# Plotting raw data
design3 %>%
  ggplot(aes(x = timep, y = lambda, colour = addtn)) +
  geom_point(position = position_jitter(width = 0.25), alpha = 0.5) +
  scale_color_manual(values = c('blue', 'red')) +
  scale_y_log10()

model3 = glmer(seeds ~ addtn * timep + (1 | plant),
               data = design3, family = 'poisson')

summary(model3)
# Getting a singularity warning here - not sure why.

with(design3, table(plant, timep))
with(design3, table(plant, addtn))
with(design3, table(timep, addtn))
# hmm...

# Also noting that, to get a significant result with n.plant = 8,
# the effect needs to be large. May need to up sample size
# (would ten work?)

# Plotting results
design3 %>%
  mutate(model.pred = predict(model3)) %>%
  ggplot(aes(x = timep, y = model.pred)) +
  geom_line(aes(group = addtn, colour = addtn))

# On the exponentiated scale (seed numbers)
design3 %>%
  mutate(model.pred = predict(model3, type = 'response')) %>%
  ggplot(aes(x = timep, y = model.pred)) +
  geom_line(aes(group = addtn, colour = addtn))

# Not incredibly evident on this scale but the effect is small.

##### Thinking about shade effects *only*.

# Expectation: for control (reference), 
# seed set decreasing with shade, decreasing with time

# Effects of shade (in control)
b4 = -1/3
# Effects of shade over time in control
# (i.e., how much worse shading is over time)
b5 = -1/15
# Effects of shade on addition
b6 = 1/3.5
# Interaction of shade, addition, and time
b7 = 1/6

design4 = design %>%
  merge(y = plant.ranef) %>%
  mutate(plant = plant + (n.plants*(timep-1))) %>%
  mutate(lambda = exp(b0 + b1 * addtn + b2 * timep + (b3 * addtn * timep) +
                      b4 * shade + (b5 * shade * timep) + (b6 * shade * timep * addtn) +
                      planef),
         seeds  = rpois(n = nrow(.), lambda = lambda))

# First, plot.
# Plotting raw data
design4 %>%
  ggplot(aes(x = timep, y = lambda, colour = addtn)) +
  geom_point(position = position_jitter(width = 0.25), alpha = 0.5) +
  scale_color_manual(values = c('blue', 'red')) +
  scale_y_log10() +
  facet_wrap(~ shade)

model4 = glmer(seeds ~ addtn * timep * shade + (1 | plant),
               data = design4, family = 'poisson')
# Another singularity warning. Not sure why.

summary(model4)
# many of these effects appear to be too lsmall to pick up on this little data.
# Although, I will have data elsewhere to test time, shade, time*shade hypotheses
# Important ones here are addition ones
# The three way interaction is there... (could just be because I chose a somewhat large one)
