##### About ######
# Merging the buprenorphine, methadone, and naltrexone access metrics into one csv
# Spatial Scale: Zips
# Transit Mode: Biking

# Load libraries
library(tidyverse)

setwd("~/Desktop/WorkCSDS/JCOIN/Access Metrics/Zip Code")

# Read in data
bup <- read.csv("Biking/bup_zip_bikeAccess.csv")
met <- read.csv("Biking/meth_zip_bikeAccess.csv")
nal <- read.csv("Biking/nal_zip_bikeAccess.csv")

# Merge data
merge_zips <- left_join(bup, met, by = "origin") %>%
  left_join(., nal, by = "origin")

# x = bup, y = methadone, unlabeled = naltrexone
head(merge_zips)

# Rename variables
bikeZip <- merge_zips %>% select(
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
write.csv(walkZip, "Biking/moud_zip_bikeAccess.csv", row.names = FALSE)
