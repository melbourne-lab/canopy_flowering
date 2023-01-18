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

tdiv.raw = tdiv

##### Load in toothpicks

# Creating new columns "Toothpick.alpha" - alphabetized for merging
# Then, going in and changing any likely-unusable toothpick records
# to end with `.q`

tpicks = read.csv('data/raw_data/data_2021/all_td_toothpicks.csv')

head(tpicks)

tpicks = tpicks %>%
  group_by(Toothpicks) %>%
  mutate(Toothpick.alpha = Toothpicks %>%
           sapply(
             function(x) sort(strsplit(x, '')[[1]]) %>% paste(collapse = '')
           )
  ) %>%
  ungroup() #%>%
# distinct(Toothpicks, Toothpick.alpha) %>%
# arrange(Toothpick.alpha) #%>% View()

### What are the last tpicks to have been added?
tpicks %>% arrange(Date) %>% tail()
# lmao date
tpicks = tpicks %>% mutate(Date = as.Date(Date, '%m/%d/%y'))

# Looking at an old (undated... ugh) datasheet - was it entered?
tpicks %>% filter(Plot %in% 1)
# it was not.
tpicks %>% filter(Plot %in% 2)

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
  filter(Tag %in% c(1134, 1220)) %>%
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

tdiv = tdiv %>%
  group_by(Toothpick) %>%
  mutate(Toothpick.alpha = Toothpick %>%
           sapply(
             function(x) sort(strsplit(x, '')[[1]]) %>% paste(collapse = '')
           )
  )

### Duplicated toothpicks in each plot
tdiv %>%
  filter(!is.na(Toothpick.alpha), !Toothpick.alpha %in% '') %>%
  distinct(Plot, Tag, Toothpick.alpha) %>%
  group_by(Plot, Toothpick.alpha) %>%
  filter(n() > 1) %>%
  arrange(Plot, Toothpick.alpha)

# w in plot 6
tdiv %>% filter(Plot %in% 6, Toothpick %in% 'w')
tdiv %>% filter(Tag %in% 1211) # hmm...
tdiv %>% filter(Tag %in% c(1128, 1138))
tpicks %>% filter(Plot %in% 6, Toothpick.alpha %in% 'w')
tpicks %>% filter(Plot %in% 6, grepl('w', Toothpick.alpha))
tdiv %>% filter(Plot %in% 6, grepl('w', Toothpick.alpha)) %>% distinct(Tag, Toothpick)
# ugh... not sure any of these can be used.
tdiv = tdiv %>%
  mutate(Toothpick.alpha = ifelse(Plot %in% 6 & Toothpick.alpha %in% 'w', 'w.q', Toothpick.alpha))

# Plot 8, toothpicks gg
tdiv %>% filter(Plot %in% 8, Toothpick %in% 'gg')
# wait wtf... are these the same plant?
tdiv %>% filter(Tag %in% c(1201, 1288)) %>% arrange(Date, Tag)
tpicks %>% filter(Plot %in% 8, Toothpicks %in% 'gg')
# three stems... hmm...
# think these two should be combined

tdiv = tdiv %>% 
  filter(Tag %in% c(1201, 1288)) %>%
  group_by(Date) %>%
  summarise(
    Plot = Plot[1],
    Tag = 1201,
    Fl_Stems    = sum(Fl_Stems    , na.rm = TRUE),
    Fl_Open     = sum(Fl_Open, na.rm = TRUE),
    Fl_Done     = sum(Fl_Done  , na.rm = TRUE),
    Toothpick   = 'gg',
    Q           = '',
    Page        = Page[1],
    Note        = paste(Note, collapse = '; '),
    RecordID    = RecordID[1],
    Toothpick.alpha = 'gg'
  ) %>%
  # Append a note explaining the merge
  mutate(Note = paste0(Note, '; 1201+1288 records merged SN Jan 2023')) %>%
  # Bind this to all date *with 1094.1099 records removed*
  rbind(tdiv %>% filter(!Tag %in% c(1201, 1288))) %>%
  # Resort rows.
  arrange(Tag)

nrow(tdiv)

# w in plot 28
tdiv %>% filter(Plot %in% 28, Toothpick %in% 'w') %>% arrange(Date, Tag)
tdiv %>% filter(Tag %in% c(1158, 1286)) %>% arrange(Date, Tag)
tpicks %>% filter(Plot %in% 28, Toothpick.alpha %in% 'w')
# hmm... gonna have to q it

tdiv = tdiv %>%
  mutate(Toothpick.alpha = ifelse(Plot %in% 28 & Toothpick.alpha %in% 'w', 'w.q', Toothpick.alpha))

# y in plot 57
tdiv %>% filter(Plot %in% 57, Toothpick %in% 'y')
# assign tag
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20867, 1251, Tag))
tdiv %>% filter(Plot %in% 57, Toothpick %in% 'y')

# ww in plot 58
tdiv %>% filter(Plot %in% 58, Toothpick %in% 'ww')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20878, 1080, Tag))
tdiv %>% filter(Plot %in% 58, Toothpick %in% 'ww')

# b in plot 59
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'b')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20822, 1145, Tag))
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'b')

# g in plot 59
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'g')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20820, 1301, Tag))
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'g')

# o in plot 59
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'o')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20821, 1147, Tag))
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'o')

# w in plot 59
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'w')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20819, 1025, Tag))
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'w')

# ww in plot 59
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'ww')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20818, 1142, Tag))
tdiv %>% filter(Plot %in% 59, Toothpick %in% 'ww')

# g in plot 62
tdiv %>% filter(Plot %in% 62, Toothpick %in% 'g')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% c(20814, 20512), 1031, Tag))
tdiv %>% filter(Plot %in% 62, Toothpick %in% 'g')
# hmm... assuming missed? not going to fill in those NA records.

# ow in plot 62
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'ow')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20813, 1260, Tag))
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'ow')

# rrw in plot 62
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'rrw')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20817, 1040, Tag))
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'rrw')
# (I suppose this never actually flowered?)
tdiv %>% filter(Tag %in% 1040)
# oh... wtf...
# that's certainly wrong.
tdiv %>% filter(Tag %in% 1060) 
# ah that's the issue - was a tag misread.
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% c(20817, 20515), 1060, Tag))
tdiv %>% filter(Tag %in% 1060) %>% arrange(Date)

# rwy in plot 62
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'rwy') %>% arrange(Date, Tag)
# hmm... note for 1065 might be wgr?
tpicks %>% filter(Plot %in% 62, Toothpick.alpha %in% 'grw')
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'grw') %>% arrange(Date, Tag)
# nope... already being used.
# but looking at the notes... this looksl ike wor?? ugh
tpicks %>% filter(Plot %in% 62, Toothpick.alpha %in% 'orw')
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'orw') %>% arrange(Date, Tag)
# yeah I think 1194 is wor
tpicks %>% filter(Plot %in% 62, Toothpick.alpha %in% c('grw', 'orw'))
# (emerged on the same date)

# re-assigning 1194 to orw, then assigning grw to 165.
tdiv = tdiv %>%
  mutate(Toothpick.alpha = ifelse(Tag %in% 1194, 'orw', Toothpick.alpha)) #%>% 
  # filter(Tag %in% 1194)
tdiv = tdiv %>%
  mutate(Toothpick.alpha = ifelse(Tag %in% 1065, 'grw', Toothpick.alpha)) #%>% 

# Now - 1276 is the true rwy
tdiv %>% filter(Plot %in% 62, Toothpick.alpha %in% 'rwy')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20815, 1276, Tag))


# plot 71, ggy
tdiv %>% filter(Plot %in% 71, Toothpick.alpha %in% 'ggy')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20788, 1289, Tag))
tdiv %>% filter(Plot %in% 71, Toothpick.alpha %in% 'ggy')

# plot 71, ry
tdiv %>% filter(Plot %in% 71, Toothpick.alpha %in% 'ry')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20789, 1041, Tag))
tdiv %>% filter(Plot %in% 71, Toothpick.alpha %in% 'ry')

# plot 73, or
tdiv %>% filter(Plot %in% 73, Toothpick.alpha %in% 'or')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20793, 1103, Tag))
tdiv %>% filter(Plot %in% 73, Toothpick.alpha %in% 'or')

# plot 73, rr
tdiv %>% filter(Plot %in% 73, Toothpick.alpha %in% 'rr')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20794, 1280, Tag))

# plot 73, y
tdiv %>% filter(Plot %in% 73, Toothpick.alpha %in% 'y')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20795, 1108, Tag))

# plot 74, bb
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'bb')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20799, 1046, Tag))

# plot 74, bo
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'bo')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20800, 1113, Tag))

# plot 74, bor
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'bor')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20808, 1223, Tag))

# plot 74, by
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'by')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20801, 1071, Tag))

# plot 74, gww
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'gww')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% c(20802, 20537), 1200, Tag))

# plot 74, ry
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'ry')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20804, 1056, Tag))

# plot 74, w
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'w')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20803, 1350, Tag))

# plot 74, www
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'www')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20807, 1233, Tag))

# plot 74, wy
tdiv %>% filter(Plot %in% 74, Toothpick.alpha %in% 'wy')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20805, 1043, Tag))

# plot 75, b
tdiv %>% filter(Plot %in% 75, Toothpick.alpha %in% 'b')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20860, 1079, Tag))

# plot 76, b
tdiv %>% filter(Plot %in% 76, Toothpick.alpha %in% 'b')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20861, 1013, Tag))

# plot 76, gr
tdiv %>% filter(Plot %in% 76, Toothpick.alpha %in% 'gr')
tdiv = tdiv %>% mutate(Tag = ifelse(RecordID %in% 20862, 1119, Tag))

# How did we do??
tdiv %>%
  filter(!is.na(Toothpick.alpha), !Toothpick.alpha %in% '') %>%
  distinct(Plot, Tag, Toothpick.alpha) %>%
  group_by(Plot, Toothpick.alpha) %>%
  filter(n() > 1) %>%
  arrange(Plot, Toothpick.alpha)
# nice!

### Now, need to go and assign toothpicks for all records for a given plant...
tdiv %>%
  filter(!is.na(Tag)) %>%
  group_by(Tag) %>%
  filter(length(unique(Plot)) > 1)

# Baseline for this
tdiv %>%
  filter(!is.na(Tag)) %>%
  group_by(Tag) %>%
  filter(length(unique(Toothpick.alpha)) > 1)

# First, check to make sure that all dupilcated Tpicks are just missing records.
tdiv %>%
  filter(!is.na(Tag), !Toothpick.alpha %in% '') %>%
  group_by(Tag) %>%
  filter(length(unique(Toothpick.alpha)) > 1)

# Check original number of rows...
nrow(tdiv)

tdiv = tdiv %>%
  filter(!is.na(Tag)) %>%
  group_by(Tag) %>%
  filter(length(unique(Toothpick.alpha)) > 1) %>%
  arrange(Tag, desc(Toothpick.alpha)) %>%
  mutate(Toothpick.alpha = ifelse(Toothpick.alpha %in% '', Toothpick.alpha[1], Toothpick.alpha)) %>%
  # Add back in un-touched records
  rbind(
    tdiv %>% filter(is.na(Tag)),
    tdiv %>% filter(!is.na(Tag)) %>% group_by(Tag) %>% filter(length(unique(Toothpick.alpha)) == 1)
  ) %>%
  arrange(Date, Plot, Tag) %>%
  ungroup()

nrow(tdiv)
# nice - looks like everything is here...

tdiv %>% distinct(Plot, Tag, Toothpick.alpha) %>% group_by(Plot, Tag) %>% filter(n() > 1)
# nice.

#### What about NAs for tags and toothpicks?

tdiv %>% filter(is.na(Tag))
# oh it's just these nine rows, and they dont' have any important info other than YVs...
tdiv %>% group_by(Plot, Toothpick.alpha) %>% filter(any(is.na(Tag)))
# none of them ever flowered.
# welp, not concerned!

tdiv %>% filter(is.na(Toothpick.alpha))
tdiv %>% filter(Toothpick.alpha %in% '')
tdiv %>% filter(Toothpick.alpha %in% '') %>% distinct(Tag) %>% nrow()
# oh lmao only five plants missed? that's fucking awesome. holy shit, hell yeah.

tdiv %>% filter(Toothpick.alpha %in% '') %>% arrange(Date, Tag) %>% distinct(Tag, .keep_all = TRUE)

# hmm... 

# oh you know what, to do this we want to merge these together and see how many
# TPs don't show up...

# first try...
tdivpix = tpicks %>%
  rename(Emerge.date = Date) %>%
  select(Plot, Toothpick.alpha, Emerge.date) %>%
  merge(tdiv, by = c('Plot', 'Toothpick.alpha'), all.x = FALSE, all.y = TRUE)
# wtf is enno... oh wait it's none lmao

tdivpix %>% distinct(Plot, Tag, .keep_all = TRUE) %>% nrow() # 151 - not bad!
tdivpix %>% 
  distinct(Plot, Tag, .keep_all = TRUE) %>% 
  group_by(have.em = !is.na(Emerge.date)) %>%
  summarise(n = n())
# okay... not sure why we have 40 plants with no TP...

tdivpix %>% 
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  filter(is.na(Emerge.date), !grepl('\\.q$', Toothpick.alpha), !grepl('enno|x', Toothpick.alpha))

# 1152 - yv should be wow...
tdiv %>% filter(Tag %in% 1152)
tdiv = tdiv %>% mutate(Toothpick.alpha = ifelse(Tag %in% 1152, 'ow', Toothpick.alpha))

# 1316 - 
tdiv %>% filter(Tag %in% 1316)
tdiv %>% filter(RecordID %in% 20923) %>% pull(Note)
# hmm... guess there's no toothpick

# 1196
tdiv %>% filter(Tag %in% 1196)
tpicks %>% filter(Plot %in% 20)
# ugh... data sheet has tp = b, but I can't find this in records
# (I do see a note on 6/14 saying it was present then but not entered... 
# but can't find it ever being on a data sheet)
# ugh... shit

# 1050
tdiv %>% filter(Tag %in% 1050)
# ?? ggrw there isn't anything like this in the tpicks dataset
# oh well.

# 
tdiv %>% filter(Tag %in% 1289)
tdiv %>% filter(Plot %in% 71) %>% distinct(Toothpick.alpha)
# wtf... only 11 plants in plot 71?
# not on record (shit.)

tdiv %>% filter(Tag %in% 1005)
tpicks %>% filter(Plot %in% 71) %>% print(n = nrow(.))
tpicks %>% filter(Plot %in% 71) %>% filter(grepl('o|r', Toothpicks))
# hmm... call this org
tdiv = tdiv %>% mutate(Toothpick.alpha = ifelse(Tag %in% 1005, 'gor', Toothpick.alpha))

# 1107
tdiv %>% filter(Tag %in% 1107)
# tp is oy
tdiv = tdiv %>% mutate(Toothpick.alpha = ifelse(Tag %in% 1107, 'oy', Toothpick.alpha))

# 1039
tdiv %>% filter(Tag %in% 1039)
tpicks %>% filter(Plot %in% 73) %>% print(n = nrow(.))
tdiv %>% filter(Plot %in% 73) %>% distinct(Toothpick.alpha)
# hmm... data sheet is unambiguously gyo
# could be gyb, could be oyy (same day)
# g could fade to y easily
tdiv = tdiv %>% mutate(Toothpick.alpha = ifelse(Tag %in% 1039, 'oyy', Toothpick.alpha))

# 1009
tdiv %>% filter(Tag %in% 1009)
# no toothpick

# 1054
tdiv %>% filter(Tag %in% 1054)
# no toothpick

# 1046
tdiv %>% filter(Tag %in% 1046)
# there just ahs to be a bb in this plot...
# actually I don't see it... come on man how did that happen
tpicks %>% filter(Plot %in% 74) %>% filter(grepl('bb', Toothpicks)) # dang, shit, etc.

# 1129
tdiv %>% filter(Tag %in% 1129)
tpicks %>% filter(Plot %in% 74) %>% filter(grepl('b|w|o', Toothpicks)) %>% print(n = nrow(.))
# oh well

# 1214
tdiv %>% filter(Tag %in% 1214)
# hmm...
tdiv %>% filter(Tag %in% 1214) %>% select(Date, Fl_Stems, Fl_Open, Fl_Done, Note)
tdiv %>% filter(Plot %in% 74) %>% group_by(Tag) %>% filter(max(Date) < as.Date('2021-07-01'))
# chewed up tag nearby...? sure seems like a dupe to me...
tdiv %>% filter(Plot %in% 74, grepl('r', Toothpick.alpha))
# welp... guess I just missed the first day here
# fixed in csv (was entry mistake)

# 1056
tdiv %>% filter(Tag %in% 1056)
# there are two ybs, ygs in data...
tpicks %>% filter(Plot %in% 74) %>% print(n = nrow(.))
# assuming tp entered gr is actually yr (on tpicks data sheet)
# fixed in toothpick csv (gr -> ry)

### Now, check to see if any Tags (plants) have multiple TPs/dates...

tdivpix = tpicks %>%
  rename(Emerge.date = Date) %>%
  select(Plot, Toothpick.alpha, Emerge.date) %>%
  merge(tdiv, by = c('Plot', 'Toothpick.alpha'), all.x = FALSE, all.y = TRUE)

tdivpix %>%
  filter(!is.na(Tag)) %>%
  group_by(Tag) %>%
  filter(length(unique(Toothpick.alpha)) > 1)
# good - no duplicated toothpicks

# any duplicated dates?
tdivpix %>%
  filter(!is.na(Tag)) %>%
  group_by(Tag) %>%
  filter(length(unique(Emerge.date)) > 1)
# woof... 

tdivpix %>%
  filter(!is.na(Tag)) %>%
  group_by(Tag) %>%
  filter(length(unique(Emerge.date)) > 1) %>%
  distinct(Tag, .keep_all = TRUE)

# 1307
tdiv %>% filter(Tag %in% 1307)
tpicks %>% filter(Plot %in% 8, grepl('orw', Toothpick.alpha))
# great...yep fucked that up
# actually - pretty sure it's not the 6/17 emergence date if it was yv on that day.
tdivpix = tdivpix %>% filter(!(Tag %in% 1307 & Emerge.date > as.Date('2021-06-11')))

# 1070
tdivpix %>% filter(Tag %in% 1070)
# two different gggs...yep both entered correctly lol
# just assume it's the earlier one
tdivpix = tdivpix %>% filter(!(Tag %in% 1070 & Emerge.date > as.Date('2021-06-11')))

# 1190
tdiv %>% filter(Tag %in% 1190)
tpicks %>% filter(Plot %in% 37, grepl('ow', Toothpick.alpha))
# great. yep that's a mistake
# assume earlier
tdivpix = tdivpix %>% filter(!(Tag %in% 1190 & Emerge.date > as.Date('2021-06-04')))

# 1071
tdiv %>% filter(Tag %in% 1071)
tpicks %>% filter(Plot %in% 74, grepl('by', Toothpick.alpha))
# two stems - going to sya it's by2 instead of by1
tdivpix = tdivpix %>% filter(!(Tag %in% 1071 & Emerge.date > as.Date('2021-06-01')))

# 1229
tdiv %>% filter(Tag %in% 1229)
tpicks %>% filter(Plot %in% 74, grepl('gy', Toothpick.alpha))
# sloppy me.
# oh well guess I'll stick to my rule of it being earlier
tdivpix = tdivpix %>% filter(!(Tag %in% 1229 & Emerge.date > as.Date('2021-06-01')))

# 1258
tpicks %>% filter(Plot %in% 74, grepl('or', Toothpick.alpha))
# yep. big old goof up
tdiv %>% filter(Tag %in% 1258)
# go with earlier
tdivpix = tdivpix %>% filter(!(Tag %in% 1258 & Emerge.date > as.Date('2021-06-04')))

# Anything else?
# Multiple observations of a plant on the same day? could happen...
tdivpix %>%
  group_by(Tag, Date) %>%
  filter(n() > 1)
# yep...

tdivpix %>%
  filter(!is.na(Tag)) %>%
  group_by(Tag, Date) %>%
  filter(n() > 1) %>%
  ungroup() %>%
  distinct(Tag)

tdivpix %>% filter(Tag %in% 1274)
tdivpix %>% filter(Tag %in% 1181)
tdivpix %>% filter(Tag %in% 1276)
tdivpix %>% filter(Tag %in% 1150)

# Get rid of NA records and duplicated records on same day
tdivpix = tdivpix %>%
  filter(!is.na(Tag)) %>%
  distinct(Tag, Date, .keep_all = TRUE)

length(unique(tdivpix$Tag))
length(unique(tdivpix$Plot))

# Good enough for me.

write.csv(tdivpix, 'data/processed_data/thermopsis_cleaned_2021.csv', row.names = FALSE)

#####

tdivpix %>%
  group_by(Date) %>%
  summarise(Fl_Open = sum(Fl_Open, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Fl_Open)) +
  geom_point() +
  geom_line()

tdivpix %>%
  group_by(Plot, Date) %>%
  summarise(Fl_Open = sum(Fl_Open, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Fl_Open, group = Plot)) +
  geom_point(size = 0.1) +
  geom_line(linewidth = 0.1)

tdivpix %>%
  group_by(Plot, Date) %>%
  summarise(Fl_Open = sum(Fl_Open, na.rm = TRUE)) %>%
  group_by(Plot) %>%
  slice_max(Fl_Open) %>%
  ungroup() %>%
  ggplot(aes(x = Date, y = Fl_Open)) +
  geom_point()

tdivpix %>%
  group_by(Plot, Date) %>%
  summarise(Pl_Open = sum(Fl_Open > 0, na.rm = TRUE)) %>%
  ggplot(aes(x = Date, y = Pl_Open, group = Plot)) +
  geom_point(size = 0.1) +
  geom_line(linewidth = 0.1)
