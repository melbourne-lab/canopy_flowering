# Field notes (2022 field season)

### May 31

I had gone out and checked conditions at the site twice earlier this month.

May 26: after the large snow event (~May 21/22) nearly all the site was beneath snow.
Meadow interiors had ~2 inches. A handful of trees had bare patches. 
Also a couple of bare areas on the slope in the SW meadow.
Blue flags indicate bare areas.

May 9: very little snow left at the site. Flags mostly noting remaining snowbanks.

I tried setting up plots today but got snowed out.

Arriving today, there was <5% of original snowcover on ground. Definitely T that was up, including in aspens. No flowers.

I put out plots 1 - 31; these were nearly all plots east of the middle aspen stand (including).
I stayed pretty faithful to the locations and estimation desciles
(see `setup/setup_2022/plot_stratify_sampling.R` and related files).

Snow rendered the paper map unusable so I stopped. Snow was sticking when I left.

Will return soon.

### Jun 2

Went up today to finish establishing plots. Snow was mostly gone - meadow interiors were zapped, aspen zapped, pine ~75% covered.

In total, I put out 70 plots as planned. Plot locations marked with pink flags (super visible!). 
I ended up not using any other of the snow markings. These have been mostly collected.

I went through each plot at the end of the end of the day and recorded snow.
The following plots had >50% snow still on them:
19, 34, 39, 40, 41, 42, 44, 48, 57, 59, 65
The following plots are snow free and have *not* been established yet (ran out of time):
14, 15, 16, 17, 18, 33, 52, 55, 60, 61, 63, 64, 68, 69, 70

Aspens have not leaved out yet. Buds visible but still very early.
Aspens have started leafing out on P2P though.
I drove through Ned on the way back and the roadside T on the entrance to town looks done (!).

### Jun 4

Late start today, only focused on installing sensors. Installed two: one at 33, one at 67.

I did not pay special attention to the direction the mount plates needed to be facing. I put SP510 cables facing north.
I misplaced my ruler so depths were approximate but serviceable (used a thumb-length as a substitute for an inch).

I also placed flags at some of the SW plots including 33, 52, 54, 63, 64, 68, 69, 70.

### Jun 6

I got to the station today and unfortunately realized I forgot to check which sensors to install.
Trying on the station computer generated a different list than my old one (maybe because their version is from 2016?!)

I installed sensors at 64 (from old list), 2, and 15. Next up should be 47. Shovel is by plot 15.

A low stand of aspens had leafed out but none others. I'm pretty sure there were no plots under the aspens leafing out (they're a few meters S of plot 2-4).
Plot 2 had not leafed out yet.

I got rained out before I could do much else. Did not establish any plots. Did not do a card swap on June 4th's sensors.

I was able to swap one of the mount plates on one of the poles without a level. 
While I can replace some (four) of these, I figured that I can also replace them with unused mount plates.

There were some T plants with yellow buds visible in the SW meadow. Still at least two days from flowering though. None in plots (that I saw).

### Jun 9

I set up a sensor at plot 125. My own lack of preparedness meant this is the only one I was able to put up today. I lost my ruler again.

I was also able to put up the remainder of the plots. There were a couple of small patches of snow, with none in plots.

Flowering: I saw <10 plants flowering site wide. The amazing thing is that two of them were in plot 118!
There were a few YV plants but nto as many as I expected. Some in 169. Some in areas that seemed first to snow off - steep part of the SW meadow and the N side of the NW meadow. Very few open flowers.
Lots of kinked stems on the plants at 169. I wonder if this is from snow?

I talked with Amy W. (!) today about pollen.
She said with EP she uses toothpicks. Could I do this?
She also recommended using an electric toothbrush (brush removed) for buzzing pollen off.
She suspects that organzo bags trap moisture.
She stores pollen in a cooler with an ice pack, ut likely doesn't last very long.
Dust study sounds cool!

I swapped cards on sensors 133 and 167 today (haven't read them in yet).

### Jun 13

Started the day doing phenology. Flowering or budding plants in ~10 plots, nearly all in the sun.
But there *are* some subcanopy plots with a lot of plants in them! Let's hope...

There are some plants budding (including a handful of YVs) below aspen canopy but none flowering.
Not crossing this week was a good idea.

Sensor 167 was toppled. I fixed it around 12:03. Level may be slightly off.
Between 4:30 and 5 I also reset the timer on 133 and 167 (on accident).
I collected data from these as well.
Looking at the data collected last week from these two:
the timer on 133 was never set (?) and the soil temp readings look bad (as if first digit was usually but not always clipped off?)

I installed another sensor at plot 37 for a total of seven in operation now.

I also spent some time in the afternoon playing around with pollen. 
In retrospect, this was *not* the proper time to do this because there was little pollen!
(There was some though)
I found that the flat-headed toothpicks were better at getting pollen than the pointed ones.
But, it was still really difficult to get pollen off of these and into the vials.
One *could* maybe walk around with toothpicks, broken in half perhaps, within vials and simply use thos as applicators.
What I think may work much better (or at least be more efficient) is to simply use an electric toothbrush.
You can stick the brush within the flowers easily and buzz it quickly to get pollen - much easier (and less destructive) than t-pick scraping!
It may be clumsy and awkward to walk around with the brush like that but I think it is much, much more effective and efficient for collection.

I put out some bags on 11 plants in three patches (all in upslope/western meadows).
I actually think these can be used for "week 0" crosses - selfing vs. inbreeding in same environment. 
Small sample size but not nothing.

A possible procedure for recipient plants: bag all budding plants (not in plots) with numbered flags, then pull a random sequence of them...

(ETA: June 14: the weirdness with the soil temp readings is because of negative readings
could get creative with rdiff() and such but this seems sloppy... look at Ard script)

### Jun 16

Good day today. Zel's first day. Arrived at ~8:10 and started ~8:45. Started with practicing with crosses.

Started crosses in earnest around ~10:15. Started in SSW meadow, in the open areas. There were three plants here.
All crossing plants will be tagged with tag numbers > 2500 (today: 2501 - 2013).
Although there were *some* open plants in the shaded areas, there weren't a ton. 
Thus we only had two treatments: selfing and outbreeding-same for only open environments.
Plants were assigned randomly to treatments using a bernoulli RNG, no replacement (watch). 
Think of the ten plants, the breakdown was 6 selfed, 4 out-same.
There were also three treatment plants in the SW meadow and four in the NW
(one previously-bagged plant had its bag/infl ripped off).
All plants emasculated first, then treated.
Worked well to have one person emasculate and another do pollen transfers.
For selfing treatments, emasculated anthers were collected in a vial for pollen application.
For the outcross-same treatments I collected pollen from 5 plants in the same population.
All pollen application was done with a Philips Sonicare toothbrush (Zel has one of these as well, but did not today).
(also for the record Zel is a great emasculator... probably good to record in notes who did which step).
We did apply nail polish to calices, although realized after a bit that there probably wasn't a need for multiple colors
(because treatment was recorded on the datasheet)
although it would be good to have different colors for different days.
Also - in the future I will need to bring a cooler for storing pollen.
Zel and I did bag 16 (in most cases) buds for use next week in SSW open, NW open, center aspen, creek aspen.
We can use a numbering scheme (numbered flags, randomly pull some) to randomly sample.
A note for treating buds on already-treated plants: finished flowers may have more frangible peduncles.

Also did phenology. There are a good number of shaded plots that have green-bud plants. 
169-170 popping. Nothing else popping in quite the same way.
Definitely saw some plants fruiting! Very cool.

Note: for phen, first two datasheets had Fl columns before Infl columns (for some reason)
Confusing! I fixed these for subsequent datasheets. I think this is more in line with datasheets of yore.

No dataloggers installed today. Hopefully will do Monday. Current thoughts are: 
- next Monday: phenology, pollen addition, sensors
- next Tuesday: boatload of crosses

Zel is able to participate both days (great!)
She logged ~11 hours today (7:30 - 7:15, including driving)

### Jun 20 2022

Solo day today (Zel had to opt out due to an injury)

Started with phenology (started at bottom) with some pollen addition.
I ran out of tags (!) in the last two plots so there are two untagged YV plants in 163 and 166.

For pollen addition: probably would have been better to do some sort of paired design (oops).
But, I did "treat" 24 plants. I painted addition plants Orange and contol plants Gray.
Visited 3-5 plants for each pollen addition treatment. Used toothbrush, etc. etc.

There were a handful of plants missing from today's datasheet... not sure what was up with that (bug?)

Also put up a sensor (sadly only one) in plot 40.
Annoyingly I lost one level and another one - get this - didn't even have a bubble in it! What the fuck!

I'm ready to put up another sensor in the spot of the old reference sensor (plot 6).
Tomorrow is the solstice should be good to get that data.

### Jun 21 2022

Went up with Zel today for a full day of crosses.

Did four areas, in order: 
Creek area (aspens w/ plot 114), 7 plants 
NW meadow (N border, near last year's plot 50), 7 plants
SSW meadow (N border), 7 plants
Center aspens (w/ plot 130-132), 6 plants

Some notes:
- Sampling: procedure was to put out 16 numbered flags by bagged plants and randomly sample seven (pre-determined)
(treatment was also pre-determined, randomly)
- I put out green flags at finished plants (did not do this in Creek - will need to go back for this)
- Tags: used tags 2501 - 2546 today
- Due to time, we only did six plants in the final group
- Zel should be up to 20-21 hours.
- Two plants were double-treated (last time and this time). Interesting to see what happens!
- In C aspen stand (maybe also SSW), some plants had one inflorescence bagged and the other open... bummer
- Out diff/away pops:
  - Creek: entrance meadow
  - NW: C aspen stand
  - SSW: small aspen stand uphill NW of Julian's meadow
  - C aspen stand: slope in SW meadow

Some observations:
- Zel is better at this than me (good!)
- Lots of infloresences with a crazy number of flowers in the central aspen stand (!)
- In the central aspen stand, some flowers (always on bottom) had a larva inside. Not sure what this is! Should have collected...
Consequence is that (self) fertilization may have naturally occurred! In any event no pollen was being presented.
How did these effers get in? We did not treat these plants.
- Relatedly, I did see a B. nevadensis pollinate a bud in the central aspen stand... possible this happened to some bagged plants?
- Also relatedly, I saw an ant crawling around on the inside of a bag somewhere. Seems these are not totally sealed (ugh).
- Other plants: Dodecatheons out! Paintbrushes out! Not much else of interest...
- The previously treated plant in NW meadow didn't look like it was seeding... but Zel said the one in SSW looked like it was

Some thoughts:
- Thought that occurred to me is that crossing distance and home/away are confounded... 
probably would be better to do distant pollen from same environment, otherwise we're kinda just looking at optimal crossing distance.
oh well, not gonna change now
- What to do about ants and whatever this insect is...? (we should collect these fruit I guess!)

Did not get to install sensor. Bummer!!

### Jun 23 2022

Began by installing a reference sensor at the (hopefully) same location as last year's plot 6.
I checked in the afternoon and strange formatting issue notwithstanding (see below) it works.

Phenology: RNG did good, human did bad. Lots of flowering plants just outside of plots. Hmm...
I think I'm up to ~16 plots with tagged/flowering plants in them - definitely some budding in others.
Lots of plants that are done and into fruiting now.
Not sure that my addition treatments worked... we'll see.

Also went around and (1) bagged 5-8 plants in
- SW meadow interior
- C aspen stand
- Creek aspen stand
- Upper part of E meadow

Finally, checked on batteries and data in a bunch of sensors. 
Batteries - outstanding performance. First ones (installed last month) are around 3.9 V.
A handful of these (06R, 115) had a strange issue where the header was missing... not sure why (easy to fix).
115 also did not have its TEROS connected, so no readings there.
But otherwise I have data from plots 133, 167, 164, 102, and 115 (solar only).

### Jun 27 and Jun 28 2022

Solo both days. 

Monday (6/27): phenology mostly.
Phenology - there is some uncertainty in whether plants are producing pollen. Oh well, uncertainty abounds.
Pollen addition: there was a dumb mistake in the datasheet so some done plants were on the list.
I had to supplement the list with some additional plants - in total 25 were treated.
I'm not so sure that the addition treatments are working. Not seeing a ton of fruiting. Worrying...

Tuesday (6/28): crosses.
Because I was solo, I didn't get a ton done... but I did cross 13-14 plants.
Four areas (in order): Center aspen patch, SW meadow, Creek, E meadow (upper part).
Colors: pale blue = home, red = away, black = self (black and rock may be confusing...)
I did fewer self crosses and more home/away (previously labelled as out-same and out-diff).
Definitely a few plants with thrips in their bags but no signs that they are doing anything.
There was, weirdly, a plant with a flower (in the bag?) eaten? Not sure how that happened.
Again, not quite sure how well these treatments are working. We'll see.
Saw swallowtails on Thermopsis as well as a lytta beetle muching on flowers.

Also: grazing in SW meadow. Elk? Some chewed tags. One plant in 164 had two of three stems grazed.

### Jun 30 2022

Phenology - looks past peak. Lots of done plants in meadow interiors.
Still some budding plants though in small clearings and below individual trees.

I installed a sensor at plot 130. Got rained out before being to install another one. 
Next is 135. Equipment is near plot 130. I need rebar.

Cloudy today, some rain in afternoon. This weather is probably here for the next week.

### Jul 4 2022

Phenology: open plots are basically done, but there are some budding plants in shaded plots.
I counted and I think I'll have first-flowering dates in 26 (!) plots.
Not very many plants available for crosses.

Placed a new sensor at plot 135. Equipment is up there.

Checked battery levels on 133 (first sensor placed) - currently at 3.6 mV! Amazing.

### Jul 5 2022

Started some pollen manipulation but got rained out.
Zel and I did six plants in the Creek Aspen patch and six in the E meadow.
Many (many) of these plants had shrivelling petals that fell off easily, but were still presenting pollen.
I also did pollen addition on ~6 plants (starting at low end).
Rain started around noon. Figured it was best to wait until dry.
Will finish with phen on Thursday July 7.

### Jul 7 2022

Went up with Zel again. I did phenology + pollen addition while she did crosses.

Phenology - ran out of tags so new plants (there were a few!) were untagged.
Addition - I think I had a sufficient number. Red = add, pale blue = control.
Should bag these soon, perhaps.

Crosses - seemed to go fine. 
Order of subgroups: (1) creek asp. (2) east open (3) sw open (4) center aspen
There aren't very many budding plants anymore, so next week is likely the last.
One exception is the area below the snowdrift in the SW meadow (think - 2020's plot 40).

I think the substantial rains earlier in the week knocked a bunch of flowers off their peduncles.

### Jul 11 2022

Phen and crossing in one day (again).
Crossing: SW meadow (1), NW meadow (2?), C aspen (3), Creek aspen (4)
Re-used the tan-colored nail polish, kinda similar to the new pink...
Probably last week for crosses.

Some new plants under the snowdrift. 

### Jul 14 2022

Zel joined for today. Phen was pretty quick - first day with no new plants (tg).

We went through and painted the fruit of addition plants. 
Some of the plants from the first week have big, beautiful fruit.
Red plants also may as well.
Some cases where perhaps too much paint was applied to a calyx and the peduncle broke under the weight (!)
We left most plants from the most recent week unpainted just in case - will return later.
All of this data was recorded.

Also did sensor checks today. Dumb, annoying stuff:
- sensor 137 did not have its TEROS connected (needs to be fixed)
- sensor 140 had its guy wire grazed (??) and not is not level
- sensor 06R was... not on! rats.
I replaced batteries on 124, 115, and 102 I believe

### Jul 18 2022

Made a mistake in datasheet procurement because I hadn't saved the prior day's entry (lmao).
This meant I visited a bunch of "done" plants.
Also some plants appeared on my datasheet that had bags on at least one inflorescence.
I tried to make a record including the inflorescence with the bag.

I think there may have been only one open flower across the whole site (!).
I say skip next Monday and just to Thursday-Thursday.

I painted a couple of fruit but forgot bags so these are *not yet bagged*.
Some of them I painted the tips - hopefully this is okay...
There is one plant in plot 130 without painted fruit.

I connected the TEROS sensor in plot 137 and repaired 140 with new suspension wire.
(the suspension wire I got level on the first try - booyah)

### Aug 18 2022

At some point last month (Jul 28? Aug 1?) I went with Zel and assessed fruit from the crosses.
Painted fruit. Looks like the crosses mostly failed. Not sure if enough for experiment.
Meh.
I painted fruit and put bags over them.

Also went through and bagged ~30 inflorescences from phen. Random sample for the most part.
A handful of plants I swapped - see datasheet.
Because this was later than usual, and because there was heavy rain, empty fruit seemed to have fallen off.
So this sample is different from last year's sample. Will need to be analyzed separately.
Maybe it can be thought of as a sample of fruit that make it to maturation? Not sure.

On Aug 18 I went out and harvested fruit from crosses, phen (seed set) and pollen addition.
I only looked at the fruit from the creek patch for crosses - none looked ready yet. Do later.
For phen and pollen add, I did plots 101 - 130, 163 - 170. Did not get 131 - 162.
Looks like most of the pollen addition plants were not visited... probably not useful data.
Bleh... Oh well I don't really care.

Most sensors I saw were intact - not sure if on. Only one I had to fix was 133.

### Aug 22 2022

Cancelled morning meeting meant I had time to run up to the MRS and fix a few things.

- Collected remaining fruit. Lots of painted calyces for empty fruit. Sad.
- Sensors... ugh. I did not have enough batteries. Replaced them in 0R6, 130, 135
- Thistle (Carduus nutans) in the NE meadow. Some heads have set+dropped seed. I clipped three. Buds incoming.

Lots of rain the last month. The soil moisture readings I have suggest VWC around 40% in one plot! Wonder what this will do.

Remaining: collect crossed fruit, drone flights (two), shoot sensor locs, take everything down


