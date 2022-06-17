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
  