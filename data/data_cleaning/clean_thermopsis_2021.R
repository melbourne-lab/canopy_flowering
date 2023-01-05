# Cleaning Thermopsis data collected in 2021
#
# init 15 Nov. 2021, resumed 4 Jan. 2023 (lol)

library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls())

##### Thermopsis #####

# First look

tdiv = dir('data/raw_data/data_2021/') %>%
  grep(pattern = '[Tt]herm', value = TRUE) %>%
  grep(pattern = 'entry|new', value = TRUE) %>%
  paste0('data/raw_data/data_2021/', .) %>%
  lapply(read.csv) %>%
  do.call(what = rbind)

tdiv %>%
  filter(!is.na(Tag)) %>%
  distinct(Plot, Tag) %>%
  nrow()
# Possibly 149 unique plants?
  
tdiv %>%
  filter(!is.na(Tag)) %>%
  distinct(Plot) %>%
  nrow()
# 31 plots with a plant in it

# Add Record ID column
tdiv$RecordID = 20000 + (1:nrow(tdiv))
# Add date
tdiv$Date = as.Date(tdiv$Date, format = '%m/%d/%y')

##### Look at duplicated tags

tdiv %>%
  filter(!is.na(Tag)) %>%
  distinct(Tag, Plot) %>%
  group_by(Tag) %>%
  filter(n() > 1)
# Only one duplicate tag!

tdiv %>% filter(Tag %in% 1055)
# hmm... okay...

## ASSIGN NEW TAG - use 1350
max(tdiv$Tag, na.rm = TRUE)

tdiv = tdiv %>% 
  mutate(Tag =  ifelse(Tag %in% 1055 & Plot %in% 74, 1350, Tag),
         Note = ifelse(Tag %in% 1055 & Plot %in% 74, 
                       "dup tag changed jan '23", Note))

##### Columns in wrong place?

str(tdiv)
# looks like plot, tag, flower info, etc. all correct actually

# Look at NAs
apply(tdiv, 2, function(x) sum(is.na(x)))

##### Look at distributions for each column

# Plot
unique(tdiv$Plot)
# Date
unique(tdiv$Date)
# Fl info
unique(tdiv$Fl_Stems)
tdiv %>% filter(is.na(Fl_Stems))
unique(tdiv$Fl_Open)
unique(tdiv$Fl_Done)
# Q column
unique(tdiv$Q)
# hmm... oh shit 'i' is "improve" fuck

##### Fix 'i' records
tdiv %>% filter(grepl('i', Q))

# oh man glad I looked...

### Tag 1269/1239
tdiv %>% filter(grepl('12[36]9', Tag))
# oh lmao oh well

### Tag 1303/1307
tdiv %>% filter(grepl('130[37]', Tag))
# guess it doesn't matter here either

### Tag 1126
tdiv %>% filter(Tag %in% 1126)
# issue here is toothpick color (was missed in first record)
tdiv %>% filter(Plot %in% 62) %>% distinct(Toothpick, .keep_all = TRUE)
# tp is orange (there is already a white)
tdiv = tdiv %>% mutate(Toothpick = ifelse(Tag %in% 1126, 'o', Toothpick))
# (!!) should also go in at some point and make sure TP records are here)

### Tag 1134/1220
# note says these are the same plant so merge them
# sounds good with me boss!
tdiv %>% filter(Tag %in% c(1134, 1220))
# woof...
tdiv = tdiv %>% 
  filter(Tag %in% c(1094, 1099)) %>%
  group_by(Date) %>%
  summarise(
    Plot = Plot[1],
    Tag = 1134,
    Fl_Stems    = sum(Fl_Stems    , na.rm = TRUE),
    Fl_Open     = sum(Fl_Open, na.rm = TRUE),
    Fl_Done     = sum(Fl_Done  , na.rm = TRUE),
    Toothpick   = 'yo',
    Q           = '',
    Page        = Page[1],
    Note        = paste(Note, collapse = '; '),
    RecordID    = RecordID[1]
  ) %>%
  # Append a note explaining the merge
  mutate(Note = paste0(Note, '; 1134+1220 records merged SN Jan 2023; tp might also be wy')) %>%
  # Bind this to all date *with 1094.1099 records removed*
  rbind(tdiv %>% filter(!Tag %in% c(1134, 1220))) %>%
  # Resort rows.
  arrange(Tag)

### Tag 1206
tdiv %>% filter(Tag %in% 1206)
# I think this is fine

### Tag 1068 (1060? 1065?)
tdiv %>% filter(grepl('106[058]', Tag)) %>% arrange(Date, Tag)
tdiv %>% filter(grepl('106[058]', Tag)) %>% distinct(Tag, Toothpick)
# hmm - not sure what the deal is with 1060 but 1068 and 1065 are the same for sure
tdiv %>% filter(grepl('106[58]', Tag)) %>% arrange(Date, Tag)
# lol? okay w/e

tdiv = tdiv %>% 
  filter(Tag %in% c(1065, 1068)) %>%
  group_by(Date) %>%
  summarise(
    Plot = Plot[1],
    Tag = 1065,
    Fl_Stems    = sum(Fl_Stems    , na.rm = TRUE),
    Fl_Open     = sum(Fl_Open, na.rm = TRUE),
    Fl_Done     = sum(Fl_Done  , na.rm = TRUE),
    Toothpick   = 'wry',
    Q           = '',
    Page        = Page[1],
    Note        = paste(Note, collapse = '; '),
    RecordID    = RecordID[1]
  ) %>%
  # Append a note explaining the merge
  mutate(Note = paste0(Note, '; 1065+1068 records merged SN Jan 2023')) %>%
  # Bind this to all date *with 1094.1099 records removed*
  rbind(tdiv %>% filter(!Tag %in% c(1065, 1068))) %>%
  # Resort rows.
  arrange(Tag)

### Tag 1113
tdiv %>% filter(Tag %in% c(1113, 1227)) %>% arrange(Date, Tag)
# hmm... looks fine (probably already fixed)

### Tag 1174
tdiv %>% filter(Tag %in% 1174)
# going to go in and fix these
tdiv = tdiv %>%
  mutate(
    Fl_Open = ifelse(Tag %in% 1174 &Date %in% as.Date('2021-07-05'), 2, Fl_Open),
    Fl_Done = ifelse(Tag %in% 1174 &Date %in% as.Date('2021-07-05'), 0, Fl_Done),
    Note    = ifelse(Tag %in% 1174 &Date %in% as.Date('2021-07-05'), 
                     '[modified manually due to comment sn jan 2023]', Note)
    ) #%>% filter(Tag %in% 1174)


### Tag 1205
tdiv %>% filter(Tag %in% 1205) %>% arrange(Date)
# eh I don't think infloresence number is that important here

### Tag 1217
tdiv %>% filter(Tag %in% 1217) %>% arrange(Date)
# yeah go back and change this
tdiv = tdiv %>%
  mutate(
    Fl_Done = ifelse(Tag %in% 1217 & Date %in% as.Date('2021-07-08'), 12, Fl_Done),
    Note    = ifelse(Tag %in% 1217 & Date %in% as.Date('2021-07-08'),
                     '[done flower count edited due to note sn jan 2023]', Note)
  ) #%>% filter(Tag %in% 1217)

##### Guess I should go through all records...
tdiv %>% arrange(Tag, Date)

### Tag 1009
tdiv %>% filter(Tag %in% 1009)
# toothpick mis-assigned
tdiv = tdiv %>%
  mutate(Toothpick = ifelse(Tag %in% 1009, NA,  Toothpick),
         Q         = ifelse(Tag %in% 1009, 'q', Q),
         Note      = ifelse(Tag %in% 1009, 'likely missed at first; exclude?', Note))

### Tag 1040
tdiv = tdiv %>%
  mutate(Fl_Open = ifelse(Tag %in% 1040 & Date %in% as.Date('2021-06-28'), 4, Fl_Open),
         Fl_Done = ifelse(Tag %in% 1040 & Date %in% as.Date('2021-06-28'), 1, Fl_Done),
         Note    = ifelse(Tag %in% 1040 & Date %in% as.Date('2021-06-28'),
                          '[modified based on subsq. record sn jan 2023]',  Note))

### Tag 1054
# (just add a note saying maybe needs to be excluded)
tdiv = tdiv %>% mutate(Note = ifelse(Tag %in% 1054, '[missed first day? ignore/exclude?]', Note))

# ### Tag 1127
# # just add the toothpick to all the records
# tdiv = tdiv %>% mutate(Toothpick = ifelse(Tag %in% 1127, 'rb', Toothpick))
# 
# ### Tag 1128
# # also adding toothpick to all records
# tdiv = tdiv %>% mutate(Toothpick = ifelse(Tag %in% 1128, 'w', Toothpick))
# # hmm I shoudl just automate this...

### Tag 1160
# notes say there is no toothpick... 'x' is misleading so maybe change to 'none'?
tdiv = tdiv %>% mutate(Toothpick = ifelse(Tag %in% 1160, 'none', Toothpick))

### Tag 1170
tdiv = tdiv %>%
  mutate(
    Toothpick = ifelse(Tag %in% 1170, 'none', Toothpick),
    Q         = ifelse(Tag %in% 1170, 'q',    Q),
    Note      = ifelse(Tag %in% 1170,
                       paste0(Note, ';', '[ignore/exclude because on boundary?]'), Note)
  )

### Tag 1227
# add toothpicks to record
tdiv = tdiv %>% mutate(Toothpick = ifelse(Tag %in% 1227, 'og', Toothpick))

### Tag 1281
# actually there is nothing here so probably don't need to include.

### Tag 1286
# 11 in one record got recorded as a 1 lol
tdiv = tdiv %>% mutate(Fl_Done = ifelse(Tag %in% 1286 & Date %in% as.Date('2021-07-05'), 11, Fl_Done)) #%>% filter(Tag %in% 1286)

############ TO DO:

# - back-link TP-yv no tag records (tag shortage) to tags
# - to TP quality analysis
#   - for plants with one TP record, assign tp to all records
#   - check for dupe TPs

#####

tdiv %>%
  group_by(Date) %>%
  summarise(Fl_Open = sum(Fl_Open, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Fl_Open)) +
  geom_point() +
  geom_line()

tdiv %>%
  group_by(Date) %>%
  summarise(Fl_Open = sum(Fl_Open, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Fl_Open)) +
  geom_point() +
  geom_line()

tdiv %>%
  group_by(Plot, Date) %>%
  summarise(Fl_Open = sum(Fl_Open, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Fl_Open, group = Plot)) +
  geom_point(size = 0.1) +
  geom_line(linewidth = 0.1)

tdiv %>%
  group_by(Plot, Date) %>%
  summarise(Fl_Open = sum(Fl_Open, na.rm = TRUE)) %>%
  group_by(Plot) %>%
  slice_max(Fl_Open) %>%
  ungroup() %>%
  ggplot(aes(x = Date, y = Fl_Open)) +
  geom_point()

tdiv %>%
  group_by(Plot, Date) %>%
  summarise(Pl_Open = sum(Fl_Open > 0, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Pl_Open, group = Plot)) +
  geom_point(size = 0.1) +
  geom_line(linewidth = 0.1)

