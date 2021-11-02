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

### Valverde, J., et al. 2016. Inter-annual maintenance of the fine-scale genetic structure in a biennial plant. Scientific Reports.

- Spatial genetic structure (SGS) produced by
	- restricted gene movement
	- genetic drift
	- local selection
- SGS maintained by
	- local mating
	- short distance seed dispersal
- There are studies of this in perennials (n.b. what I am most interested in) - see Kalisz et al. 2001, Vekemans and Hardy 2004
	- few studies in biennials
	- "perfect" biennial have no overlap in mating due to only flowering in second year, although "perfect" bienniality is rare
	- "inter-annual migrants" - not quite sure how these are defined - allow gene flow among cohorts and produce homogenization
	- how does spatial distribution influence this?
- Here: lookng at two consecutiv cohorts of a biennial in Spain
	- dispersal over short distances only
	- patchy distributions
	- Are the cohorts genetically differentiated?
	- Is there isotropic SGS?
- 100 sampled individuals per cohort
	- most loci at HWE
	- plastids used for haplotypes - 5 haplotypes with 96% of individuals in two haplotypes
- "Global" spatial structures of cohorts but no "local" structures
	- i.e. differentiation between distant neighbors but not close ones
	- Fig. 2 looks like two clusters along a PCA axis with high spatial autocorrelation
	- Looks lik global structure is associated with light availability (shading)
- Environment-genotype correlations: autoregressive models look at PC1 and PC2 (genetic)
	- light availability strongly associated with both PCs (moreso on PC1)
	- PC2 associated with cations
- No evidence of genetic differentiation between cohorts (low FST, non-significant AMOVA)
	- would expect this more in smaller populations where drift is more common
	- 17% of population are inter-annual migrants?
	- Between-cohort gene flow could be due to: delayed seed emergence/dormancy, repeated flowering/delayed reproduction, 
		- (delayed reproduction due to resource allocation?)
- Spatial distribution of genotypes: could be due to local dispersal of seeds or pollen
	- positive (genetic) correlation vanishes between 1 and 3m, while documented dispersal is typcally <0.5m...
	- "congruent SGS pattern showed by the nuclear and plastidal markers suggest that pollinators moving pollen at long distances are not blurring the SGS"
	- "we think that the prevalence of floral visitors that tend to forage at short distances may facilitate mating events among nearby relatives, causing biparental inbreding, and reinforcing the SGS"
- "Asymmetry in SGS for both cohorts, indicating directionally biased gene flow"
	- here the Kinship-distance correlation has spatal periodicity with higher "resistances to gne flow" at 90 and 87deg 
	- not really sure what this means or how it is determined... fig. 4 I guess
	- could be due to non-random movment of pollinators, micro-environment (influencing germination?), or influence from neighboring populations
	- could be pollinator affinity for certain environment types (mediated by light)
	- soil too... supported by other studies, although seedling limitation seems to be stronger in effect

Interesting. Techniques to consider include sPCA, FST (known) and genetic techniques. Worth looking in to the anisotropy and symmetry of gene flow (same?)

Good to note: they did find evidence of spatial structure *associated* with solar exposure. This could just be a function of short dispersal distances and (or?) constrained pollination. They suggest seed germination and pollinator affinity as mechanisms but not phenology. Maybe there is a lot of phenological overlap here? (note: scales of synchrony...) Would phenophase/general phenological overlap influence the effects here?

I need to consider seed dispersal distances throughout...

Like the idea of "inter-annual migrants"... think about these in perennials. The nested project - those (genes/genotypes) who flower most will appear frequenly in successive generations.

Read Kalisz et al. and the 2004 papers next.

### Zhu, J., Zhang, Y., and Wang, W. 2016. Interactions between warming and soil moisture increase overlap in reproductive phenologya mong species in an alpine meadow. Biol. Lett.

- (from intro) "whereas other species might take several years for the cumulative effects of warming to emerge (Hoffmann et al. 2010)
- warming can expand or shorten overlap of successive species
	- possibly moving means away from the summer peak? see Sherry et al. 2007
- Here: a conceptual model for resposes of phenology to warming 
	- warming would delay reproductive phenology of shallow-rooted early-flowering species but advance it for deep-rooted late flowering species
	- test the model in Tibetan plateau system
- System on Tibetan Plateau: summer monsoon season starting around 22 May, growing season mid-May to mid-September
- Passive warming through open top chambers (ITEX-consistent design)
	- measured air temperature and moisture 10cm abovbe ground
	- measured soil temperature and moisture 5cm below ground
	- control plus four levels of warming, four replicates per treatment = 20 plots
	- warming increased air and soil temperature while reducing soil moisture
- Measured phenology of individuals for six species
	- phenology in six stages (modified from Dunne et al. 2003)
	- one species shallow early, two species shallow mid, three species deep late (root depth + timing)
- Warming delayed phenology of SREF, advanced in one SRMF and two DRLF, had no effect on one SRMF and DRLF
	- more overlap between SREF and advanced SRMF in the warming plots
- Life history and rooting depths mean different vulnerabilities to reduced moisture in top layers of soil (see Dorji et al. 2013)
	- SREF would be more sensitive to warming... makes sense because the driver here is the monsoon. But why would it delay?
		- (speculating) because they're trying to avoid periods of stress and wait for the rainy period??
	- SRMF plants start later and typically avoid the early water stress
	- DRM/LF start during hte monsoon and use deeper soil water
		- less constrained by water limitation then and instead (?) respond to the the soil and air temperature
- In general plants moved towards the rainfall peak under warming

Very interesting stuff although I wish they had gone more into their conceptual model. Seemms like the big driver here is the monsoon - in our case though I think the driver would have to be snowmelt. Rather than happening early in the season like our snowmelt, the driving force here is mid-season (same as Sonoran desert plants?)

The deep versus shallow root dichotomy is interesting! The soil profile in open versus shallow areas would be interesting to study; hypothesizing here that open areas have a steeper gradient due to drying and the vegetation buffer? Or maybe it's an effect no matter what the depth is. Note that Dunne et al. 2003 had two soil depths used.

In our case both species are rhizomatous so the effects on phenology up at the top could be due to temperature, but also could be due to what's going on deep with soil moisture. What's the physiological reason that water would influence flowering? Speculating again: flowering means high resource yield so I guess you just want to avoid periods of stress?

### Dorji. T., et al. 2013. Plant functional traits mediate reproductive phenology and success in response to experimental warming and snow addition in Tibet. Globacl Change Biology. 

- The system here is semi-arid The shallow vs. deep root dichotomy seems to be rooted in surface vs. deep water.
- Prediction here: SREF species will have delayed phenology under warming 
because warming will zap away upper-soil moisture
	- spring snow addition would advance phenology and increase reproductive effort of SREF species because it would add more moisture
- Site: has summer monsoon season, also fully factorial manipulation experiments with warming, snow, pika presence
	- 8m diameter circular plot w/ four blocks
	- snow and warming applied in five subplots in each treatment 
	- snow added when ground was snow free as is usual in this system
	- warming done with open top chambers
- Measure air temp 10cm above ground, soil sensors used (at what length??)
- Four species measured: Kobresia, Potentilla (x2), Astragalus	
	- five individuals per plot, noting bud date, flowering, fruiting, and number of each
	- Kobresia: thick clonal mats so plots were subdivided and infructescences assessed
	- Astragalus is DRLF
	- Ps is SRMF (small taproot), Pf is DRMF (shrub with long taproot)
- Treatments: C (control) W (warming) WS (warming + snow), x year fixed efects on phenology, number of flowers, reproductive success
- Warming increased air and soil temperatures by 1-2C
	- snow addition decreased soil temp on ground and a week after snowmelt
	- soil moisture lower in warmed plots compared to controls
	- soil misture increased by snow addition for 30 days after addition
	- mean soil moisture was 5-6% lower in warming than control plots
- Warming delayed day of 50% inflorescences and max in Kobresia by two weeks
- Warming advanced budding and flowering in Astragalus by 2-5 days and date of flowering by Pf by a week
- Warming + snow addition delayed max inflorescence date in Kobresia by two days
	- snow advanced peak flowering days of Kobresia
	- but this was a lot less than the delay of warming alone
	- peak day delayed by 2 days in warming but delayed by nine days in warming + snow
	- snow meant slightly more inflorescences, warming meant ~10% less
- Warming means more K inflorescences, did not influence other sp
	- snow increased K inflorescnences (moisture good) and lowered number of Astragalus flowers in one year (no effect in other), no effects on othe r sp
	- warming alone meant fewer infloresences than warming + snow in Kobresia, no effects of combined treatment elsewhere
- Overall: snow mitigates the negative effects of warming on flowering phenology and reproductive effort because snow adds moisture to the top soil layers at important times
	- however it did influence dates of budding in Astragalus (DRLF) and flowering in Potentilla fruticosa (DRMF)

There's a lot going on in here, but I think it's very similar to the Zhu study above with the added element of moisture. Think this ties in to another study (forget which - saw it but haven't read it yet) showing that moisture modulates the effects of warming under climate change.

Kobresia flowers during relative drought (pre-monsoon) so warming makes it... wait? Is this a form of plasticity or constraint? I suppose if it has a lower moisture requirement to flower but will still flower at some point, then moisture stress will make it wait as long as it can. And/or, perhaps there is a slow increase in precip even before the monsoon. 

The moisture stress here is supported by the addition of snow, which seems to negate a lot of these effects in Kobresia. Warming plus snow had only two days of delayed flowering relative to the control (warming only led to a two week dalay). Snow alone seems to move the date up, suggesting that the moisture seems to limit the earliness of flowering in this species. Moisture also seems to increase the number of flowers (makes sense I suppose).

But the other species didn't have these effects - more moisture mostly didn't influence flowering time in other species (snow did seem to delay it for Potentilla saundersiana - shallow root means it doens't need the moisture? The two mid/later flowering species did flower earlier with heat - possibly because the warmth is what is limiting the earliness of flowering here? 

Some stuff in here about reproductive effort but I didn't read super closely.

Given thoughts above perhaps it's good to think about limiting factors on the earliness? In the Tibetan plateau system, the moisture pulse happens mid-season but I guess temperature increases slowly over time. In our system, moisture I guess is stable and then decreases (snowmelt and June rains) while temperature also increases. For *Thermopsis* is the limiting factor just temperature, then? As in higher temperatures mean earlier flowering? In the *Campanula*, I'm not sure what it would be - moisture? It's flowering later in the season when there is less moisture? If *Thermopsis* flowers earlier maybe it is especially reliant on moisture? Interesting frameowrk.


### Winkler, D.E., Chapin, K.J., and Kueppers, L.M. 2016. Soil moisture mediates alpine life form and community productivity responses to warming. Ecology.

- Warmer temperatures can directly affect productivity by advancing snowmelt (but no other direct effect of temps?)
	- but what about soil moisture? if there is no increase in summer rain, warmer temperatures mean drier soil and most people only think about temperature
	- Elmendorf et al. 2012 shows that temporal increases in abundance and height (huh?) are greatest in wetter sites
	- Elmendorf et al. 2012 (different paper) suggests experimental warming and soil moisture interact (meta-analysis) although results vary for functional group
- Productivity changes could be due to shifts in species relative abundances
- Here: alpine productivity (at Niwot Ridge) as a function of warming and moisture
- 20 3m diameter experimental plots in 2008; five plots get each of four treatments: control, heat (H), watered (W), heat and water (HW)/
	- heating with active infrared heater: nightime warming, maintaining natural wind, modified snowmelt timing, but no warming of air, delivering an extra 215 W/m2 (42 W/m2 in winter)
	- watering (beginning after snowmelt) 2.5mm of water weekly 
	- plots subdivided into 4 1m2 plots to get variation; measure soil moisture and temp every 15 minutes at 5-10 cm dept in center of each quadrat
	- soil degree days is days with soil temp > 0
	- adequate soil moisture days was number of days with mean daily VWC > 0.13
- H-W interaction present in aboveground productivity (with pre-treatment productivity as covariate), explaining 21-53% of variation in productivity
	- community-wide: heating alone decreases productivity, heating plus water increases it
	- interaction strength is strongest for forbs, and slopes suggest that productivity would only increase with water + heating, not with heat or water alone
	- graminoids respond better in heat + unwatered groups than heat + water (negative interaction) so graminoids may do well in a hotter future

Great - more evidence of moisture x temperature interactions. I am very curious to see what results look like in the soil, comparing sub-canopy with open meadows. Given expected warmer temperatures in the future, the outcome (for production at least) depends on the amount of moisture (i.e. if rising temperatures which otherwise limit production are compensated by increasing moisture). All else equal (of course not true), my naive assumption is lower temperatures and more moisture in the aspen subcanopy and lower temperature and less moisture in the pine subcanopy.

The finding about different functional types is interesting. Forbs will do well with wetness + heat, grasses will do meh; reverse is true for warming without water. This could provide insight into the differences between openness and canopy, perhaps. Keep in mind though that this paper is looking only at alpine!

Next step of course is to look at the phenology paper from this group (Jabis et al. 2020).

### Denney, D.A., et al. 2020. Small spaces, big impacts: contributions of micro-environmental variation to population persistence under climate change. AoB Plants.

- Here: micro-environments influencing plasticity, genetic variation, population persistence in the face of global change
- Microclimate: topography, nutrients, water, etc.
	- Ehleringer and Cooper 1988: microtopography and plant physiology
	- Paz 2003: rooting depends on canopy versus understory
	- Anderson 2009, Anderson et al. 2009 on tree and shrub recruitment, plant distributions
	- Cervantes et al. 2005 on light availability by habitat types
- Thermal stress influences photosynthetic yield, root or shoot growth, leaf senescence
	- e.g. stomatal size and density
	- climate change will increase temperature, disrupt precip, altering plant phys
	- combined effects may differ than what is expected from individual effects
	- Microhabitats will be helpful here; e.g. Uriarte et al. 2018 and seedling growth by microhabitats
- -omics: genomics, transcriptomics, epigenomic analyses, specifically on non-model organisms
	- differences in gene expression could underlie responses to variation
	- epigenetic differences: Richards et al. 2012, Herrera and Bazaga 2016
- Plants could be locally adapted (to their biotic or abiotic conditions) to micro-environmental conditions
	- Variation on small spatial scales can produce divergent selection within natural populations - microgeographic adaptation (see various refs here, e.g., Antonovics 2006, Dittmar and Schemske 2017)
	- Uncommon microhabitats can harbor individuals with rare alleles (see some Antonovics papers on heavy metal contamination)
	- long-term studies? Davies and Snaydon 1976, Panetta et al. 2018
	- gene flow: effects on adaptation could be negative (hindering local adaptation) or positive (providing novel genetic material for selection)
	- landscape genetic analyses could be useful (see Wang and Bradburd 2014 - Isolation by Environment)
	- quantifying additive genetic variation would be rad
	- some functional genomics work; e.g., Price et al. 2018 identifying specific genes responsible for a genetic trade-off
	- reciprocal transplants...
- Microenvironmental variation can also select for greater plasticity
	- E. cicutarium in serpentine soils are an example - heterogeneous, within dispersal distance, producing divergent selection
		- more plasticity favored in one habitat type, less plasticity favored in the other?
		- see Baythavong and Stanton 2010, Baythavong 2011
	- More plasticity means more buffering against short-term climatic change
	- also, trans-generational plasticity... not quite sure what this is
- Microhabitats as microrefugia: people currently think that microrefugia (where local conditions diverge from/are decoupled from regional climates) were key for the proliferation of warm-adapted species surviving glacial periods
	- microrefugia are small (by definition) and thus populations therein may have less genetic diversity, but also may be differentiated from each other and/or populations outside the refugia
	- see Mee and Moore 2014: survival in microrefugia may drive evolution of local adaptation?
	- who persists in microhabitats? high tolerance, long-lived, asexually reproducing/selfers, pops with low genetic load (Hampe and Jump 2011, Mosblech et al. 2011)
	- also: small seeds, dispersed by wind, vegetative reproduction also helps
	- note: habitat fragmentation may create microrefugia, but also may make them more difficult to find by altering local climate

Hmm... well... okay. Not as much fine-scale stuff as what we are working on (e.g. final section talks about an example where 20 ha is the size of a microrefuge) but there is some stuff in here about small-scale variation. Specifically look in to the microgeographic adaptation stuff - perhaps this (like the Galloway paper) is just about the selection pressures. There is note of additive genetic variation, but less so about assortative mating. Very little on demographic effects. They do mention isolation by environment (we would be linking isolation by environment with isolation by time). 

### Antonovics, J. 2006. Evolution in closely adjacent plant pouplations X: long-term persistence of prereproductive isolation at a mine boundary. Heredity.

- "Parapatry"/"micro-allopatric" adjacent but not completely isolated habitats, causing disruptive selection
	- some early theoretical work looking at speciation in panmictic populations - Maynard Smith 1966, Antonovics 1968, Dickinson and Antonovics 1973
	- genetic divergence is likely to evolve in such situations, but the evolution of reproductive isolation is "more difficult" to achieve
	- some empirical quant gen stuff confirming theoretical results? see paragraph
- The mine system: high levels of genetic differentiation found over short distances, even with substantial gene flow (McNeilly 1968, Antonovics and Bradshaw 1970)
	- plants on mine soil flowered earlier and had greater self compatability (Antonovics 1968, McNeilly and Antonovics 1968)
		- phenological effects persisted under cultivation in a common garden study
		- this "inverse cline" was consistent with theoretical expectation on an environmental gradient (Caisse and Antonovics 1978)
- Here: visit mine transects to measure flowering times in 1965, 1979, 2005
	- Anthoxanthum odoratum on a mine in North Wales, UK, where mine soil is contaminated with zinc and lead from a mine shuttered in 1898
	- transect east (mine) to west (pasture)
	- 1979: flowering stage of most advanced inflorescence recorded on all plants
		- 829 plants on mine, 228 in pasture
		- 3m wide 60m long transect going in 1m segments on either side
	- 2005: flowering stage of every inflorescence recorded in a quadrat placed on each meter along transect
		- 1647 inflorescences on mine, 1056 on pasture
		- inflorescence-based measurements correlate well with measurements on per plant basis
	- Phenology measured using a numeric scale (1-5) where an increase of one flowering stage means about a week difference in flowering time
	- Isolation index (Moyle et al. 2004): I - 1 - (B/(1-B)) where B = sum_i XiYi / (Xi + Yi) for frequency of population X/Y in ith stage on pasture/mine
		- 1 is complete isolation, 0 is panmixia
- Plants flowered earlier on the mine in both 1979 and 2005
	- isolation index between populations was 0.43 in 2005
	- in 1979, more heterogeneity in flowering times on mine than in 2005
	- inverse cline? less difference in flowering time at transect extremes than mine boundary?
		- no evidence of inverseness in 1979 and weak evidence (underpowered?) in 2005
- Maintenance of this difference over 40 years
	- assortative mating likely, promoting reproductive isolation
	- isolation index suggests that if populations were intermixed, there would be 40% less mating between populations compared to within populations
- 1966 analysis (common garden) shows a genetic basis to the difference
	- 1970 analysis shows correlations between flowering time and metal tolerance were nonsignificant, so pleiotropy unlikely
	- but, there could be direct selection for earlier flowering and therefore earlier seed maturation, as the mine has other attributes differentiating it from pasture other than soil
	- could there be more selection for differing flowering times on mine boundary? more difference in flowering time close to mine boundary
		- in this case, perhaps mixing of genotypes here is bad?

Interesting study here. Here is a clear case where there is an environmental influence on flowering time inducing isolation. It's maintained a long time. The inverted cline is interesting - could we find it here???

### Wang, I.J., and Bradburd, G.S. 2014. Isolation by environment. Molecular Ecology.

- Wright's isolation by distance (IBD): restricted gene flow means genetic differentiation between populations
- Isolation by environment: genetic differentiation increases environmental differences independently of geographic distance
	- One challenge: disentangle IBD and IBE (distance and environment are often correlated)
		- Does some factor explain genetic distances more than just pairwise distances?
	- Another challenge: connect pattern to process
	- relatedly: isolation by resistance (BR) due to probability of dispersal from population to another where more dispersal is less resistance
		- note that IBR conflates IBD and IBE and makes it impossible (how?) to separate these two patterns empirically
##### Processes generating IBE
- One example: differentiation of *Phlox* populations mediated by pollinator communities? (Hopkins et al. 2012)
- Four possible (not mutually exclusive) processes that could influence patterns:
	- Selection against immigrants
	- Sexual selection against immigrants
	- Reduced hybrid fitness
	- Biased dispersal
- Selection against immigrants: driven especially by local adaptation
	- local adaptation of the immigrant means it would be maladapted to a novel environment
	- (thought... more successful migrants coming from a larger and therefore likely more diverse habitat? when would we not expect local adaptation? selection pressure but also heterogeneity?)
	- (anything else? does this rely on local adaptation?)
- Sexual selection against immigrants: divergence in mate choice or sexual signals influences reproductive success of dispersers
- Reduced hybrid fitness: hybrids with intermediate phenotypes may be outside both natal or new niches, or they could have few mating opportunities
	- also: selection acts on the next generations after the immigrants themselves, meaning there could be different selection pressures
- Biased dispersal and/or preference for a paerticular environment
	- e.g., fitness or performance benefits to being in certain environments, or affinities/aversions to habitat types when dispersing across a heterogeneous landscape
##### Studying and measuring IBE
- Most important thing is disentangling environmental and geographic/physical distances
	- (like with the response-surface idea: two dimensional space w/ axes of different distances; it's good to maximize spread)
	- also need to sample thoroughly across the gradient to characterize changes
	- see Fig. 3: give histograms of pairwise distances, estimate correlations of pairwise distances under potential sampling schemes prior to colleciton
		- (estimated curves for IBD/IBE in Fig. 3?)
- Sampling per sampling location: more individuals sampled per location decreases binomial sampling noise around allele freq. estimates
	- but with next-gen sequencing, each individual can be sampled at a lot of loci, such that one can still get good estimates of differentiation between two populations (see Patterson et al. 2006?)
- Statistics: pairwise genetic distances are inherently nonindependent
	- Mantel andn partial Mantel tests explicitly account for the pairwise nature of hte data
		- but, with spatial autocorrelation, partial Mantel has pathological (??) type I error rate according ot Guillot and Rousset 2013)
	- More robust methods include modeling covariances in allele frequencies and matrix regression approaches
		- BEDASSLE (Bradburd et al. 2013) models covariances in allele frequencies across the genome as a decreasing function of pairwise geo/eco distances
		- Multiple matrix regression with randomization (MMRR by Wang 2013) quantifies effects of multiple distances matrices on a single response e.g. genetic differences
		- some other stuff here too, e.g., LocalDiff, MEMGENE on p. 5655
		- Bayenv2 by Coop et al. 2010, spaMM by Rousset and Ferdy 2014, look at fuller genome? spatial autocorrelation in SNPs or genotypes (seems more functional)
- Experiments: reciprocal transplant is the best way to look for local adaptation, hybridization studies (for shorter-lived individuals) w/ a common garden feature
	- think about non-selective processes as well, e.g., biased dispersal, differentially resistant landscape elements
	- possible confounders: population history, demography, heterogeneity could produce migration-drift disequilibrium
- Ecological speciation: definition here is reproductive isolating barriers due to divergent selection under different ecological conditions (refs herein)
	- if IBE always results from selection, IBE would be evidence of early stages of ecological speciation (see Shafer and Wolf 2013?)
	- but, of course, IBE can result from other processes as well, so IBE is one condition under which speciation could happen rather than an indication that it is happening
- "Ideal free distribution" - theoretical null expectation that barring barriers to movement, individuals will move unimpeded through habitat patches and distribute themselves according to resource availability
	- IBE is a deviation from ideal free distribution
##### The future
- Landscape genomics: the environment can act on different parts of the genome differently
	- neutral processes will act upon the entire genome while selection will only act directly on those sites of loci directly under selection
	- IBE due to selection may be observed at these important loci, but may not be seen globally in the genome
- Comparative landscape genetics: multiple species or multiple landscapes
- Population heterogeneity (!!): most of these studies appear to be at the species or meta-population level
	- populations themselves may have heterogeneity in dispersal ability (due to landscape), habitat preference, adaptation to different ecological conditions
	- "few landscape genetic studies have considered how spatial variation in the traits and factors affecting gene flow contributes to estimates of IBE and its causal factors at higher levels"
- Temporal variation: evolutionary forces and ecological processes vary through time
	- what is the tempo (natural scale?) of variation in ecological drivers of diversification
- Ecological processes: looking beyond landscape genetics and towards more traditional landscape ecological methods

Very cool, although I am having trouble fitting this flowering project into their framework. This is in a sense reduced gene flow, although it's reduced spatio-temporal gene flow. Definitely a reduction in/deviation from random mating. Thinking about local adaptation in this system: there's adaptation to, e.g., less light but also are there other things to adapt to? E.g., lack of pollinator availability?

It was good to see the tie-in here to speciation but good to note that this is not speciation per se. We are definitely potentially seeing reproductive isolation here but not necessarily speciation (and I'm not super interested in speciation except for its nascent stages). These refs may be the best places to start.

Future directions: population heterogeneity (responses to differences in environmental "quality" across a gradient) and temporal variation (are we looking at temporal variation here?) is what we're looking at... 

### Donohue, K., et al. 2000. Evidence of adaptive divergence in plasticityL: density- and site-dependent selection on shade-avoidance responses in *Impatiens capensis*. Evolution.

- Population differentiation in phenotypic plasticity and local adaptation - lots of empirical stuff here, hypothesized to be due to adaptive divergence
	- but - selection can perhaps affect plasticity itself
		- if plasticity is costly, then plasticity means lower fitness relative to non-plasticity with the same mean in the same environment
		- correlation between trait mean and plasticity: can vary by environment (okay...) and this is a function of the additive genetic variance of the character between environments (not clear to me)
		- selection on the trait can thus also lead to selection for/against plasticity and therefore differences in plasticity can be (1) environmentally mediated and (2) the result of selection on trait values themselves
- Here: looking at *Impatiens capensis* (annual jewelweed) in different canopy environments
	- crowding and vegetation shade: elongated internodes (taller?) and accelerated flowering (refs herein - but this is the opposite of what I am seeing at MRS?)
	- red:far-red light ratio is a cue here
	- adaptive value (demonstrated empirically) of these responses varies by environment type
		- adaptive in open environments - light as a signal of competition
		- but maladaptive under closed canopy - because there's no way you're going to beat the tree?
	- see relatedly: Morgan and Smith 1979; Corre 1983; Van Hinsberg 1996; Van Tienderen and Van Hinsberg 1996 for comparative studies of sp/pops in open/closed canopy
	- Genotypes from open-canopy sites exhibit greater plasticity in elongation and/or flowering date compared to closed-canopy sites (as predicted)
		- but is it adaptive? must measure density-dependent selection at both sites
##### Methods
- Seeds collected from 18 lines in sun population, 17 lines in woodland population from a reserve in RI
	- weighed, transplanted from plug trays, in two treatments: density (53/m2 in low density, 470/m2 natural for woods, 1305/m2 for natural in open canopy)
	- two weeks after planting, internode length measured
		- size: number of nodes, leaf length
	- plants censused twice per week
- Separate analysis of phenotypic and genotpyic selection
	- genotypic: averages phenotype and fitness across replicates of genotype that is random across microenvironments (think about this)
	- fitnesses: standardized within each treatment by dividing by mean w/in treatment fitness
	- estimating selection differentials (total selection: direct and indirect) and selection gradients
	- phenotypic selection analysis is similar to genotypic one
- Was selection density dependent in each site?
	- analysis of covariance *within* each site: density, population, block as main effects and standardized traits as covariates (response is rel fitness)
	- interaction between trait and density gives selection that varies significantly by density
- Also, ad hoc selection analysis performed at sun site: heavy mortality means changing density environment for survivors
- Selection on plasticity independent of selection on phentypes (costs of plasticity)
	- Difference in genotypic mean phenotype (what does this mean?) between density treatments: this gives plasticity to density
- Local adaptation: ANOVA with site, density, population as fixed effects against DV absolute or relative fitness
	- population-by-site interaction shows fitness differences depend on the site and allows us to see if population has higher fitness in its native site
##### Results
- Direction of selection on internode length: varies in sun, does not vary in woodlands
	- sun: shorter internodes have higher fitness at low density but longer internodes are more fit at higher density
		- plasticity of internode length: a more selectively favored phenotype can be expressed in both densities so the plasticity can be considered adaptive
	- woods: longer internodes favored regardless (so plasticity is, or would be?, adaptive)
	- supports adaptive divergence hypothesis (because the selection pressures on plasticity itself varies)
	- No selection gradient on internode length at low density for either habitat type
		- so, selection isn't direct on internode length at low density; selection does operate indirectly through correlated characteristics (plasticity)
- Later flowering: favored at low density in sun site but not selected for at natural density
	- survival bias possible - high mortality may have removed early-flowering individuals or the decrease in density later in life has an effect
	- in woods, earlier flowering favored at both densities (plasticity again is not favored)
	- selection on flowering date isn't density dependent but is site-dependent
- Fewer nodes favored at natural density in sun site but nowhere else
	- phenotypic analysis: selection shows opposite... idk man there's too much shit going on here
- Some other stuff about leaf size
- Mortality: similar between densities in woodland site, different in sun site (mortality higher at natural densities)
	- n.b. mortality likely due to drought
	- similar mortality curves by population source but slightly earlier senescence for woodland plants in the sun, low-density treatment (god this design is confusing as hell to me)
- No signs of costs or benefits of plasticity?
	- Exception: cost of plasticity in leaf length in woodland site at natural density
		- but plasticity wasn't adaptive at the woodland site so there wasn't a direct cost? 
	- different results when analyzing each character separately (come on man!)
		- benefit of plasticity in internode length at low density in sun and both densities in woodlands
		- but this could be due to selection on correlated traits
	- "the evidence for costs or benefits of plasticity independent from phenotypic values is weak" so I guess this is just the cost/benefit of maintaining plasticity... wait what else would the benefit be? I see the cost (maintenance) but aside from the phenotype what else could benefit the plant?
- Significant correlation between genotypic mean phenotypes and genotypic plasticities
	- direction and magnitude varies by environment
- This "frequency of low density" - I'm not sure what this means, so I didn't read the results on it
- Evidence of local adaptation: plants have higher absolute fitness in their home environment (although only at low density for sun habitat... what does this mean???)
##### Discussion
- "Our results support the hypothesis of adaptive divergence in plastic responses to density"
	- sun population has more plasticity in internode length and flowering date than woodland population
	- here: selection on internode length and flowering date favors selection of plasticity in sunny but not woodland site
	- these results could also be due to drift rather htan selection
- Total selection on plasticity within each site was determined by selection on density dependence on phenotypes which are correlated with plasticity of those phenotypes
	- important evidence here is the fact there was no evidence of costs or benefits associated with plasticity but there was density-driven selection on phenotypes
- Microgeopgraphic scale of shade avoidance: plasticity is helpful in the sun, but stem elongation is not helpful in the shade and thus (plasticity that underlies stem elongation?) is maladaptive
- Also local adaptation for plasticity of flowering time
	- in wooded site, early mortality was common and thus early flowering universally favored (i.e. plasticity here is bad)
	- timing of mortality was density dependent in the flowering site - delayed flowering favored at low density because plants lived longer (plasticity favorted - density determines whether it's adaptive to flower earlier or later)
- "The results of this study demonstrate that even when an environment is rare, an appropriate response to it can give an enormous fitness advantage when the rare environment is more favorable than the common one"
	- [I suppose the magnitude fitness benefit has to relate somehow to the rarity of the environment?] [- ah this is said later in the paragraph]
	- Low density is rare in open environments, but when plants do occur there, tbhe plasticity allows individuals to exploit it for fitness benefit
	- (ah this is the reason for the frequency of density)

Goodness this was a doozy to read. So much going on. Parts of it I don't understand. But... the plasticity seems to be a response to density where certain trait values are favored at natural/low density. Height and flowering time are two identified here (height: response to competition; flowering time: response to mortality). Plasticity here would allow individuals to exploit low densities by adopting the adaptive trait value.

However - there's adaptive divergence occurring here such that the environment determines the adaptive value of the plasticity. Turns out that in a wooded environment that no matter what a plastic response is bad (height: wasted because a flower can't outgrow trees; flowering time: plasticity would deviate from the optimal phenotype).

Okay - I am lost on everything else. I understand the concept behind correlation of plasticity and trait values but don't understand the mechanism or what that looks like in this system. What I do understand is that they measured costs/benefits of plasticity (independent of phenotype - although I still don't know what it means for a benefit of plasticity to be independent of phenotype! cost is obvious though) and found none so it's not the plasticity itself that is adaptive. What is driving the correlation of phenotypes and plasticity? I guess it seems kinda obvious to me that the selection would be on the phenotypes and not the plasticity...

Also some stuff about local adaptation in here. That makes sense. But how does it fit in to the picture.

Some other stuff this makes me think about: so in addition to considering plasticity this does sorta reinforce that there's confounding happening here between environment-type and density. How to control? I suppose I can leverage the fact that there are sunny plots with low density (I think?) although I'm not sure there are very many shade plots with high density to make it balanced. But I guess this should be included as a covariate? Also of course the plasticity stuff. Plasticity is useful to include in a theory model though - or at least environmental variation... but maybe plasticity too ugh jesus christ there is so much I won't be able to do here.

### Schemske, D.W. 1984. Population structure and local selection in *Impatiens pallida* (Balsaminaceae), a selfing annual. Evolution.

- Wright (1946, 1949) showed that mating system influences population structure with selfing promoting genetic subdivisions
	- genetic variation maintained by selfers is larger than people think
	- this study: look at local adaptation in the context of mating system
		- within and between-population components of variation in quantitative characters incl. fitness
		- quantify and compare genetic variation present in local populations
		- experimentally determine the role of selection
- *Impatiens pallida* - annual with obligate selfing (cleistogamous CL) or obligate outcrossing (chasmogamous CH) flowers in central IL
- Three transects, 18m long at two sites
	- Allerton: riparian, Brownfield: prairie with CH flowers on edge and CL flowers in forest interior
	- plants collected at every .9m interval giving 20 plants/transect
	- shaded greenhouse, plants used for seed produced by CL selfing to get F1 
		- 10 plants/family x 20 families/transect x 3 transects = 600 plants
- "Population structure" determined using quantitative characters
	- Plant height (at multiple days), leaf length and width, petiole length, days to first flower, meristems, pods through time and total, CL and CH flowers
	- ANOVA: variance components of each component
		- variance between transects, among-family within-transect
		- seed weight used as covariate to control for maternal effects
			- although I guess this was only done where there was positive correlation between seed weight and the trait? which occurred primarily during the first two?
	- population structure among transects done with discriminant analysis
		- "the discriminant model produces a classification matrix based on a measure of generalized squared distance" [distances in 16 dimensional trait space?]
		- "Each observation (=family) is placed into the class (=transect) for which the generalized squared sitance is smallest."
		- so using the traits to determine how often this classification routine places individual plants in the right transect lineage
- Local adaptation: reciprocal transplant starting from F2 CL seed
- Selection within a transect (local selection) on flowering time
	- Brownfield (where there is variation in canopy coverage) F3 selfed progeny from mid-woods
	- Response is time to first flower (CL)
- Monitoring survivorship and reproduction in natural populations
	- frequency of selfing through cleistogamy
	- compare LH traits from greenhouse to those observed in field
##### Results
- Allerton (flood plain) population shows genetic variation with greater variation within transects (compared to among) for 12/19 characters
	- significant variation in number of CH flowers suggesting genetic variation in mating system
	- variation in some traits increased with age/growth stage
	- among transects: more variation among families in floodplain samples compared to mid-slope and ridge samples
- Brownfield (prairie/forest) genetic variation present with greater within transect variation for 12/19 characters
	- also variation both within and among transects in number of CH flowers -> variation in mating system
	- here days to first CL flower and number of CL flowers are most important for classificaiton (compared to Allerton where it was mostly mating system?)
	- family variance component significant for all traits in edge and mid-woods but only sign for 13/19 innter woods
	- trait differences among transects e.g. 38% larger seeds from mid-woods and inner-woods
	- different LH/fecundity traits across transects incl. time to first flower (earlier in forest)
		- note overlap in family means for flowering time...
- Local adaptation: no evidence of variation among transects at Allerton but at Brownfield it's possible there was post-germination survivorship to reproduction home advantage between seed and forest
- Natural populations: phenological differentiation observed between transects at Brownfield but not Allerton
	- later and also more pods in edge compared to forest
	- extreme mortality at Brownfield - forest plants were dead by mid-July there but 1/3 edge plants survived into September (beetle attacks in July)
##### Discussion
- Differentiation may be promoted by gene flow
	- note that outcrossing followed by selfing will produce recombination (Stebbins 1957) possibly contributing to differences among transects in w/in transect genetic variation
	- forest populations are CL for a long time (selfing) but CH (outcrossing) would allow for genetic exchange in case of some disturbance (presumably increasing light?)
		- (do we know, or is it just hypothesized that, light is what allows CH?)
	- "the impact of gene flow on local genetic variation will depend on the extent of genetic divergence between populations, and local selection intensities"
	- the fact that CH in edge vs. CL in mid-forest and interior forest didn't necessarily produce a noticeable difference in among-family variance in edge vs. mid-forest suggests that perhaps mating system does not necessarily reflect genetic variation within populations... hmm okay not sure I 100% get what's going on here see Allard et al. 1968, Brown 1979
- Drift and differentiation: Wright wrote about theory, but few papers definitively suggesting that drift is more important than selection for creating genetic structure
	- "emphasis on natural selection as the differnetiating force in plant populations is based on the expectation that local selection differentials are large compared to the magnitude of gene flow"
	- here: differentiation found at both sites but only local adaptation observed at Brownfield
		- at Allerton it may be selfing followed by drift that produces very fine-scale differentiation
- Local adaptation appears to be driven by post-germination survivorship to reproduction in home environment

Okay very cool. The multi-level ANOVA approach gives a blueprint into how to do a genetic differentiation analysis without sequencing. It demonstrates scales of variation in quantitative traits. Can we incorporate distances directly into this? I bet we can. I also think we can incorporate flowering time *of the parent* into this.

Note that the plants on which the traits were measured were actually F1 or F2 (I forget). This removes for maternal effects. It also allows us to boost sample sizes! Would be great to use collected seed for this.

It's interesting that the forested plots had *earlier* flowering rather than later. The beetle mortality explains this. I've had two successive years of grazing, particularly in shaded *C* plots, but this doesn't seem to select for earlier flowering there. Constraint? Why does this constraint act upon *C* but not the *Impatiens*?

Gene flow is invoked in discussion but not anywhere else (to my memory at least). Was gene flow actually measured in any way? Flowering time wasn't even explicitly mentioned in the flowering time discussion (but does seem to be implied). The gene flow discussion here is important and useful to return to.

The drift argument - perhaps there is going to be drift in my later-flowering plants because of the paucity of available mates? This reinforces that a selfing study should be done next year. Did the UNC duo look at selfing in *T*? I do know it was done for *C* in some of the 90s papers.

### Servedio, M.R., et al. 2011. Magic traits in speciation: "magic" but not rare? TREE.

- Gene flow and speciation - gene flow and recombination recombinize associations between genes under divergent selection and/or genes causing non-random mating that leads to pre-mating
	- but a selection-recombination antagonism disappears if non-random mating depends on the trait under divergent selection (because the recombination stops? or the gene flow?)
	- **magic traits** are those which cause non-random mating and is also under divergent selection
	- are these traits common? 
- defining magic traits
	- a *magic gene* is subject to divergent selection and also pleiotropically influences reproductive isolation
	- must be true (due to the pleiotropy) that recombination can not disrupt this relationship
	- there must be selective pressures favoring different optima that can coexist in the same population
	- this doesn't include traits that evolve via uni-directional selection e.g. reduce dispersal
	- necessary outcome is the trait contributing to the evolution of reproductive isolation (what does it mean to say "evolution of reproductive isolation" rather than "reproductive isolation"?)
	- see: models with: (refs herein)
		- a single locus contributing to non-random mating and fitness 
		- a trait w/ multiple loci with dual effects on viability and reproductive isolation
		- mating cues being under divergent selection
		- mating within a chosen habitat type (is this us?)
- *Automatic* magic traits: non-random mating "built into" traits under divergent selection with non-random mating as an unavoidable byproduct
	- e.g., phenology (Lowry et al. 2008 "The strength and genetic basis of reproductive isolating barriers in flowering plants")
	- other examples: flower color (if different colors mean different pollinators), habitat choice
	- could also occur if individual survival (in specific environments/locations) produces assortative mating; local adaptation will contribute to the assortative mating
- *Classic* magic trait: divergent selection acting on mating cues (but not necessarily producing non-random mating?)
	- requires: (1) the magic trait and not something correlated must control the selection (2) the magic trait and not something correlated must produce non-random mating
		- e.g., butterflies that prefer to mate with the same color pattern (divergence produces sexual isolation) and coloration is subject to divergent selection (somehow related to mimicry)
	- could also arise due to selection acting on mating preferences (sensory drive: perception of potential mates)
- Importance of magic traits: end result of speciation (degree thereof? differentiation at least I guess) depends on the magnitude of the effect
	- reproductive isolation can occur by other means independent of the magic trait (should ask: how much isolation is there before the magic trait divergence)
	- some stuff about mimicking by non-magic traits... linkage disequilibrium, etc., also interactions

Digging this but hard to directly tie in to what we're doing. Magic traits: same trait (gene) is simultaneously under divergent selection and producing reproductive isolation. One ref in here (Lowry) that discusses flowering phenology as a barrier here.

Divergent selection - are we seeing this? We don't have evidence that selection is necessarily operating in either system. The trait producing reproductive isolation is quite obvious though. It's physical or physiological constraints is it not? Or is that selection? Not sure.

### Hall, M.C., and Willis, J.H. 2006. Divergent selection on flowering time contributes to local adaptation in *Mimulus guttatus* pouplations. Evolution.

- First para: refs on environmental determinants of flowering time (day length, light level, temp, snowmelt timing, nutrients, water availability)
	- refs on genetic divergence in flowering time
- "adaptive flowering time hypothesis" - flowering time differentiation contributing to local adaptation
	- difficulty: populations don't just differ in their timing of reproduction but also in other important traits (Clausen et al. 1940, Hiesey et al. 1971)
	- flowering time could be adaptive, but selection could also be operating on correlated traits
	- better approach: use "genetically variable hybrids" (traits uncorrelated?) in a reciprocal transplant design
- Here: *M. guttatus* and its huge range; within species diversity in several traits
	- does the evolution of flowering time in different habitats contribute to local adaptation?
##### Methods
- Two *M. guttatus* subpopulations - coastal (**DUN**, *var. grandis*) and inland (**IM**, *var. guttatus*)
	- same latitude -> same photoperiod (approximately)
	- IM: diminutive annuals in shallow porous rocky soils and variable montane environments, fall germination with June flowering (outcross)
	- DUN: perennials in coastal dunes with stable environment (incl. moisture via fog), long flowering season, some vegetative growth 
- Experimental hybrid approach: recombinant inbred lines (RILs) from individuals crossed between combinations
	- crossed individuals from an inbred IM line to a single DUN plant
		- this inbred IM line (IM62) has been used in QTL studies
	- some other stuff here that I don't understand
- Reciprocal transplant of parental and hybrid genotypes into a DUN population and to a site near the IM population
	- seeds in greenhouse, germinated, thinned, transplanted into transects approximating densities at each site
	- visited sites on alternate days to monitor flower production
		- measured phenotypic characters to note possible trait correlations, e.g., corolla width, corolla tube length, stem thickness, etc.
		- all Cascade plants died in July; survivors at Dunes monitored after
- Analysis: 
	- do trait values vary among four genotypic classes and at the two sites? ANOVA on all traits and characteristics w/ Tukey-Kramer HSD comparisons
		- Pearson correlation coefficients, one estimate per site, for each trait pair for each genotyipc class
	- composite measure of fitness: lambda_i (growth rate of a population where all individuals are equivalent to the ith individual) (McGraw and Caswell 1996)
		- at Cascades, just each plant's fecundity in year one or total number of seeds
		- at Dunes, use a projection model approach
	- phenotypic selection: only focus on a subset of uncorrelated traits
		- relative fitness (abs. fitness divided by lambda of class) regressed onto four traits of interest to get linear selection terms
		- flowering time: linear and quadratic selection on all classes at DUN site due to differences in sign among classes, test of stabilizing selection
##### Results
- Highly significant differences among genotypic classes within site
	- flowering was rare for DUN plants in the Cascades
- Differences in fitness among phenotypic classes and among sites (incl. interactions)
	- native plants had higher fitness than non-natives at both sites
		- at Cascades, no DUN plants survived to flower before drying (IM plants did fine)
			- BC-IM hybrids also outperformed BC_DUN hybrids at cascades
			- BC-IM hybrids having higher fitness than local IM plants?
		- at Dunes: no differencese between native and non-native plants for survival to flowering but more flowers (and seeds) per plant for DUN plants
- Phenotypic selection
	- Cascades: selection for earlier and larger flowers for both IM and BC-IM plants
	- Dunes: larger flowers (and plants) and different selection pressures among classes
		- some quadratic relationsihps for date of first flower (stabilizing selection)
##### Discussion
(start here)

### Clark, C.J., et al. 2007. Are plant populations seed limited? A critique and meta-analysis of seed addition experiments. Am. Nat.

- Why care? Mechanisms influencing abundance and distribution of [plant] populations is "a central challenge of ecology"
	- recruitment failure can be: propagule production, propagule transportation, competition, predation, herbivory, although most people/studies focus on propagule availability in space or time
	- "a growing consensus" that processes early in the life cycle have a disproportionate outcome on this
- *Seed limitation*: fewer individuals "than possible" because seeds are below saturating densities to match all potential recruitment sites
	- source limitation (not enough seeds produced, even if seeds could reach all sites) vs. dispersal limitation (not enough seeds reach all sites although enough are produced)
- *Establishment limitation* population size is constrained by space for establishment (and not the number of seeds)
- Relative influences of these two processes:
	- if establishment limitation is more important, then community composition is determined by competitive ability (over few sites)
	- if seed limitation is more important, then it's more of a lottery model where the better competitor only wins a few sites and most microsites are drawn at random from the available pool of seeds
- Thus the seed addition experiment: add seeds in some places and not others, compare seedlings
	- if there is no increase in seed density after seed addition, then one can conclude there is no seed limitation
	- if there is an increase after addition, then limitations is at least partially attributable to seed availability
	- n.b. this only tells us about early life stages and whole-life cycle analyses may show something different
- Difficulty in interpreting results, though, if seed limitation is found
	- Is the study taking place in a place where the species does not occur at all, or simply in sites where we wonder why there aren't more?
	- for the latter (determining what limits size/density rather than prohibiting a population) the number of seedlings is important and the *magnitude* of the response is more important than presence/absence of limitation
- seed limitation is a *continuous variable* that is often dichotomized inappropriately
	- seed and establishment limitation as opposite ends of a gradient
	- proportion of seeds planted that emerge as a magnitude of response?
	- what happens if the number of seeds that emerge is intermediate? two factors limit the response but vary in the strength of their effects
- Here: meta-analysis on 43 publications
##### Methods
- Effect size for ith study: (R_exp,i - R_cont,i)/A_i
	- i.e. seedling densities in experimental plots minus the densities in control plots, divided by the number of seeds added to experimental plots
	- can be interpreted as number of recruits obtained per sown seed
	- note: sampling error can produce E<0 or E>1
- mean effect size is a weighted average of effect sizes, with weights with a weighted resampling procedure based on total number of seeds added
	- pooled weighting used in some cases (multiple species or multiple seed densities added)
- Absolute effect sizes: E_abs,i = R_exp,i - R_cont,i
	- not explained why this is done
- Also: disturbed vs. undisturbed settings
- Analyses: separate for disturbed vs. undisturbed plots, and for those species occurring in both disturbed and undisturbed, looked at the differences in effect sizes
- 43 publications, 798 effect sizes, 159 species
##### Results
- In undisturbed environments: only 15 per 100 seeds emerging as seedlings
	- only 12% of species had E > 0.5
	- Variation in response: good portion of it explained by seed origin, seed size, seed presence, and avg. seed bank longevity
		- shorter-duration seed bank are more seed limited than those with longer seed banks
		- marginally positive relationship between seed mass and seed limitation (more mass -> more limitation)
- In disturbed environments, only about 14 per 100 seeds emerging as seedlings
- Effects of disturbance: direct comparison from the same study (75 studies) showed that disturbance means ~10 more emerged seedlings per 100 seeds relative to undisturbed plots
	- no differences among grouping variables estimated
##### Discussion
- Note that without more information from later parts of the life cycle, the (already modest) effects of seed limitation may be overstated
- Two explanations for the modest effects of seed limitation:
	- There may be an establishment bottleneck occurring between the seed deposition and the seedling censuses (Harper 1977)
	- And/or could be due to experimental design where seeds are added at biologically irrelevant densities
- Post-dispersal factors constraining establishment areimportant
- Seed predation and herbivory: mixed results on how much seed limitation influences plant population sizes
	- predation should only affect abundance of plants that are seed limited (if seed density is what determines plant density, and seed density is reduced by herbivory, then plant density will also be reduced)
	- whereas if plants are microsite limited then reduction in seed density won't really influence plant density
- No variables measured (of 16) only weak evidence for any on degree of limitation was found
- Proposed improvements
	- most addition experiments are not designed to separate density-dependent and density-indpendent mortality (but see Shaw and Antonovics 1986)
		- results could vary if there is a non-linear recruitment function (e.g. density dependent emergence)
		- Poulsen et al., 2007 looks at 18 studies with multiple augmentation levels, finding that a linear recruitment function fitted as well as a non-linear one
	- knowing the natural number of seeds deposited via seed rain would be helpful  by reducing/controlling for noise occurring naturally
		- more seeds per plot on average may mean more variation and therefore it would be harder to determine differences

Good and helpful study! The continum argument is useful especially for our model. If doing averaging over a sufficient number of replicates (that reduce effects of background variation in seed density), then we can say that E is an estimated establishment success per established seed. We can partition this further into germination etc. if we are interested (seems cool). 

Useful to note that in general the rate of limitation is small, and the effect size is very likely to be less than 50%. Seems then like we would want to add a lot of seeds to increase the chance of observing an effect.

Points at the end about the non-linearity and knowing the background variation of seed rain are helpful. It's good to know that non-linearity doesn't appear to be widespread or strong at least. The background seed rain - I can go up one day and assess this myself to see if this is easy to detect.

Next up the Poulsen et al. 2007 paper could be a good read.

### Cortes, A.J., et al. 2014. Small-scale patterns in snowmelt timing affect gene flow and the distribution of genetic diversity in the alpine dwarf shrub Salix herbacea. Heredity.

- Climate change: changing growing seasons  and plant phenology (several refs including Elmendorf et al. 2012), but there is small-scale topographic variability herein that can operate on even a few meters (Yamagishi et al. 2005, Scherrer and Korner 2011)
	- can produce local adaptation (Gonzalo-Turpin and Hazard 2009)
	- genetic diversity and migration on such small scales: see Hirao and Kudo 2008, Shimono et al. 2009
- Snowfall variation: snowbeds are depressions and ridges are more exposed and have much less coverage during the winter
	- ridges are more stressful: less water, more frosting at either end of season
	- phenological effects of snowbeds: Shimono and Kudo 2005, Kudo and Hirao 2006
	- Stanton et al. 1997 on fine scale genetic structure (some other refs in here about flowering time)
	- pollen flow can be restricted due to phenology - but seed dispersal can counteract this
		- although gene flow operating primarily due to seed may produce source-sink patterns (Nathan and Muller-Landau 2000)
- Ridge/snowbed very much like climate change threatened vs. climate change resistant environments?
	- restricted gene flow and differentiation may produce local adaptation in which case some species such as late-snowmelt associated genotypes of long-lived species like shrubs may have trouble persisting
	- early-snowmelt genotypes of long-lived species may have trouble colonizing because long-lived species have rare colonization anyway
	- asymmetric gene flow could also affect genetic variation
- Study questions:
	- Do differences in snowmelt mean different flowering times
	- Do differences in snowmelt microhabitats mean differences in genetic diversity
	- Are patterns of genetic differentiation and gene flow driven by snowmelt?
##### Methods
- *Salix herbacea* long-lived (up to 450 years) prostrate dwarf shrub
	- wind dispersed seeds
- 12 sampling sites in Swiss Alps on three mountains ~10 km apart
	- two altitudes on each mountain
	- snowbed and ridge chosen at each altitude (determined by topology - topography? - and vegetation)
- 30 *S. herbacea* stems randomly sampled at a 100m2 plot at each site - 360 samples total
	- five leaves sampled per stem, stored in empty tea bags (!)
- 359 patches (!?) outside of the other sites but on the same mountains surveyed
	- snowmelt and flowering time recorded weekly in 2011, 2012
	- assessed flowering time ~ snowmelt x altitude with linear models
- Microsats
	- departure from HWE, F_IS assessed
	- number of alleles, expected/observed heterozygosity, at each site
	- compare number of alleles, heterozygosity metrics between microhabitats w/ linear mixed models
		- microhabitat as fixed effect, mountain as random effect
- Genetic differentiation
	- pairwise F_ST among 12 sites
	- Mantel test: correlation between F_ST matrices and snowmelt distance (partial Mantel to look across geographic distance classes - among-within mountain, altitude, microhabitats)
	- STRUCTURE used to quantify population structure
- Effective population sizes and pairwise migration rates based on coalescent theory and MLE
	- something else to look for recent/ancient migration and demographic processes depending on re-colonizatiom etc.
##### Results
- Yes - earlier snowmelt on ridges compared to snowbeds such that ridges were snow free a month earlier than snowbeds
	- notably in 2011 snowmelt was almost a month earlier than 2012
	- strong association of flowering time and snowmelt time: slope .805, R2 .827
		- altitude did not influence flowering time differences
- 97 alleles, 11 private alleles evenly distributed among microsites (private allele?)
	- higher inbreeding than expected under HWE
	- no evidence of bottlenecks
	- more allelic richness, slightly higher heterozygosity in snowbeds than ridges
- Low genetic differentiation among the 12 sites
	- no significant differences within- or among-mountains, or within- and between-microhabitats
	- genets from same mountain were more related than those from different mountains (wait... what does this mean for above?)
	- relatedness did differ among within- and between- microhabitat comparisons
- Non-significant Mantel tests for F_ST ~ relatedness, F_ST ~ snowmelt
	- F_ST ~ geographic distance, and relatedness ~ snowmelt distance n.s. when accounting for geographic distances
- K = 2 as the most likely number of clusters (n.b. this is the smallest allowable by the test)
- No evidence of bottlenecking
	- number of migrants per generation attributable to asymmetric gene flow, not post-glacial recolonization dynamics
	- asymmetric migration between microhabitats
	- non-zero migration among mountains but more migration within mountains
#####  Discussion
- There is phenological differentiation but it does not lead to genetic differentiation among microhabitats
	- But, later-snowmelt habitats (snowbeds) are more diverse and receive more gene flow
- The genetic differentition result is contrary to a number of other studies (e.g. Stanton and Galen 1997)
	- n.b. that they were limited to only testing for structure at seven putatively neutral microsats - differentiation could be occurring at other regions (refs here about local adaptation)
- What's stopping genetic differentiation from occurring?
	- Seed dispersal could be occurring
		- in this system, seeds are wind-dispersed and snowmelt rarely poses a problem for seed dispersal across microhabitats
	- There could be intermediate sites acting as gene flow bridges
	- The phenological barrier could be broken by a couple of years of extreme or aberrent weather
	- Could be something with recent ancestry... I didn't understand this but also barely tried to read it
- Asymmetric gene flow: very likely to be due to phenology, probably just the fact that the snowbeds are in depressions
	- could also be due to moisture and conditions for establishment

Super cool paper. Obviously for my purposes the most important finding is that phenological barriers do not necessarily mean genetic differentiation - there is basically none here at scales that I am interested in. The dynamic phenological barrier argument is a cool one. I am convinced by the seed dispersal argument though.

What differs in our systems? (1) there may be quite large differences in establishment probabilities between canopy and open meadow - in fact I have some papers that show this, e.g., I think one of the Young papers in Med Bow and also an Albrecht paper in a different system. (2) Most obvious thing is our seeds are not wind pollinated but instead are large fruits that are more likely to disperse shorter distances by gravity. Of course, it's hard to know if this is true without a natural study. (3) Some system specific differences, e.g., pollinator communities, reproductive strategies and allocation, life histories... may be that our shorter lived plants have more pollen movement? Does that make sense or produce an effect in the direction that would create this result? Perhaps not actually...

Oh yeah and of course I will need to look at snowmelt and its effects independent of canopy coverage (inasmuch as that is possible).

It would be nice to look at the richness in different sites too - very relevant for the climate change claims I am making. Can I do this just with the quantitative traits? I don't see why not.

Next steps are to read some of the phenological offset papers - lots from Japan. Also Stanton and Galen 1997 (holy FUCK this is a 35 page paper) and Elmendorf et al. 2012.

### Munoz-Pajares, A., Abdelaziz, M., and Pico, F.X. 2020. Temporal migration rates affect the genetic structure of populations in the biennial Erysimum mediohispanicum with reproductive asynchrony. AoBPlants.

- A population - what is it?
	- certainly, a common feature is variation in the number of individuals contributing to the next generation, which produces spatio-temporal variation in allele frequencies and creates genetic structure (refs, incl. Rosenberg et al. 2002 - lol this is about human genetics)
- We know about genetic structure in space - genetic structure in time is less well- studied but has been formalized in some work (e.g. Hendry and Day)
	- it will be important when organisms require > 1 year between reproductive periods; biennials are an extreme case of this
	- importance ofc depends on heritability of flowering time: complete heritability means distinct mating demes with no interbreeding (Weis and Kossler 2004)
		- in a case like this, individuals belonging to one deme but reproducing with another are temporal migrants which will reduce differentiation
	- asynchrony in reproduction well studied in many animals, e.g., salmonids, and when considered in plants people are usually considering seed banks
- Here: what do temporal migrants do to genetic structure of plant populations over time?
##### Methods
- Study organism: *Erysimum mediohispanicum* - biennial in Spain
	- 2-3 years as vegetative rosettes before dying after reproduction: semelparous but with variation in timing of first reproduction
	- mixed mating, diverse pollination community, wind dispersal
- Field: haphazardly tagged 100-120 vegetative rosettes of similar size (most of them) per site per year
	- prev. work and domain knowledge suggest that all of these were 1 year old whne tagged
	- estimating portion of rosettes completing their life cycle in 2 years (to get individuals who require >2 years - these are the migrants?)
	- 807 plants total
- Leaf material collecteed from 30 individuals per deme to assess genetic diversity and differentiation
	- three years, four populations, two demes per population -> 720 individuals
	- 687 individuals genotyped across three years
	- mean alleles per locus, obs. heterozygosity, gene diversity (?) estimated for each individual
	- hierarchical analysis of molecular variance gives hierarchical F-statistics that gives genetic variance at multiple scales
	- genetic structure in STRUCTURE
	- genetic distance between demes
- Demographic-genetic model
	- vegetative and reproductive individuals: can't interbreed
		- reproductive individuals are from seeds germinated two years prior whereas vegetative ones are only one year prior
	- define temporal migrant rate as the proportion of individuals from a specified deme reproducing one year later
	- temporal migration event probability: frequency at which migration occurs over time (more ecological/environmental?)
	- N_T is total reproductive individuals recruited into deme through reproduction N_R or immigration N_M (subtracting individuals emigrating from deme N_E)
	- N_R(y, d1) = lambda(y, d1) N_T(y-2, d1) if deme 1 has tth generation at time y; lambda is growth rate sampled from normal distribution with mean 1 and sd 0.01
		- (N_R for second deme is defined similarly)
	- migration between demes defined by m_{12} and m_{21}
	- individuals with 100 unlinked diallelic loci 
- Model run at 10 scenarios:
	- constant migration rates, 0-90% of individuals
	- at each migration rate, 11 scenarios of event probabilities from 0 to 1 over the generations
	- (I think this is proportion of population vs. migration occurring at all)
	- gene diversity, genetic differentiation between demes and among individuals within demes calculated on final genotyeps after 100 generations
##### Results
- Empirical: temporal migration varies from 15%-67%
	- mortality of individuals was ~1/3 in one year and ~50% in another
	- no differentiation among sites
	- genetic differences among demes... uhm these results are not clear to me?
- Model: large migration rates and intermediate migration event probabilities maximize the probability of deme etinction and recolonization
	- mean individuals per deme is minimized with higher migration event probabilities
	- no migration means high degree of temporal differentiation
	- "U"-shaped relationship between genetic differentiation and temporal migration rates: a lot or very little of migration means more differentiation
##### Discussion
- The expectation that increasing temporal migration rates would homogenize populations: met but with caveat
	- genetic distance also went up again with high migration
	- could this be because migration means *loss of individuals from the donor population?*
		- loss of these individuals contributing to demographic stochasticity (genetic stochasticity?)
	- migrants as survivors of mass mortality events...

Okay discussion was nothing to write home about but this is a cool concept. Shows temporal (inter-annual) structure. Implications for perennials not flowering every year (Amy's stuff)... nested structure seems like it would minimize genetic structure.

Temporal migrants - MRS study can also feature mixing by temporal migrants (environmental migrants?). Maybe those that are ducking behind a tree? The migration rate (variance around the environmental-flowering time trend) allows for mixing despite little overlap. But the scale of environmental variance would also influence this.



