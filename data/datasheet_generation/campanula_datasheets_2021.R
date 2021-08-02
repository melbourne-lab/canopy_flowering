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
  distinct(Tag, .keep_all = TRUE) %>% ## comment out in successive versions
  write.csv('data/raw_data/data_2021/campa_entry_22-07-21.csv', row.names = FALSE, na = '')

### Jul 26 2021

read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  rbind(read.csv('data/raw_data/data_2021/campa_entry_19-07-21.csv'),
        read.csv('data/raw_data/data_2021/campa_entry_22-07-21.csv')) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  # Get rid of gone or collected plants
  group_by(Tag) %>%
  filter(!grepl('[Cc]ollected|[Gg]one', Note)) %>%
  # (at some point - next time - will want to remove plants with more than 3 consecutive
  # empty records)
  ungroup() %>%
  # Get only one row per plant
  distinct(Tag, .keep_all = TRUE) %>%
  mutate(Prev = paste(Fl_stems, Fl_open, Fl_done, sep = ';')) %>%
  rename(Prev_note = Note) %>%
  mutate(Date = NA, Fl_stems = NA, Fl_open = NA, Fl_done = NA, Q = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Prev, Prev_note) %>%
  write.csv(file = 'data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_26-07-21.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_26-07-21.csv') %>%
  mutate(Date = NA, Page = NA, Note = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Page, Note) %>%
  distinct(Tag, .keep_all = TRUE) %>% ## comment out in successive versions
  write.csv('data/raw_data/data_2021/campa_entry_26-07-21.csv', row.names = FALSE, na = '')

### Jul 27 2021

plots.0727 = read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  rbind(read.csv('data/raw_data/data_2021/campa_entry_26-07-21.csv')) %>%
  filter(Date %in% '7/26/21') %>%
  group_by(Plot) %>%
  summarise(nfl = sum(Fl_open))

set.seed(1516)

sample(plots.0727$Plot, 15)
#  [1]  7 45  1 10 53 67 17  3 82  8 34 37 74 66  2

### July 29 2021

read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  rbind(read.csv('data/raw_data/data_2021/campa_entry_19-07-21.csv'),
        read.csv('data/raw_data/data_2021/campa_entry_22-07-21.csv'),
        read.csv('data/raw_data/data_2021/campa_entry_26-07-21.csv')) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  # Get rid of gone or collected plants
  group_by(Tag) %>%
  filter(!grepl('[Cc]ollected|[Gg]one|[Ii]ggy', Note)) %>%
  # (at some point - next time - will want to remove plants with more than 3 consecutive
  # empty records)
  ungroup() %>%
  # Get only one row per plant
  distinct(Tag, .keep_all = TRUE) %>%
  mutate(Prev = paste(Fl_stems, Fl_open, Fl_done, sep = ';')) %>%
  rename(Prev_note = Note) %>%
  mutate(Date = NA, Fl_stems = NA, Fl_open = NA, Fl_done = NA, Q = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Prev, Prev_note) %>%
  write.csv(file = 'data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_29-07-21.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_29-07-21.csv') %>%
  mutate(Date = NA, Page = NA, Note = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Page, Note) %>%
  distinct(Tag, .keep_all = TRUE) %>% ## comment out in successive versions
  write.csv('data/raw_data/data_2021/campa_entry_29-07-21.csv', row.names = FALSE, na = '')

### August 2 2021

plots.0729 = read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  rbind(read.csv('data/raw_data/data_2021/campa_entry_29-07-21.csv')) %>%
  filter(Date %in% '7/29/21') %>%
  group_by(Plot) %>%
  summarise(nfl = sum(Fl_open))

set.seed(90208223)

sample(plots.0729$Plot, 15)
#  [1] 10 57 66 17  6 74 58 73 45 37 79 70  3  7 38

read.csv('data/raw_data/data_2021/Campanula_newplants_2021.csv') %>%
  rbind(read.csv('data/raw_data/data_2021/campa_entry_19-07-21.csv'),
        read.csv('data/raw_data/data_2021/campa_entry_22-07-21.csv'),
        read.csv('data/raw_data/data_2021/campa_entry_26-07-21.csv'),
        read.csv('data/raw_data/data_2021/campa_entry_29-07-21.csv')) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  # Get rid of gone or collected plants
  group_by(Tag) %>%
  filter(!grepl('[Cc]ollected|[Gg]one|[Ii]ggy', Note)) %>%
  # (at some point - next time - will want to remove plants with more than 3 consecutive
  # empty records)
  mutate(Date = as.Date(Date, format = '%m/%d/%y')) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('pv|bud', Note[1]) | grepl('pv|bud', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  ungroup() %>%
  # Get only one row per plant
  distinct(Tag, .keep_all = TRUE) %>%
  filter(is.na(done) | !(done %in% 'done')) %>%
  mutate(Prev = paste(Fl_stems, Fl_open, Fl_done, sep = ';')) %>%
  rename(Prev_note = Note) %>%
  mutate(Date = NA, Fl_stems = NA, Fl_open = NA, Fl_done = NA, Q = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Q, Prev, Prev_note) %>%
  write.csv(file = 'data/datasheet_generation/datasheet_outputs/data_datasheets_2021/campa_02-08-21.csv',
            na = '', row.names = FALSE)
