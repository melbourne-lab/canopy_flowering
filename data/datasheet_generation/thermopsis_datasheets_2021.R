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

# Data entry for Jun 24

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_24-06-2021.csv') %>%
  mutate(Date = NA, Note = NA) %>%
  select(Date, Plot, Tag, Tp, Q, Fl_stems, Fl_open, Fl_done, Note) %>%
  rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_24-06-2021.csv', na = '', row.names = FALSE)

### Jun 28 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv')) %>%
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
  # Export
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_28-06-2021.csv',
            na = '', row.names = FALSE)

# Write data entry sheet

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_28-06-2021.csv') %>%
  mutate(Date = NA, Note = NA) %>%
  select(Date, Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Note) %>%
  rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_28-06-2021.csv', na = '', row.names = FALSE)

# Get plots for pollinator observations
plots.0628 = rbind(
  read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
  read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
    rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done)
) %>%
  filter(Date %in% '6/28/21') %>%
  filter(Fl_Open > 0) %>%
  distinct(Plot)

set.seed(9292)

sample(plots.0628$Plot, size = 15, replace = FALSE) # 13th is backup in case there's something wrong
#  [1] 62 36 38 71 57  9 60  5 37 21 79  6 24 70 76

### 1 Jul 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] == Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>% 
  arrange(Plot, done, Tag) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(Fl_Stems, Fl_Open, Fl_Done, sep = ';'),
         Fl_stems = NA, Fl_open = NA, Fl_done = NA, q = NA) %>%
  rename(Old_note = Note, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Done,
         Last_date, Old_info, Old_q, Old_note) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_01-07-2021.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_01-07-2021.csv') %>%
  filter(!grepl('done', Done)) %>%
  mutate(Date = NA, Note = NA) %>%
  select(Date, Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Note) %>%
  rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_01-07-2021.csv', na = '', row.names = FALSE)


### 5 Jul 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] == Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>% 
  arrange(Plot, done, Tag) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(Fl_Stems, Fl_Open, Fl_Done, sep = ';'),
         Fl_stems = NA, Fl_open = NA, Fl_done = NA, q = NA) %>%
  rename(Old_note = Note, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Done,
         Last_date, Old_info, Old_q, Old_note) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_05-07-2021.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_05-07-2021.csv') %>%
  filter(!grepl('done', Done)) %>%
  mutate(Date = NA, Note = NA, Page = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Toothpick, Q, Page, Note) %>%
  rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_05-07-2021.csv', na = '', row.names = FALSE)

# pollinator observations july 7
plots.0707 = rbind(
  read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv'),
  read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
    rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done)
) %>%
  filter(Date %in% '7/5/21') %>%
  filter(Fl_Open > 0) %>%
  distinct(Plot)

set.seed(5986)

sample(plots.0707$Plot, size = 15, replace = FALSE) 
# [1] 21 75 73 58 24  9 76 10 71 70 60 59 37 66  8

### Jul 8 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] <= Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Get rid of collected plants
  filter(!any(grepl('collected', Note))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>% 
  arrange(Plot, done, Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('6/28/21', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(Fl_Stems, Fl_Open, Fl_Done, sep = ';'),
         Fl_stems = NA, Fl_open = NA, Fl_done = NA, q = NA) %>%
  rename(Old_note = Note, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Done,
         Last_date, Old_info, Old_q, Old_note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_08-07-2021.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_08-07-2021.csv') %>%
  filter(!grepl('done', Done)) %>%
  mutate(Date = NA, Note = NA, Page = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Toothpick, Q, Page, Note) %>%
  rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_08-07-2021.csv', na = '', row.names = FALSE)


### Jul 12 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_08-07-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] <= Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Get rid of collected plants
  filter(!any(grepl('collected', Note))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>% 
  arrange(Plot, done, Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('7/1/21', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(Fl_Stems, Fl_Open, Fl_Done, sep = ';'),
         Fl_stems = NA, Fl_open = NA, Fl_done = NA, q = NA) %>%
  rename(Old_note = Note, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Done,
         Last_date, Old_info, Old_q, Old_note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_12-07-2021.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_12-07-2021.csv') %>%
  filter(!grepl('done', Done)) %>%
  mutate(Date = NA, Note = NA, Page = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Toothpick, Q, Page, Note) %>%
  rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_12-07-2021.csv', na = '', row.names = FALSE)

plots.0713 = rbind(
  read.csv('data/raw_data/data_2021/therm_entry_12-07-2021.csv'),
  read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
    rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done)
) %>%
  filter(Date %in% '7/12/21') %>%
  filter(Fl_Open > 0) %>%
  distinct(Plot)

set.seed(4929)

sample(plots.0713$Plot) 
sample(plots.0713$Plot) 

# [1] 70 73 57 60 74 25  9 74 57  9 70 60 25 73

### Jul 15 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_08-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_12-07-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Turn date column in to date object
  mutate(Date = as.Date(Date, format = '%m/%d/%y')) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] <= Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Get rid of collected plants
  filter(!any(grepl('collected', Note))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>% 
  arrange(Plot, done, Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('7/5/21', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(Fl_Stems, Fl_Open, Fl_Done, sep = ';'),
         Fl_stems = NA, Fl_open = NA, Fl_done = NA, q = NA) %>%
  rename(Old_note = Note, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Toothpick, Q, Fl_stems, Fl_open, Fl_done, Done,
         Last_date, Old_info, Old_q, Old_note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_15-07-2021.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_15-07-2021.csv') %>%
  filter(!grepl('done', Done)) %>%
  mutate(Date = NA, Note = NA, Page = NA) %>%
  select(Date, Plot, Tag, Fl_stems, Fl_open, Fl_done, Toothpick, Q, Page, Note) %>%
  rename(Fl_Stems = Fl_stems, Fl_Open = Fl_open, Fl_Done = Fl_done) %>%
  write.csv(file = 'data/raw_data/data_2021/therm_entry_15-07-2021.csv', na = '', row.names = FALSE)

