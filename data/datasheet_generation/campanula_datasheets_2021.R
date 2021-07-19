# For generating campanula datasheets in 2021

library(dplyr)
library(tidyr)

read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  arrange(Plot, Tag) %>%
  mutate(Prev = paste(Fl_stems, Fl_open, Fl_done, sep = ';')) %>%
  rename(Prev_note = Note) %>%
  mutate(Date = NA, Fl_stems = NA, Fl_open = NA, Fl_done = NA, Q = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Prev, Prev_note) %>%
  write.csv(file = 'data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_19-07-21.csv',
            na = '', row.names = FALSE)
