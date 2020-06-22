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

