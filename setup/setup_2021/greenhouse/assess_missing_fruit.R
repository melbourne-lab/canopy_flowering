# Assessing missing Thermopsis fruit

library(ggplot2)
library(dplyr)
library(tidyr)

##### Thermopsis #####

# Phenology data

tdiv = dir('data/raw_data/data_2021/') %>%
  grep(pattern = '[Tt]herm', value = TRUE) %>%
  grep(pattern = 'entry|new', value = TRUE) %>%
  paste0('data/raw_data/data_2021/', .) %>%
  lapply(read.csv) %>%
  do.call(what = rbind)

# Harvest data

harv = dir('data/raw_data/data_2021/') %>%
  grep(pattern = '[Tt]herm', value = TRUE) %>%
  grep(pattern = 'harv', value = TRUE) %>%
  paste0('data/raw_data/data_2021/', .) %>%
  lapply(read.csv) %>%
  do.call(what = rbind)

# Summarise - get total number of fruit collected per plant

harv.summ = harv %>%
  group_by(Tag, Plot) %>%
  summarise(fruit_coll = sum(Fruit_Coll, na.rm = TRUE))

tdiv.fruit = merge(
  x = tdiv %>% filter(!is.na(Tag)) %>% distinct(Plot, Tag),
  y = harv.summ,
  by = c('Plot', 'Tag'), all.x = TRUE, all.y = TRUE)
)

tdiv.fruit %>%
  group_by(Plot) %>%
  summarise(n.pla.fruit = sum(fruit_coll > 0, na.rm = TRUE),
            n.pla.nofrt = sum(!fruit_coll | is.na(fruit_coll))) %>%
  arrange(n.pla.fruit) %>%
  print(n = nrow(.))

tdiv.fruit %>%
  filter(!fruit_coll) %>%
  distinct()

# Fruit summary, by date of first flower

tdiv.date = merge(
  x = tdiv %>% filter(!is.na(Tag), Fl_Open > 0) %>% distinct(Plot, Tag, Date),
  y = harv.summ,
  by = c('Plot', 'Tag'), all.x = TRUE, all.y = TRUE)
)

head(tdiv.date)

tdiv.date %>%
  filter(!is.na(fruit_coll)) %>%
  ggplot(aes(x = Date, y = fruit_coll)) +
  geom_point(position = position_jitter(width = 0.25, height = 0.25))

glm(any.fruit ~ Date, family = 'binomial',
    tdiv.date %>% mutate(Date = as.numeric(as.Date(Date, '%m/%d/%y')), any.fruit = fruit_coll > 0)) %>%
  summary()
