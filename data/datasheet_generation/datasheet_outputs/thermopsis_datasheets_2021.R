library(dplyr)
library(tidyr)

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

