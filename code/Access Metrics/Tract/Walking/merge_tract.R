##### About ######
# Merging the buprenorphine, methadone, and naltrexone access metrics into one csv
# Spatial Scale: Tract
# Transit Mode: Walking

# Load libraries
library(tidyverse)

# Set wd
setwd("~/Desktop/WorkCSDS/JCOIN/Access Metrics/Tract")

# Read in data
bup <- read.csv("Walking/bup_tract_walkAccess.csv")
met <- read.csv("Walking/meth_tract_walkAccess.csv")
nal <- read.csv("Walking/nal_tract_walkAccess.csv")

# Merge data
merge_tract <- left_join(bup, met, by = "origin") %>%
  left_join(., nal, by = "origin")

# x = bup, y = methadone, unlabeled = naltrexone
head(merge_tract)

# Rename variables
walkTract <- merge_tract %>% select(
  GEOID = origin,
  bupTimeWalk = minutes.x,
  bupCountWalk60 = count.within.60.x,
  bupCountWalk30 = count.within.30.x,
  metTimeWalk = minutes.y,
  metCountWalk60 = count.within.60.y,
  metCountWalk30 = count.within.30.y,
  nalTimeWalk = minutes,
  nalCountWalk60 = count.within.60,
  nalCountWalk30 = count.within.30
)

# Save final data
write.csv(walkTract, "Walking/moud_tract_walkAccess.csv", row.names = FALSE)
