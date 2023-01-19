# Annalise completed a lot more of the seed counting and weighing than I expected.
# This is good! Here, I'll look for possible biases to see if anything needs correcting.
# SN - 18 Jan 2023

# Libraries

library(ggplot2)
library(dplyr)
library(tidyr)

# Load in data, gsub out invisible spaces

seed.data = read.csv('data/raw_data/data_2021/seed2021_counts_post-annalise.csv') %>%
  mutate(Date_counted = as.Date(Date_counted, format = '%m/%d/%y'),
         Initials = gsub('\\s', '', Initials))
  

head(seed.data)

# Counts by person

seed.data %>%
  group_by(Initials, Date_counted) %>%
  summarise(n = n()) %>% tail()

seed.data %>%
  mutate(Initials = gsub('\\s', '', Initials)) %>%
  group_by(Initials) %>%
  summarise(n = n())

# I forgot to add in initials before this date...
seed.data2 = seed.data %>% 
  mutate(Person = ifelse(Initials %in% '' & Date_counted < as.Date('2022-10-01'), 'SN', Initials))

# How many per person now? And how many left over
# still 21 left to do but that's 5% of the total
seed.data2 %>%
  group_by(Person) %>%
  summarise(n = n())

# Give me only those done by either of us (still >350)

seed.data3 = seed.data2 %>% filter(Person %in% c('AS', 'SN'))

# Number of seeds per person
glm(Total_n_seeds ~ Person, family = poisson, data = seed.data3) %>%
  summary()
# that's pretty good news...
# not seeing an effect of person on total number of seeds - that's good!

lme4::glmer(Total_n_seeds ~ Person + (1|Tag), family = poisson, data = seed.data3) %>%
  summary()
# yeah after controlling for plant also no effect!

glm(Full__n_seeds ~ Person, family = poisson, data = seed.data3) %>%
  summary()
# Okay I definitely have more seeds

lme4::glmer(Full__n_seeds ~ Person + (1 | Tag), family = poisson, data = seed.data3) %>%
  summary()
# although this differences goes away after controlling for the plant...

# Logistic regression - seems like this is better for classifying empty/full

glm(cbind(Full__n_seeds, Empty_n_seeds) ~ Person, family = binomial,
    data = seed.data3 %>% mutate(Empty_n_seeds = Total_n_seeds - Full__n_seeds)) %>%
  summary()
# Yeah - I am ~2.5x more likely to call it it full than annalise

# Tag-level random effect
lme4::glmer(cbind(Full__n_seeds, Empty_n_seeds) ~ Person + (1 | Tag), 
            family = binomial,
            data = seed.data3 %>% mutate(Empty_n_seeds = Total_n_seeds - Full__n_seeds)) %>%
  summary()
# yeah unquestionably; larger effect size...

### Plots
# (because plots are good too lol)

# what about weights
seed.data3 %>% ggplot(aes(x = Full__n_seeds)) + geom_histogram(binwidth = 1)
# wtf that is so many zeros...

seed.data3 %>% ggplot(aes(x = Total_n_seeds)) + geom_histogram(binwidth = 1)

seed.data3 %>% 
  ggplot(aes(x = Total_n_seeds, y = Full__n_seeds, colour = Person)) +
  geom_point(position = position_jitter(height = 0.5, width = 0.5))
# woof
# wait I'e had 15 seeds...?

seed.data3 %>%
  group_by(Person) %>%
  summarise(Empties = mean(Total_n_seeds > Full__n_seeds, na.rm = TRUE))
# hmm I have a lot more full than her...

seed.data3 %>%
  group_by(Person) %>%
  summarise(Empties = mean(Total_n_seeds > 0 & !Full__n_seeds, na.rm = TRUE))
# oh man he called a lot of these empties...

seed.data3 %>%
  ggplot(aes(x = Person, y = Total_n_seeds)) +
  geom_point(position = position_jitter(width = .25))

seed.data3 %>%
  ggplot(aes(x = Person, y = Full__n_seeds)) +
  geom_point(position = position_jitter(width = .25))
# man a lot of zeros, especially for her (way more for her...)

seed.data3 %>%
  ggplot(aes(x = Person, y = Full_fruit_wt)) +
  scale_y_log10() +
  geom_point(position = position_jitter(width = .25))
# this actually looks okay...

seed.data3 %>%
  filter(All_seeds__wt > 0) %>%
  ggplot(aes(x = Person, y = All_seeds__wt)) +
  scale_y_log10() +
  geom_point(position = position_jitter(width = .25))
# hmm... some slight differences here

seed.data3 %>%
  filter(All_seeds__wt > 0) %>%
  ggplot(aes(x = Total_n_seeds, y = All_seeds__wt, colour = Person)) +
  geom_point(position = position_jitter(width = 0.5)) +
  scale_y_log10()
# yeah does kinda look like seed weights are not so great...
# I should check these out

# Look at log weight PER "FULL" SEED
lme4::lmer(
  logwt.per ~ Person + (1|Tag),
  data = seed.data3 %>%
    filter(All_seeds__wt > 0, Full__n_seeds > 0) %>%
    mutate(logwt.per = log(All_seeds__wt / Full__n_seeds))
  ) %>%
  summary()
# oh that's surprising - would have expected a difference because of the differences...

lm(
  logwt.per ~ Person,
  data = seed.data3 %>%
    filter(All_seeds__wt > 0, Full__n_seeds > 0) %>%
    mutate(logwt.per = log(All_seeds__wt / Full__n_seeds))
) %>%
  summary()
# nice!

# what about dividing by total? total should be a more consistent number...

lme4::lmer(
  logwt.per ~ Person + (1|Tag),
  data = seed.data3 %>%
    filter(All_seeds__wt > 0, Total_n_seeds > 0) %>%
    mutate(logwt.per = log(All_seeds__wt / Total_n_seeds))
) %>%
  summary()
# hmm... so weight per seed divided by total number of seeds does matter some...
# I have more weight per seed
# would expect this to not matter?

lm(
  logwt.per ~ Person,
  data = seed.data3 %>%
    filter(All_seeds__wt > 0, Total_n_seeds > 0) %>%
    mutate(logwt.per = log(All_seeds__wt / Total_n_seeds))
) %>%
  summary()

# hmm... what differences does this make though?
exp(0.621)
# seems kinda like a big number...

# One final one - should just do total seed weights to be safe
# (although what am I actually more likely to be measuring...?
# I guess this is just for super-safety)

lm(
  logwt.per ~ Person,
  data = seed.data3 %>%
    filter(All_seeds__wt > 0, Total_n_seeds > 0) %>%
    mutate(logwt.per = log(All_seeds__wt))
) %>%
  summary()
# yeah that's a difference I have heaver seeds (why?)

####################################################
# Conclusions:
# - Definitely some discrepancies
#     - I am much more likely to call seeds full
#       - as such I think I should go back and re-count seeds... full more improtant
#       - this also means seed weight per full is kinda messed up though even if I didn't see it
#     - No differences in total number of seeds though... I guess this is good?
#     - Not sure what to make of weight differences though...
#       - I say just re-do a subset and compare to her measurements
#     - Lesson for the future... do more thorough training on judgement call-involved tasks!
#

