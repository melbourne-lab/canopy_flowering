
library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls())

grid.points = read.csv('data/solar_data/elk_coords_svf.csv')

head(grid.points)

plot.points = read.csv('data/spatial/2020_plot_coords.csv') %>%
  filter(grepl('^p', Label)) %>%
  select(-Z.Altitude)

head(plot.points)

# Okay, idea: Round up and down (keeping original coords), merge,
# then for each plot with multiple hits in the merge, keep the one that's closest
double.merge = plot.points %>%
  mutate(X_round = round(X.Easting), Y_round = round(Y.Northing)) %>%
  merge(
    y = grid.points %>% 
      select(ElementNo, X_East, Y_North) %>%
      mutate(x_up = ceiling(X_East), y_up = ceiling(Y_North)),
    by.x = c("X_round", "Y_round"), by.y = c("x_up", "y_up"),
    suffixes = c("", "_up"),
    all.x = TRUE
  ) %>%
  merge(
    y = grid.points %>% 
      select(ElementNo, X_East, Y_North) %>%
      mutate(x_down = floor(X_East), y_down = floor(Y_North)),
    by.x = c("X_round", "Y_round"), by.y = c("x_down", "y_down"),
    suffixes = c("", "_down"),
    all.x = TRUE
  )

# double.merge %>%
#   rename(ElementNo_up = ElementNo,
#          X_East_up = X_East,
#          Y_North_up = Y_North) %>%
#   pivot_longer(cols = starts_with(c("ElementNo", "X_East")),
#                names_to = c("eldir", "xtype"),
#                names_sep = '-',
#                values_to = c("elno", "xcoord"))
#   pivot_longer(cols = starts_with(c("ElementNo", "X_East", "Y_North")),
#                names_to = c("x", "y", "z"),
#                names_sep = "-",
#                values_to = c("a","b", "c"))

solar.plots = double.merge %>%
  # Get errors introduced by rounding
  # I.e., how much are each of the grid cells (corners?) off from the coordinate of the plot
  mutate(err_up = sqrt((X_East - X.Easting)^2 + (Y_North - Y.Northing)^2),
         err_dn = sqrt((X_East_down - X.Easting)^2 + (Y_North_down - Y.Northing)^2),
         down_correct = err_dn < err_up) %>%
  select(-c(X_round, Y_round, X_East, X_East_down, 
            Y_North, Y_North_down, err_up, err_dn)) %>%
  gather(c(ElementNo, ElementNo_down), key = 'dir', value = 'ElementNo') %>%
  mutate(is_down = grepl('down$', dir)) %>%
  filter(down_correct == is_down) %>%
  select(-c(down_correct, is_down, dir)) %>%
  merge(y = grid.points, by = "ElementNo", all.x = TRUE) %>%
  rename(X_plot = X.Easting, Y_plot = Y.Northing,
         X_solr = X_East, Y_solr = Y_North) %>%
  # Rearrange cols
  # (note: removing elementno here - may be worth keeping if the df expands
  # to include more info from the solar radiation model)
  select(Label, svf, X_plot, Y_plot, X_solr, Y_solr, Z_elev)

# Plot stuff.

grid.points %>%
  mutate(Canopy = 1 - svf) %>%
  ggplot() +
  geom_tile(
    aes(
      X_East,
      Y_North,
      fill = Canopy
    )
  ) +
  geom_point(
    data = solar.plots,
    aes(
      x = X_plot,
      y = Y_plot
    ),
    size = 4,
    shape = 22,
    fill = 'orange'
  ) +
  xlim(range(solar.plots$X_plot) + c(-10, 10)) +
  ylim(range(solar.plots$Y_plot) + c(-10, 10)) +
  scale_fill_gradient(low = 'gray88', high = 'forestgreen') +
  labs(x = 'Easting (m)', y = 'Northing (m)') +
  theme(panel.background = element_blank(),
        legend.position = 'bottom') +
  ggsave(file = '~/Documents/Research/shade/money/proposals_2021/elk_2020_map.pdf',
         width = 6, height = 6)


### Now load in plant obs. data.

therm = read.csv('data/processed_data/therm_draft_01-12-2021.csv')
campn = read.csv('data/processed_data/campn_draft_01-12-2021.csv')

therm = merge(
  x = therm,
  y = solar.plots %>% mutate(Label = gsub('^p', '', Label)) %>% select(Label, svf),
  by.x = 'Plot', by.y = 'Label'
)

head(therm)

campn = merge(
  x = campn,
  y = solar.plots %>% mutate(Label = gsub('^p', '', Label)) %>% select(Label, svf),
  by.x = 'Plot', by.y = 'Label'
)

head(campn)

# Try summarising?

therm = therm %>%
  arrange(Plot, Tag, Date) %>%
  filter(Infl_spread > 0 | Infl_done > 0) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  mutate(Date_asd = as.Date(Date),
         Date_num = as.numeric(Date_asd),
         Date_num = Date_num - mean(Date_num))

lm(Date_num ~ svf, therm) %>% summary()

# Adding random effect
lme4::lmer(Date_num ~ (1 | Plot), therm) %>% summary()
lme4::lmer(Date_num ~ svf + (1 | Plot), therm) %>% summary()

therm.init.0 = lme4::lmer(Date_num ~ (1 | Plot), therm)
therm.init.s = lme4::lmer(Date_num ~ (1 | Plot) + svf, therm)

hist(summary(therm.init.0)$residuals)
qqnorm(summary(therm.init.0)$residuals)
hist(summary(therm.init.s)$residuals)
qqnorm(summary(therm.init.s)$residuals) 
qqline(summary(therm.init.s)$residuals)

therm.init.l = lme4::lmer(Date_num ~ (1 | Plot) + svf2, 
                          therm %>% mutate(svf2 = log(1 - svf)))
qqnorm(summary(therm.init.l)$residuals) 
qqline(summary(therm.init.l)$residuals)

AIC(therm.init.0, therm.init.s, therm.init.l)

summary(therm.init.s)

campn = campn %>%
  arrange(Plot, Tag, Date) %>%
  filter(Fl_straight > 0 | Fl_curled > 0 | Fl_done > 0) %>%
  distinct(Plot, Tag, .keep_all = TRUE) %>%
  mutate(Date_asd = as.Date(Date),
         Date_num = as.numeric(Date_asd),
         Date_num = Date_num - mean(Date_num))


campn.init.0 = lme4::lmer(Date_num ~ (1 | Plot), campn)
campn.init.s = lme4::lmer(Date_num ~ (1 | Plot) + svf, campn)

AIC(campn.init.0, campn.init.s)

