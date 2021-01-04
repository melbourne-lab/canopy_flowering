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

### Santandreau, M., and Lloret, F. 1999. Effect of flowering phenology and habitat on pollen limitation in **Erica multiflora**. Canadian Journal of Botany.

- Env. factors limiting seed set: pollen lim., resource lim., prdation, environmental harshness (e.g., low temps.)
	- Pollen limitation: few pollinators, few pollen donors, inefficient pollinators, self-incompatibility
- Plants flowering at peak may have highest rates of outcrossing
	- But, may also be competing for resources most (possibly resources selectively allocated to certain ovules; Copland and Whelan 1989)
	- Asynchronous flowers may have reduced competition for pollinators
	- Asynchronous flowers are also less likely to face predation
- *E. multiflora* occurs in pine forest and shrublands
	- Santandrea 1997 shows that floral production is lower in forests than shrubs
	- Less light in forests
- Main question: how does poll. activity, flower density influence seed and fruit set in *E. multiflora*
	(1) Look at self-incompatbility (using pollen from same fl., same infl., same plant)
	(2) Variation in pollinator activity during fl. period and btwn. pine forest/shrub
	(3) Pollen limittion through flowering period
##### Methods
###### Breding system
- 15 plants of simlar size selected at peak flowering in shrubland site
	- on each plant, five terminal inflorescences enclosed in bag before anthesis
	(1) control - natural pollination
	(2) hand pollination w/ pollen from other plant
	(3) hand pollination w/ pollen from other infl. same plant
	(4) hand pollination w/ pollen from same infl.
	(5) hand pollination w/ from same flower
	- Treatments applied on three separate days
- Seeds collected
	- Response: mean # seeds per five fruits
	- Response square root transformed
	- randomized block ANOVA: breeding system fixed effect, plant is block
###### Pollen vector
- Five shoots selected from 24 randomly selected plants
	- Inflorescences (with >5 mature flowers) counted periodically
		- (What was counted? # flowers?)
- 45 random plants selected
	- Three flowering periods (early/mid/late), 15 plants each assigned
	- Per plant, three inflorecences assigned to
		(1) control
		(2) mesh enclosure (wind, no insect)
		(3) bag enclosure (no wind or insect)
- Seed set and fruit set analyzed by ANOVA
	- flowering period (fixed effect), poll. vector (fixed), plant (random)
- Five flowering plants at peak of flowering period selected in each env. type
	- experimental setup above repeated at each site
	- all sites >1 km apart
###### Insect pollinators
- Six flpl selected for each habitt stand in each locality and each fl period
- All insect visits in a 15 minute period per plant counted on several watch days
- # insect visitors / flowering period counted via ANOVA
###### Pollen limitation
- Selected 15 plants in each period (45 total) in shrubland habitat
- Two terminal inflorescences got control or supplemental pollen
- Same seed set model as above described
- Five plants at peak of flowering period studied in each habitat type
##### Results
###### Breeding system
- Most seeds in control + outcross, fewer in same plant treatments, ~none in same flower treatments
###### Pollination visitors
- In main shrub site: ns differences between early/peak but def fewer visits per plant and per infl. in late
- Sign. effct of vector (enclosure) on sed set and % filled fruits
	- natural pollination produced higher seed set
	- bag treatment produced more seed and fruit than mesh (interesting)
	- effects changed over time
		- control had highest seed + fruit early
		- bag was similar to open for peak and late
	- many fewer seeds in late flowering plants than early
- No differences (in vector experiment) by habitat type but yes by locality
- Fewer visitors in pine forest than shrubland
	- pine forest visitation barely changes over time
###### Pollen limitation
- Fewer filled seeds per fruit at peak than early (like with EP studies!)
- Hand pollination increased seed and fruit set in late periods but not early or peak
- No differences in seed or fruit set by habitat type (interesting!)
	- hand pollination did not increase seed set overall at either habitat type
##### Discussion
- *E. multiflora* primarily has outcrossing but can do some selfing if between flowers
- As in other studies (Gross and Werner, 1983, Herrera, 1988), insect exclusion has differing effects over time
	- at the end of the fl period, bagging had no effect on seed set - insects less important at end of season
		- makes sense - fewer pollinators observed at end of study (see Motten et al. 1981 - temperature?)
	- but pollination is very important pre-peak - bagging reduced seed set pre-peak but not at peak
- Pollen limitation varies over time
	- pre-peak, highest rate of visitation, but slightly more fruits filled per inflorescence when supplemented
		- perhaps pollinators here are carrying too little pollen?
	- no pollen limitation at peak
		- resource lmitation could be high here - fruit per plant at its peak
		- self-pollination could be more prevalent here - most fruits per plant
		- but also pollen-added plants could influence stuff
	- pollen limitation is very high at the end of the study
		- few pollinators around, but also low competition for resources
- Lower floral density and less pollination by habitat type, but no influence on reproductive output
	- it's possible there is movement from shrubs into nearby pine forests
	- could be more selfing and within-plant competition in shrubs (more competitors)
	- hand pollination at peak didn't show differences between habitats
		- i.e., habitat type doesn't necessarily induce (marginal) limitation
		- so resources may explain low output in shrub populations

Wow - lots of interesting stuff in here... The resource angle is very important. Higher overall flowering in open areas (not to mention heterospecifics!) may increase pollen visitation but that also comes with resource limitation. (N.b. what are the resources? this is never defined here... unlikely to be light). So what is more important - pollination or resources? This varies over time according to the size of the pollen pool. Early and late there is less floral competition. Early there is still pollination, so seed set is very high early. But at peak there's high competition and high competition. Late there is low competition but also low visitation, inducing limitation such that pollen addition increases seed set here (but at no other times).

The time vs. limitaton aspect here is super interesting. The shade-peak may still have plenty of plants around, although there will be fewer of these plants. So shade peak would have higher reproductive success than shade tail. Also for a low-autocorrelation environment (patchy), shade peak can exchange genes with open tail (and likewise for shade head and open peak, I'd bet). This is when most of the genetic exchange between habitat types would occur.


