##### About #####

# This script aggregates tract-level NDVI averages to county, state, and zip code levels. 
# For zip codes, we use the HUD Tract to Zip crosswalk to match tracts with zip codes. 
# Data Source: Michelle Stuhlmacher, DePaul University Department of Geography
# Analysis, cleaning, and aggregation by: Susan Paykin, CSDS, University of Chicago
# Date: April 12, 2022

##### Set up ######

library(tidyverse)
library(sf)
library(readxl)

##### Tract #####

# Read in original data 
ndvi_t <- read.csv("data_final/BE06_NDVI_T.csv") %>% select(2:7)

# Pad tract geoid with leading 0s - 11 chr
ndvi_t$tract_fips <- as.character(ndvi_t$tract_fips)
ndvi_t$tract_fips <- sprintf("%011s", ndvi_t$tract_fips)

# Extract state fips
ndvi_t$state_fips <- substr(ndvi_t$tract_fips, start=1, stop=2)
#ndvi_t$state_fips <- as.character(ndvi_t$state_fips)
#ndvi_t$state_fips <- sprintf("%02s", ndvi_t$state_fips)

# Extract county fips
ndvi_t$cnty_fips <- substr(ndvi_t$tract_fips, start=3, stop=5)
ndvi_t$cnty_geoid <- substr(ndvi_t$tract_fips, start=1, stop=5)
#ndvi_t$cnty_fips <- as.character(ndvi_t$cnty_fips)
#ndvi_t$cnty_fips <- sprintf("%03s", ndvi_t$cnty_fips)

##### County #####

# Aggregate and average at county-level
ndvi_c <- ndvi_t %>%
  group_by(cnty_geoid, cnty_fips, state_fips) %>%
  summarise(ndvi = mean(ndvi))

##### State #####

# Aggregate and average at state-level
ndvi_s <- ndvi_c %>%
  group_by(state_fips) %>%
  summarise(ndvi = mean(ndvi))

##### Zip Code #####

# Crosswalk 
crosswalk <- read_xlsx("data_final/geometryFiles/crosswalk/TRACT_ZIP.xlsx")
ndvi_z2 <- left_join(ndvi_t, crosswalk, by = c("tract_fips" = "TRACT"))
ndvi_z2 <- ndvi_z %>% select(1:8)

# Aggregate and average at zip code-level
ndvi_z <- ndvi_z2 %>%
  group_by(ZIP, state, state_fips, cnty_fips, cnty_geoid) %>%
  summarise(ndvi = mean(ndvi))

##### Save files #####

write.csv(ndvi_t, "data_final/BE06_NDVI_T.csv") # Tract
write.csv(ndvi_z, "data_final/BE06_NDVI_Z.csv") # Zip code
write.csv(ndvi_c, "data_final/BE06_NDVI_C.csv") # County 
write.csv(ndvi_s, "data_final/BE06_NDVI_S.csv") # State
