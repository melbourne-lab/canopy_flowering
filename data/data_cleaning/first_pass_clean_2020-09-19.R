## Init script for looking at Elk data and cleaning
## SN - September 19, 2020

## Load packages
library(ggplot2)
library(dplyr)
library(tidyr)

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

# 