# Script for getting fruits to harvest

library(ggplot2)
library(dplyr)
library(tidyr)

### July 15 2021

set.seed(07152021)

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
  # Get done plants
  filter(done %in% 'done') %>%
  # Get plants that have been finished for 10 or more days
  filter(as.Date(Date, '%m/%d/%y') <= as.Date('7/5/21', '%m/%d/%y')) %>%
  # Arrange by last date of observation
  # randomly shuffle order of plants within date of finishing
  group_by(Plot, Date) %>%
  sample_n(size = n()) %>%
  # Create harvest date and harvest note columns and rename old columns
  rename(Last_Date = Date, Last_Note = Note) %>%
  mutate(Harvest_Date = NA, Harvest_Note = NA,
         Fruit_Pres = NA, Fruit_Coll = NA) %>%
  # Add old flowering info
  mutate(Last_Info = paste0(Fl_Stems, ':', Fl_Done)) %>%
  select(Harvest_Date, Plot, Fruit_Pres, Fruit_Coll, Last_Date, Tag, Last_Info, Last_Note, Harvest_Note) %>%
  # Write file
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_15-07-21.csv',
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_15-07-21.csv') %>%
  mutate(Return = NA, Page = NA) %>%
  select(Harvest_Date, Plot, Tag, Fruit_Pres, Fruit_Coll, Return, Page, Harvest_Note) %>%
  write.csv('data/raw_data/data_2021/therm_harvest_15-07-21.csv', na = '', row.names = FALSE)

### July 19 2021

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_08-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_12-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_15-07-2021.csv')) %>%
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
  # Get done plants
  filter(done %in% 'done') %>%
  # Get plants that have been finished for 10 or more days
  filter(as.Date(Date, '%m/%d/%y') <= as.Date('7/11/21', '%m/%d/%y'),
         as.Date(Date, '%m/%d/%y') >  as.Date('7/1/21', '%m/%d/%y')) %>%
  # Arrange by last date of observation
  # randomly shuffle order of plants within date of finishing
  group_by(Plot, Date) %>%
  sample_n(size = n()) %>%
  # Create harvest date and harvest note columns and rename old columns
  rename(Last_Date = Date, Last_Note = Note) %>%
  mutate(Harvest_Date = NA, Harvest_Note = NA,
         Fruit_Pres = NA, Fruit_Coll = NA) %>%
  # Add old flowering info
  mutate(Last_Info = paste0(Fl_Stems, ':', Fl_Done)) %>%
  select(Harvest_Date, Plot, Fruit_Pres, Fruit_Coll, Last_Date, Tag, Last_Info, Last_Note, Harvest_Note) %>%
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_15-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_19-07-21.csv', na = '', row.names = FALSE)

# sheet for entry
read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_19-07-21.csv') %>%
  mutate(Return = NA, Page = NA) %>%
  select(Harvest_Date, Plot, Tag, Fruit_Pres, Fruit_Coll, Return, Page, Harvest_Note) %>%
  write.csv('data/raw_data/data_2021/therm_harvest_19-07-21.csv', na = '', row.names = FALSE)

### July 26 2021

set.seed(212428)

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_08-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_12-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_15-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_19-07-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(as.Date(Date, format = '%m/%d/%y'))) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] <= Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Get rid of collected plants
  filter(!any(grepl('collected|grazed', Note))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Get done plants
  filter(done %in% 'done') %>%
  # Get plants that have been finished for 10 or more days
  filter(as.Date(Date, '%m/%d/%y') <= as.Date('7/18/21', '%m/%d/%y'),
         as.Date(Date, '%m/%d/%y') >  as.Date('7/5/21', '%m/%d/%y')) %>%
  # Arrange by last date of observation
  # randomly shuffle order of plants within date of finishing
  group_by(Plot, Date) %>%
  sample_n(size = n()) %>%
  # Create harvest date and harvest note columns and rename old columns
  rename(Last_Date = Date, Last_Note = Note) %>%
  mutate(Harvest_Date = NA, Harvest_Note = NA,
         Fruit_Pres = NA, Fruit_Coll = NA) %>%
  # Add old flowering info
  mutate(Last_Info = paste0(Fl_Stems, ':', Fl_Done)) %>%
  select(Harvest_Date, Plot, Fruit_Pres, Fruit_Coll, Last_Date, Tag, Last_Info, Last_Note, Harvest_Note) %>%
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_15-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # For plots with more than 9 plants, select 8 plants
  group_by(Plot) %>%
  sample_n(size = ifelse(n() > 8, 8, n())) %>%
  ungroup() %>%
  # Export csv
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_26-07-21.csv', 
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_26-07-21.csv') %>%
  mutate(Return = NA, Page = NA) %>%
  select(Harvest_Date, Plot, Tag, Fruit_Pres, Fruit_Coll, Return, Page, Harvest_Note) %>%
  write.csv('data/raw_data/data_2021/therm_harvest_26-07-21.csv', na = '', row.names = FALSE)

### Jul 29

### July 26 2021

set.seed(11291113)

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_08-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_12-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_15-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_19-07-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(as.Date(Date, format = '%m/%d/%y'))) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] <= Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Get rid of collected plants
  filter(!any(grepl('collected|grazed', Note))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Get done plants
  filter(done %in% 'done') %>%
  # Get plants that have been finished for 10 or more days
  filter(as.Date(Date, '%m/%d/%y') <= as.Date('7/21/21', '%m/%d/%y'),
         as.Date(Date, '%m/%d/%y') >  as.Date('7/8/21', '%m/%d/%y')) %>%
  # Create harvest date and harvest note columns and rename old columns
  rename(Last_Date = Date, Last_Note = Note) %>%
  mutate(Harvest_Date = NA, Harvest_Note = NA,
         Fruit_Pres = NA, Fruit_Coll = NA) %>%
  # Add old flowering info
  mutate(Last_Info = paste0(Fl_Stems, ':', Fl_Done)) %>%
  select(Harvest_Date, Plot, Fruit_Pres, Fruit_Coll, Last_Date, Tag, Last_Info, Last_Note, Harvest_Note) %>%
  # Remove already harvested plants from July 15
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_15-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # Remove already harvested plants from July 19
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_19-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # Remove already harvested plants from July 20
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_26-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # Export csv
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_29-07-21.csv', 
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_29-07-21.csv') %>%
  mutate(Return = NA, Page = NA) %>%
  select(Harvest_Date, Plot, Tag, Fruit_Pres, Fruit_Coll, Return, Page, Harvest_Note) %>%
  write.csv('data/raw_data/data_2021/therm_harvest_29-07-21.csv', na = '', row.names = FALSE)

### August 5 2021

set.seed(11291113)

read.csv('data/raw_data/data_2021/Thermopsis_newplants_2021.csv') %>%
  rename(Fl_Done = Fl_done, Fl_Open = Fl_open, Fl_Stems = Fl_stems) %>%
  rbind(read.csv('data/raw_data/data_2021/therm_entry_21-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_24-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_28-06-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_01-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_05-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_08-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_12-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_15-07-2021.csv'),
        read.csv('data/raw_data/data_2021/therm_entry_19-07-2021.csv')) %>%
  # Get rid of plants without tags (none were flowering as of last visit)
  filter(!is.na(Tag)) %>%
  # Pick out plants not finished yet
  #   finished = no open flowers in two most recent records, number of done flowers same
  #   and no yv in notes
  #   (requires sorting rows by date)
  arrange(Plot, Tag, desc(as.Date(Date, format = '%m/%d/%y'))) %>%
  group_by(Plot, Tag) %>%
  # Mark finished plants
  mutate(done = (!Fl_Open[1] & !Fl_Open[2]) & 
           (Fl_Done[1] <= Fl_Done[2]) & 
           !(grepl('yv', Note[1]) | grepl('yv', Note[2])),
         done = ifelse(is.na(done), FALSE, done),
         done = ifelse(done, 'done', NA)) %>%
  # Get rid of collected plants
  filter(!any(grepl('collected|grazed', Note))) %>%
  ungroup() %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  # Get done plants
  filter(done %in% 'done') %>%
  # Get plants that have been finished for 10 or more days
  # Create harvest date and harvest note columns and rename old columns
  rename(Last_Date = Date, Last_Note = Note) %>%
  mutate(Harvest_Date = NA, Harvest_Note = NA,
         Fruit_Pres = NA, Fruit_Coll = NA) %>%
  # Add old flowering info
  mutate(Last_Info = paste0(Fl_Stems, ':', Fl_Done)) %>%
  select(Harvest_Date, Plot, Fruit_Pres, Fruit_Coll, Last_Date, Tag, Last_Info, Last_Note, Harvest_Note) %>%
  # Remove already harvested plants from July 15
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_15-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # Remove already harvested plants from July 19
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_19-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # Remove already harvested plants from July 26
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_26-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # Remove already harvested plants from July 29
  merge(y = read.csv('data/raw_data/data_2021/therm_harvest_29-07-21.csv') %>%
          select(Tag, Return),
        all.x = TRUE) %>%
  filter(Return | is.na(Return)) %>%
  arrange(Plot) %>%
  select(-Return) %>%
  # Export csv
  write.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_05-08-21.csv', 
            na = '', row.names = FALSE)

read.csv('data/datasheet_generation/datasheet_outputs/data_datasheets_2021/therm_harvest_05-08-21.csv') %>%
  mutate(Return = NA, Page = NA) %>%
  select(Harvest_Date, Plot, Tag, Fruit_Pres, Fruit_Coll, Return, Page, Harvest_Note) %>%
  write.csv('data/raw_data/data_2021/therm_harvest_05-08-21.csv', na = '', row.names = FALSE)

### done!
