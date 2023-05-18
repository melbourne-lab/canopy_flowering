# Converting GPS coords (lat/long) into UTM (easting/northing)

library(ggplot2)
library(dplyr)
# need to install rgdal fully

##### May 17 2023

# Coords shot May 16
coords.05.16 = read.csv('data/spatial/2021-2022_plot_coords_2023-05-16.csv')

head(coords.05.16)

coords.05.16 %>% arrange(Name) %>% select(Name)

# What's missing? 2021 plots
setdiff(c(1:11, 14, 16:82), coords.05.16$Name)

# [1]  7  9 11 14 16 18 19 21 23 27 29 30 31 32 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50
# [31] 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80
# [61] 81

# 7 - plain ol forgot
# 9 - couldn't find (snow?)
# 11 - couldn't find (snow?)
# 14 - snow
# 16 - 19: other side of creek
# 21 - couldn't find - under snow?
# 23 - under snow
# 29 - 32: under snow

# What's missing? 2022 plots
setdiff(101:170, coords.05.16$Name)

# [1] 105 106 111 113 115 116 117 118 119 120 121 122 123 124 125 128 129 131 133 134 135 136 137
# [24] 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160
# [47] 161 162 163 164 165 166 167 168 169 170

