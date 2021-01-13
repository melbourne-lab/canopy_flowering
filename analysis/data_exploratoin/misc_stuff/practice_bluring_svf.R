smooth.2d(
  Y = grid.points$svf,
  ind = grid.points$ElementNo
)

woke = smooth.2d(
  Y = grid.points$svf,
  ind = grid.points[, c("X_East", "Y_North")],
  theta = 0.1
)

head(woke)
image(woke)

# woke0 = with(grid.points, matrix(0, nrow = length(unique(X_East)), ncol = length(unique(Y_North))))
# i = 1; j = 1
# for (k in 1:nrow(grid.points)) {
#   if (j <= 377) {
#     woke0[i,j] = grid.points$svf[k]
#     j = j + 1
#   } else {
#     i = i + 1
#     j = 1
#     woke0[i,j] = grid.points$svf[k]
#   }
# }

woke0 = with(grid.points,
             matrix(grid.points$svf, 
                    nrow = length(unique(X_East)), 
                    ncol = length(unique(Y_North)),
                    byrow = TRUE)
             )

image(t(woke0))

woke0 - woke

woke = smooth.2d(
  Y = grid.points$svf,
  ind = grid.points[, c("X_East", "Y_North")],
  theta = 0.1
)

#####

d1 = exp(-1 * 
  matrix(c(2*sqrt(2), sqrt(3), 2, sqrt(3), 2 * sqrt(2),
           sqrt(3), sqrt(2), 1, sqrt(2), sqrt(3),
           2, 1, 0, 1, 2,
           sqrt(3), sqrt(2), 1, sqrt(2), sqrt(3),
           2*sqrt(2), sqrt(3), 2, sqrt(3), 2 * sqrt(2)),
         nrow = 5, ncol = 5
         )
  )
d1 = d1 / sum(d1)

orig = with(grid.points,
            matrix(grid.points$svf, 
                   nrow = length(unique(X_East)), 
                   ncol = length(unique(Y_North)))
)

newg = matrix(0, nrow = dim(orig)[1], ncol = dim(orig)[2])

for (i in 3:(dim(orig)[1]-2)) {
  for (j in 3:(dim(orig)[2]-2)) {
    newg[i, j] = sum(orig[i + (-2:2), j + (-2:2)] * d1)
  }
}

image(orig)
image(newg)

image(newg - orig)

sum((grid.points$svf - matrix(orig, ncol = 1))^2)
grp = grid.points
grp$svf.blur = matrix(newg, ncol = 1)

hist(grp$svf - grp$svf.blur)

ggplot(grp) +
  geom_raster(
    aes(
      x = X_East,
      y = Y_North,
      fill = svf.blur - svf
    )
  )

