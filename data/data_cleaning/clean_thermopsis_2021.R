# Cleaning Thermopsis data collected in 2021
#
# init 15 Nov. 2021

library(ggplot2)
library(dplyr)
library(tidyr)

##### Thermopsis #####

# First look

tdiv = dir('data/raw_data/data_2021/') %>%
  grep(pattern = '[Tt]herm', value = TRUE) %>%
  grep(pattern = 'entry|new', value = TRUE) %>%
  paste0('data/raw_data/data_2021/', .) %>%
  lapply(read.csv) %>%
  do.call(what = rbind)

tdiv %>%
  filter(!is.na(Tag)) %>%
  distinct(Plot, Tag) #%>%
  nrow()

