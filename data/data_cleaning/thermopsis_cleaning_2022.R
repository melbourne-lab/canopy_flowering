# Cleaning Thermopsis 2022 data
# SN - 18 January 2022

library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls())

##### Thermopsis #####

# First look

tdiv = dir('data/raw_data/data_2022/') %>%
  grep(pattern = '[Tt]herm', value = TRUE) %>%
  paste0('data/raw_data/data_2022/', .) %>%
  lapply(read.csv) %>%
  do.call(what = rbind)

head(tdiv)
nrow(tdiv)
str(tdiv)

# Add date, recordID
tdiv = tdiv %>% 
  mutate(RecordID = 30000 + 1:nrow(.)) %>%
  mutate(Date = as.Date(Date, format = '%m/%d/%y')) %>%
  arrange(Date) 

head(tdiv)

length(unique(tdiv$Tag))
length(unique(tdiv$Plot))

tdiv.raw = tdiv

##### Check for duplicated tags

tdiv %>% 
  group_by(Tag) %>% 
  filter(length(unique(Plot)) > 1) %>% 
  arrange(Tag, Plot) %>% 
  distinct(Tag, Plot)

# yikes what happened here

# Tag 2011
tdiv %>% filter(Tag %in% 2011)
# Think this was an entry mistake of some kind
tdiv = tdiv %>% filter(!(Tag %in% 2011 & Plot %in% 169))

# Tag 2026
tdiv %>% filter(Tag %in% 2026)
# hmm... not sure how this happpened
max(tdiv$Tag)
# Assign new tag, 2201
tdiv = tdiv %>%
  mutate(Tag = ifelse(Tag %in% 2026 & Plot %in% 162, 2201, Tag)) %>%
  mutate(Notes = ifelse(Tag %in% 2201, '[dupe tag changed 2026->2201 jan 2023]', Notes)) # %>% filter(Tag %in% 2026)

# Tag 2035
tdiv %>% filter(Tag %in% 2035)
# new tag, 2202
tdiv = tdiv %>%
  mutate(Tag = ifelse(Tag %in% 2035 & Plot %in% 170, 2202, Tag)) %>%
  mutate(Notes = ifelse(Tag %in% 2202, '[dupe tag changed 2035->2202 jan 2023]', Notes)) # %>% filter(Tag %in% 2026)

# Tag 2046
tdiv %>% filter(Tag %in% 2046)
tdiv = tdiv %>%
  mutate(Tag = ifelse(Tag %in% 2046 & Plot %in% 169, 2203, Tag)) %>%
  mutate(Notes = ifelse(Tag %in% 2203, '[dupe tag changed 2046->2203 jan 2023]', Notes)) # %>% filter(Tag %in% 2026)

# Tag 2088
tdiv %>% filter(Tag %in% 2088)
tdiv %>% filter(Tag %in% 2038)
tdiv %>% filter(Tag %in% 2038 | (Tag %in% 2088 & Plot %in% 163)) %>% arrange(Date, Tag)
# I say conclude these are the same plant.
tdiv = tdiv %>% 
  filter(Tag %in% 2038 | (Tag %in% 2088 & Plot %in% 163)) %>%
  group_by(Date) %>%
  summarise(
    Plot = 163,
    Tag = 2038,
    N_infl      = sum(N_infl  , na.rm = TRUE),
    Fl_open     = sum(Fl_open , na.rm = TRUE),
    Fl_done     = sum(Fl_done , na.rm = TRUE),
    Q           = NA,
    Page        = paste0(Page, collapse = ';'),
    Notes       = paste0(Notes, collapse = ';'),
    RecordID    = RecordID[1]
  ) %>%
  # Append a note explaining the merge
  mutate(Notes  = paste0(Notes, '; 2038/2088 records merged SN Jan 2023')) %>%
  # Bind this to all date *with 1094.1099 records removed*
  rbind(tdiv %>% filter(!(Tag %in% 2038 | (Tag %in% 2088 & Plot %in% 163)))) %>%
  # Resort rows.
  arrange(Date)

nrow(tdiv)

# Good

##### Tags with multiple records on the same day

tdiv %>% group_by(Tag, Date) %>% filter(n() > 1)
# hmm...

# 2163
tdiv %>% filter(Tag %in% 2163)
tdiv %>% filter(RecordID %in% (30932 + (-10:10))) %>% print(n = nrow(.))
# data entry mistake?
tdiv %>% filter(Date %in% as.Date('2022-07-11')) %>% distinct(Page)
# where is page 34...
# I have no idea what's happening here lol
# I guess just junk it
tdiv = tdiv %>% filter(!RecordID %in% 20932)

##### Look for NAs and such

apply(tdiv, 2, function(x) sum(is.na(x)))

tdiv %>% filter(is.na(N_infl)) # seems like this is ifne

##### Look at Q, improve, etc. records

tdiv %>% filter(!is.na(Q))

# Plant 2026
tdiv %>% filter(Tag %in% 2026)
tdiv = tdiv %>% mutate(N_infl = ifelse(RecordID %in% 30135, 2, N_infl))

# Plant 2090
tdiv %>% filter(Tag %in% 2090) # done

# Plant 2085
tdiv %>% filter(Tag %in% 2085)
tdiv = tdiv %>% mutate(N_infl = ifelse(RecordID %in% c(30232, 30332, 30433), 2, N_infl))

# Plant 2076
tdiv %>% filter(Tag %in% 2076)

# Any plants to ignore/exclude?
tdiv %>% filter(grepl('iggy', Notes))

# This might be done and ready?

write.csv(tdiv, row.names = FALSE, 'data/processed_data/thermopsis_cleaned_2022.csv')

##### Plots

tdiv %>%
  group_by(Date) %>%
  summarise(Fl_Open = sum(Fl_open, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Fl_Open)) +
  geom_point() +
  geom_line()

tdiv %>%
  group_by(Plot, Date) %>%
  summarise(Fl_Open = sum(Fl_open, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Fl_Open, group = Plot)) +
  geom_point(size = 0.1) +
  geom_line(linewidth = 0.1)

tdiv %>%
  group_by(Plot, Date) %>%
  summarise(Fl_Open = sum(Fl_open, na.rm = TRUE)) %>%
  group_by(Plot) %>%
  slice_max(Fl_Open) %>%
  ungroup() %>%
  ggplot(aes(x = Date, y = Fl_Open)) +
  geom_point()

tdiv %>%
  group_by(Plot, Date) %>%
  summarise(Pl_Open = sum(Fl_open > 0, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Pl_Open, group = Plot)) +
  geom_point(size = 0.1) +
  geom_line(linewidth = 0.1)