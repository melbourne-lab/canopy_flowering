# Protocol and log for fruit and seed assessment (Spring 2022) 

I have ~450 fruit from ~130 *Thermopsis divaricarpa* plants observed in summer of 2021.

From these, I want to assess reproductive success. I will use two measures for this: (1) number of seeds and (2) mass measurements. Mass measurements were suggested by Nancy Emery during a committee meeting.

I've assembled a datasheet for collecting this (in this repo, see `data/raw_data/data_2021/seed_counting_data.csv`, generated from `setup/setup_2021/seed_set_datasheet_prep.R`). It has the following columns:

* *Tag* (**pre-filled**) - tag of maternal plant, which will connect fruit to phenology datasets
* *Fruit_no* (**pre-filled**) - ensures there is one row per collected fruit; fruit after assessment will be labeled
* *Full_fruit_wt* - will have mass (in g) of fruit, as measured on laboratory scale
* *Total_n_seeds* - number of seeds in fruit
* *Full__n_seeds* - previous experience assessing seeds has shown that there are full sized seeds but also smaller "dud" seeds; here I'll just be counting the full-sized seeds which are likely to be the only viable ones
* *All_seeds__wt* - mass (in g) of all seeds, weighed simultaneously (another measure of reproductive investment)
* *Date_counted*  - date that these measurements were done
* *Notes* - for any extraneous notes about the fruit or measurement process

### Materials needed

* Scale: lab scale is a Mettler Toledo XS64, recording measurements up to four digits of precision.
* Coin envelopes: will be used for putting (separated) seeds back into the envelope. Could also I guess put fruit coats in here? I'll need a lot (~450), which I currently don't have. I do have some (maybe ~300?) ordered from Staples this summer, but will need more
* Forceps: useful in handling seeds. There is one in the lab but seeds occasionally slip out of them and scatter. I borrowed two BioQuip ones that collapse when squeezed and have flat pinchers, which respectively stop seeds from slipping out and flying away and prevent nicking the seed coat. I borrowed this from the Davies lab (talk to Andy Hicks).
* Workspace: using a white plastic casserole dish for all seed extraction. The walls of this will contain all parts, especially stray seeds that may fly out of the forceps. I also borrowed this from the Davies lab (talk to Andy)
* Bags: Some container for storing all finished seeds. Would be good to organize this somehow. More organization is better.

### Procedure

1) Obtain bag pertaining to current plant on datasheet (n.b., plants are in a random order - stick to this order to eliminate any bias in order of seed processing)
2) Remove all fruit, put in to workspace
3) Choose one fruit (order here doesn't matter), zero the scale, and weigh fruit (placing fruit on small platform)
4) Record fruit weight in *Full_fruit_wt* column of datasheet
5) Remove coat from fruit and count seeds therein, recording these in the *Total_n_seeds* and *Full__n_seeds* columns
6) Tranfer seeds from work space to scale, placing seeds all at once on the small platform in the scale using the tweezers or by hand, and record scale in the *All_seeds__wt* column
7) Transfer seeds from work space to coin envelope.
8) On the coin envelope, write the tag, date processed, and **number of seeds**.
9) Place the coin envelope in the proper processed bag.

### Log (notes from processing)