library(dplyr)
library(tidyr)

### 12 Jun 2022

# Create datasheet for 13 Jun 2022

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Tag, .keep_all = TRUE) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q) %>%
  select(Plot, Tag, Q, Fl_open, Fl_done, N_infl,
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-13-2022.csv',
            na = '', row.names = FALSE)

### Jun 15 2022

# Create data entry for 13 Jun 2022

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-13-2022.csv') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_06-13-2022.csv', na = '', row.names = FALSE)

# Create data sheet for 16 Jun 2022

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv')
  ) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Tag, .keep_all = TRUE) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-16-2022.csv',
            na = '', row.names = FALSE)
  
### Jun 19 2022

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-16-2022.csv') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_06-16-2022.csv', na = '', row.names = FALSE)

# Datasheet for Jun 20

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv')
  ) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  ungroup() %>%
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Tag, .keep_all = TRUE) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-20-2022.csv',
            na = '', row.names = FALSE)

# Designate plants for pollen addition

set.seed(17020078)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-20-2022.csv') %>%
  select(Plot, Tag) %>%
  sample_n(32) %>%
  mutate(i = 1:32) %>%
  mutate(Treatment = ifelse(i %% 2, 'Addition', 'Control'),
         Extra     = ifelse(i < 25, '', 'Extra')) %>%
  select(-i) %>%
  arrange(Plot, Tag, Extra) %>%
  mutate(Treated = NA, Flowers_treated = NA, Flowers = NA, Note = NA) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/pollen_add_06-20-2022.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-20-2022.csv') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_06-20-2022.csv', na = '', row.names = FALSE)

### Jun 23 2022

# Make data entry datasheet
read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv')
  ) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  ungroup() %>%
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Tag, .keep_all = TRUE) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-23-2022.csv',
            na = '', row.names = FALSE)

# Make data entry
read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-23-2022.csv') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_06-23-2022.csv', na = '', row.names = FALSE)

### Jun 27

### Jun 23 2022

# Make data entry datasheet
read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-23-2022.csv')
  ) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('yv', Notes[1]) | grepl('yv', Notes[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  ungroup() %>%
  distinct(Tag, .keep_all = TRUE) %>%
  # Done tag...
  arrange(Plot, !is.na(done), Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('6/18/22', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, Done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-27-2022.csv',
            na = '', row.names = FALSE)

set.seed(2043119)

# for pollen addition
read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-27-2022.csv') %>%
  select(Plot, Tag) %>%
  sample_n(30) %>%
  mutate(i = 1:30) %>%
  mutate(Treatment = ifelse(i %% 2, 'Addition', 'Control'),
         Extra     = ifelse(i < 25, '', paste0('Extra', i - 24))) %>%
  select(-i) %>%
  arrange(Plot, Tag, Extra) %>%
  mutate(Treated = NA, Flowers_treated = NA, Flowers = NA, Note = NA) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/pollen_add_06-27-2022.csv',
            na = '', row.names = FALSE)

# data entry
read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-27-2022.csv') %>%
  filter(Done %in% '') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_06-27-2022.csv', na = '', row.names = FALSE)

### Jun 29 2022

# Make data entry datasheet
read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-23-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-27-2022.csv')
  ) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('yv', Notes[1]) | grepl('yv', Notes[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  filter(!any(grepl('collected', Notes))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Done tag...
  arrange(Plot, !is.na(done), Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('6/20/22', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, Done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-30-2022.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_06-30-2022.csv') %>%
  filter(Done %in% '') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_06-30-2022.csv', na = '', row.names = FALSE)

### Jun 30 - prep for Jul 4

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-23-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-27-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-30-2022.csv')
  ) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('yv', Notes[1]) | grepl('yv', Notes[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  filter(!any(grepl('[Cc]ollected', Notes))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Done tag...
  arrange(Plot, !is.na(done), Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('6/23/22', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, Done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-04-2022.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-04-2022.csv') %>%
  filter(Done %in% '') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_07-04-2022.csv', na = '', row.names = FALSE)

rbind(
  read.csv('data/raw_data/data_2022/therm_entry_07-04-2022.csv'),
  read.csv('data/raw_data/data_2022/thermopsis_newplants_2022.csv')
) %>%
  filter(Date %in% max(Date)) %>%
  filter(!is.na(Fl_open) & (Fl_open > 0 | grepl('yv', Notes))) %>%
  select(Plot, Tag) %>%
  sample_n(30) %>%
  mutate(i = 1:30) %>%
  mutate(Treatment = ifelse(i %% 2, 'Addition', 'Control'),
         Extra     = ifelse(i < 21, '', paste0('Extra', i - 20))) %>%
  select(-i) %>%
  arrange(Plot, Tag, Extra) %>%
  mutate(Treated = NA, Flowers_treated = NA, Flowers = NA, Note = NA) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/pollen_add_07-05-2022.csv',
            na = '', row.names = FALSE)
  
  
### July 7 Data

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-23-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-27-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-30-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-04-2022.csv')
  ) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('yv', Notes[1]) | grepl('yv', Notes[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  filter(!any(grepl('[Cc]ollected', Notes))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Done tag...
  arrange(Plot, !is.na(done), Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('6/27/22', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, Done, 
         Last_date, Old_info, Old_q, Old_notes)  %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-07-2022.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-07-2022.csv') %>%
  filter(Done %in% '') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_07-07-2022.csv', na = '', row.names = FALSE)

### Jul 11 2022

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-23-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-27-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-30-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-04-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-07-2022.csv')
  ) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('yv', Notes[1]) | grepl('yv', Notes[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  filter(!any(grepl('[Cc]ollected', Notes))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Done tag...
  arrange(Plot, !is.na(done), Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('6/30/22', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, Done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-11-2022.csv',
            na = '', row.names = FALSE)

set.seed(1502128)

rbind(
  read.csv('data/raw_data/data_2022/therm_entry_07-07-2022.csv'),
  read.csv('data/raw_data/data_2022/thermopsis_newplants_2022.csv')
) %>%
  filter(Date %in% max(Date)) %>%
  filter(!is.na(Fl_open) & (Fl_open > 0 | grepl('yv', Notes))) %>%
  select(Plot, Tag) %>%
  sample_n(30) %>%
  mutate(i = 1:30) %>%
  mutate(Treatment = ifelse(i %% 2, 'Addition', 'Control'),
         Extra     = ifelse(i < 21, '', paste0('Extra', i - 20))) %>%
  select(-i) %>%
  arrange(Plot, Tag, Extra) %>%
  mutate(Treated = NA, Flowers_treated = NA, Flowers = NA, Note = NA) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/pollen_add_07-11-2022.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-11-2022.csv') %>%
  filter(Done %in% '') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_07-11-2022.csv', na = '', row.names = FALSE)

### Jul 14 2022

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-23-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-27-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-30-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-04-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-07-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-11-2022.csv')
  ) %>%
  mutate(Date = as.Date(Date, format = '%m/%d/%y')) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('yv', Notes[1]) | grepl('yv', Notes[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  filter(!any(grepl('[Cc]ollected', Notes))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Done tag...
  arrange(Plot, !is.na(done), Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('7/4/22', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, Done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-14-2022.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-14-2022.csv') %>%
  filter(Done %in% '') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_07-14-2022.csv', na = '', row.names = FALSE)

# Pollen re-painting datasheet
read.csv('data/raw_data/data_2022/pollen_addition_data_2022.csv') %>%
  arrange(Plot, Date, Treatment) %>%
  select(Plot, Tag, Date, Treatment, Color, Flowers_treated) %>%
  mutate(Fruit_painted = NA, Repaint_date = NA, Fruit_unpainted = NA, Notes = NA) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/fruit_painting_07-14-2022.csv',
            na = '', row.names = FALSE)

### Jul 18

read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
  rbind(
    read.csv('data/raw_data/data_2022/therm_entry_06-13-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-16-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-20-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-23-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-27-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_06-30-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-04-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-07-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-11-2022.csv'),
    read.csv('data/raw_data/data_2022/therm_entry_07-14-2022.csv')
  ) %>%
  mutate(Date = as.Date(Date, format = '%m/%d/%y')) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_open[1] & !Fl_open[2]) & 
           (Fl_done[1] <= Fl_done[2]) & 
           !(grepl('yv', Notes[1]) | grepl('yv', Notes[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Filter out plants with two can't find records
  group_by(Plot, Tag) %>%
  filter(sum(grepl("can\'t find", Notes)) < 2) %>%
  filter(!any(grepl('[Cc]ollected', Notes))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Done tag...
  arrange(Plot, !is.na(done), Tag) %>%
  # Get rid of done plants older than a week old
  filter(as.Date(Date, '%m/%d/%y') > as.Date('7/7/22', '%m/%d/%y')) %>%
  # Reformat columns for a datasheet
  # rename(old_stems = Fl_stems, old_open = Fl_open, Old_note = note) %>%
  mutate(Old_info = paste(N_infl, Fl_open, Fl_done, sep = ';'),
         Fl_open = NA, Fl_done = NA, N_infl = NA, q = NA) %>%
  rename(Old_notes = Notes, Last_date = Date, Old_q = Q, Q = q, Done = done) %>%
  select(Plot, Tag, Q, N_infl, Fl_open, Fl_done, Done, 
         Last_date, Old_info, Old_q, Old_notes) %>%
  # Export CSV
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-18-2022.csv',
            na = '', row.names = FALSE)


read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/therm_07-18-2022.csv') %>%
  filter(Done %in% '') %>%
  mutate(Date = NA, Notes = NA, Page = NA) %>%
  select(Date, Plot, Tag, N_infl, Fl_open, Fl_done, Q, Page, Notes) %>%
  write.csv(file = 'data/raw_data/data_2022/therm_entry_07-18-2022.csv', na = '', row.names = FALSE)


## Plants to bag

set.seed(1692903)

merge(
  x = read.csv('data/raw_data/data_2022/Thermopsis_newplants_2022.csv') %>%
    distinct(Plot, Tag),
  y = read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2022/fruit_painting_07-14-2022.csv') %>%
    distinct(Plot, Tag) %>%
    mutate(Manip = TRUE),
  all.x = TRUE, all.y = TRUE
) %>%
  filter(is.na(Manip)) %>%
  sample_n(size = 35, replace = FALSE) %>%
  select(-Manip) %>%
  arrange(Plot, Tag)

### Aug 18
