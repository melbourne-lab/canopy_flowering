## Init script for looking at Elk data and cleaning
## SN - September 19, 2020

## Load packages
library(ggplot2)
library(dplyr)
library(tidyr)

##### Thermopsis data.

## Load Thermopsis data

# `therm.orig` will be original, unaltered data
# Read in new plant csv
therm.orig = read.csv('data/data_thermopsis_active.csv') %>%
  # remove junk "X" col (should be empty)
  select(-X) %>%
  # read in pre-made data collection sheets
  rbind(
    read.csv('data/data_entry_06-21-2020.csv'),
    read.csv('data/data_entry_06-24-2020.csv'),
    read.csv('data/data_entry_06-27-2020.csv'),
    read.csv('data/data_entry_07-01-2020.csv'),
    read.csv('data/data_entry_07-05-2020.csv'),
    read.csv('data/data_entry_07-09-2020.csv'),
    read.csv('data/data_entry_thermopsis_07-13-2020.csv'),
    read.csv('data/data_entry_thermopsis_07-17-2020.csv'),
    read.csv('data/data_entry_thermopsis_07-21-2020.csv')
  )

# `therm` will contain data in progress
therm = therm.orig

## Look at columns

head(therm)
str(therm)
# Racemes is character

# Fixing racemes
unique(therm$Racemes)
therm %>% filter(Racemes %in% 'whop') 
therm[therm$Racemes %in% 'whop', c("Racemes", "Twist.ties")] = c(NA, "whop")

str(therm)
unique(therm$Racemes)
therm$Racemes = as.numeric(therm$Racemes)

# There is campanula data in here?
therm %>% filter(Species %in% 'Campanula rotundifolia')
# get rid of 'er!
therm = therm %>% filter(Species %in% 'Thermopsis divaricarpa')

# Make the date column an actual date column.
therm$Date
as.Date(therm$Date, format = '%m/%d/%y')
therm$Date = as.Date(therm$Date, format = '%m/%d/%y')

# How many NAs?
apply(therm, 2, function(x) sum(is.na(x)))

## Assess data complteness

# How many entries per day
table(therm$Date)
# neat!
table(therm$Date) %>% plot()
# But: this includes plants never flowering.

# It would be good to sort by tags and see how many plants have no fl records
# Although: this would possibly cut out tag misreads.
# Ugh.

# Guess I need to fix tags first!
therm %>%
  group_by(Tag) %>%
  summarise(n.plots = length(unique(Plot))) %>%
  filter(n.plots > 1)
# It's quite a few! 33 tags. Not good.

therm %>%
  group_by(Tag) %>%
  filter(length(unique(Plot)) > 1) %>%
  arrange(Tag, Date, Plot) %>%
  View()

# How many records are there total?
# Use this as reference for how many records should be removed in each step.
nrow(therm)
# 1450

# Plant 1001:
# plot 2 record is empty and also trash (must have been misplaced tag...?)
therm = therm %>% filter(!(Plot %in% 2 & Tag %in% 1001))
nrow(therm)

# Plant 1012
# this is a case (I remember) where I mistakenly recorded plot as 47
# instead of 48.
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1012, 48, Plot)) %>%
  # While I am here, get rid of the "bad old record" record
  filter(!(Tag %in% 1012 & grepl('bad old record', Note)))

nrow(therm)
# good - one record removed

# check to make sure this workd correctly
therm %>% filter(Tag %in% 1012)

# Plant 1018
therm %>% filter(Tag %in% 1018)
# req's field check
check.tags = c(1018)
# for now - all records are empty (no FL) so no worries

# Plant 1023
# looks like this should be plot 2
therm = therm %>% mutate(Plot = ifelse(Tag %in% 1023, 2, Plot))
therm %>% filter(Tag %in% 1023)

# Plant 1031
# another case where plot 47 is wrong, should be plot 48
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1031, 48, Plot)) %>%
  filter(!(Tag %in% 1031 & grepl('bad old record', Note)))

# check
therm %>% filter(Tag %in% 1031)
nrow(therm)

# Plant 1033
# there's a record here for plot 47 but correct plot is 21
therm %>% filter(Plot %in% 47:48) %>% distinct(Tag, Plot) %>% arrange(Tag)
# 1083? 1036? 1037? maybe check records
if (!1033 %in% check.tags) check.tags = c(check.tags, 1033)

therm %>% filter(Tag %in% 1083)

# Plant 1036
# this is a 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1036, 48, Plot)) %>%
  filter(!(Tag %in% 1036 & grepl('bad old record', Note)))

# check
therm %>% filter(Tag %in% 1036)
nrow(therm)
# woke

# Plant 1055
# hmmm two records for plot 22
# wonder if tag was moved?
therm %>% filter(Plot %in% 2) %>% distinct(Tag)
# should the 1055, plot 2 records be 1054? or 1050?
# look to see if there are 1050/1054 records on 05/30 or 06/02
therm %>% filter(Tag %in% c(1050, 1054))
therm %>% filter(Date %in% as.Date('2020-05-30') & Plot %in% 2)
therm %>% filter(Date %in% as.Date('2020-06-05') & Plot %in% 2)
# uhh
# well... nuke it. No flowers anyway.
therm = therm %>% filter(!(Plot %in% 2 & Tag %in% 1055))

# Check
therm %>% filter(Tag %in% 1055)
nrow(therm)

# Plant 1056
# in plot 22 and plot 48
# but, note in plot 48 says may be 1036
therm %>% filter(Tag %in% c(1036, 1056), Plot %in% 48) %>% arrange(Date)
# Both of these were recorded on June 14
therm %>% filter(Plot %in% 48) %>% distinct(Tag) %>% arrange(Tag)
# 1095??
therm %>% filter(Tag %in% c(1056, 1095), Plot %in% 48) %>% arrange(Date) 

# not sure what to do about this one
if (!1056 %in% check.tags) check.tags = c(check.tags, 1056)

# Plant 1068
# is a 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1068, 48, Plot)) %>%
  filter(!(Tag %in% 1068 & grepl('bad old record', Note)))

# check
therm %>% filter(Tag %in% 1068)
nrow(therm)
# woke!

# Plant 1077
# record for 1077 in plot 22 should be 1071
# just to make sure
therm %>% filter(Tag %in% 1071)
# yep - no record on june 14
# to remedy this: change 1077 in plot 22 to 1071
therm = therm %>%
  # Get rid of NA records for plot 1077
  filter(!(Tag %in% 1077 & Plot %in% 22 & is.na(Infl_spread))) %>%
  # Change tag for the rest of the plants
  mutate(Tag = ifelse(Tag %in% 1077 & Plot %in% 22, 1071, Tag))

# n.b. - is it worth adding a processing note here?

# Tag 1081
# notes say that 1081 in plot 25 should be 1080
# check:
therm %>% filter(Tag %in% 1080)
# Yes.
# (but... ugh no other records here!!! it mysteriously ended!!)
therm = therm %>%
  # Get rid of NA records for plot 1080
  filter(!(Tag %in% 1081 & Plot %in% 25 & is.na(Infl_spread))) %>%
  # Change tag for the rest of the plants
  mutate(Tag = ifelse(Tag %in% 1081 & Plot %in% 25, 1080, Tag))

nrow(therm)

# Plant 1083
# 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1083, 48, Plot)) %>%
  filter(!(Tag %in% 1083 & is.na(Infl_spread)))

# check
therm %>% filter(Tag %in% 1083)
nrow(therm)
# okay

# Plant 1084
# Record for plant 46 is likely 1089 according to note
therm %>% filter(Tag %in% 1089)
# yes - and missing records from june 21
therm = therm %>%
  # Get rid of NA records for plot 46
  filter(!(Tag %in% 1084 & Plot %in% 46 & is.na(Infl_spread))) %>%
  # Change tag for the rest of the plants
  mutate(Tag = ifelse(Tag %in% 1084 & Plot %in% 46, 1089, Tag))

# check
therm %>% filter(Tag %in% c(1084, 1089)) %>% arrange(Tag)


# Plant 1085
# It's a 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1085, 48, Plot)) %>%
  filter(!(Tag %in% 1085 & is.na(Infl_spread))) # %>% filter(Tag %in% 1085)
# 

# Plant 1090
# 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1090, 48, Plot)) %>%
  filter(!(Tag %in% 1090 & is.na(Infl_spread))) # %>% filter(Tag %in% 1090)

# Plant 1095
# 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1095, 48, Plot)) %>%
  filter(!(Tag %in% 1095 & is.na(Infl_spread))) # %>% filter(Tag %in% 1095)

# Plant 1098
# is likely in plot 31, but no subsequent records after 6/14
if (!1098 %in% check.tags) check.tags = c(check.tags, 1098)

# Plant 1101
# the 6/2 record in plot 6 looks like junk
therm = therm %>% filter(!(Tag %in% 1101 & Plot %in% 6))
nrow(therm)

# Plant 1102
# is a 47/48 plot
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1102, 48, Plot)) %>%
  filter(!(Tag %in% 1102 & is.na(Infl_spread)))

# Plant 1117
# 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1117, 48, Plot)) %>%
  filter(!(Tag %in% 1117 & is.na(Infl_spread))) # %>% filter(Tag %in% 1117)

# Plant 1181
# the plot 48 stuff is all just yv
therm = therm %>% filter(!(Plot %in% 48 & Tag %in% 1181)) # %>% filter(Tag %in% 1181)

# Plant 1183
# record for 1183 on 6/24 (plot 50) could be 1187?
# uh.... well it's not 1186
# not really sure what else it could be
therm %>% filter(Plot %in% 50) %>% distinct(Tag)
# note there's a twist tie here - look specifcally at twist tied plants
therm %>% filter(grepl('wh', Twist.ties), Plot %in% 50)

# assuming it's 1187 (twist ties plus notes on ants)
# but, there is another record here for 1187 in 50 on this day
therm %>% filter(Tag %in% 1187)
# this has less info

# remove 1187 record (less info), change 1183 to 1187, remove empties
therm = therm %>% 
  filter(!(Tag %in% 1187 & Date %in% as.Date('2020-06-24'))) %>%
  mutate(Tag = ifelse(Tag %in% 1183 & Plot %in% 50, 1187, Tag)) %>% # filter(Tag %in% 1187)
  filter(!(Tag %in% 1187 & is.na(Infl_spread) & is.na(Infl_done))) # %>% filter(Tag %in% 1187)

# Plant 1229
# 47/48 plant
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1229, 48, Plot)) %>%
  filter(!(Tag %in% 1229 & is.na(Infl_spread))) # %>% filter(Tag %in% 1229)

# Plant 1231
# 47/48
therm = therm %>% 
  mutate(Plot = ifelse(Tag %in% 1231, 48, Plot)) %>%
  filter(!(Tag %in% 1231 & is.na(Infl_spread))) # %>% filter(Tag %in% 1231)

# Plant 1247
# erm... records suggest this is in plot 14, but things are weird and not good
# no YV records, first record has done plots
# not good! maybe is 1241:1249?
therm %>% filter(Tag %in% 1241:1249) %>% arrange(Date, Tag) 
# was last record in new data sheet, plot no. inherited from above
# 2/14 are near each other
# assuming it's 14
therm = therm %>%
  mutate(Plot = ifelse(Tag %in% 1247, 14, Plot)) %>%
  filter(!(Tag %in% 1247 & is.na(Infl_spread) & is.na(Infl_done))) # %>% filter(Tag %in% 1247)

nrow(therm)

# Plant 1262
# record for plant 3 is bad.
therm = therm %>%
  mutate(Plot = ifelse(Tag %in% 1262, 2, Plot)) %>%
  filter(!(Tag %in% 1262 & is.na(Infl_spread) & is.na(Infl_done))) # %>% filter(Tag %in% 1262)

# Plant 1275
# stray record in plot 22 - what should this be?
therm %>% filter(Plot %in% 22) %>% distinct(Tag) %>% arrange(Tag)
therm %>% filter(Tag %in% 1271)
# the 1275 I am guessing should be 1271 (not that it matters it's 0,0)
therm = therm %>%
  mutate(Tag = ifelse(Tag %in% 1275 & Plot %in% 22, 1271, Tag)) #%>% filter(Tag %in% 1271)

# Plants 1288/1295
# 6/21 record - what should this be? tg 1288, note says perhaps 1295?
therm %>% filter(Tag %in% 1295)
# ah what the hell
# should these be two separate plants...?
# no because they're in different plots?

# check.
if (!1288 %in% check.tags) check.tags = c(check.tags, 1288)
if (!1295 %in% check.tags) check.tags = c(check.tags, 1295)

# Plants 1309
# notes say that plot 32 record is in fact 1209
# good notes!
therm = therm %>%
  mutate(Tag = ifelse(Tag %in% 1309 & Plot %in% 32, 1209, Tag)) #%>% filter(Tag %in% 1209)

nrow(therm)

##### Campanula

# read in campanula data
campn.orig = read.csv('data/data_campanula_active.csv') %>%
  # read in subsequent data
  rbind(
    read.csv('data/data_entry_campanula_07-13-2020.csv'),
    read.csv('data/data_entry_campanula_07-17-2020.csv'),
    read.csv('data/data_entry_campanula_07-21-2020.csv'),
    read.csv('data/data_entry_campanula_07-28-2020.csv'),
    read.csv('data/data_entry_campanula_08-02-2020.csv'),
    read.csv('data/data_entry_campanula_08-06-2020.csv'),
    read.csv('data/data_entry_campanula_08-10-2020.csv'),
    read.csv('data/data_entry_campanula_08-14-2020.csv'),
    read.csv('data/data_entry_campanula_08-19-2020.csv'),
    read.csv('data/data_entry_campanula_08-23-2020.csv'),
    read.csv('data/data_entry_campanula_08-27-2020.csv')
  ) %>%
  # make date column into date format
  mutate(Date = as.Date(Date, format = '%m/%d/%y'))


# (there is one file missing here but it probably won't change anything.

## Duplicate
campn = campn.orig

## Look at columns
str(campn)

# what's up wth the 'q' column
unique(campn$Q)
# seems good

## Okay look for double tags.

campn %>%
  group_by(Tag) %>%
  summarise(n.plots = length(unique(Plot))) %>%
  filter(n.plots > 1)

# woohoo! only 13 plants.

campn %>%
  group_by(Tag) %>%
  filter(length(unique(Plot)) > 1) %>%
  arrange(Tag, Date) %>%
  View()

# Plant 1530
# note says could be 1570?
campn %>% filter(Tag %in% 1570)
# There is no record for this plant on 7/9...
# going to say that the 7/9 1530 record is 1570.
campn = campn %>%
  mutate(Tag = ifelse(Tag %in% 1530 & Plot %in% 2, 1570, Tag)) %>%
  filter(!(Tag %in% 1530 & is.na(Fl_straight) & is.na(Fl_curled))) # %>% filter(Tag %in% 1530)

# Plant 1537
# plot 53 record - could be 1737? or 1539?
campn %>% filter(grepl('39$', Tag)) %>% arrange(Date)
# well... there is a 1739, but it's recorded on the same date
campn %>% filter(Tag %in% 1539) # not this
campn %>% filter(Tag %in% 1534)
campn %>% filter(Plot %in% 53) %>% arrange(Tag) %>% distinct(Tag)
# 1737?
campn %>% filter(Tag %in% 1737)
# going to assume 1537 in plot 53 is 1737.
campn = campn %>%
  mutate(Tag = ifelse(Tag %in% 1537 & Plot %in% 53, 1737, Tag)) %>%
  filter(!(Tag %in% 1737 & is.na(Fl_straight) & is.na(Fl_curled))) # %>% filter(Tag %in% 1737)

# Plant 1544
# looking at notes, the plot 33 record may be 1593
campn %>% filter(Tag %in% 1593)
# it is
campn %>%
  mutate(Tag = ifelse(Tag %in% 1543 & Plot %in% 33, 1593, Tag)) %>%
  filter(!(Tag %in% 1593 & is.na(Fl_straight) & is.na(Fl_curled))) %>% filter(Tag %in% 1593)
# wait... july 21 is 001, but july 28 is 110?
# also the july 21 record says old tag.
# come back to this...
campn %>% filter(Plot %in% 33) %>% distinct(Tag) %>% arrange(Tag)

if (!1543 %in% check.tags) check.tags = c(check.tags, 1543)
  
# Plant 1548
# plot 31 record? similar tags?
campn %>% filter(Plot %in% 31) %>% distinct(Tag)
# could be 1544? is there a record on 7/21?
campn %>% filter(Tag %in% 1544)
# I'm going to assume this should be 1544
# [I checked the notes and it is 1544 - was misread]
campn = campn %>%
  mutate(Tag = ifelse(Tag %in% 1548 & Plot %in% 31, 1544, Tag)) %>%
  filter(!(Tag %in% 1544 & is.na(Fl_straight) & is.na(Fl_curled))) #%>% filter(Tag %in% 1544)

# Plant 1561
# there are multiple 1561s records in each plot
# must be one legit plant in 1561
campn %>% filter(Plot %in% 2) %>% distinct(Tag) %>% arrange(Tag)
campn %>% filter(Tag %in% 1611)

# Are there multiple tags? Check collected tags.
if (!1561 %in% check.tags) check.tags = c(check.tags, 1561)

# Plant 1568

# ugh this one will require some record merging...
# recycled tag.

# Plant 1584
campn %>% filter(Tag %in% c(1854, 1548)) %>% arrange(Date, Tag)
# both of these have records for the date in question
# what the heck man
campn %>% filter(Plot %in% 1) %>% arrange(Tag) %>% distinct(Tag)
# 1582?
campn %>% filter(Tag %in% 1582) %>% arrange(Date)
# ahhh what the hell

# think of something later

# Plant 1669
# this should be plot 22
campn = campn %>%
  mutate(Plot = ifelse(Tag %in% 1669 & Plot %in% 2, 22, Plot)) %>%
  filter(!(Tag %in% 1669 & is.na(Fl_straight) & is.na(Fl_curled))) # %>% filter(Tag %in% 1669)

# Plant 1677
# note says 1677 in plot 47 is 1577
# check this:
campn %>% filter(Tag %in% 1577)
campn = campn %>% mutate(Tag = ifelse(Tag %in% 1677 & Plot %in% 47, 1577, Tag)) # %>% filter(Tag %in% 1577)

# Plnt 1678
# note says this may be 1576?
campn %>% filter(Tag %in% 1576) %>% arrange(Date)
# I don't think so... 7/17 record is 3 stems, 7/21 record is 1 stem
campn %>% filter(Plot %in% 33) %>% distinct(Tag) %>% arrange(Tag)
campn %>% filter(Tag %in% 1578) %>% arrange(Date)
# no this has a record in the date in question
# paper record is def 16X8 - maybe 1628?
campn %>% filter(Tag %in% 1628) %>% arrange(Date)
campn %>% filter(Stms %in% 3 & Plot %in% 33)
campn %>% filter(Tag %in% 1528)
# I think it's 1528
campn = campn %>%
  mutate(Tag = ifelse(Tag %in% 1678 & Plot %in% 33, 1528, Tag)) %>%
  filter(!(Tag %in% 1528 & is.na(Fl_straight) & is.na(Fl_curled))) # %>% filter(Tag %in% 1528)

# Plot 1694 

# requires merging

### Generate check list for dismantling plots

# therm %>%
#   filter(Tag %in% check.tags) %>%
#   arrange(Plot, Tag, Date) %>%
#   write.csv('data/data_cleaning/therdiva_check_tags.csv', row.names = FALSE)
# 
# campn %>%
#   filter(Tag %in% check.tags) %>%
#   arrange(Plot, Tag, Date) %>%
#   write.csv('data/data_cleaning/camprotu_check_tags.csv', row.names = FALSE)

### Picking up where we left off.
# Here, relying on notes from clean-up on Oct. 4

# Thermopsis tags

# Tag 1018
# the 1018 record in plot 12 is 1048
therm = therm %>% 
  mutate(Tag = ifelse(Tag %in% 1018 & Plot %in% 12, 1048, Tag)) # %>% filter(Tag %in% 1048)

# Tag 1033
# ah.. note ays that this is plant 1044
# need a way to handle combined plants...
# but also record for plant in plot 47
therm %>% filter(Tag %in% 1033 & Plot %in% 47)
# hmm... record is for june 5
therm %>% filter(Tag %in% c(1037, 1093))
# hmm... well, not so sure this matters, because it's a non-flowering record
# but I'd guess this is 1037 (closer rosette count)
therm = therm %>% 
  mutate(Tag = ifelse(Tag %in% 1033 & Plot %in% 47, 1037, Tag)) #%>% filter(Tag %in% 1033)

# Tag 1056
# notes say that 1056 is present in plot 22
# the one in plot 48 is probably 1036
therm %>% filter(Tag %in% 1036 | (Tag %in% 1056 & Plot %in% 48))
# on 6/14 they both have records
# look at plants on 6/11 - how many had 2 open?
therm %>% filter(Plot %in% 48 & Date %in% as.Date('2020-06-11')) # %>% View()
# ah what the heck man
# okay, try to see which tags only show up once between 6/11 and 6/14
therm %>% 
  filter(Plot %in% 48 & Date %in% c(as.Date('2020-06-11'), as.Date('2020-06-14'))) %>%
  group_by(Tag) %>%
  summarise(n = n()) %>%
  filter(n < 2)
# 1083, 1098...
therm %>% filter(Tag %in% c(1083, 1098) & Date %in% as.Date('2020-06-14'))
# 1098 appears, but 1083 doesn't
therm %>% filter(Tag %in% c(1083, 1056) & Plot %in% 48) %>% arrange(Date, Tag)
# no! what the heck... 1083 has seven flowers!
therm %>%
  filter(Plot %in% 48) %>%
  filter(!Tag %in% 1117) %>%
  select(Date, Tag, Infl_spread) %>%
  spread(Date, Infl_spread)
# 1068 is plusible...
therm %>%
  filter(Plot %in% 48) %>%
  filter(!Tag %in% 1117) %>%
  select(Date, Tag, Infl_done) %>%
  spread(Date, Infl_done)
# 1068 is the only realistic option
therm %>% filter(Tag %in% c(1056, 1068) & Plot %in% 48) %>% arrange(Date, Tag)
# gonna say this was 1068
therm = therm %>%
  mutate(Tag = ifelse(Tag %in% 1056 & Plot %in% 48, 1068, Tag)) %>%
  filter(!(Tag %in% 1068 & is.na(Infl_spread) & is.na(Infl_done))) #%>% filter(Tag %in% 1068)

# Tag 1098
# tag 1098 not found in either plot when collecting tags
therm %>% filter(Plot %in% 31)
# eh
therm %>%
  filter(Plot %in% 31 & Tag %in% 1090:1099) %>%
  select(Date, Tag, Infl_spread) %>%
  spread(Date, Infl_spread)
# okay maybe it's not a 109X tg
therm %>%
  filter(Plot %in% 31, !Tag %in% 1107) %>%
  select(Date, Tag, Infl_spread) %>%
  spread(Date, Infl_spread)
# uhhh - could be 1248...? could also be lost somehow
therm %>% filter(Tag %in% 1098, Plot %in% 48)
# these all look kinda garbo
therm %>%
  filter(Plot %in% 48) %>%
  filter(!Tag %in% 1117) %>%
  select(Date, Tag, Infl_done) %>%
  spread(Date, Infl_done)
# yeah these are garb - no evidence that 1098 is in plot 48
# so what is that 1098 record from?? conceivably 1083
therm %>% filter(Tag %in% 1083 | (Tag %in% 1098 & Plot %in% 48 & !is.na(Infl_spread)))
# oh... nope
# man idk
# just nuke it? where the heck is it coming from
therm %>%
  filter(Plot %in% 48) %>%
  filter(!Tag %in% 1117) %>%
  select(Date, Tag, Infl_spread, Infl_done) %>%
  unite(col = Infl, c(Infl_spread, Infl_done), sep = '_') %>%
  spread(Date, Infl)
# uhhh some of thes look pretty whack - wtf is happening with 1183
# that is def whack lmao - 100% bad looking
# (the 29 is def what is written on the data sheet)
# it's conceivable that the 1098 record is 1183... 1 rac, 0 spread, 4 done
# is there any plant with 29 flowers at any points?
# hmm... it would make sense that 1083 got recordd as 1183 (1083 is missing on 6/14)
# thn maybe 1098 got recorded somehow as 1183 - it makes a very parsimonious dataset
# ahhhh except that the 29 fl record has only 1 stem whereas all other 1083s have 2
# we were so close...

# fix this later

# Tag 1561
# Okay - there are actually two distinct tags here!
# I guess manually make up my own tag?
# call it 1950 - a tag that was never created
campn = campn %>% mutate(Tag = ifelse(Tag %in% 1561 & Plot %in% 9, 1950, Tag)) # %>% filter(Tag %in% 1561) # filter(Plot %in% 9)

# Tag 1543
# the plot 32 record has good tag, plot 33 is something else
# notes from collections suggest it's either 1593 or 1547 (lean 1547)
campn %>% filter(Tag %in% c(1543, 1547, 1593) & Plot %in% 33) %>% arrange(Date, Tag)
# agh... this campanula data is annoying
# okay - 1593 doesn't have any done flowers in its first record after this
# but, 1547 has a record on the same day as the 1543 record
campn %>% 
  filter(Plot %in% 33, !(Tag %in% c(1521, 1552, 1597, 1550))) %>%
  mutate(Fl_open = Fl_straight + Fl_curled) %>%
  select(Date, Tag, Fl_open, Fl_done) %>%
  unite(col = Fl, c(Fl_open, Fl_done), sep = ', ') %>%
  spread(Date, Fl)
# none of those look great...
# try 1597
campn %>% filter(Tag %in% c(1543, 1597) & Plot %in% 33)
# nope - two july 21 records here

# ahhhh just nuke it
campn = campn %>% filter(!(Tag %in% 1543 & Plot %in% 33)) # %>% # filter(Tag %in% 1543)
  
### Start looking at dupes.
  
### Thermoposis dupes
therm %>%
  group_by(Tag, Date) %>%
  filter(n() > 1) # %>% View()

# woke! Not that many.

# Tag 1107
# both records are fine

