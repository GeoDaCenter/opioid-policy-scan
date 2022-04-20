##### About ######
# Merging the buprenorphine, methadone, and naltrexone access metrics into one csv
# Spatial Scale: Zips
# Transit Mode: Walking

# Load libraries
library(tidyverse)

setwd("~/git/opioid-policy-scan/code/Access Metrics")

# Read in data
bup <- read.csv("Zip Code/Walking/bup_zip_walkAccess.csv")
met <- read.csv("Zip Code/Walking/meth_zip_walkAccess.csv")
nal <- read.csv("Zip Code/Walking/nal_zip_walkAccess.csv")

# Merge data
merge_zips <- left_join(bup, met, by = "origin") %>%
  left_join(., nal, by = "origin")

# x = bup, y = methadone, unlabeled = naltrexone
head(merge_zips)

# Rename variables
walkZip <- merge_zips %>% select(
  ZCTA = origin,
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
write.csv(walkZip, "Zip Code/Walking/moud_zip_walkAccess.csv", row.names = FALSE)
