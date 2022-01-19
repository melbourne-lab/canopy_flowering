# Script for generating datasheet for counting seeds from 2021 fruit
# SN - 11 Jan 2022

# Load packages
library(ggplot2)
library(dplyr)
library(tidyr)

### Read in data

# Read in all harvest datasheets

setwd('data/raw_data/data_2021')

harv.all = dir() %>%
  as.data.frame() %>%
  filter(grepl('therm_harvest', .)) %>%
  unlist() %>%
  lapply(read.csv) %>%
  do.call(what = rbind)
  
setwd('../../..')

# Look at data
head(harv.all)
# Looks right

# Get only plants where fruit was harvested
harv.all = harv.all %>% filter(Fruit_Coll > 0)

### Generate dataframe

# Set seed (because plant order is shuffled)
set.seed(717374)

# Fruit data frame
harv.frt = harv.all %>%
  # Shuffle order of plants (currently there is one row per plant)
  sample_n(size = n(), replace = FALSE) %>%
  # Get only relevant data (don't need harvest dates - these can be cross referenced)
  select(Tag, Fruit_Coll) %>%
  # Get one row per fruit collected (as counted)
  # (then add fruit number column)
  uncount(Fruit_Coll) %>%
  group_by(Tag) %>%
  mutate(Fruit_no = 1:n()) %>%
  ungroup() %>%
  # Add columns
  #   - Full_fruit_wt: weight of whole fruit
  #   - Total_n_seeds: total number of seeds seen (including small, likely nonviable ones)
  #   - Full__n_seeds: number of full-sized seeds
  #   - All_seeds__wt: weight of all seeds (including small, likely nonviable ones)
  mutate(Full_fruit_wt = NA,
         Total_n_seeds = NA,
         Full__n_seeds = NA,
         All_seeds__wt = NA,
         Date_counted  = NA,
         Notes = NA
  )

head(harv.frt)

# Export
write.csv(harv.frt,
          'data/datasheet_generation/datasheet_outputs/data_datasheets_2021/seed_counting_data.csv',
          na = '', row.names = FALSE)
