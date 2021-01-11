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


