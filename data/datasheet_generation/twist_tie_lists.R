library(dplyr)
library(tidyr)

all.records = read.csv('data/data_active.csv')

head(all.records)

# Ran this script on June 10 to get June 11 data
all.records %>%
  filter(!(Twist.ties %in% 'NULL')) %>%
  filter(as.Date(Date) < as.Date('06/09/2020')) %>%
  arrange(desc(Date)) %>%
  distinct(Tag, .keep_all = TRUE) %>%
  select(Tag, Plot, Racemes, Infl_spread, Twist.ties, Note, Date) %>%
  rename(Last_Record = Date, Twist_ties = Twist.ties) %>%
  mutate(Status_Jun_11 = NA) %>%
  write.csv('data/datasheet_generation/datasheet_outputs/twist_tie_list_2020-06-11.csv', 
            row.names = FALSE, na = '')
