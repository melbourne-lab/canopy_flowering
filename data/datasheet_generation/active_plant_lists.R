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

### July 17 data

# Theremopsis data generation

read.csv('data/data_thermopsis_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv'),
        read.csv('data/data_entry_06-24-2020.csv'),
        read.csv('data/data_entry_06-27-2020.csv'),
        read.csv('data/data_entry_07-01-2020.csv'),
        read.csv('data/data_entry_07-05-2020.csv'),
        read.csv('data/data_entry_07-09-2020.csv'),
        read.csv('data/data_entry_thermopsis_07-13-2020.csv')) %>%
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
  filter(Date > as.Date('07-05', format = '%m-%d')) %>%
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
  write.csv('data/datasheet_generation/datasheet_outputs/active_thermposis_2020-07-17.csv',
            row.names = FALSE, na = '')

# A new campanula datasheet
read.csv('data/data_campanula_active.csv') %>%
  rbind(read.csv('data/data_entry_campanula_07-13-2020.csv')) %>% 
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
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
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-17.csv',
            row.names = FALSE, na = '')

# Data entry for july 17

read.csv('data/datasheet_generation/datasheet_outputs/active_thermposis_2020-07-17.csv') %>%
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
  write.csv('data/data_entry_thermopsis_07-17-2020.csv', na = '', row.names = FALSE)

# Data entry for July 13 Campanula  
read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-17.csv') %>%
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
  write.csv('data/data_entry_campanula_07-17-2020.csv', na = '', row.names = FALSE)

### July 21 data

# Thermopsis
read.csv('data/data_thermopsis_active.csv') %>%
  select(-X) %>%
  rbind(read.csv('data/data_entry_06-21-2020.csv'),
        read.csv('data/data_entry_06-24-2020.csv'),
        read.csv('data/data_entry_06-27-2020.csv'),
        read.csv('data/data_entry_07-01-2020.csv'),
        read.csv('data/data_entry_07-05-2020.csv'),
        read.csv('data/data_entry_07-09-2020.csv'),
        read.csv('data/data_entry_thermopsis_07-13-2020.csv'),
        read.csv('data/data_entry_thermopsis_07-17-2020.csv')) %>%
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
  filter(Date > as.Date('07-09', format = '%m-%d')) %>%
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
  # You know what? This time around, I'm not even going to print the done plants.
  filter(!Spread %in% -9) %>%
  # Select relevant columns
  select(Date, Pl, Tag, Q, Spr, Dne, Tt, Spread, Done, Note, Old_Note) %>%
  arrange(Pl, Spread, !is.na(Done)) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_thermposis_2020-07-21.csv',
            row.names = FALSE, na = '')

# A new campanula datasheet
read.csv('data/data_campanula_active.csv') %>%
  rbind(read.csv('data/data_entry_campanula_07-13-2020.csv'),
        read.csv('data/data_entry_campanula_07-17-2020.csv')) %>% 
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
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
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-21.csv',
            row.names = FALSE, na = '')

# Data entry

read.csv('data/datasheet_generation/datasheet_outputs/active_thermposis_2020-07-21.csv') %>%
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
  write.csv('data/data_entry_thermopsis_07-21-2020.csv', na = '', row.names = FALSE)

# Data entry for July 13 Campanula  
read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-21.csv') %>%
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
  write.csv('data/data_entry_campanula_07-21-2020.csv', na = '', row.names = FALSE)

### July 25

# Thermopsis is done. No thermopsis datasheets.

# Campanula
read.csv('data/data_campanula_active.csv') %>%
  rbind(read.csv('data/data_entry_campanula_07-13-2020.csv'),
        read.csv('data/data_entry_campanula_07-17-2020.csv'),
        read.csv('data/data_entry_campanula_07-21-2020.csv')) %>% 
  group_by(Plot, Tag) %>% filter(!any(grepl('iggy', Note))) %>% ungroup() %>%
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
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
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-25.csv',
            row.names = FALSE, na = '')

# Data entry

read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-07-25.csv') %>%
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
  write.csv('data/data_entry_campanula_07-28-2020.csv', na = '', row.names = FALSE)

### Materals for August 2

read.csv('data/data_campanula_active.csv') %>%
  rbind(read.csv('data/data_entry_campanula_07-13-2020.csv'),
        read.csv('data/data_entry_campanula_07-17-2020.csv'),
        read.csv('data/data_entry_campanula_07-21-2020.csv'),
        read.csv('data/data_entry_campanula_07-28-2020.csv')) %>% 
  group_by(Plot, Tag) %>% mutate(iggy = any(grepl('iggy', Note))) %>% ungroup() %>%
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  arrange(desc(Date), Plot, Tag) %>%
  distinct(Tag, .keep_all = TRUE) %>%
  select(-c(Page, Species)) %>%
  rename(Pl = Plot,
         Str = Fl_straight,
         Crl = Fl_curled,
         Dne = Fl_done,
         Old_note = Note) %>%
  mutate(Straight = ifelse(iggy, -9, NA),
         Curled = ifelse(iggy, -9, NA),
         Done = ifelse(iggy, -9, NA),
         Note = NA) %>%
  select(Date, Pl, Tag, Q, Stms, Str, Crl, Dne, Straight, Curled, Done, Note, Old_note) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-02.csv',
            row.names = FALSE, na = '')

# Make data entry sheet

read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-02.csv') %>%
  # Get rid of non-checked plants (i.e., give only rows which are blank)
  filter(is.na(Straight)) %>%
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
  write.csv('data/data_entry_campanula_08-02-2020.csv', na = '', row.names = FALSE)

### August 6 data generation

read.csv('data/data_campanula_active.csv') %>%
  rbind(read.csv('data/data_entry_campanula_07-13-2020.csv'),
        read.csv('data/data_entry_campanula_07-17-2020.csv'),
        read.csv('data/data_entry_campanula_07-21-2020.csv'),
        read.csv('data/data_entry_campanula_07-28-2020.csv'),
        read.csv('data/data_entry_campanula_08-02-2020.csv')) %>% 
  # Get rid of plants to ignore
  group_by(Plot, Tag) %>% filter(!any(grepl('iggy', Note))) %>% 
  # Get rid of plants with collected tags
  filter(!any(grepl('collected', Note))) %>%
  # Get rid of plants which have disappeared (and ungroup)
  filter(!any(grepl('^gone$', Note))) %>% ungroup() %>%
  # Add dates
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Now, try to figure out how to get rid of plants which haven't changed in four visits
  # Do this by sorting by date and picking out unique entries for demo data
  # then, filter out plants past a cutoff date
  # (this means if there is no change in demo data since this date, don't check it)
  arrange(Date, Plot, Tag) %>%
  distinct(Tag, Fl_straight, Fl_curled, Fl_done, .keep_all = TRUE) %>%
  filter(Date > as.Date('2020-07-17')) %>%
  # Now, get only the most recent record for each (remaining) plant
  arrange(Plot, Tag, desc(Date)) %>%
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
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-06.csv',
            row.names = FALSE, na = '')

# Make data sheet

read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-06.csv') %>%
  # Get rid of non-checked plants (i.e., give only rows which are blank)
  filter(is.na(Straight)) %>%
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
  write.csv('data/data_entry_campanula_08-06-2020.csv', na = '', row.names = FALSE)

### Make data sheet for August 10

read.csv('data/data_campanula_active.csv') %>%
  rbind(read.csv('data/data_entry_campanula_07-13-2020.csv'),
        read.csv('data/data_entry_campanula_07-17-2020.csv'),
        read.csv('data/data_entry_campanula_07-21-2020.csv'),
        read.csv('data/data_entry_campanula_07-28-2020.csv'),
        read.csv('data/data_entry_campanula_08-02-2020.csv'),
        read.csv('data/data_entry_campanula_08-06-2020.csv')) %>% 
  # Get rid of plants to ignore
  group_by(Plot, Tag) %>% filter(!any(grepl('iggy', Note))) %>% 
  # Get rid of plants with collected tags
  filter(!any(grepl('collected', Note))) %>%
  # Get rid of plants noted as "no plant"
  filter(!any(grepl('no\\splant', Note))) %>%
  # Get rid of plants which have disappeared (and ungroup)
  filter(!any(grepl('^gone$', Note))) %>% ungroup() %>%
  # Add dates
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Now, try to figure out how to get rid of plants which haven't changed in four visits
  # Do this by sorting by date and picking out unique entries for demo data
  # then, filter out plants past a cutoff date
  # (this means if there is no change in demo data since this date, don't check it)
  arrange(Date, Plot, Tag) %>%
  distinct(Tag, Fl_straight, Fl_curled, Fl_done, .keep_all = TRUE) %>%
  filter(Date > as.Date('2020-07-21')) %>%
  # Now, get only the most recent record for each (remaining) plant
  arrange(Plot, Tag, desc(Date)) %>%
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
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-10.csv',
            row.names = FALSE, na = '')

# Make data entry form

read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-10.csv') %>%
  # Get rid of non-checked plants (i.e., give only rows which are blank)
  filter(is.na(Straight)) %>%
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
  write.csv('data/data_entry_campanula_08-10-2020.csv', na = '', row.names = FALSE)

### August 14 data

read.csv('data/data_campanula_active.csv') %>%
  rbind(read.csv('data/data_entry_campanula_07-13-2020.csv'),
        read.csv('data/data_entry_campanula_07-17-2020.csv'),
        read.csv('data/data_entry_campanula_07-21-2020.csv'),
        read.csv('data/data_entry_campanula_07-28-2020.csv'),
        read.csv('data/data_entry_campanula_08-02-2020.csv'),
        read.csv('data/data_entry_campanula_08-06-2020.csv'),
        read.csv('data/data_entry_campanula_08-10-2020.csv')) %>% 
  # Get rid of plants to ignore
  group_by(Plot, Tag) %>% filter(!any(grepl('iggy', Note))) %>% 
  # Get rid of plants with collected tags
  filter(!any(grepl('collected', Note))) %>%
  # Get rid of plants noted as "no plant"
  filter(!any(grepl('no\\splant', Note))) %>%
  # Get rid of plants which have disappeared (and ungroup)
  filter(!any(grepl('^gone$', Note))) %>% ungroup() %>%
  # Add dates
  mutate(Date = as.Date(Date, '%m/%d/%y')) %>%
  # Now, try to figure out how to get rid of plants which haven't changed in four visits
  # Do this by sorting by date and picking out unique entries for demo data
  # then, filter out plants past a cutoff date
  # (this means if there is no change in demo data since this date, don't check it)
  arrange(Date, Plot, Tag) %>%
  distinct(Tag, Fl_straight, Fl_curled, Fl_done, .keep_all = TRUE) %>%
  filter(Date > as.Date('2020-07-28')) %>%
  # Now, get only the most recent record for each (remaining) plant
  arrange(Plot, Tag, desc(Date)) %>%
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
  write.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-14.csv',
            row.names = FALSE, na = '')

# NOTE:
# find increasing plants like so:
# this one won't work - not sure why (date sorting?)
jul21 %>% arrange(Plot, Tag, Date) %>% filter(any(diff(Fl_straight + Fl_curled + Fl_done) > 0))
jul21 %>% arrange(Plot, Tag, Date) %>% filter(any(diff(Fl_straight + Fl_curled + Fl_done) > 0)) %>% 
  distinct(Plot, Tag) %>% nrow()
# doing date sorting like so:
jul21 %>% group_by(Plot, Tag) %>% mutate(allfl = Fl_straight + Fl_curled + Fl_done) %>% filter(any(diff(allfl) < 0))


# enter data collected august 14

read.csv('data/datasheet_generation/datasheet_outputs/active_campanula_2020-08-14.csv') %>%
  # Get rid of non-checked plants (i.e., give only rows which are blank)
  filter(is.na(Straight)) %>%
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
  write.csv('data/data_entry_campanula_08-14-2020.csv', na = '', row.names = FALSE)
