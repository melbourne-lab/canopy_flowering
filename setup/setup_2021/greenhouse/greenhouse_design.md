# Experimental design for a greenhouse study

The hypothesis being tested here is that there is "genetic structure" associated with an environmental variable. Schemske (1984) did something a little simpler here, looking just at spatial structure by comparing heirarchical variance terms.

Schemske's design had three transects and several plants from a family within a transect. He then fit a multi-level ANOVA to look for variation in 17 quantitative traits at these two scales (among plot, within plot). He seems to have concluded there was "genetic structure" if there was a significant i.e. non-zero (!) variance term at the among-transect level. This seems like a very low bar to clear, but, hey. What are the conclusions to finding within-plot among-family variance? Would be cool to look at this. The reported results (e.g., see Table 6) also include % of total variance explained at each level.

Notably one part of Schemske's analysis looks at within-transect among-family variance at the different transect levels. Here an environmental variable (a gradient going from open to closed canopy) influences the degree of within-plot variance. This could (may need to be?) incorporated into an analysis we perform.

### A plan for a basic analysis

We can possibly perform an analysis similar to Schemske's. We have plots and, in some cases, multiple plants per plot. From each of those plants, where available, we can get multiple offspring. These are the same as Schemske's levels: plots (similar to his transects), families (parent plants) within plots, and plants within a family (i.e. of the same parent plant). The parentage may possibly be complicated by clonality. I think that's just a risk we'll have to take.

Index the `p`-th plot by `p = 1, ..., P`. Say within plot `p`, the `q`th parent is indexed `q = 1, ..., Q_p`. 

Let y_i be a quantitative trait (TBD, but one of several) of plant i. A model with no predictors would have:

```
y_i = b_0 + e_i
e_i ~ N(0, sigma^2_y)
```

the residual term `e_i` would have all variance in the trait in it. The R code for this model would be `y ~ 1`.

A model that treats all parent plants within a plot as IID, but with a plot level random effect, would take form

```
y_i = b_0 + a_{p,p[i]} x_{p,i}
a_p ~ N(0, sigma^2_p)
e_i ~ N(0, sigma^2_y)
```

This is similar to Schemske's model but incldues plot as a random effect instead of a fixed effect (allowing for partial pooling in estimating plot means, although I'm not sure these means are incredibly important to us). Here, `sigma^2_p / (sigma^2_p + sigma^2_y)` gives a proportion of the total variance that is due to differences among plots. I'll return to these shortly. The R formula would be `y ~ (1 | plot)`.

A model that incorporates variation within plots (due to parents) would look like

```
y_i = b_0 + a_{p,p[i]} x_{p,i} + a_{q, q[i]} x_{q, i]
a_p ~ N(0, sigma^2_p)
a_q ~ N(0, sigma^2_q)
e_i ~ N(0, sigma^2_y)
```

The variance structure is similar to above, but with a new term `sigma^2_q` for variance among families within a plot. This variance term is nested within variance at the plot level; the corresponding R code is `y ~ (1 | plot / family)`. 

Now for the environmental portion. I am not exactly sure how to draw inference, or what specifically the quantity of interest would be as far as genetic structure goes, but we can still incorporate this into the models above. 

There are two possible variables to incorporate: the environmental variable at the plot-level (almost surely in this model some aggregate measure of solar radiation) and a parent plant-level measurement of flowering date (initiation, mean, or peak). I am hypothesizing that the environmental variable is a sort of ultimate cause of population structure, but it acts through the proximate cause of the flowering time. That is to say these two are very likely to be correlated with each other. Subsequent analysis will have to deal with that.

But with that in mind, we can potentially reduce a lot of variance at one or both of the plot and parent level by incorporating these environmental variables into the analysis. Say that `x_i` is the value of the environmental variable at plot `i` (without loss of generality - everything that follows should also apply for the flowering time data), for which we want to incorporate a fixed effect in the model. If this fixed effect is `b_1`, then the model would become

```
y_i = b_0 + b_1 x_i + a_{p,p[i]} x_{p,i} + a_{q, q[i]} x_{q, i]
a_p ~ N(0, sigma^2_p)
a_q ~ N(0, sigma^2_q)
e_i ~ N(0, sigma^2_y)
```

For the environmental variable, incorporating this fixed effect will reduce the estimate of `sigma^2_p` if the environmental variable does have an influence on genetic structure. Likewise for the flowering time, which applies at the plant level but also likely varies by some degree from plot to plot if the effect is environmentally-mediated, then the variable will reduce `sigma^2_p` and `sigma^2_q` simultaneously depending on the spatial variance in flowering phenology.

I feel like the reductions in variance due to incorporating these fixed effects are actually more interesting and informative for this question than the fixed effects themselves, but I don't know what the best framework for doing this is. 
