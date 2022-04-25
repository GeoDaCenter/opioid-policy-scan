##### About ######
# Merging the buprenorphine, methadone, and naltrexone access metrics into one csv
# Spatial Scale: Tract
# Transit Mode: Biking

# Load libraries
library(tidyverse)

# Set wd
setwd("~/Desktop/WorkCSDS/JCOIN/Access Metrics/Tract")

# Read in data
bup <- read.csv("Biking/bup_tract_bikeAccess.csv")
met <- read.csv("Biking/meth_tract_bikeAccess.csv")
nal <- read.csv("Biking/nal_tract_bikeAccess.csv")

# Merge data
merge_tract <- left_join(bup, met, by = "origin") %>%
  left_join(., nal, by = "origin")

# x = bup, y = methadone, unlabeled = naltrexone
head(merge_tract)

# Rename variables
bikeTract <- merge_tract %>% select(
  GEOID = origin,
  bupTimeBike = minutes.x,
  bupCountBike60 = count.within.60.x,
  bupCountBike30 = count.within.30.x,
  metTimeBike = minutes.y,
  metCountBike60 = count.within.60.y,
  metCountBike30 = count.within.30.y,
  nalTimeBike = minutes,
  nalCountBike60 = count.within.60,
  nalCountBike30 = count.within.30
)

# Save final data
write.csv(bikeTract, "Biking/moud_tract_bikeAccess.csv", row.names = FALSE)
