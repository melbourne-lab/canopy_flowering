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
- number insect visitors / flowering period counted via ANOVA
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

### Llorens, L., and Penuelas, J. 2005. Experimental evidence of future drier and warmer conditions affecting flowering of two co-occurring mediterranean shrubs. Int. Journal of Plant Sci.

- Climate influences start and performance of flowering in cool temperate climates (Walkovszky 1998, Tyler 2001, Rathcke and Lacey 1985)
	- includes temperature, photoperiod, rainfall
	- temperature: Ratchke and Lacey 1985, Fitter et al. 1995, Galan et al. 2001
	- temperature, experimentally: Alatalo nd Totlnd 1997, Welker et al. 1997, Sandvk and Totland 2000, Dunne et al. 2003
	- small influences of precip: Spano et al. 1999, Pico and Retana 2001, Penuelas et al. 2002
- Here, experimentally manipulate heat and moisture and flowering phen in two shrubs in Mediterranean shrub
	- Do warmer and/or drier conditions change flowering patterns, production, lifespan?
##### Methods
- Two dominant shrubs: *Erica multiflora* and *Globularia alypum*
- Climate manipulations:
	(1) extended summer drought: cover plots with transparent waterproof plastic curtains over spring and fall growing seasons
	(2) passive night tim warming: cover vegetation and soil wth aluminum curtains to retain infrard radiation
- Measure precipitaton with a bucket
- Measure soil moisture w/ time domain reflectometry every 1-2 weeks
	- depth? 0-15 cm
	- three fixed sampling points per plot
- Measure air temp and soil temps with thermstors
	- temperatures measured every 10 min
- 9 20m2 plots (4x5m)
	- Central 12m2 area of plots for plant monitoring
	- Monitored plots 1/wk
	- In total 23, 19, 23 *E.m* and 34, 34, 31 *G.a.* in resp. treatment plots
	- Estimated (!!!) % "functonal" flowers/heads w/ visible stamens rel. to total # flowers
	- Estimated (!!!) flower production as % of branches wth flowers (rel to all branches)
	- Estimate bins: 0%, 1-25%, 26-50%, 51-75%, 76-100%
	- Flowering period per plant
- Estimated number flowers by counting length & number of infl. and using allometric equations
	- individual lifespans: marked one closed flower/spring bud in 4-10 plants per plot at beginning of season, monitoring weekly
- Analysis
	- Survival analysis: warmer/drier conditions influence onset of flowering?
	- survival analysis: onset of flower senescence (first senescent fl. per plant)
	- survival analysis: time until (estimated) >75% of plants had sensecent
	- right-censoring: if event doesn't happen by end of study it's designated as last day
	- survival: Kaplan-Meier nonparametric for survival curves, Cox-Mantel for differences between treatments
	- Length of flowering: ANOVAs with blocking
##### Results
- Summer "drought" trt reduced soil moisture by 29% in year 1 and 17% in year 2
	- drought effects mostly Sept - February...
- Warming trt very slightly reduced soil moisture (11% and 8.4%)
- Warming trt increased minmum temperatures by 0.7C in air, 1.6C at 2cm below, 1.1C 10cm below
	- warming effects largest Oct - March but also somewhat in rest of year
- *E.m.* is unimodal synchronous flowering, *G.a.* is bimodal (spring and fall)
- Drought delays flowering in *E.m.* 2000 (p 0.02) but not 1999 
	- in 2000, KM test says eight day delay for median date of onset in drought (Oct).
	- in 1999, on (arbitrary) date, more plants senescent in control than drought
	- end of flowering period delayed by drought
	- warming didn't influence duration of phenophase
- In *G.a.* drought meant fewer flowers and flowers that opened later
	- all warmed plants had flowering heads in both years
		- in 1999, warmed plants had later autumn flowers but earlier winter flowers
- *E.m.* drought plants: longer phenophase in drought than controls in 1999, same in 2000
	- no effect of warming on phenophase duration
- *G.a.* 11-12 days shorter autumn flowering period in drought
	- warmer plants also had ~10 days fewer
- Fewer *E.m.* wth >75% of branches flowering (i.e., reproductive effort) less common in drought (both years)
	- other metrics of effort (e.g. fl / infl) show same pattern
	- no effects of warming on flower production
- No winter flowering for drought *G.a.*
	- control/warming have some (what is measurement here? ugh)
- In both spces longer floral lifespan n droguht than control, no effect of warming
- Shorter corolla lengths in *E.m.* treatment groups than controls (~10% reduction)
##### Discussion
- Higher production of winter flowers in *G. alypum* may have caused unimodal flowering in 2000
	- high winter flowering may have resulted from high rainfall in 1999
	- high reproductive effort and reserves for future reproduction: Snow and Whigham 1989, Sandvik 2001
- Drought means less leaf net photosynthesis, which may cause delay in flowering (Llorens et al 2003)
	- (remember this was only observed in one year)
- Warming affected *G.a.* but not *E.m.*; effect varied by flower type (fall/winter)
	- (one of these may be influenced by warming causing reduced soil moisture)
- Longer duration of flowers in drought - no real explanation here, looks like this is unusual
	- could be compensation (counteracting scarcity of pollinators)	
	- but ths lkely induces maintenance costs... no extra thought in here
- Smaller flowers under drought - kinda makes sense,
	- Galen et al. 1999 - larger flowers require greater water uptake
	- trade-off between floral maintenance and floral construction?

Not my favorite paper! Results are spotty and inconsistent. The mediterranean aspect also reduces relevance - longer phenophase and the multiple flowering periods complicate interpretation. I'm not sure how useful this is. Look into similar paper in alpine or arctic environments. Dunne et al. 2003 is probably a better reference. 

### Ison, J.L., and Wes, A.E. 2017. Temporal population genetic structure in ht epollen pool for flowering time: a field experiment with *Brassica rapa*. American Journal of Botany.

- Mean breeding value for mating/flowering phenology will change over the course of a season -> assortative mating
	- This produces an excess of early/late alleles (at certain points in time) than random mating
	- This *inflates* additive genetic variance in the assorting trait? How?
	- But also it leads to temporal isolation.
	- See Weis et al. 2014 for a look at pairwise mating opportunities and genetic correlation in 31 sp.
- Spatial distribution also influences mating patterns (e.g., Wes and Kossler, 204, Thomson and Thomson, 1989, Fenster, 1991)
	- Strength of phenological assortative mating my b greater in areas of high conspecific density
- Other things may cause deviation of offspring phenotypes from expectation
	- e.g., selection for floral traits, temporal variation in reproductive success
##### Methods
- \bar{z}^P_t is phenotypic mean of plants contributing to pollen pool on day t
	- \bar{z}^P_t is z_i for each plant (1, ..., N), weighted by i's open flowers on day t
	- for pollen grain sampled from pollen pool on day t, \bar{z}^P_t is expected phenotype of pollen donor
	- slope of \bar{z}^P_t over time is how much the mean phenotype changes over time
		- steep when variance in flowering time is high and flowering duration is short
		- is zero of mating pool is totally unstructured
	- breeding value \bar{A}_t is (\bar{z}^P_t - \hat{z}^P)*h^2
		- i.e., deviation of phenotype from grand mean, multiplied by heritability
	- slope $\bar{A}_t$ is indcative of genetic structure carried on to offspring
		- slope of 1 (req's h = 1) means total turnover, i.e., each day is an isolated pool
		- slope of 0 means no temporal genetic structure and/or no structure inherited by offspring
	- Prospective estimate of genetic structure: regress \bar{z}^P_t ~ t, multiply by h^2
	- Retrospective estimate: regress \bar{Z}^O (offspring phenotypes) ~ t
		- assumes breeding values are uncorrelated with pollen recipients, violated by assortative mating
- Gene trapping breaks the donor-recipient correlation
	- Using genetically uniform pollen recipients (dams)
		- Thus dam mean genotype is constant over time
	- These plants are male-sterile, so only receive pollen from pollen pool without donating
	- Gene trap line done by mating... not really sure why! This produced some mal-sterile segregants.
- Spatial component of experiment: two open-pollinated field experiments
	- Expmt 1: six plots of pollen donors in hexagonal plot
		- in three plots, pollen donors planted at 0.5m spacing
			- six gene trap plants in plots
		- in other three plots, pollen donors bunched into corner of hexagon
			- w/in corner, plants 0.17m apart; corners >2.7m apart
			- each gene trap has corner in center
		- In each plot, in each plant, first flowering date and newly opened flowers every 3-4 days
	- Expmt 2: "amplified" heritability - how much does it increse temporal shift in the breeding value
		- Two additional plots (one even, one clumped)
		- Assortatively-mated offspring put into field plots
		- "Amplified" heritability 1: w/in fam stabilizing selection
			- only planted progeny with identical flowering time to parent
			- elimnates contributions w/ extreme segregation and envronment
			- much higher covarance between parents and offspring
		- "Amplified" heritability 2: reduced developmental env. variance
			- all plants grown in greenhouse conditions to reduce env. variance
		- Recorded date of first flower and opening date of each flower per plant
	- In both expmts, took seven seeds from gene trap plants, recorded dates of first flower?
- Stats:
	- Measured phenotypic correlation of flowering time between potential mates (Weis and Kossler 2004)
	- Phenotypic shift in donors: regress donor flowering time ~ t
	- Effects of spatial arrangement on mean pheno of pollen donors: regresson...?
	- Strength of temporal genetic structure: regress \bar{z}^O_t ~ t
	- Spatial arrangement and progeny: prog. flowering time ~ date * space
##### Results
- Sign. shifts in phenotype of active pollen donors over time
	- mean strat date shifts 0.387-0.506 day/day
	- similar results in both experiments as well as amplified h studies
	- Stronger shift of donor phenotype/time in even rel. to clumped expmts
- Retrospective structure (offspring ~ t) evident in five of six plots
	- regression coefficients in amplfied heritability plots steeper than main expmt
	- no evidence of small-scale spatial clumping here
- Mean donor phno predicts flowering time in progeny
##### Discussion
- (What is "mean combining ability"?)
- Seasonal shift phenotype of pollen donors is translated into shift in offspring
- The prospective (donor-phenotype) estimate assumes every flower has equal probabilities in all-to-all mating
	- comparing prospective with retrospective tests these assumptions
	- retrospective test may also pick up genetic effects (e.g., epistasis)
	- the observed retrospective estimates falls w/in range of h2 obs. in wild populations
	- prospective est. falls w/in 2 sterr. of restrospective estimates
		- supports hypothesis of random all-to-all exchange
		- retrospective mean is higher... could there be more structure in wild population?
	- interestingly: differnce in prospective by space, no difference in retrospective by time
- Consequences of temporal structure
	- For mating time breeding value ~ t close to 1 means isolated breeding pools
		- drift at neutral loci -> divergence among pools
		- see Dainou et al. 2012 Suni and Whiteley 2015 for examples
	- Spatial structure too - close neighbors breeding omre likely if schedules overlap
		- see Almeida-Neto et al. 2004, Hirao and Kudo 2008 for examples
		- note no vidence of spatial arrangement influencing temporal structure in this study

Papers to read next:
- Hendry and Day 2005
- Weiss and Kossler 2004
- Rathcke and Lacey 1985 (also referenced above)
- Weis 2005
- Weis et al. 2014

Interesting ideas here... like the approach of testing assumptions of prosp. estimate with the retrosp. estimate. This does give a framework for thinking about changing phenotypes over time. Some empirical evidence of heritable variation in flowering times being transmitted through generations with potental for assortative mating. Assortative mating is a good thing to highlight in theory/discussion of Elk meadow work.

### Suni, S.S., and Whiteley, A.R. 2015. Genetc structure of a montan perennial plant. Conservation Genetics.

- Geographic distribution of genetic variation in a metapopulation is important for response to environmental change (Jay et al., 2012)
	- Portfolio effect (Shindler et al. 2010)
- Isolation by distance is often considered in landscape genetics, but isolation by phenology is less often considered (Stanton et al. 1997)
	- Assortative mating based on flowering time
	- Flowering time is highly heritable in some plants (Geber and Griffen 2003, also Jung and Miller 2009?), subject to slction (refs) and _can lead to genetic differentiation_
	- some refs on envronmental influencs on flowering time
	- Flowering time variation - usually considered on continental scale, but also can happen on local (~10 km) scales
	- _Shimono et al. 2009_ looks at snowmlt timing and patterns in variation
	- Need to consider relative influences of pollen movement and seed movement for landscape genetic structure
- Here: consider spatial distribution of variation in *Ipomopsis aggregata* in Colorado
##### Methods
- *I. aggregata* - monocarpic, self-incompatible, hearty rosette only for several years until flowering
	- one flower typically open 3-5 days, plants flower 4-6 weeks
	- Seeds fall near parent plants so gene flow is mostly through pollen
- Study at RMBL
	- sampled tissue from 297 individuals, ~20 plants / 14 sites
	- sites: 2.6 - 130 km apart
	- at each site, sample plants within a 50m radius
	- sampld phenology for all plants in meadow at one site
###### Molecular analysis
- eight microsatellite loci developed (Wu 2006)
	- details on PCR
	- use GENEMAPPER and Geneious software for microsatellite lengths (?)
###### Genetic differentiation
- Looking for departures from HW
	- look for HW departures at complete-sampled site between early and late plants
- linkage disquilibrium
- F_{IS} averaged over loci for each site, looking for differences in heterozygosity and allelic richness
- F_{ST} (some intricat stuff here - G_{ST} as unbiased estimator)
- Bayesian clustering to find population structuring
- Landscape structure:
	- geographc distance F_{ST}, F'_{ST} ~ distance
	- genetic differentiation ~ elevation
		- pairs of sites
		- cumulative elevation change among pairs (?)
- Phenology
	- At one focal site, designtd early/late groups of plants (>1 week difference in onset)
		- these groups were intermixed through meadow
		- look at F_{ST} between sites
	- sampld leaf tissue from plants on day of flowering at 13 sites
		- distance matrix: days apart (of frst flowering) compared with mantel tests
		- some prmutation approaches to account for high type I error/low power
##### Results
- Deviations from HW at some sites due to a deficit of heterozygosity (F_{IS) btwn 0.002 and 0.29)
	- F_{IS} higher, heterozygosity lower, allelic richness marg. sign. lower n disturbed sites compared to meadows
- Moderate (F_{ST} betwen 0 and 0.13, mean 0.04) with pairwise F'_{ST} between 0 and 0.53 (mean 0.19)
	- after correcting for type I error, 90% of tests were significant (non-zero F_{ST}?)
- STRUCTURE test says K = 2 or K = 3 if locatoin is used as a prior but K = 1 if not
	- no correlation between allelic richness and proportion of genome assigned to second group, i.e., not supporting hypothesis that drift drove STRUCTURE results in one cluster type
- No evidence of isolation by distance; geographic distance and F_{ST}/F'_{ST} not correlated
- No elvation effects on genetic distance
- At focal meadow, F_{ST} = 0.05, F'_{ST} = 0.23 between early and late flowering plants
- Flowering time associated with genetic structure across populations
	- i.e. correlation between diff. in flowering time and F_{ST} and F'_{ST}
	- correlations remain after controlling for geographic distance and elvaton
	- phenologcal distance had a higher regression coefficient than geographic distance in MMRR
##### Discussion
- Phenology a better predictor of genetic relatedness than landscape features
	- seen on both small (~80m) scale and large (~130)
- In *I. aggregata*, hertability of flowering estimated to be approx 0.3, influenced also by snowmelt timing
	- elevaton and flowering time are correlated
	- but no strong evidence of levation as a prdictor of gnetic relatedness
	- also possible hybridization occurring between *I. aggregata* and *I. tenituba*?
- Temporal isolation within populations: se Antonovics, 2006, Kovach et al., 2013
	- but note that plants can produce a lot of flowers flowering over a long period of time providing overlap between early- and late-flowering plants
	- alternative explanation is cohort effects (drft among cohorts)
	- also can't rule out micro-envronmental differences over time!
- What drives among-population differentiation?
	- third cluster (one population) does not appar to be due to inbreeding b/c only one HW departur and and one LD test 
	- but if the sit with the lowest F_{IS} is removd, F_{IS} is correlated with how much of the genome is assigned to group 2 suggesting inbreeding may be driver for this group
	- genetic drft may occur in peripheral populations (periphery of drainage)
	- gene flow in central drainage could occur via pollinator sharing
	- (N. Waser and some hummingbird work)
	- seed dispersal could occur through water
- Some stuff about evidence of inbreeding in small populations

Very cool and useful! Will go back to this on for genetic techniques. It seems like microsatellites on parents are good for looking at genetic relatedness (F_{ST} as a continuous measure may not work for us unless we choose extremes of shade distribution). But this will also be useful for establishing that over larger spatial scales, phenology structures populations (moreso than distance even). Great stuff.

### Albrecht, M.A., Becknell, R.E., and Long, Q. 2016. Habitat change in insular grasslands: woody encroachmnt alters th population dynamics of a rare ecotonal plant. Biological conservation.

- Rare ecotonal spcies: may require intermediate habitats or special, distinct microhabitats
	-  but environmental change can shift ecotones
- This study: ecotonl plant in a limestone cedar glade
	- mostly short-statured annuals
	- thin, rocky, infertile soil
	- typically narrow abupt transition zones between glade and forest (where deep soil supports perennials and grasses)
	- changing fire frequency -> woody encroachment
	- natural form of fragmentaton and Morris et al. 2002 shows evidence that outcrops used to be part of a larger matrix
##### Methods
- *Astragalus bibullatus* is small individual, known <5K remaining, mostly in a small area in Tennessee
	- typcially flower before tree laf out
	- little is known about population dynamics 
	- number of populations is small
- Six sites with 22 (total) 1m2 plots
	- plots vary between 13-88% tree cover
- Over three years, record
	- percent cover in plot (of veg. type/ground cover)
	- soildepth
	- soil chem
	- sling density, multi-stm veg. dults, flowering adults, n. stems, n. fruits
- Combine env. variables into a PCA/composite, look at demographic performance ! microhabitat with GLMs
	- separate models for each demographic variable + year
		- avoiding overfitting by capping models at five vars.
- Recruitment assessed using transect sweeps and tagging adults
	- up to 30 seedlings tagged each spring and followed for duration of study
	- reproductive adults: count n. inflorescences, infructescences, number of fruits, seeds per fruit
- shade manipulation study in 36 plots
	- crossing presence/absence of cedar x cover (summer or spring cover)
	- cedar cover treatments achievd with cloth 
	- each plot: three seeds and three vegetative adults in pots
	- recorded above and belowground biomass in subeset of surviving plants
	- preliminary results show no difference within cedar groups so treatments collapsed to CE only
	- modl: germination, survival, final stem number
	- models were on plot means averaging across surviving individuals
##### Results
- Adult vitals (stem numbers, reproductive adults, legumes) affected by canopy cover, seedlngs not (Table 2)
	- forb cover is consistent predictor of seedlng numbers
- (Figure 2) somewhat more stems per adult in mowed (i.e., somewhat less canopy) plots, somewhat more fruits per plot
	- more seedlings per plot in unmowed (higher canopy) plots
	- proportion of seedlings declined moving from closed to open canopy
		- greater seedling survival in closed rel. to edge/open sites
	- more inflorescences, more fruits in open sites
- (Fig. 4) proportionally opn plots had a lot more adult plants, more flowering plants
	- more fruit per plant n open rel. to edge
- Pot study: sedling emergnce ddn't vary by CE, but survival was greater without CE (added cloth)
	- fewer stems in CE+ than CE- (in seedlings only, n.s. in transplants)
	- higher root:shoot ratio in CE- than CE+
##### Discussion
- Rock outcropping endemics requre high light and are poor competitors
	- open microhabitats provide more light
	- however, open habitats also have several light-requiring competitors, lowering seedling recruitment
	- for *A. bibullatus* nitrogen availability in open soil may also have fostered competitors for microsites
- Despite rare flowering, seedling densities in shade suggest that there isn't seed limitation in shade
	- dispersal from nearby unlikely
	- soil seed banks persisting for decades? (Morris et al. 2002)
	- historically cedar coverage was lower - suggests that historic conditions may have been good for reproduction

Interesting. Provides support to the idea that shading influences demographic processes. Also some thoughts here on shade encroachment. Very interesting point that despite reproduction and size being larger in open areas, seedling density was not. This is because open areas have higher forb coverage and fewer available microsites. Think about ths in the context of meadows - likely hgher density of competitors (con- or heterospecific) which impedes recruitment. However, there's also a layer of leaf litter in aspen understory - this may also block out light needed for recruitment there. In either scenario the take-home here is that higher flowering in open areas does not necessarily mean an increase in recruitment.

### Hendry, A.P., and Day, T. 2005. Populaton structure attributabl to reproductive time: isolation by time and adaptation by time. Molecular Ecology. 

- Some examples of traits covarying with mating phenology: clutch size/egg laying day, body size/metamorphosis date, reproductive lifespan of fish/breeding day
- Could reproductive timing be flexible/plastic instead of highly heritable?
	- Temporal phenotypic clines
	- Could be constraints or adaptive tactics
	- Alternatively, trait expression could be due to environmental condition at a given time (also creating phenotypic clines)
	- adaptive tactics (altered trait expression)
- Alternatively: could be strong heritable controls over trait expression
	- an individual that should reproduce early (late) that instead reproduces late (early) - what kind of traits will they express?
- Reproductive fitness may be influenced by a combination of heritable variation, random environmental effects, individual choice
##### Isolaton by time
- In temporally-structured mating population with heritable variation, probability of two individuals mating is inverseley related to difference in heritable component of reproductive times
	- i.e., probabilty of mating is high when difference in heritable component of reproductive time is low
	- if heritable time is an additive trait (well supported! see Table 1) then this is also difference in breeding values
	- *isolation by time* is tendency for less reproductive as differences in timing get larger
- Similarities to isolation by distance: predictions similar, but differences in how to "disperse" in space/time
	- in IBD model, reproducing at a given location then offspring disperse with distribution centered at location
		- offspring inherit the location (jumping off point for their own dispersal)
	- in asexual IBT model, "dispersal" happens because environment causes them to reproduce at other times (*feel like this is relevant to us...*)
		- temporal dispersal inversely related to heritabilty of trait
		- however, if your reproductive timing varies from your breeding value (due to env. effects), your offspring still inherit your breeding value
		- i.e., offspring jumping off point is the same
	- in sexual IBT model, dispersal happens because mating between two individuals produces avg. breeding value at midpoint
		- offspring disperse from this new point
		- if reproductive activity is not uniform through time (e.g., more reproductive activity early), then the mean breeding value of offspring will be shifted directionally
			- (this latter case of directional dispersal seems like selection, like spatial gene flow)
- In general, lower heritability -> more temporal dispersal -> more gene flow -> less temporal structure
- How to demonstrate empirically? Heritability alone is insufficient
	- One way is relatedness of individuals ~ reproductive time
		- early vs. late seems like a good binning
	- in general this is a deviation from random mating to get part way there
		- look for heterozygote deficits
		- linkage disequlibrium when pooling samples w/in a time period
	- need to be wary of spatial confounding here
	- Temporal clines in allele frequencies, if found, may be genetic drift (assuming limited gene flow) or linkage (neutral alleles linked to those under selection)
	- pairwise approach? (what does this mean?)
- Demonstrating IBT in flowering times specifically
	- Geber and Griffen 2003 hav flowering time mean h2 of 0.40 (n = 139)
	- candidate genes influencing flowering time found in arabadopsis
	- some differences in genetic makeup of early vs. late flowring morphs
	- but, looking for genetic differences ~ flowering time *within a population* is rare (see Stanton et al. 1997)
		- but, can find genetic differences in the pollen pool although by themselves this does not confirm IBT
	- Flowering time causing departures from random mating! Gutierrez and Sprgue 1959, Ennos and Dodson 1987
##### Adaptation by time
- Limited gene flow -> adaptive divergence
	- adaptive divergence in space is well-documented
	- if selection varies through the season and there are temporal clines in phenotypic traits, adaptation by time may occur
- ABT rquires IBT and temporal variation in selection
	- observed trait clines should become stronger as optimal trait clines get stronger
	- mismatches betwen optimal and observed clines will grow if heritability decreases for reproductive (and IBT gets weaker) or phenotypic trait (selection response gets weaker) and/or if reproductive activity becomes less uniform (?? maladaptive gene flow is directional)
**Note: did not read remainder of this section, skimmed empirical flowering time work**

Interesting theoretical framework for IBT (ABT is less appealing for our specific study right now). The dispersal in time ideas in particular are interesting. Come back to this when thinking about empirical demonstrations in meadow systems.

### Hererra, C.M. 1995 (Jan.) Floral biology, microclimate, and pollination by ectotherm bees in an early-blooming herb. Ecology.

- "The importance of abiotic factors in plant-pollinator systems will presumably be greatest when flowering occurs primarily during climatically unfavorable periods" such that the environment limits pollinator activity
- Interior temprature of flowers as a trait to enhance floral visitaton (by ectotherms)
##### Study
- Flower: *Narcissus longspathus* perennial herb in SE Spanish mountains
	- flowering in lat February to mid-April
	- snowstorms do occur in this time period
	- single flowers on a scape, long-ish yellow perianth
- Pollinator: *Andrena bicolor* does 70-90% of all visits to *N. longispathus*
	- bask in or outside perianth during foraging
	- during *N. longispathus* flowering period *A. bicolor* appars to specialize
- Measured floral microclimate by measuring air temp inside and outside flowers
- Netted bees, brought them to lab, did cooling tests
	- mesured minimum flight temp and maximum voluntary tolerance
- In field, followed bees, recorded air tmp. and floral temp of visited flowers "as often as possible"
##### Results
- *N. longispathus* in >100 W/m2 (up to 900-1100 Wm2) settings: air warmer inside flowers than outside
	- generally increasing temperature inside flowers with more radiation
- There was considerable variation in air temp. within flowers, getting warmer closer to the anthers (further in the perianth)
- Significant relationship between air temp and thoracic temp of bees captured in field
	- qualitatively similar but slightly different regression lines depending on bee being caught in flower or in air
	- small but significiant difference between air temp in flight and in flower (1.2C +-0.23 warmer in flight)
- When foraging, bees spent 66% in within flowers, 17% basking n flowers, and 17% flying between flowers
	- with increasing air temp, more tme in flowers, less time basking
	- flight time not influenced by air temp
	- (wait - this was only on two days of observation??)
- After accounting for air temp and visitation rate, bees spent more time in warmer flowers
	- bees less likely to bask after visiting warmer flowers

Interesting stuff. I didn't know about the basking behavior. Also had never thought about temperature *inside* of a flower. I wonder if our pollinators do this. It seems like air temp did not influence the proportion of time spent in flight but a cooler air temperature did lead to more time spent in the warming areas of a flower. Given the relationshp betwen air temp and floral temperature it's a safe bet that the interior of plants in shade is cooler than the interiors of those in sun. Also if there's interspecific variation in floral temperature then pollinators may selectively forage in shade. Definitely a useful paper!

### Kilkenny, F.F., and Galloway, L.F. 2008. Reproductive success in varying environments: direct and indirect effects of light on plants and pollinators. Oecologia.

- Light can influence growth, allocation (lower light may necessitate more allocaton to photosynthtic tissue), and pollinator behavior
	- Potential interacton: more light -> more floral display -> more pollinator visits
- Objectives of study:
	1. Poll. visitation ~ light
	2. Poll behavior ~ light + floral display size
	3. Reprod. success ~ reprod. success
	4. Selection on phnological characters driven by light?
##### Methods
- *Campanulastrum americanum* annual/binnial, compact indeterminate inflorescences
	- protrandrous: male phase on day female phase 2-3 days (up to 6-9 days possible without pollination though)
	- populations can exst in heterogeneous light environments, e.g., under canopy
	- primary pollinators: Bombus, halictds
- Observed plants for ten minutes on seven different days
	- two environment types: sun and shade
	- recorded number and type of pollinators on each day
- Measured pollen removal for 15 plants in each habtat type
	- observed on one day
	- followed protocol of Evanhoe and Galloway 2002
- Does pollen limitation study
	- compared seeds produced per flower on augmentation vs. control
	- model: seed set ~ env. + poll. + poll*date + poll*env
	- compared with set of flowers with no hand pollination b/c plants with added pollen may allocate resources differently
- Experimental manipulaton of display size
	- grew *C. americanum* in greenhouse, transplanted to field
	- planted individuals 1m apart each
	- small display sze: removd flowers until only three were left
	- large display size: did not manipulate (mean 21.5 fl)
	- observed arrays of five plants for 20 min. (n = 112 arrays)
		- watch one plant, randomly chosen, recorded n. pollinators vistng and n. flowers visiteds
	- prior to obs period, measure PAR and temperature
- Phenology test
	- three measurements: date of initiation, peak day, duraton day
	- marked one flower, counted its seeds at end of season, used that to estimate seed production by whole plant
	- calculated phenotypic selection: relative fitness (to mean in env.) calculated, estimated selection diffrential as covariance of fitness and traits
	- looking to see if phenotypic selection varied by env. type through an ANCOVA (heterogeneity in slopes: looking for trait*env. interactions as difference in slope between environments)
##### Results
- Plants in the sun had 7x the vists of plants in the shade
	- more vsits wth larger displays
	- Bombus and halctids visitd sun plants more than shade but no difference for syrphids
- Pollinator visitation highest earliest in the season for both environment types
- Pollen movement and fitness differences
	- ~3x as much pollen removal in the sun than in the shade
	- in shade, pollen addition increased seed set by 50% whereas in sun pollen augmentation did not influence seed set
		- not due to resource limitation
		- pollen augmentation effects did not change over time
	- overall seed production lower in shade
- In experimental arrays, more Bombus visits per plant and per flower
	- no difference in visits between display size treatments
- Plants in sun were 17x larger and initiated flowering nine days sooner, flowered for twice as long, produced 9x the number of flowers
	- stronger selection differential in shade compared to sun
	- in sun, earlier flowering and longer flowering durations have greater fitness, but no evidence of selection on these traits
		- instead selection on plant size
	- in shade, plants flowering ealier had higher seed and fruit production, higher fruit production with longer duration
		- here, traits were under selection
##### Discussion
- Plants visit light moreso than they do shade
	- although this difference was taxon-specific (no effects on syrphid flies)
	- differences in removal rates does suggest that this influences fitness
	- differences wee due in part due to differences in floral display, although there was no difference in per-flower visitation
		- no evidence of increased reproductive success in open displays
	- Conclusion: direct pollinator-mediated effects on success, but no evidence of indirect effects mediated by response to display size
- Light directly influences reproductive success
	- Haggerty 2006 showed *C. americanum* are differentiated in common field environment (i.e., uncorrelated?)
	- Flowering time is heritable (Burgess et al. 2007)
- Selection pressure on phenology
	- more visitation early in the flowering season regardless of envronment + later initiation of flowring in shade means phenotypic selection for early flowering in shade
	- selection on duration (longer duration -> more seeds) explained by pollen limitation

Fuck. Okay this is 100% exactly what I wanted to do plus stuff I hadn't thought of explicitly. Goddamnit. 

Interesting and good to incorporate display size into analysis. Also interesting to note that selection pressure varied by environment type - selection pressure in the shade but no selection on flowering time in the sun. Otherwise results are exactly what I expected.

Where to go from here? Would be good to look at (1) seedling recruitment and (2) genetic structure to sorta fully complete the loop. Pollinator observations may still be worth doing but only in conjuntion with other work if only to show what is driving the mechanism. Notably this work doesn't reference Hendry and Day. Maybe talk to committee about their thoughts. 

### Dunne, J.A., Harte, J., Taylor, K.J. 2003. Subalpine meadow flowering phenology responses to climate change: integrating experimental and gradient methods. Ecological Monographs, 73(1): 69 - 86. 

- Two lines of research into climte change and environmental research:
	- Timing of plant developmental stages ~ abiotic factors (e.g., photoperiod vs. temperature accumulation)
	- genetic basis and natural selection in plant phenology
- Three basic questions in this study:
	- (1) is do factors other than snowmelt date (e.g., soil moisture, soil temp., cumulative energy inuts) explain flowering phen. variability
	- (2) community-wide trends in flowering versus species-specific responses?
	- (3) constraints on timing and duration of flowering - microclimate factors?
##### Methods
- RMBL - four study sites, four ecosystem types (spruce, fir, aspen, meadow) with some sagebrush shrub (?!)
	- 99 angiosperm species in study plots (nine shrubs, 68 forbs, 22 graminoids)
	- ~80% of annual precipitaton is snow, max depth of 197 cm
- Exp. design
	- 1990/1991: 10 3x10m plots in subalpine meadow ("warming" meadow)
	- two electric radiant heters 2.5m above ground for each plot - 15 W/m2 year round heat flux
	- three sites nearby: lower, middle, upper (elevation gradient)
		- five pairs of 4x4m plots laid out per site, assn. ctrl. or snow removal
			- here snowmelt date changed, not altering other factors?
- Microclimate
	- measure soil moisture every 2h, 12 and 25 cm depths, in all plots (gypsum blocks)
		- readings averaged over each diurnal cycle to get daily and seas. soil moist.
	- air temp data every two hours (weather stations)
	- snowmelt date: day when 12cm remained above 1C
- Phenology
	- 11 perennial plant species
	- Censuses once per week after snowmelt
	- Flagged five individuals per plot (once five individuals started budding)
	- Recorded stage (e.g., not yet flw., budding, open flws., etc.) numerically, averaged over stages present per individ.
	- used this to calculate timing (time to stage 3.5) and duration (days to go from 1-5)
- Analysis 
	- ANOVA/ANCOVA to investigate effects of trt, site, year, plot position on microclimate and phen. variables
	- Phenology ~ microclimate: linear regression for phen ~ snowmelt
		- warming meadow: phen response to small-scale gradient, elev. meadows: landscape-scale snowmelt gradient
	- Phenological soil microclimate variables in one year at elev. sites: mean soil temp., mean soil. moist., sol degree days (def. herein)
##### Results
- Snowmelt earlier (14 days) in most northern vs. most southern control plots
- Warming advanced snowmelt by ~16 days
	- warming increased spring soil temp by ~2C, summer by 1.2C
	- decreased summer soil moist. by 14%
- Snow removal also hastened snowmelt
	- snow removal advanced snowmelt by more at lower than higher sites
	- snow removal increased spring soil temp., no effect on summer soil temps.
	- lower site had driest soil
- Experimental warming advanced timing of flowering in 8/8 (8?) sp.
	- later flowering times: weaker response to warming
	- warming also extended duration of flowering
- Snow removal extended duration for 7/8 sp.
	- treatment effects on duraton consistent across time
- Melt date affects 7/8 species in warming plots
	- timing 0.3-0.7d earlier flower per day earlier snowmelt
	- earlier flowering species had ns. stronger relationship to melt date than later
	- 3/8 species have longer duration with snowmelt changes
- Melt date affects 7/8 (8/8?) sp.'s timing in elevational plots
	- 0.2-0.8d earlier flowering per day of early melt
	- here earlier flowering species had sign. stornger resp. to snowmelt date
- Phenology and soil microclimate
	- if warming influences timing via changes to melt rather than soil microcl., sp. response to warming should be ~2x response to snow removal (2.3-fold greater difference btwn heated-control vs. snow-control)
		- festuca had ~4x, forbs had ~1.5-2.1x difference
	- also, look at residual warming effects beyond snowmelt date
		- only sign. effects for 2/8 sp.'s timing, only 1/8 sp.'s duration
	- warming spring soil temp. advanced timing sign. 7/8
		- spring soil temp. had higher R2 than melt date
		- spring soil temp. had stronger effect on earlier flowering comp. to later flowering
	- drier flowering period soil sign. advanced timing 2/8
	- timing not influenced by soil degree-days
	- But, multivariate models had earlier timing due to warmer soil temp., lower degree days (?)
	- spring and flowering period temps influenced durations 2/8
		- in multivariate mos, in forbs longer duration due to cooler days, increased DD (??)
	- soil moisture never a significant predictor of tming
	- microclimate variables explain on avg. 82% of variation in timing, 38% of duration
##### Discussion
- Some discussion of consequences in first few paras: species interactions, e.g.
- Evolution: "climate change may directly alter plant fitness" - cites Galen and Stanton 1991, 1993, Wookey et al. 1993
	- indirect effects on reproductive success through pollination change - lots of citations here
	- mixed effects on fruit set
- Unlke timing of flowering, duraton showed stronger response to snow removal than to warming, esp. in early species
	- additional effects of warmer, drier soil may stress plants and offset gains in duration due to snowmelt
- "Advanced flowering time associated with earlier snowmelt date, shallower snowpack, or lower total snowfall [...] appears to be a general property of [...] species"
	- some thoughts on why Eriogonum didn't show any response - may be due to the fact it's a lower-elev. species (less constrained? not sure how)
- In general along gradients populations (w/in sp.) may be responding to different cues or constraints
- Soil moisture: early snowmelt caused by lower snowpack and drier soil
	- refs to studies suggesting soil moisture influences timing of flowerings
	- here, soil moisture did not consistently influence phenology
	- *Erigeron* and *Festuca* did have earlier flowering with drier soil in unvariate models
	- see de Valpine and Harte 2001 for water addition treatment to *Erigeron*
- Soil temperature: earlier snowmelt meant warmer soil (exposed sooner)
	- residual effects of warming treatment beyond snowmelt date show delay in flowering with warmer snow?
		- warming treatment increased soil temp, timing of flowering not affected by other soil effects (moisture)?
- "We found that best-fit models for timing of flowering in most species incorporated some combination of..."
	- earlier snowmelt date
	- warmer flowering period soil temp
	- decreased soil degree days
- Univariate models worked best for early-flowering species, multi-variate models have stronger fits for later-flowering ones
	- single factors have greater explanatory power (one factor controls process) in early-flowering

Boy there is a lot going on here! Not sure I'm understanding the scales, differences between warming and elevation... The abiotic measurements and their influences are helpful here. I'm not really sure how to disentangle snowmelt's effects from other correlated things... maybe this could be re-analyzed? Anyway, I like the way spring soil temp., summer/flperiod soil temp., and soil moisture at various points are tested here. Seems like soil moisture does not necessarily have an effect here whereas summer soil temperature may. Thinking about collinearity in models will be very important (these should all be correlated under shade cover). Also worth disentangling time and duration of flowering.

### Rixen, C., Stoeckli, V., Huovinen, C., and Huovinen, K. 2001. The phenology of four subalpine herbs in relation to snow cover characteristics. From Proceedings of a symposium in Sixth IAHS Scientific Assembly, Maastricht, Ned. 

- Ski slopes: artificial snow, water, minerals added; snow compressed
	- Cold temps may more easily reach the soil, possibly causing soil freezing here
	- artificial snow my have later snowmelt
- Artificial snow field on a cultivated grassland: 10 artificial snow plots, 10 natural snow plots, 10 plos untreated snow on field edge
- Phenology of four species incl. Taraxacum off. monitored frmo end of April to end of June
- Groomed snow had lower and more variable soil temperature than natural ungroomed snow (incl. sub-freezing)
	- compressed natural snow took one day more to melt than untreated natural (sign.?)
- First three flowering species: earliest under untreated snow plots, compressed snow took longer (how much?)
	- ehhh looks like these are not significant, but also n = 10 only so probably underpowered

Eh... small sample size. Compressed snow will melt later and will cause fluctuations (going below freezing) in soil. Converse of this is that natural snow insulates soil very well! (up until snowmelt  suppose).

### Forrest, J., Inouye, D.W., and Thomson, J.D. 2010. Flowering phenology in subalpine meadows: Does climte variation influence community co-flowering patterns? Ecology, 91(2): 431 - 440. 

- Cites Dunne, saying that earlier flowering species will have a stronger relationship to timing of snowmelt than later-flowering species
- Thrust of this paper seems to be thinking about/looking at the co-flowering community
	- Thinking about pollination... variation in phenological response influences pollinator preference, possibly
- Here: does timing of snowmelt influence temporal overlap [of different species?]
- Why snowmelt? It integrates springtime temperature, winter snow accumulation, influences start of growing season, soil moisture
	- Snowmelt is lower here than historcally
##### Methods
- 30 2x2m plots, monitored nearly every summer 1974 - ~2000?
	- 16 unmanipulted plots in dry incl. in aspen and meadows
	- n. open flowers in all non-graminoid plants
- snow accumulation and date of first bare ground recorded within 1km
	- snowmelt varies by plots... on average ground bcomes bre 9.3 pm 8.9d earler at station?
	- interannual variation much larger than inter-plot
	- monthly April - June temps didn't add much to analysis
- Focal species: an early (Mertensia), a late (Heterotheca), two intermediates (Lathyrus, Hymenoxys)
- Community metric of overlap: take all flw plants during flowering period, measured relaive abundances ~ timing of snowmelt
	- or... looked only within a 2x2m plot (local overlap)
	- Use Mantel to evaluate relationshp between snowmelt date and first bare ground date
		- i.e., snowmelt date is matrix 1, Bray Curtis flowering matrix is matrix 2
		- (what are matrices? matrix 2 is B_{ij} is overlap in community from year 1 to 2? A_{ij} is difference in snowmelt?
		- this gives each day equal weight in defining co-flowering community
	- Also, overlap between species pairs
		- used Schoener's index of niche overlap
			- SI = 1 - (1/2)*sum_k |p_{ik} - p_{jk}|; p_{ik} is proportion of i's flowering occurring on day k
				- this sums over days, giving overlap in temporal distribution
			- use linear interpolation for missing days (good idea!)
		- did this jsut for Lathyrus-Lupinus and Lathurus-Vicia because they may share pollinators
		- ssess significance by looking t SI ~ snowmelt date (rank based assessments)
##### Results
- No temporal autocorrelation of either snowmelt date or flowering intensity/duration
- For 2/4 species, correlation between first date of bare ground and composition of coflowering species
	- third species becomes significant if using only presence/absence data (increased power b/c more data available)
	- Fourth species (unaffected) was latest- and longest-flowering speces
	- Lathyrus: 10.11 coflowering species responsive to snowmelt date
- Later snowmelt means more co-flowering species?
	- Three sp. with strongest intensty ~ snowmelt date are late-flowering??
	- (so because late-flowering species are less responsive, everyone is getting shoved together when the season is shorter)
- Much less Lathyrus-Lupine overlap with earlier snowmelt
- No association of Lathyrus-Vicia overlap with snowmelt
##### Discussion
- Early species are more responsive to snowmelt timing
- For Lathyrus (most seriously studied species), more species to overlap with with late snowmelt
- Prevously shown that some species have more flowers in years with more snow, later melt
	- early snowmelt may cause frost damage to buds
- Duration effects: early snowmelt can increase duration by providing a longer growing season, later snowmelt/more snow can increase duration by providing more moisture...
	- Ooh!!! wow. This duration effect may operate *within species* as well... e.g., there may be a difference in timing that conflates *plot level duration* with *individual duration* such that conspecifics are smooshed together if they start later
- N.b. air temp did not have very much marginal effect (perhaps not fine-grained enough)
- Some stuff about pollinators.

This is useful for thinking about early vs. late flowering species and how they may respond differently to cues (Dunne also talks about this). Early flowering (like Thermopsis) may show more variation because it's much more reliant on when there is bare ground. Perhaps Thermopsis also will be more sensitive to changes in microclimate because they are relying on cues? Also the framework here of thinking about overlap between species can be useful for us, thinking about overlap/synchrony between plots. Linear interpolation is a good idea for imputing floral abundances!

### Chazdon, R.L., and Pearcy, R.W. 1991. The importance of sunflecks for forest understory plants. BioScience, 41(11): 760 - .

- With closed canopy, often only ~5% of solar radiation can reach the understory
	- Sunflecks: brief and unpredictable periods of direct irradiance
	- Also: shadeflecks are brief (or longer-lasting) cloud-induced shading periods
- Direct radiation has a different low red:far-red ratio than direct sunlght
- Canopy openings need to exceed angular size (?) of ~0.5 degrees for full irradiance
	- penumbral parts of a sunfleck probably don't reach same photon flux as direct sunlight, only barely better than diffuse radiation
- Generally, sunfleck duration and irradiance decrease wth taller tree height and leaf area
- Similar photon flux density from sunflecks (i.e., I think proportion of direct understory irradiance coming from flecks) is similar btwn. temperate and tropical understories
	- but within a day, for a given point in space, variation in irradiance can span orders of magnitude
	- e.g., in Hawaii, 60% of sunflecks were <30 seconds; in CA redwoods, median duration is 2 secs
	- highly clustered temporally, quite restricted spatially (~20 cm apart will vary over the course of a day)
- Sunflecks important for carbon gain (some physiology stuff I didn't understand)
	- Orozco-Segovia 1986: in MX rainforest, more seed germination of pioneer species in sunflecks
	- in HI evergreen forest, seedlings show linear relationship between rel. growth rate and potential minutes of sunfleck
	- Pitelka et al. 1980: in eastern deciduous forest, an Aster has more reproductive effort and size with more light
	- Young 1983 seems to do something similar with an Arnica
- Photosynthetic response to sunfleck: depends on whether leaves have been previously (recently?) exposed to near-saturating irradiance
	- I guess it takes time (~20 sec) for the leaf to get up and running, see Fg. 6
	- These combine to mean the effects on photosynthesis depend highly on the temporal sequence of sunflecks
	- Efficiency of sunfleck use varies by species (and also within species? see Chazdon and Pearcy or solo refs)

Very cool stuff! Lots of physiology and photosynthetic stuff I don't understand. But it's interesting to think of forest subcanopy as both responding to diffuse radation and also requiring (?) brief periods of intense solar radation penetrating the forest overstory. The sections on recruitment and size are most interesting or relevant sounding to me/us.

### Young, D.R. 1983. Comparson of intraspecfic variations in the reproduction and photosynthesis of an understory herb, Arnica cordifolia. American Journal of Botany, 70(5): 728 - 734. 

- Understory herbs: typically in single-sp. patches, dependent on light, precip., and microtopography
	- refs in here about differences in reproduction: light, temp., moisture, density
- Photosynthesis varies under canopy - look at intraspecific variation in photosynth. and carbon storage in an understory species
##### Methods
- *Arnica cordifolia*
	- Young and Smith , 1980, Y&S 1982, look at photosynthesis depending on understory microhabitat
	- Max. photosynthetic rate per unit leaf area in a clearing is >2x that on edge or in shade
	- Max. carbon gain per unit leaf area: highest in plants from open locations (~3x shaded plants)
	- typically 1/3 m tall, 4-6 large broad leaves on one stem
	- Summer growth cycle typically 4-8 weeks
		- one shoot may flower for about one week, seed maturation in 2-3 days (!)
	- Asexual reproducton through rhizomes
	- New shoots need >3 years to reproduce a flowering head (just vegetative or all?)
- Field work
	- patch types: open typically >12 MJ/m2/day, shade <5
	- Field sites: 1980, 1981 in Med Bow, NE-facing slope
	- Go to six flowering sites
	- Collect seeds (6 shoots from each of five patches per microhabitat, i.e., five each of open, semi-, closed)
		- no evidence of differences in dry weight per ramet
	- Germination: do gerimination differences exist by microhabitat?
		- 100 seeds from each microhabtat: subdvded into groups of 20, put in five petri dishes
		- monitor gerination over time
##### Results
- From 1980 studies, higher max. photo rate, higher light saturation, higher max carbon gain going up openness gradient
- Only sign. differences in # flower heads, # seeds, total seed weight per ramet
	- 2x number of heads in open env. rel. to shaded (2x seed weight per ramet)
- No differences (among ramets) in seed, vegetative, or aboveground dry weight
	- ramets in open locations had greater belowground weight comp. to shade
- Similar max temp. for germination for all three env. types
	- however, the best performing env. type seemed to vary by temp?
		- e.g., hghest germ. for open seeds at 20C, but highest was shaded at 25C
	- similarly, differences across shaded microhabitats
		- only shaded seeds would germinate in darkness
		- in general, germ. rates tracked PAR from their home env. type (!) although differences were slight
##### Discussion
- Yep: more patch reproductive effort in open locations
	- associated with more photosynthetic capacity
	- also means more max. daily carbon gain (more carbon for reproductive investment)
- Improved germination in light env. similar to area of maternal plant
	- highest overall germination was mid-temp from seeds collected from shade
		- compensation? perhaps... seems shakey
	- 80% of plants occur in intermediate/semi-open canopy
		- this is the range of optimal germination	
		- intermediate climate here may allow max water use efficiency
- Seed reproductive effort, vegetative reproductive effort, total rep. eff. (SRE, VRE, TRE)
	- (how are these defined? just weight?)
	- looking at all three of these in conjunction allows examination of vegetatively-reproducing plants
	- high VRE in relation to SRE could just be vegetative reprod.... self-evident?
	- In understory, SRE increases and VRE increases with plant density, daily light (refs)
		- but in this Arnica, both SRE and VRE increased with density and light
		- is increase just due to more carbon gain allowing more reproduction?
	- Are photoassimilates (some chem. compound?) transfered among plants through underground stuff? whoa

Wow, lots of interesting stuff here. Need to think about this more in the context of clonality - we know Campanula has vegetative reproduction through ramets. But as far as seeding goes, we see more evidence here that more flowers and seeds are produced in sun rel to shade. Also more belowground growth for allocation. Is there a reason to assume this may influence timing of flowering? The seed germination stuff was also super interesting - not just what environment is best for seeding, but what maternal environment could do to seeding. Is this a seed quality thing? Thinking about maternal investment, why would shaded plants have higher quality seed in any setting? Is this some sort of local adaptation? Plasticity?

At the very least it makes it tempting to do a source x environment part of a seed addition experiment!

### Young, D.R., and Smith, W.K. 1982. Simulaton studies of the influence of understory location on transpiraton and photosynthesis of *Arnica cordifolia* on clear days. Ecology, 63(6): 1761 - 1770.

- Study sp: *Arnica cordifolia* - herbaceous perennial, 1/3 m. tall, 4-6 overlapping leaves on one uprght stem
	- Rapid growth and senesence of the leaves
	- Y&S 1980 show variaton in leaf morphology and variation according to microhabitat and understory location
- Simulation modeling looking at photosynthesis and transpiration at three understory locations:
	- EL: "typical" understory location, early morning and late afternoon sunpatches  
	- SH: shaded most of the day
	- LM: only receiving sunlight at mid-day
	- Leaf phenotypes at each location:
		- LM, small leaves
		- average sized leaves at EL
		- large leaves for SH
	- Factorial leaf size vs. location simulation design
- Microclimate measurements (1979, 1980) taken at 15 understory locations along shade gradient
	- Incident solar radiance, quantum flux, wind speeds at ~10 cm, air humidity, air temperatures, surface soil temperatures
- Photosynthesis measured on leaes
	- Influences of light, temperature, and xylem pressure potential on photosynthesis? Field measures or modeling?
	- Stomatal resistanc to water vapor diffuon, leaf temp, humidity used to estimate transpiration (water loss)
- Simulatons based on energy balance equations, leaf temp. ~ air temp, radiation levels, wind speed, air humidity
	- Clculate photosynthesis, transpiration, water use efficiency for each phenotype in natural location and other two microhabitats
	- Validation by comparing sim results to one day of measurements on two plants (but nine levels...)
- Sim results:
	- SH location: morning+afternoon net photosynthesis highest in large leaves, mid-day more in sm/average leaves
	- EL location: during high radaton in morning and afternon, average leaves favored while larger leaves have advantage during shaded peiods
	- LM location: small leaves have advantage at mid-day, large and average leaves have advantage durng morning/afternoon
	- Highest net carbon gain for small leaves, but also highest water loss, such that small leaves had the lowest water use efficiency in LM
	- Transpiration rate similar: leaf resistance differences offset by temperature
- Carbon gain per plant is constant (?) for *A. cordifolia* because of trade offs in leaf area per plant vs. photosynthesis per leaf area
	- Model suggests small leaves have greatest net carbon gain and water loss, but lowest WUE in its natural location
	- average leaf size had greatest carbon gain and WUE at natural location
	- does this suggest that WUE is more important than carbon gain?

Useful for thinking about trade-offs from leaf size. Larger leaves mean more photosynthesis but also more transpiration (water loss) - transpiraton probably more likely in open (warmer, less humid?) areas. Water use efficiency may be selected for more strongly than net photosynthesis and/or carbon gain.

### Steinaker, D.F., and Wilson, S.D. 2008. Phenology of fine roots and leaves in forest and grassland. Journal of Ecology, 96: 1222 - 1229.

- Response of leaf out to climate change is well studied, bu what about root phenology
	- Also, does root phenology predict shoot phenology?
	- Shoots are dependent on roots for soil resources
	- Roots are dependent on shoots for photosynthates
- There may be decoupling of these phenologies if
	- Shoots are affected by air temp while roots are affected by soil temp (ar warms faster than soil)
	- Nutrients and photosynthates are stored in distal tissue
	- There is strong light pre-emption in forests (due to leaf out) such that it's advantageous to leaf out rapidly
- Do we see differences in root and shoot phenology depending on environment? Forest (aspen) vs. grassland.
##### Study
- Mosaic of grassland and aspen in SK Great Plains
	- Aspen creep (changing burn regimes + N deposition)
	- Forest is shrubby understory
	- Grassland dominated by Stipa, Agropyron, Koeleria, Selaginella
- Measure root and leaf production + soil water + soil temperature
	- 10 locations, >30m apart, total 20 locations
	- Root and leaf measurements with sequential imaging
- Root images:
	- One rhizotron tube per location (20 tubes total)
	- 25 images along each rhizotron tube per day (250 for each habitat on each date, >7K photos)
	- Photo every 15 days
- Shoot images:
	- Sequential downward-facing images taken biweekly over growing season
	- Count green pixels for stuff
	- In forest, also tke upward-facing images to get canopy changes
- Differences n production are inverse (?) of summed difference btween production value on each date and mean site production (???)
- Analysis: repeated measures ANOVA used to get differences in production duration betwen habitat types
	- root depth measurements are repeated measures for one plant
##### Results
- In grasslands, leaf production begins one sample interval (15 days) before max root production (such that root and shoot were correlated over time)
- In forest, max leaf production occurred 45 days after max root production (less correlation)
	- I.e., synchrony in grassland but not forest
- Leaf production starts on same days in ech habtat, although forest max is 30 dys sooner than grassland max
	- forest leaf production finishes 15 days soner
- Root production occurs in spring and summer, with greatst production in early summer in both env. types
	- Root duration longer than shoot duration for both habitat types, although no differences in root duration between types
- Soil moisture varies through time but not by habitat
	- similar patterns between sites
- Soil temperature varie by time
	- warmer soils in grasslands than forests
- Grassland leaf production increases with soil temps
	- Forest leaf production increases with soil moisture, as leaf production is greatest earlier in season when moisture is highest
	- Root production increases over growing season - soil temp increases and moisture decreases
	- [think about how all of this fits together...]
##### Discussion
- Forest leaf production occurs before root production because air warms faster than soil
	- Forest leaf production may also b faster due to translocation from twigs (??) and due to intense light competition
- More synchronous growth in grasslands because nutrients for new leaf production come from belowground storage
	- (Is there a different allocation of resources due to the scarcity of light? Root depth greater in sun where there is greater light availability)
- Root and leaf production are temporally coupled in grasslands and decoupled by woody invasion
- Temperature changes may have increasing effects on grasslands than shaded areas due temperature's moderating effect on climate
	- i.e., soil temperature increases more in grasslands than forests
- Jackson et al. 2001 (in Terrestrial Global Productivity): "5-10 day lengthening of growing season can improve net productivity in temperate forests by 1/3 because early spring photosynthetic tissue disproportionately increases total productivity"

Differences in timing of leaf out and also root production between forest and open area. Leaf out is *earlier* in forest. But, root production looks about the same by habitat type. Leaf out is important in light to get the available light quickly. Thinking about differences in allocation... there's likely to be a lot less root mass in understory because of the lack of available light. Soil temperature varied over time. **Soil was warmer in grassland than forest**. Soil temperature was important for leaf phenology in grasslands, soil moisture important in forest. Both important for roots (similar effects by habitat: moister soil meant less production, soil temperature has positive effects).

Use of this paper: thinking about phenology of stages and importance of roots... well at the very least there is some influence of light on leaf phenology (not so for roots though) due to competition. That's interesting - makes me want to look at bolting of *Thermopsis*. Soil moisture doesn't seem to vary by habitat type (noteworthy) - this ecosystem probably also gets a lot of snow, although no topography that may influence snowmelt levels. The fact that moisture and temperature correlations depend on habitat type (for leaf productivity) is interesting, although no effect on rooting. Underground is probably just less sensitive to changes/heterogeneity than aboveground is. This says to me maybe flowering is likely to be affected by either of these. Use use use!

### Chen, J., et al. 1999. Microclimate in forest ecosystem and landscape ecology. BioScience, 49(4): 288 - 297.

- Forest structure/stand structure (e.g., overstory coverage, sp. composition) vs. landscape structure (topography, spatial patterns in soil, veg.)
- Microclimate produces non-linear patterns, e.g., decomposition of organic matter is a function of soil temp. and moisture
- Variance in microclimate is very important, e.g., short ~10 min sunflecks providing a disproportionate amount of an organism's total seasonal PAR
- Microclimate highly sensitve to changes in overstory canopy
- Spatial variation (scales) vary by forest ecosystems, e.g., doug fir forests and oak forests will have different scales of variation of air and soil temperatures
	- although, generally, soil temperature is more spatially variable than air temperature 
	- e.g., Chen and Franklin 1997 comparing summer air temperatures and soil temperatures along transects in WA
	- e.g., in oaks of the Ozarks, air and soil temperatures varied by much less
	- differences perhaps attributable to evenly-aged stand structure in oaks (compared to WA doug fir old growth varied canopy)
- Temporal scale of measurement is important - microclimate variation may be related to daily, seasonal, or dramatic chance weather variation	
	- means the choice of summary statistic is important
- Forest edges can cause variation, e.g., moving into a forest remnant can cause an increase in daytime summer temperature but an increase in humidity
	- Chen et al. 1995 - scales of variation, 8C differences at patch boundaries, compared to 2.7C within a patch
	- extreme temperatures at edges due to stable air masses??
	- strong wind, low humidity near edges?
- [A good question... what is the magnitude of within-site variation or change compared to climate change?]

Meh. I do like the question about between environment variation vs. across year variation (with climate change trend). Chen and Franklin have some interesting stuff but it looks like it's mainly on old growth forests.

### North, M., et al. 2005. Influence of light and soil moisture on Sierran mixed-conifer understory communities. Plant Ecology, 177: 13-24.

- Southern Sierra: fire suppression means more shade-tolerant trees, overstory canopy, more litter, less light
- The effects of gap openings on forest understory likely are influenced by forest type
	- e.g., in old growth forest, more herbs in gaps due to increasing radiation (Gray et al. 2002)
	- in deciduous forests, gaps mean more soil moisture due to precip
- Here: lok at herb and shrub cover, compared to canopy cover, soil moisture, litter depth, bedrock depth
##### Methods 
- Teakettle Exmpt. Forest: mixed conifer of red fir and lodgepole pine (also white fir, black oak, sugar pine)
	- White fir has most stems and basal area
	- Sugar pine and Jeffrey pine have largest diameter and tallest trees
	- Fire interval was 12-17 years historically, only two surface fires since 1865
- In a 200 ha block, 18 4-ha plots established
	- in 12 plots, 50x50m grid and six 25x25m plots
		- in large plots, 9 points per plot, in small, 49 points per
	- At each sample point, measure: soil depth, volumetric soil water content, canopy cover (hemi photo + moosehorn?)
	- Also, 10m2 circular plot: % cover of herb and shrub
- From photos, get %can cover, direct rad., diffuse rad., and photosynthetically active photon flux density (PPFD)
- For plant cover data per plot: alpha, beta, gamma richness, Simpson and Shannon div.
	- Also species groupings using cluster analysis, ordination, regression trees (damn!)
- Analysis... goddamn this seems like overkill goodness
##### Results
- Overall rich community but infrequent and heterogeneous at small scales
	- 84 herbs at 402 sites, with most abundant (Pteridum) at 11.5% total herb cover
	- 14 shrub species, dominated 75% of one species
- By canopy, there are four distinct habitat types:
	- mesic closed canopy (with woody debris)
	- open canopy, drier understory, high litter
	- dry gap with shallow soil (no litter or debris)
	- Rock cover, shallow soils, littl moisture
- Regression trees looking at predictors of habitat type
	- high herb cover with >14% October moisture
	- also herb cover with >10% Oct. moisture and less sunlight (?)
	- shrub cover associated with more diffuse light, less moisture, less direct light
	- herb richness associated with higher Oct moisture, somewhat influenced by May moisture, more diffuse, less direct light
##### Discussion
- Functional group stuff
	- Annual herbs complete life cycle after snowmelt
	- Perennial shrubs tolerate warm and ry summers
	- Herbs are patchy
- Herb response to light varies by direct and diffuse PPFD
	- more cover with less direct light
	- diffuse light has less effect
	- direct PPFD under direct sunlight (Barbour et al. 1991, North et al. 2002)
	- litter depth is positively correlatd wth Oct. soil moisture (litter traps moisture?)
- Shrubs form large contiguous patches, a lot on the edge of tree clumps and gaps
	- shrubs do well where moisture is low
- Available soil moisture has largest influence on understory plant composition
	- soil moisture can be influenced by porosity, bedrock depth, litter depth, temperature, plant use
	- differences in bedrock depth and plant functional types may most influence soil moisture patterns observed here
	- Closed canopy has deepest soils retaining most moisture (what is the driver here? soil depth -> tree cover -> canopy -> moisture?)
	- Closed canopy and partial canopy have similar litter and sol depths, but varied moisture; may be due to shrubs that compete for water
	- Trees reduce understory light, possibly less affecting moisture

Ehh... good discussions on plant functional types and drivers of soil moisture (although are they sourced?) Litter and canopy coverage *as well as* current plant composition driving soil moisture. Compare our eventual soil moisture results with this. Litter depth influencing moisture - there seems to be a lot of litter in aspens, perhaps these have high moisture (but also less light penetration I'd guess?) Herb coverage influenced by soil moisture for sure - more moisture means more herbs, less moisture typically associated with shrubs (where are the understory shrubs at Elk Meadows?) The patchiness of herbs is interesting - annuals, ephemeral populations? Like fireflies blinking across the landscape... idk. 

### Buck, J.R., and St. Clair, S.B. 2012. Aspen increase soil moisture, nutrients, organic matter and respiration in Rocky Mountain forest communties. PLoS One.

- Rocky mountain successonal cycle: 
	- disturbance removes overstory
	- aspen roots "sucker" (?)
	- aspen stands establish
	- conifer seedlings grow rapidly and slowly promote aspen mortality
- Aspen stands have more biodiversty and production than forest meadows (??)
	- see citation here: Kuhn et al. 2011
	- also, may be mroe snowpack in aspen stands than open meadows (see: LaMalfa and Ryle 2008)
- Are there plant-soil feedbacks related to forest type, overstory composition, etc.?
	- Hypothesis: soil resources and respiration high in aspen stands, lower in conifers stands and meadows
- Ten sites at Fishlake National Forest (UT) w/ four stand types each
	- >75% aspen, 50-50 conifer/aspen, mostly coniper (fir and Engelman n spruce), and open meadow adjacent to forest edge
	- vascular plants (shrubs and forbs) most abundant in aspen understory
	- meadow mostly mixed grasses and forbs, some shrubs
- Soil samples collected from four stand types at seven (?) sites
	- nutrient concentrations, soil texture, respiration
	- differences 
- Differences in C:N, total N, K, Fe, Zn between stand types (acc'd to ANOVA)
	- (n.b., Zn p = 0.04, organic matter p = 0.03)
	- no differences among NO3, P, Mn, pH, Mg
- Most organic matter, N and Zn in aspen stands, then mixed or conifer dominated then meadows
- Confier stands had highest C:N, Fe
- Aspen stands had more N, K, and lower C:N compared to conifers
- Meadows and aspen stands had higher soil temperature compared to conifer dominatd stands
	- changes across the summer were consistent across summer
- Soil moisture decreased over time
	- aspen and meadows had approx. 30% higher soil moisture compared to conifers early in summer
	- soil moisture converged later in summer
- Soil respiraton increases from early June to july in all soil types
	- aspen stands consistently had highest soil respiration (aspen > mixed > confier > meadow)
- Nutrient inputs into soil: root exudates, root turnover, litter, stemflow
	- litter likely different among communites
	- foliar nitrogen could be contributing to differences in N
		- broadleaf species typically have higher N and lower C:N in litter compared to conifers
- Soil moisture is important for plant community composition
	- moisture reliant on snow pack (so things dry out later in summer)
	- early in summer more snow in aspens but convergence by late summer
	- soil moisture convergence: maybe aspens have higher summer evapotranspiration?
	- the differences in soil organic matter may be what cause differences in soil moisture
	- ref in here about water penetration in conifer soils... not high!

Great references in here about biodiversity and some abiotic factors under aspen canopy. I'm not really sure what to do with the geochemical stuff, other than perhaps to use it to say we can't specify what exactly is driving patterns (a secondary concern, anyway).

But, it's super cool to see some of the abiotic differences between aspen and conifer laid out here. Does this influence plant physiology? Or it could, perhaps more likely, influence whether plants appear in these canopy types at all. For species present in both, contrasts between these two may be useful for disentangling direct light effects from effects of other variables like moisture.

Good question here about snow pack - how much is this contributing to soil moisture? Litter also seems to be contributing a lot (nutrients, organic matter, but also to moisture retention). What if we did litter removal experiments???

### Abrahamson, W.G. 1979. Patterns of resource allocation in wildflower populations of fields and woods. American Journal of Botany. 66(1): 71 - 79.

- In r- vs. K-selection, less mature/highly disturbed environments cause more investment in reproducton
	- reproductive allocation declines with habitat "maturity"
	- allocation should also rely on the limiting resource
		- Abrahamson and Gadgil 1973: if light is limiting, the more biomas for stems to avoid shading or more biomass for leaves
- Here: sampled 52 populations (56 sp.); 36 from fields, 16 from forests
	- sampled durng peak fruiting period in 1977
	- 8-17 randomly chosen flowering or fruiting plants chosen
		- whole plant excavated
		- plants divied into stems, leaves, flowers, fruits
		- each part weighed
	- seeds per plant counted for ten individuals per species
	- field sites 5-20 y/o, wood sites 50-125 y/o
- Regressing biomass measurements against each other
	- in woods, pretty strong associations (r = 0.99 except flower mass against total)
	- in fields, lower correlations (0.79 - 0.95)
	- root to shoot correlations: field r = 0.67 forest r = 0.99
		- when accounting for annual vs. perennial differences, annuals r = 0.91 and r = 0.76 for perennials
-  About 10x seeds per plant in field speces (comp. to forest)
	- about 9x seed biomass in field species
	- ~14 and 23% of biomass in field goes to seed and fruit resp.
	- ~4 and 16% of biomass goes to seed and fruit in forest resp.
- No differences in biomass allocations between introduced and native field species
	- except that introduced field species have slightly higher floral biomass
- Root to shoot ratio higher in field perennials, typically more belowground allocationa nd less stem allocation in perennials compared to annuals
- In general, more allocation to flower, seed and fruit in field populations, relatively more allocation to belowground leaves in woods, more and smaller propagules in field
	- Field species have earlier-successional stage attributes
	- Genetics? Physiology and plasticity?
- Similar patterns in single sp. studies (Abrahamson and Gadgil 1973, Gaines et al 1974, Abrahamson 1975, Hickman 1975, Roos and Quinn 1975)
- Due to vegetative propagation, it's impossible to truly quantify vegetative reproduction in dis stuff
- There was a good amount of residual variation after site was accounted for, possibly explained by
	- differences in life cycles (although we'd expect only perennials in forest understory yes?)
	- spring vs. fall flowering
	- growth form differences within a habitat type
	- pollination mode? showy petals etc. may be very costly
	- biotic or abiotic dispersal

Good stuff. Makes me think there is a life history aspect of this as well. In general the shaded plants are more interested in resource accumulation and survival which will drive them towards less flowering, perhaps. Wonder if there are longevity differences between the two! As a general pattern though much more investment in reproduction in sun.

Would be good to look at some of the refs in here about single-species although maybe not in time for writing a proposal.

### Peschel, A.R., Boehm, E.L., and Shaw, R.G. 2020. Estimating the capacity of *Chamaecrista fasciculata* for adaptation to change in precipitation. Evolution, 75(1): 73 - 85. 

- Fisher's Fundamental Theorem of Natural Selection (FTNS) predicts the change in mean fitness (quantitative trait) between the current generation and progeny is V_A(W) / \bar{W}
	- i.e., more genetic diversity increases rate of genetic change
	- note that this is due entirely to the environment of the parental generation and that environmental change will cause deviation from this
	- "Whether a decreasing population (\bar{W} < 1) will be 'rescued' from extirpation through adaptation resulting in \bar{W} >= 1 depends on the magnitude of V_A(W) / \bar{W}"
- Very few estimates of V_A(W)
	- people say that populations will have little genetic variation because selection will remove it (fixation of beneficial alleles)
	- in Chamaecrista
		- Etterson (2004) looks at a soil moisture gradient for evidence of variance
		- Sheth et al. 2018 and Kulbaba et al. 2019 estimate this V_A(W) in natural populations
		- significant V_A(W) found
- In tallgrass prairie, adaptation via gene flow is unlikely due to fragmentation, meaning that persistence will rely on in situ adaptation
	- Climate change means greater cumulative precipitaton but less frequent rain, meaning likely changes in soil moisture
	- specific leaf area is related to fitness-precipitation/moisture relationshp (thicker leaves/lower SLA = fitness advantage in low moisture)
	- here: look at heritability, selection, plasticity of SLA
- (1) is there V_A(W) in differing rainfall differences?
	- (2) if yes what is the rate of adaptation in each condition?
- (3) is there selection on SLA?
	- (4) what is the heritability of SLA?
	- (5) is there adaptive phenotypic plasticity for SLA?
	- (6) is there a GxE interaction (variation for plasticity) between SLA and fitness?
##### Methods
- V_A(W) determined from a pedigree (variance between noninbred half-siblings)
- Adaptive capacty of *Chamaecrista* - ten 2m2 plots, five with rainfall excluded (17 storms) in one summer
	- summer is wetter than usual (considerably)
	- 208 seeds (52 full sib fams representing 18 half-sib groups) planted
		- thinned such that one seed per full-sib fam remained
- At end of season, seeds collected and counted, SLA determined by weighing
- V_A(W) and \bar{W} estimated with aster models
	- aster has emergence as bernoulli and seed emergence as poisson
- Testing for GxE interaction using trt and plot as fixed factors, dam sire and sire x trt as random factors
	- get pearson's r as indicator of similarity of breeding values between treatments
	- SLA plasticity is difference in trait expression between environments
	- selection differential on SLA measured with n aster (regress fitness on trait)
###### Results
- rain shelters reduced 40% of incident rain
- n.s. differences in mean lifetime fitness between rain treatments
- large and significant effects of V_A(W) (??) in both treatments
	- this comes from parental effects
	- V_A(W) is higher in rain reduction treatment than in full rain
	- also plot effects were significant, so, spatial variation in lifetime fitness
- Both treatments had parental fitness greater than 1
	- rain reduction had 52% larger predicted change in mean fitness (due to high V_A(W)?)
	- predicted mean progeny fitness is 20% larger in reduction treatment
- GxE interaction for lifetime fitness
- Significant differences in SLA betwen treatments
	- larger leaves in full rain treatments
	- variable selection between treatments (trt x SLA influences fitness)
	- slightly quadratic fitness function (fitness ~ SLA) for full ran, i.e., disruptive selection but no detectable selection in rain exclusion
##### Discussion
- Significant standing genetic variation (likely higher than other studies to to herbivore exclusion and weeding)
	- populations have ability to adapt to both environmental types (very wet and dry)
- Sire group breedng values only moderately correlated across treatments
	- sire group's fitness in one environment type is a weak predictor of fitness in other environment type
- Greater variation in fitness in more relaxed environment (rain exclusion is akin to historical rain)
	- *Chamaecrista fasciculata* tends to occupy well-drained soils
	- contrast with Etterson 2004
	- Both populations have fitness well above replacement
	- high variance suggests high adaptive capacity regardless
- Although plasticity could be good, but here plasticity was maladaptive
	- if rate of genetic change is slow, adaptive plasticity can buffer the population
	- but here, selection in full rain treatment favored low SLA, but plasticity produced higher SLA (I thought it was bi-directional?)

Not sure I 100% get what's going on here, but the important thing is that here is some natural variaton in an annual plant. It's a little confusing that the rain exclusion treatment here tends to resemble more historic treatments. I'm not sure why V_A(W) varies by treatment group. Also both fitness and varaiance are huge here. I'm also somewhat confused by the parts on SLA - this is associated with fitness. What are the biological and genetic mechanisms here? The stuff on plasticity is interesting and worth considering more.

### Frey, S.J.K., et al. 2016. Spatial models reveal the microclimatc buffering capacity of old-growth forests. Sci Adv.

- In mountains, surface temps diverge from troposphere due to (1) local air-flow (2) microtopography
	- vegetation can influence this too
	- forest structure can influence this stuff (think: old growth vs. secondary)
- At HJA: combine topo + veg structure form LiDAR with Boosted Regression Trees to get thermal properties of landscape
	- 183 HOBO loggers / 6400 ha placed 1.5m above forest floor recording Jan '12 to Jul '13 (7.4 mil loggings)
	- Predictors: elevation, microtopography and veg structure
	- Scales tested around sample point: 25m, 250m
	- Responses: CDDs, mean min/max monthly temps, temp variability in Jan-March and Apr-Jun
	- Boosted regression trees: air temp ~ predictors (38)
		- also looked at each group of predictors and how much variance was explained (summng RI vars)
		- no effect sizes womp womp
	- Old growth vs. new: temperatures ~ PCA of LiDAR variables
		- this is somehow getting at differences between old and new growth
##### Results
- elevation is the best predictor for most temp measures
- topography too: steeper, exposed, south-facing sites warmer and more variable
- vegetation structure predicts temperature variability
- old forest characteristics typically produce cooler less variable temps
- topographic position (valley versus exposed) accentuates effects of forest structure
- elevation-canopy interaction
- max temperature seems to be equally related to elevation, topo and veg
- vegetation metrics typically have more influence at broader (250m) scale
- Principle Components: (1) forest structure: closed canopy plantation -> old growth forest explains 44% of variance
	- PC1 associated with 8/10 temp vars esp. temp extremes 
	- (cooler in old growth)
- Refs here (18, 19, 31, 32) about mature forest vs. grassland and clear cuts would be good to read at some point

Results here are good (forest characteristics influence climate buffering, along with topography) for thinking about aspen vs. conifer. More intriguing is the statistical technique used. 183 sensors is a lot - we won't be able to do this. The statistical technique here is worth noting as well - will we have enough data for techniques like this? Will 8-9 time serieses be enough to capture spatial variation?

### Campbell, D.R. 2019. Early snowmelt projected to cause population decline in a subalpine plant. PNAS.

- With climate change, mountain snowpack declines, earlier meltoff, earlier phenology
- What will this mean for plant reproduction and population dynamics?
- Here: *Ipomopsis aggregata* and *Ipomopsis tenuituba* near RMBL, 2001 - 2016
	- Snowmelt date has advanced 1.34d / decade 1935 - 2016
	- Common garden data
- Questions
	- (1) does seed production depend on snowmelt date?
	- (2) how is seed production driven by n. flowers, fruits/flower, seeds/fruit, seed escape prob?
	- (3) how will seed production change in future? impact on population growth?
	- (4) population growth and snowmelt timing - effects of seedling establishment, survival, etc.
- *Ia* and *It*: monocarpic, 5y as vegetative rosettes then blooming only once
	- *Ia* is seed limited with no seed bank
	- most vital rates from common garden (plantd from seed)
		- seed production from natural populations
		- seed establishment don separately
	- seedlings in CG followed until flowering or death
		- length of longest leaf
	- four multiplicative influences of seed production (per plant) considered
- Seed production and snowmelt date: ANCOVA gets mean total seed production ~ date of snowmelt + site
	- snowmelt dates taken from weather station nearby (8km from CG... annual variation only)
	- lag effects tested by using precip and snowmelt in prev. year
- Seed production: ANCOVA approach on each component of seeding
- Population growth rates: two approaches, one is an IPM, not sure what the other was
	- get actual mean fecundity and the fecundity needed to obtain lambda = 1
	- vital rates here modeled as functions of size, snowmelt date, site
	- take 12 snowmelt dates
##### Results
- 2.64 fewer mature seeds for every day of earlier snowmelt (!)
	- mean seed producton not related to june and july rainfall or lag precip
	- variance in seed prod (?) not associated with site or snowmelt date
- Seed production patterns driven primarily by proportion of flowers fruiting and seeds per fruit
	- flowers produced unaffected by snowmelt date
	- proporton of flowers setting frut did decline wth earlier snowmelt though
	- (does this technique disentangle these? not sure but inclination is no)
- Demography if only seed set is changed: 74-77 seeds per plant needed per reproductive plant for population stasis
	- seed production falling below replacement level approx. half of hte time
	- snowmelt day 134-136 for stasis in this case
		- critical snowmelt day would be below 2035 at current rate by these estimates
- Demography if all vital rates are influenced by snowmelt
	- seedling establishment is increases with snowmelt date
	- veg growth varies by one site (not sure how)
	- later snowmelt increased survival over next year and probabilty of flowering in next year (only)
	- elasticity most dependent on growth and survival with fecundity effects only true in some cases
		- but lambda changed more strongly with *observed* snowmelt-induced changes in seed production
	- combind says that populations fall below replacement rate of 1 for snowmelt days 130 - 139 (decline by 2064 or ~2025 depending on how counting happens)
- Proportion fruiting and seeds per fruit - may be a pollination effect o seed provisioning effect
	- maybe soil moisture influences nectar or pollen production
- Density dependence unlikely to compensate for negative impacts of snowmelt on seed production (based on other studies)
- Some other refs here about seed production and snowmelt: Inouye 2008, Aldridge et al. 2011, Amy Iler's papers
- Petry et al. 2018 on sex-specfic responses to climate change in plants!!

Good study looking at population level response. In general earlier snowmelt influences several vital rates (check flowering in subsequent years, etc.) but most importantly fruiting and seed set info. Definitely seems like a possible pollination influence to me.

Seems like our paper would be very helpful for looking at the individual level and also for seeing how variation within populations may be helpful. Given what we know about how timing influences individual seed set, and how conspecific density may influence pollination and reproductive success, it's a really good question how variation may do this? [Actually, has this been done? Have we looked into how overall temporal overlap influences reproductive success at the population level?] Seems like a compelling mechanism may be "spreading out the phenophase lowers individual reproductive success by reducing phenological overlap"... if populations are seed limited I guess.

### Chen, J., Franklin, J.F., and Spies, T.A. 1995. Growing-season microclimatic gradients from clearcut edges into old-growth douglas-fir forests. Ecological Applications, 5(1): 74 - 86. 

- Measure diurnal changes in air temp, soil temp, relative humidity, radiation, wind speed, soil moisture as a function of distance to edge, edge orgientation, weather, etc.
- Study site: doug-fir forests at Wind River Exp. For. (S WA) and HJA
- 16 edges (13 at Wind River, 3 at HJA) between old growth forest and 10-15 yr clearcuts
	- weather stations placed a 30m intervals up to 240 m from edge
		- shorter 15m transects used for soil moisture
	- measured soil temp 10 cm into soil and all else measured 2m above soil
	- soil moisture measurd during a three day period at 10 sites
	- data collected for 134 days
- Highest air temps at edge and declining temps going into forests
	- edge orientation determines the strength of gradients (strongest effects in south and east facing)
	- highest effects of air temperature in early morning
	- strong edge effects during sudden weather changes (e.g., cloudy to sunny)
	- occasionally air temp had edge effects of >240 but typical range is 60-120
- Soil temp shows similar patterns to air temp
	- high at edge with larger edge effects during day than air temps
	- edge effects here only go about 60 m in
- Short wave radiation: very high at edge, decreases rapidly 30-60m into forest
	- in forest only spikes due to sunflecks
- Wind speed decreases from edge into forest
- Soil moisture did not vary from edge into forest
	- high variability recorded in edge but stabilizng ~15m in
	- moisture variation did seem higher at 90 - 270 angles from north (i.e. generally south facing)
- Topography matters - in general stronger edge effects in South facing edges
- Wind matters - influences evapotranspiration, seed dispersal, insect paths (!), air circulation
	- (several paras on wind!)
- This stuff matters for litter decomp - soil moisture and temperature mean that ltter decomposition is higher near edges
	- unpublished finding that organic layer is shallower at edge!

Well not exactly great for the purposes of what we are studying but sufficient for proposal. Interior of forests are generally cooler (although the thing that I did not consider before reading this was that the edge effects persist into the forest). Considerng microtopography here is also quite important. The soil moisture result is interesting but they only study one day, and they do so late in the season (perhaps when things are most likely to be dry everywhere?) Hmm. Soil temp differences are worth noting. Do we care about wind? For purposes of pollinators yes, maybe.

### Resasco, J., Chacoff, N.P., and Vazquez, D.P. 2021. Plant-pollinator nteractions between generalists persist ovr time and space. Ecology.

- General patterns from plant-pollinator network studies: most interactions are inconsistent over both time and space
	- Of those that do occur conistently, they're typically generalist species at the core
	- Perhaps tolerance (spatial and temporal) influences generalization and thus interactions (e.g., broader tolerance probably means more interactions)
- Predictions for this study (Julian's six sites over five years): more persistent interactions (in space and time - longer phenophase, broader spatial occurrence) between generalists at core
- Plant pollinator observations (2015 - 2019) supplemented with air temperature measurements (weather station), soil moisture, ground temperature (latter two collected once in July 2018)
	- Fay et al. 2000 a good reference for soil moisture
- P-p matrix, three matrix values to measure persistence *per interaction*
	- number of years, span of days, number of plots interaction was recorded
	- distance to core for interaction: 1 - standardized euclidian distance of interaction to corner of matrix
	- Spearman rank-order correlation tests distance to core vs. variables of spatial, temporal persistence
	- compare with null distributions from 1000 randomized mtrices
- Species-level analysis: species distance to network core (row/col no. divided by total number of rows/cols) vs. inter-annual occurrence, intra-annual occurrence, inter-plot occurrence
	- assessed with polynomial regression (2nd degree)
	- got thermal tolerance of species using temperatures during sampling days
- 836 links, 267 pollinators (wow) and 41 plants
	- network connectance of 0.08
	- NODF 25 (I forget how to interpret)
	- one module
- Interactions between generalists (core) tend to have higher inter-annual persistence, intra-annual persistence, and inter-plot persistence (correlation coefficients 0.22 - 0.35)
- Interactions with higher persistence have longer phenophases and occur in more plots
- For species, more generalization mens more inter-annual persistence, longer phenophases, and more plot occurrence
	- phenophase length associated with broader temperature range
- Hypothesized mechanism supported: broader tolerance to environmental variation means more generalization due to more overlap
	- (the temperature tolerance stuff... think about this more. just observational. longer phenophase maybe due to other things?)
	- Generalizability relates to the concept of nich breadth and environmental constraints
	- the temporal and spatial persistence of interactions could be a function of niche breadth

Interesting. Could be useful to get our sensors in there for some use. Still not exactly sure why interactions are a good focal unit of measurement though...

The tolerance-phenophase question is interesting... does this framework allow for differential responses among species to cues? Or is that an alternative hypothesis? Phenophase breadth means more likely generalization... more likely to produce seeds?

This does make me think about those plants on the sort of extreme of spatial and temporal ranges (in these meadows at least). Stuart's isolation questions... In this paper the breadth allows you to pick up more interactions with pollinators. What does this mean on the individual level? Jennifer's 2018 Oikos paper says at least the later plants (in Echinacea system) carry less conspecific pollen.


