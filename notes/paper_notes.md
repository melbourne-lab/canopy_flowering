# Paper notes

Notes from reading related to the canopy and flowering project.

### Inouye, 2001. Response surface experimental designs for investigating interspecific competition. Ecology.

Context here is that two-species competition experiments typically use additive or substitution designs, which have been widely critiqued. This paper highlights why response designs are better.

##### Review of designs

Objective of the experiment are crucial to evaluate. 

In competition experiments, three possible objectives: (1) Measure effects of competitor Y on focal species X without interest in effects of X on Y. (2) Distinguish between intraspecific and interspecific competition. (3) Estimate parameters for a model given that its functional form has been chosen.

**Substitution design** with two species holds overall number/density of individuals constant while varying ratios of species. **Additive design** holds one species density constant, varies density of the competitor. Both of these designs trace a line in the X,Y plane (substitution is a x+y=1, additive is a x = 1).

Substitution designs confound variation in intraspecific and interspecfic density, giving results only to one density and giving inference only at an arbitrarily chosen single-species density (on boundaries). Additive designs give insight into effects on focal species across overall density range, but don't give insight into intraspecific competition on focal.

**Response surface designs** sample a grid over X,Y space. This does not necessarily require factorial designs; any design where treatments do not fall on a line are response surface. This allows the experimenter to distinguish between inter- and intraspecific competition. An advantage of this is that this allows estimation of model parameters in mechanistic (e.g., population dynamic) models. More levels are good for cases of non-linearity in response (competition or density dependence in this case) on either axis. 

### Celis, J., et al. 2017. Intraspecific trait variation and the differential dcline of meadow species during confier encroachment. Plant Ecology.

Hypothesis: trait variation (wrt light acquisition: SLA, leaf mass, height, clonality) within species will predict the sensitivity to shading. They measured a small (15-17 per species!) number of individuals to get trait variation. They got sensitivity (ISP or something like that) by using a loess smoother to get the mean percentage of (non-zero) cover over space, then calculating the coefficient of variation of predicted cover. 

However, there was no relationship between this measure of sensitivity and trait variation. Note that SLA *did* change with shading in all species, but this wasn't related to response to shading. Other traits did not change with shading. It's possible that the lack of relationship was only because of small sample size (13 species).

Very interesting premise though! Worth interrogating what the implication here because I don't know if it's adaptive capacity or phenotypic plasticity. Plasticity seems like it may be measured somewhat differently.

Some other thoughts

* Clonalty: spreading in a directed way (refs herein) can be a way of moving into higher-light areas
* Changes in height: some species showed directional trends in height, but, the direction varied. Interesting! Some got taller, some got shorter. Think about why this may be. Resource allocation and usage - shorter ones are limited by the limiting resource.

### Celis, J., et al. 2019. Consequences of reduced light for flower production in conifer-invaded meadows of the Pacific Northwest, USA. Plant Ecology.

Analysis here is kind of strange and at times not straightforward. Looking at responses in number of flowers, density of flowers, and flowering effort per plant across the light gradient. Also distance to edge at M1 which is much more stark difference. Looking at light penetration here as measured by canopy photographs.

Light penetration did have significant effects on probability of individuals flowering as well as cover and effort; the relationships for the latter two species, though, were weak. Pr. flowering was a stronger effect but there was still considerable variation. Distance to edge had a lot less explanatory power.

Also tried looking at scatter plots of individual sp. responses against light penetration (to calculate CV/ISE). All of the responses generally increased with cover although couldn't be fit to the same curve.

Some other notes

- Refs herein for community change and biodiversity in meadows and forest clearings
- Also some refs on response to shade cross taxa (e.g., Albrecht et al. 2016 and some *Astragalus*)
- Lots of reference in here to the fact that most of the change in light penetration happens early in the encroachment process, when trees are first establishing

### Stone, W.B., and Wolfe, M.L. 1996. Respons eof understory vegetation to variable tree mortality following a mountain pine beetle epidemic in lodgpole pine stands in northern Utah. Vegetatio, 122: 1 - 12.

Looking at stands of lodgepole pine with a recent (2-9 years prior) pine beetle outbreak of varying severity (0-90% tree mortality). Several studies demonstrate (refs herein - especially in intro) that there's a lot more biomass production under beetle-killed trees, but what about diversity? They surveyed tree mortality and vegetation stuff below said stands.

As with other studies, there's more biomass production (exponentially) as mortality increases. However, the *diversity* (and richness) as well as patchiness (measured by CV in cover) were highest at intermediate levels. Supposedly, this was because at higher densities there's less diversity in niches and a smaller collection of species can dominate. Note that models here look a little whack although trends are clear. More open areas have tons of grass. Lots of fruiting from shrubs.

So - beetle kill is another thing that can quickly open up canopy changing vegetation and reproductive dynamics. 
