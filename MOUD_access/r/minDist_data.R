#### Set up ----

library(tidyverse)
library(sf)

#### Load data ----

mindist <- read.csv("data_raw/Access01_Z.csv")

#### Clean data ----

mindist$originGEOID <- sprintf("%05d", mindist$originGEOID)
str(mindist)

mindist <- mindist %>% 
  select(GEOID = originGEOID, minDisMet, minDisNalV)

##### Dialysis min dist

mindist.dial <- read.csv("intmed_output/Access_Dialysis_Z.csv")
mindist.dial$originGEOID <- sprintf("%05d", mindist.dial$originGEOID)
mindist.dial <- mindist.dial %>% select(GEOID = originGEOID, minDisDial = minDialysis)

# Merge with mindist
mindist <- left_join(mindist, mindist.dial, by = "GEOID")

#### Buprenorphone min dist

mindist.bup <- read.csv("intmed_output/Access_Bup_Z_minDist.csv")
mindist.bup$originGEOID <- sprintf("%05d", mindist.bup$originGEOID)
mindist.bup <- mindist.bup %>% select(GEOID = originGEOID, minDisBup)

# Merge with mindist
mindist <- left_join(mindist, mindist.bup, by = "GEOID")

#### Merge with geometry ----

# Merge min dist with zip geom, set projection
mindist.sf <- merge(zips_clean, mindist, by.x = "GEOID10", by.y = "GEOID") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

# Filter variables
mindist.sf <- mindist.sf %>% select(GEOID = GEOID10, minDisBup, minDisMet, minDisNalV, minDisDial, geometry)
str(mindist.sf)

# Code NAs as 9999s, for mapping
mindist.sf <- mindist.sf %>% replace(is.na(.), 9999)
mindist.sf$minDisBup <- round(mindist.sf$minDisBup, 2)
mindist.sf$minDisMet <- round(mindist.sf$minDisMet, 2)
mindist.sf$minDisNalV <- round(mindist.sf$minDisNalV, 2)
mindist.sf$minDisDial <- round(mindist.sf$minDisDial, 2)


#### FIN ----


