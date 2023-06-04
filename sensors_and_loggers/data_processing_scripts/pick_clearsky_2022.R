# Script for picking out reference times from reference data using 2022 ameriflux data
# init SN 4 Jun 2023

library(ggplot2)
library(cowplot)
library(dplyr)
library(tidyr)

rm(list = ls())

select = dplyr::select

usnr.2022 = read.csv('~/Downloads/niwot_USNR1_radiation_2022_5min.csv', header = FALSE) %>%
  select(paste0('V', c(2:6, 8))) %>%
  rename(Month = V2, Day = V3, Hour = V4, Minute = V5, Sec = V6, Rsw_25m = V8) %>%
  filter(Month %in% 6:10, Hour %in% 7:18)

head(usnr.2022)

usnr.2022 %>%
  mutate(Hour = Hour + 1 + Minute/60) %>%
  ggplot(aes(x = Hour, y = Rsw_25m)) +
  geom_line(aes(group = interaction(Month, Day), colour = factor(Month)), linewidth = 0.1)

# 
sensor.dir = 'sensors_and_loggers/data/'

gaga = dir(sensor.dir) %>%
  grep(pattern = 'plot\\d{3}', value = TRUE) %>%
  (function(x) x[!grepl('NA', x)]) %>%
  paste0(sensor.dir, .) %>%
  lapply(
    function(fn) {
      read.csv(fn) %>%
        mutate(Plot = gsub('sensors\\_and\\_loggers\\/data\\/', '', fn),
               Plot = gsub('202[12]\\-\\d{2}\\-\\d{2}', '', Plot),
               Plot = gsub('\\_|raw\\.TXT', '', Plot)) %>%
        filter(grepl('SP510', Sensor_ID),
               grepl('volt', Reading_type),
               ((Hour_UTC - 6) %% 24) %in% 7:19)
    }
  ) %>%
  do.call(what = rbind)

gogo = dir(sensor.dir) %>%
  grep(pattern = 'plot\\d{2}R', value = TRUE) %>%
  (function(x) x[!grepl('NA', x)]) %>%
  paste0(sensor.dir, .) %>%
  lapply(
    function(fn) {
      read.csv(fn) %>%
        mutate(Plot = gsub('sensors\\_and\\_loggers\\/data\\/', '', fn),
               Plot = gsub('202[12]\\-\\d{2}\\-\\d{2}', '', Plot),
               Plot = gsub('\\_|raw\\.TXT', '', Plot)) %>%
        filter(grepl('SP510', Sensor_ID),
               grepl('volt', Reading_type),
               ((Hour_UTC - 6) %% 24) %in% 7:19)
    }
  ) %>%
  do.call(what = rbind)

all.field = rbind(gaga, gogo)

head(all.field)

subs.ref = merge(
  usnr.2022, all.field %>% distinct(Month_UTC, Day_UTC),
  by.x = c('Month', 'Hour'), by.y = c('Month_UTC', 'Day_UTC')
)

nrow(usnr.2022)
nrow(subs.ref)

subs.ref %>%
  filter(Month %in% 6, Day %in% 6) %>%
  mutate(Hour = Hour + 1 + Minute/60) %>%
  ggplot(aes(x = Hour)) +
  geom_line(aes(y = Rsw_25m)) +
  geom_label(
    data = . %>% filter(Minute %in% 2),
    aes(x = Hour, y = Rsw_25m, label = floor(Hour))
  )
