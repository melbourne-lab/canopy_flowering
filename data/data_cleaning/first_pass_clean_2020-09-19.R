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



table %>%
  group_by(Tag) %>%
  
therm %>%

