# Looking at these things for comps proposal

library(ggplot2)
library(dplyr)
library(tidyr)

# Data downlaoded from EDI (https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-nwt.401.5)
# downloaded on Nov 9 2021

all.c1 = read.csv('data/solar_data/c1_2000-2020/c-1cr23x-cr1000.daily.ml.data.csv')

head(jday)

all.c1 %>%
  ggplot(aes(x = jday, y = solrad_tot)) +
  geom_line(aes(group = year), size = 1/20) 

all.c1 %>%
  ggplot(aes(x = jday, y = solrad_tot)) +
  geom_line() +
  facet_wrap(~ year)

# 2014 is a bust, 2015-2020 appears to be different than 2000 - 2013
# looks like there is something strange happening at end of 2016, early in 2020, ...

# what about mean instead of total?
all.c1 %>%
  ggplot(aes(x = jday, y = solrad_avg)) +
  geom_line() +
  facet_wrap(~ year)

# only 2013-2020 but this does look better!

# Try looking at period of interest only: March 1 - June 30 (jday 61-181)
all.c1 %>%
  filter(jday %in% 61:181) %>%
  ggplot(aes(x = jday, y = solrad_tot)) +
  geom_line() +
  facet_wrap(~ year)

all.c1 %>%
  filter(!is.na(solrad_avg)) %>%
  filter(jday %in% 61:181) %>%
  ggplot(aes(x = jday, y = solrad_avg)) +
  geom_line() +
  facet_wrap(~ year)

# Can we get a clean curve just by looking at max?

all.c1 %>%
  filter(!is.na(solrad_avg)) %>%
  group_by(jday) %>%
  summarise(max_avg = max(solrad_avg)) %>%
  ggplot(aes(x = jday, y = max_avg)) +
  geom_line()

# Actually I think a smoother could fix this? Perhaps?

all.c1 %>%
  group_by(jday) %>%
  summarise(max_tot = max(solrad_tot)) %>%
  ggplot(aes(x = jday, y = max_tot)) +
  geom_line()
# Spottier.

# Should also look at "flag" cols at some point.

# From the manifest:
# Climatological data were collected from the C1 climate station on Niwot Ridge
# (3018 m elevation) throughout the year. From 2000-06-24 to 2013-03-25, data
# were recorded using a Campbell Instruments CR23X data logger. Starting
# 2013-03-27, data were recorded using a Campbell Instruments CR1000 data
# logger. Maximum and minimum values were recorded instantaneously, with a
# sampling interval of 5 seconds. Daily means and totals were calculated from
# 17,280 individual measurements. The CR23X logger was programmed to generate
# both hourly and daily output. The CR1000 logger generated daily, hourly, and
# minute data until 2014-09-10, when these time periods were discontinued and
# only 10 minute raw data were collected.

# So the sampling interval changes as does the logger. Probably should only do 2015 - 2020 then.
