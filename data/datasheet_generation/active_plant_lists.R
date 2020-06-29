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

