# Data import miscellany

### Aug 23 2021

###### Plot 25, August 2021

I have no clue how this happened (beyond the likely fact that it happened when animals chewed through the SP510 cable), but somehow the Unixtime clock on the mayfly board was reset for this sensor.

The csv file (`plot25_aug2021_problems_raw.csv`) has first row with Unixtime 2226877260 and the final row has 2227567910 (corresponding to times in the year 2040). Obviously incorrect!

In the field I reset the Unixtime (on August 20). Here is a snippet (all that remains) of the Serial dialogue:

```
16:09:42.921 -> Monday, [...] 11, 2010 1:01:57 (2223680517)
16:09:43.918 -> Monday, [...] 11, 2010 1:01:58 (2223680518) 
```

The `[...]` corresponds to a string of mostly backwards question marks and some other erratic characters. 

Note! The Unixtime here does not correspond to the ones recorded in the script! If they aligned, then it would be possible to offset all of the unixtimes and write a script to translate them in to MDT. But, we don't have a precise reference point for how much the timer is off by. I have no idea how Serial and the RTC on the board are set to values that are off by so much.

Now, the battery finishes off around 3.71 volts. That means that it likely did not stop recording until I shut it off to perform the switch. This would have been some time around 4:05. We can't know the exact offset with total certainty, but we could possibly offset the final readings by something close to this amount and use contemporaneous records from other sensors as well as previous days' records at the same sensor to get more precise readings, perhaps? The Unixtime for 4:09:44 on August 20 (MDT) is 1629497384 and 4:05:00 gives 1629497100 (offset here would be 598070810).

Is this worth fixing? Two arguments against are: (1) TEROS readings (and I suppose all readings) are unlikely to be synchronized with other sensors making direct comparisons possibly inappropriate. Another argument against is that these readings are unlikely to be used in any analysis.

For the time being I have uploaded the raw script (again - `plot25_aug2021_problems_raw.csv`) and not processed it. I didn't use the archiving script, but instead simply copied it from the card.



