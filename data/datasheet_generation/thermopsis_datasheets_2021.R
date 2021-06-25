library(dplyr)
library(tidyr)

### 21 Jun 2021

# Create datasheet for 21 Jun 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  # Get only one record per plant (requires getting TP where tags were missing)
  mutate(id = ifelse(!is.na(Tag), Tag, paste0(Plot, '-', Toothpick))) %>%
  arrange(Plot, id, desc(Date)) %>%
  distinct(id, .keep_all = TRUE) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(Fl_stems, Fl_open, Fl_done, sep = ';'),
         Fl_stems = NA, Fl_open = NA, Fl_done = NA, q = NA) %>%
  rename(Old_note = Note, Last_date = Date, Old_q = Q, Q = q) %>%
  select(Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done,
         Last_date, Old_info, Old_q, Old_note) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_21-06-2021.csv',
            na = '', row.names = FALSE)

# for data entry

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_21-06-2021.csv') %>%
  mutate(Date = NA, Note = NA) %>%
  select(Date, Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Note) %>%
  rename(Tp = Toothpick, Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_21-06-2021.csv', na = '', row.names = FALSE)

### 22 Jun 2021

plots.0621 = rbind(
  read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
  read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv')
) %>%
  filter(Date %in% '6/21/21') %>%
  filter(Fl_Open > 0) %>%
  distinct(Plot)

set.seed(7173)

sample(plots.0621$Plot, size = 12, replace = FALSE)
#  [1] 37 71  8  6 76 59 62 79 10 74 73 7

# Slight reorder:
# 37, 8, 6, 10, 7, 74, 71, 76, 73, 74, 62, 59

### 24 Jun 2021

# Get (flowering/budding) plants to check

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Get only most recent record for each plant
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(Fl_Stems, Fl_Open, Fl_Done, sep = ';'),
         Fl_stems = NA, Fl_open = NA, Fl_done = NA, q = NA) %>%
  rename(Old_note = Note, Last_date = Date, Old_q = Q, Q = q) %>%
  select(Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done,
         Last_date, Old_info, Old_q, Old_note) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_24-06-2021.csv',
            na = '', row.names = FALSE)

# Get toothpick list (may be helpful)

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv')) %>%
  group_by(Plot, Toothpick) %>%
  filter(all(is.na(Tag))) %>%
  filter(!any(grepl('collected', Note))) %>%
  distinct(Plot, Toothpick)

