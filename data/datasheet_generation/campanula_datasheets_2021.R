# For generating campanula datasheets in 2021

library(dplyr)
library(tidyr)

### Jul 19

read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  arrange(Plot, Tag) %>%
  mutate(Prev = paste(Fl_stems, Fl_open, Fl_done, sep = ';')) %>%
  rename(Prev_note = Note) %>%
  mutate(Date = NA, Fl_stems = NA, Fl_open = NA, Fl_done = NA, Q = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Prev, Prev_note) %>%
  write.csv(file = 'data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_19-07-21.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_19-07-21.csv') %>%
  mutate(Date = NA, Page = NA, Note = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Page, Note) %>%
  write.csv('data/raw_data/data_2021/campa_entry_19-07-21.csv', row.names = FALSE, na = '')

### Jul 20

plots.0720 = read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  rbind(read.csv('data/raw_data/data_2021/campa_entry_19-07-21.csv')) %>%
  filter(Date %in% '7/19/21') %>%
  group_by(Plot) %>%
  summarise(nfl = sum(Fl_open))

set.seed(9900)

sample(plots.0720$Plot[plots.0720$nfl > 0])
# [1] 74 17 37 71 53  7  6 73
sample(plots.0720$Plot[!plots.0720$nfl])
# [1] 26 82 67
sample(plots.0720$Plot[plots.0720$nfl > 0], size = 4)
# [1] 53 73 71  6

### July 22 2021

# get phen datasheet
read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  rbind(read.csv('data/raw_data/data_2021/campa_entry_19-07-21.csv')) %>%
  arrange(Plot, Tag) %>%
  mutate(Prev = paste(Fl_stems, Fl_open, Fl_done, sep = ';')) %>%
  rename(Prev_note = Note) %>%
  mutate(Date = NA, Fl_stems = NA, Fl_open = NA, Fl_done = NA, Q = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Prev, Prev_note) %>%
  write.csv(file = 'data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_22-07-21.csv',
            na = '', row.names = FALSE)

# get data entry csv

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_22-07-21.csv') %>%
  mutate(Date = NA, Page = NA, Note = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Page, Note) %>%
  write.csv('data/raw_data/data_2021/campa_entry_22-07-21.csv', row.names = FALSE, na = '')

