# VIsualizing Elk Meadow complex, space, etc.

library(ggplot2)
library(ggmap)
library(dplyr)
library(tidyr)
library(sp)

elk.boundbox = expand.grid(lon = c(-105.543333, -105.540341), lat = c(40.030426, 40.031635))

elk.boundbox

elk.map = get_map(elk.boundbox, source = 'google', maptype = 'satellite', zoom = 18)

ggmap(elk.map)

# meadow.oi.bb = data.frame(lon = c(-105.543333, -105.542619, -105.540356),
#                           lat = c(40.031635, 40.030310, 40.031304))

gg.elk = ggmap(elk.map)

meadow.oi.bb = data.frame(lon = c(-105.543333, -105.542876, -105.542361, 
                                  -105.540708, -105.540356),
                          lat = c(40.031635, 40.030518, 40.030132, 
                                  40.030785, 40.031304))

# Width of bb is ~250 m; divide into 40 pieces to get 40 ~6m spaces
# height of bb is ~150 m; divide into 24 pieces to get 24 ~6m spaces
meadow.oi.pt = expand.grid(lon = -105.54000 - (1e-6)*seq(3333, 356, length.out = 20),
                           lat = 40.03000 + (1e-6)*seq(1635, 132, length.out = 12))

# Bounding box for clump of trees in the middle (Aspen and pine)
meadow.oi.tb = data.frame(lon = c(-105.541859, -105.541502, -105.541226,
                                  -105.541190, -105.540781, -105.540716,
                                  -105.541642, -105.541501, -105.541898,
                                  -105.541989),
                          lat = c(40.031156, 40.031190, 40.031107, 
                                  40.030763, 40.030813, 40.030570,
                                  40.030403, 40.030673, 40.030736,
                                  40.030941)
                          )

# Getting points only in ROI.
meadow.oi.in = point.in.polygon(meadow.oi.pt$lat, meadow.oi.pt$lon,
                                meadow.oi.bb$lat, meadow.oi.bb$lon)
meadow.oi.pt = meadow.oi.pt[as.logical(meadow.oi.in),]

meadow.oi.cp = point.in.polygon(meadow.oi.pt$lat, meadow.oi.pt$lon,
                                meadow.oi.tb$lat, meadow.oi.tb$lon)
meadow.oi.pt = meadow.oi.pt[!as.logical(meadow.oi.cp),]


nrow(meadow.oi.pt)

gg.elk +
  geom_polygon(data = meadow.oi.bb, fill = 'gray99', alpha = 0.15) +
  geom_point(data = meadow.oi.pt, colour = 'red', shape = '+', size = 3)
