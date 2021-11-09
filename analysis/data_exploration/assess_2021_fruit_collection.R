### Script for looking at Thermopsis fruit collected in July 2021
# Some summary statistics mostly, but soon should get flowering dates
# SN - 8 Nov 2021

library(ggplot2)
library(dplyr)
library(tidyr)

all.fruit = rbind(
  read.csv('data/raw_data/data_2021/therm_harvest_15-07-21.csv'),
  read.csv('data/raw_data/data_2021/therm_harvest_19-07-21.csv'),
  read.csv('data/raw_data/data_2021/therm_harvest_26-07-21.csv'),
  read.csv('data/raw_data/data_2021/therm_harvest_29-07-21.csv')
)

all.fruit = all.fruit %>% filter(!is.na(Fruit_Pres), Fruit_Coll > 0)

all.fruit %>%
  summarise(n.plots = length(unique(Plot)),
            n.plant = length(unique(Tag)),
            n.fruit = sum(Fruit_Coll))

# Which plots?  

all.fruit %>%
  distinct(Plot) %>%
  arrange(Plot)
# Appears to be a good spread.

# 