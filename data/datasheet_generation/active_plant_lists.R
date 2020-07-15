library(dplyr)
library(tidyr)

alld = read.csv('data/data_active.csv')

# June 21 Plants to visit
alld %>%
  filter(Infl_spread > 0 | Infl_done > 0 | grepl('yv', Note)) %>%
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species, Racemes, X)) %>%
  mutate(Date = gsub('\\d{4}\\-', '', Date),
         Twist.ties = ifelse(Twist.ties %in% 'NULL', '', as.character(Twist.ties)),
         Q = ifelse(Q %in% 'NULL', '', as.character(Q)),
         Note = gsub('\\s', '', Note)) %>%
  rename(Pl = Plot,
         Spr = Infl_spread,
         Dne = Infl_done,
         Old_Note = Note,
         Tt = Twist.ties) %>%
  mutate(Spread = NA,
         Done = NA,
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-06-21.csv',
            row.names = FALSE, na = '')

# Make data entry form for June 21:
read.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-06-21.csv') %>%
  select(Date, Pl, Tag) %>%
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Racemes = NA,
         Infl_spread = NA,
         Infl_done = NA,
         Twist.ties = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_active.csv') %>% select(-X))) %>%
  write.csv('data/data_entry_06-21-2020.csv', na = '', row.names = FALSE)

##### June 24

# Bind together active data and june 21 entries
read.csv('data/data_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv')) %>%
  # Give only plants with non-zero columns and/or yellow visible in notes
  filter(Infl_spread > 0 | Infl_done > 0 | grepl('yv', Note) | grepl("can't find", Note)) %>%
  # Format date
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Get rid of plants which end with two days of no spread flowers
  group_by(Plot, Tag) %>% arrange(Plot, Tag, Date) %>% 
  filter(!(Infl_spread[1] & !Infl_spread[2])) %>% ungroup() %>%
  # Remove duplicates
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species, Racemes)) %>%
  # Add and reformat cols for data recording
  mutate(Date = gsub('\\d{4}\\-', '', Date),
         Twist.ties = ifelse(Twist.ties %in% 'NULL', '', as.character(Twist.ties)),
         Q = ifelse(Q %in% 'NULL', '', as.character(Q)),
         Note = gsub('\\s', '', Note)) %>%
  rename(Pl = Plot,
         Spr = Infl_spread,
         Dne = Infl_done,
         Old_Note = Note,
         Tt = Twist.ties) %>%
  mutate(Spread = NA,
         Done = NA,
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-06-24.csv',
            row.names = FALSE, na = '')

# Prepare a csv for data entry
read.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-06-24.csv') %>%
  select(Date, Pl, Tag) %>%
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Racemes = NA,
         Infl_spread = NA,
         Infl_done = NA,
         Twist.ties = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_active.csv') %>% select(-X))) %>%
  write.csv('data/data_entry_06-24-2020.csv', na = '', row.names = FALSE)

### June 27 plant lists

read.csv('data/data_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv'),
        read.csv('data/data_entry_06-24-2020.csv')) %>%
  # Give only plants with non-zero columns and/or yellow visible in notes
  filter(Infl_spread > 0 | Infl_done > 0 | grepl('yv', Note) | grepl("can't find", Note)) %>%
  # Format date
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Get rid of plants which end with two days of no spread flowers
  group_by(Plot, Tag) %>% arrange(Plot, Tag, Date) %>% 
  filter(!(Infl_spread[1] & !Infl_spread[2])) %>% ungroup() %>%
  # Remove duplicates
  arrange(Plot, Tag, desc(Date)) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species, Racemes)) %>%
  # Add and reformat cols for data recording
  mutate(Date = gsub('\\d{4}\\-', '', Date),
         Twist.ties = ifelse(Twist.ties %in% 'NULL', '', as.character(Twist.ties)),
         Q = ifelse(Q %in% 'NULL', '', as.character(Q)),
         Note = gsub('\\s', '', Note)) %>%
  rename(Pl = Plot,
         Spr = Infl_spread,
         Dne = Infl_done,
         Old_Note = Note,
         Tt = Twist.ties) %>%
  mutate(Spread = NA,
         Done = NA,
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-06-27.csv',
            row.names = FALSE, na = '')

# Prepare a csv for data entry
read.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-06-27.csv') %>%
  select(Date, Pl, Tag) %>%
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Racemes = NA,
         Infl_spread = NA,
         Infl_done = NA,
         Twist.ties = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_active.csv') %>% select(-X))) %>%
  write.csv('data/data_entry_06-27-2020.csv', na = '', row.names = FALSE)

### July 1

### June 27 plant lists

read.csv('data/data_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv'),
        read.csv('data/data_entry_06-24-2020.csv'),
        read.csv('data/data_entry_06-27-2020.csv')) %>%
  # Give only plants with non-zero columns and/or yellow visible in notes
  filter(Infl_spread > 0 | Infl_done > 0 | grepl('yv', Note) | grepl("can't find", Note)) %>%
  # Format date
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Flag plants where last two records have no infloresences spreading
  group_by(Plot, Tag) %>% arrange(Plot, Tag, desc(Date)) %>% 
  mutate(done = (!Infl_spread[1] & !Infl_spread[2])) %>% ungroup() %>%
  # Take care of NAs (occur if there is only one record)
  mutate(done = ifelse(is.na(done), FALSE, done)) %>%
  # Remove plants not seen since (arbitrarily chosen) June 14
  filter(Date > as.Date('06-14', format = '%m-%d')) %>%
  # Remove duplicates
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species, Racemes)) %>%
  # Handle yv records here
  # (because there is only one record per plant, if it is YV and done,
  # that is a mistake)
  mutate(done = ifelse(done & grepl('yv', Note), FALSE, done)) %>%
  # Add and reformat cols for data recording
  mutate(Date = gsub('\\d{4}\\-', '', Date),
         Twist.ties = ifelse(Twist.ties %in% 'NULL', '', as.character(Twist.ties)),
         Q = ifelse(Q %in% 'NULL', '', as.character(Q)),
         Note = gsub('\\s', '', Note)) %>%
  rename(Pl = Plot,
         Spr = Infl_spread,
         Dne = Infl_done,
         Old_Note = Note,
         Tt = Twist.ties) %>%
  mutate(Spread = ifelse(done & !is.na(done), -9, NA),
         Done = ifelse(done & !is.na(done), -9, NA),
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  arrange(Pl, Spread, !is.na(Done)) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-07-01.csv',
            row.names = FALSE, na = '')

# Make a csv for data entry for july 1 data
read.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-07-01.csv') %>%
  # Rid us of ye done plants!!
  filter(!Spread %in% -9) %>%
  # Get the columns with relevant information
  select(Date, Pl, Tag) %>%
  # Generate empty rows for entry
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Racemes = NA,
         Infl_spread = NA,
         Infl_done = NA,
         Twist.ties = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_active.csv') %>% select(-X))) %>%
  write.csv('data/data_entry_07-01-2020.csv', na = '', row.names = FALSE)

### July 5 data sheet

read.csv('data/data_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv'),
        read.csv('data/data_entry_06-24-2020.csv'),
        read.csv('data/data_entry_06-27-2020.csv'),
        read.csv('data/data_entry_07-01-2020.csv')) %>%
  # Give only plants with non-zero columns and/or yellow visible in notes
  filter(Infl_spread > 0 | Infl_done > 0 | grepl('yv', Note) | grepl("can't find", Note)) %>%
  # Format date
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Flag plants where last two records have no infloresences spreading
  group_by(Plot, Tag) %>% arrange(Plot, Tag, desc(Date)) %>% 
  mutate(done = (!Infl_spread[1] & !Infl_spread[2])) %>% ungroup() %>%
  # Take care of NAs (occur if there is only one record)
  mutate(done = ifelse(is.na(done), FALSE, done)) %>%
  # Remove plants not seen since (arbitrarily chosen) June 14
  filter(Date > as.Date('06-24', format = '%m-%d')) %>%
  # Remove duplicates
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species, Racemes)) %>%
  # Handle yv records here
  # (because there is only one record per plant, if it is YV and done,
  # that is a mistake)
  mutate(done = ifelse(done & grepl('yv', Note), FALSE, done)) %>%
  # Add and reformat cols for data recording
  mutate(Date = gsub('\\d{4}\\-', '', Date),
         Twist.ties = ifelse(Twist.ties %in% 'NULL', '', as.character(Twist.ties)),
         Q = ifelse(Q %in% 'NULL', '', as.character(Q)),
         Note = gsub('\\s', '', Note)) %>%
  rename(Pl = Plot,
         Spr = Infl_spread,
         Dne = Infl_done,
         Old_Note = Note,
         Tt = Twist.ties) %>%
  mutate(Spread = ifelse(done & !is.na(done), -9, NA),
         Done = ifelse(done & !is.na(done), -9, NA),
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  arrange(Pl, Spread, !is.na(Done)) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-07-05.csv',
            row.names = FALSE, na = '')

# Make data entry form

read.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-07-05.csv') %>%
  # Rid us of ye done plants!!
  filter(!Spread %in% -9) %>%
  # Get the columns with relevant information
  select(Date, Pl, Tag) %>%
  # Generate empty rows for entry
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Racemes = NA,
         Infl_spread = NA,
         Infl_done = NA,
         Twist.ties = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_active.csv') %>% select(-X))) %>%
  write.csv('data/data_entry_07-05-2020.csv', na = '', row.names = FALSE)

### July 9

read.csv('data/data_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv'),
        read.csv('data/data_entry_06-24-2020.csv'),
        read.csv('data/data_entry_06-27-2020.csv'),
        read.csv('data/data_entry_07-01-2020.csv'),
        read.csv('data/data_entry_07-05-2020.csv')) %>%
  # Give only plants with non-zero columns and/or yellow visible in notes
  filter(Infl_spread > 0 | Infl_done > 0 | grepl('yv', Note) | grepl("can't find", Note)) %>%
  # Get only Thermopsis (for this data sheet)
  filter(Species %in% 'Thermopsis divaricarpa') %>%
  # Format date
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Flag plants where last two records have no infloresences spreading
  group_by(Plot, Tag) %>% arrange(Plot, Tag, desc(Date)) %>% 
  mutate(done = (!Infl_spread[1] & !Infl_spread[2])) %>% ungroup() %>%
  # Take care of NAs (occur if there is only one record)
  mutate(done = ifelse(is.na(done), FALSE, done)) %>%
  # Remove plants not seen since (arbitrarily chosen) June 14
  filter(Date > as.Date('06-27', format = '%m-%d')) %>%
  # Remove duplicates
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species, Racemes)) %>%
  # Handle yv records here
  # (because there is only one record per plant, if it is YV and done,
  # that is a mistake)
  mutate(done = ifelse(done & grepl('yv', Note), FALSE, done)) %>%
  # Add and reformat cols for data recording
  mutate(Date = gsub('\\d{4}\\-', '', Date),
         Twist.ties = ifelse(Twist.ties %in% 'NULL', '', as.character(Twist.ties)),
         Q = ifelse(Q %in% 'NULL', '', as.character(Q)),
         Note = gsub('\\s', '', Note)) %>%
  rename(Pl = Plot,
         Spr = Infl_spread,
         Dne = Infl_done,
         Old_Note = Note,
         Tt = Twist.ties) %>%
  mutate(Spread = ifelse(done & !is.na(done), -9, NA),
         Done = ifelse(done & !is.na(done), -9, NA),
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  arrange(Pl, Spread, !is.na(Done)) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-07-09.csv',
            row.names = FALSE, na = '')

# Thermopsis data entry

read.csv('data/datasheet_generation/datasheet_outputs/active_plas_2020-07-09.csv') %>%
  # Rid us of ye done plants!!
  filter(!Spread %in% -9) %>%
  # Get the columns with relevant information
  select(Date, Pl, Tag) %>%
  # Generate empty rows for entry
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Racemes = NA,
         Infl_spread = NA,
         Infl_done = NA,
         Twist.ties = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_active.csv') %>% select(-X))) %>%
  write.csv('data/data_entry_07-09-2020.csv', na = '', row.names = FALSE)

### July 9

# Theremopsis data generation

read.csv('data/data_thermopsis_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv'),
        read.csv('data/data_entry_06-24-2020.csv'),
        read.csv('data/data_entry_06-27-2020.csv'),
        read.csv('data/data_entry_07-01-2020.csv'),
        read.csv('data/data_entry_07-05-2020.csv'),
        read.csv('data/data_entry_07-09-2020.csv')) %>%
  # Give only plants with non-zero columns and/or yellow visible in notes
  filter(Infl_spread > 0 | Infl_done > 0 | grepl('yv', Note) | grepl("can't find", Note)) %>%
  # Get only Thermopsis (for this data sheet)
  filter(Species %in% 'Thermopsis divaricarpa') %>%
  # Format date
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Flag plants where last two records have no infloresences spreading
  group_by(Plot, Tag) %>% arrange(Plot, Tag, desc(Date)) %>% 
  mutate(done = (!Infl_spread[1] & !Infl_spread[2])) %>% ungroup() %>%
  # Take care of NAs (occur if there is only one record)
  mutate(done = ifelse(is.na(done), FALSE, done)) %>%
  # Remove plants not seen since (arbitrarily chosen) June 14
  filter(Date > as.Date('07-01', format = '%m-%d')) %>%
  # Remove duplicates
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species, Racemes)) %>%
  # Handle yv records here
  # (because there is only one record per plant, if it is YV and done,
  # that is a mistake)
  mutate(done = ifelse(done & grepl('yv', Note), FALSE, done)) %>%
  # Add and reformat cols for data recording
  mutate(Date = gsub('\\d{4}\\-', '', Date),
         Twist.ties = ifelse(Twist.ties %in% 'NULL', '', as.character(Twist.ties)),
         Q = ifelse(Q %in% 'NULL', '', as.character(Q)),
         Note = gsub('\\s', '', Note)) %>%
  rename(Pl = Plot,
         Spr = Infl_spread,
         Dne = Infl_done,
         Old_Note = Note,
         Tt = Twist.ties) %>%
  mutate(Spread = ifelse(done & !is.na(done), -9, NA),
         Done = ifelse(done & !is.na(done), -9, NA),
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  arrange(Pl, Spread, !is.na(Done)) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_thermposis_2020-07-13.csv',
            row.names = FALSE, na = '')

# A new campanula datasheet
read.csv('data/data_campanula_active.csv') %>%
  arrange(desc(Date), Plot, Tag) %>%
  distinct(Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species)) %>%
  rename(Pl = Plot,
         Str = Fl_straight,
         Crl = Fl_curled,
         Dne = Fl_done,
         Old_note = Note) %>%
  mutate(Straight = NA,
         Curled = NA,
         Done = NA,
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Stms, Str, Crl, Dne, Straight, Curled, Done, Note, Old_note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-13.csv',
            row.names = FALSE, na = '')

# Data entry for July 13 Thermopsis

read.csv('data/datasheet_generation/datasheet_outputs/active_thermposis_2020-07-13.csv') %>%
  # Rid us of ye done plants!!
  filter(!Spread %in% -9) %>%
  # Get the columns with relevant information
  select(Date, Pl, Tag) %>%
  # Generate empty rows for entry
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Racemes = NA,
         Infl_spread = NA,
         Infl_done = NA,
         Twist.ties = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_thermopsis_active.csv') %>% select(-X))) %>%
  write.csv('data/data_entry_thermopsis_07-13-2020.csv', na = '', row.names = FALSE)

# Data entry for July 13 Campanula  
read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-13.csv') %>%
  # Get the columns with relevant information
  select(Date, Pl, Tag) %>%
  # Generate empty rows for entry
  rename(Plot = Pl) %>%
  mutate(Page = NA,
         Date = NA,
         Species = NA,
         Stms = NA,
         Fl_straight = NA,
         Fl_curled = NA,
         Fl_done = NA,
         Q = NA,
         Note = NA) %>%
  select(names(read.csv('data/data_campanula_active.csv'))) %>%
  write.csv('data/data_entry_campanula_07-13-2020.csv', na = '', row.names = FALSE)
