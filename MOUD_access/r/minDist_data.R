#### Set up ----

library(tidyverse)

#### Load data ----

mindist <- read.csv("data_raw/Access01_Z.csv")

#### Clean data ----

mindist$originGEOID <- sprintf("%05d", mindist$originGEOID)
str(mindist)

mindist <- mindist %>% 
  mutate(GEOID = originGEOID) %>% 
  select(GEOID, minDisBup, minDisMet, minDisNalV)

#### Merge with geometry ----

# Merge min dist with zip geom
mindist.sf <- merge(zips_clean, mindist, by.x = "GEOID10", by.y = "GEOID")
# Filter variables
mindist.sf <- mindist.sf %>% select(GEOID = GEOID10, minDisBup, minDisMet, minDisNalV, geometry)
str(mindist.sf)

# Code NAs as 9999s, for mapping
mindist.sf <- mindist.sf %>% replace(is.na(.), 9999)
mindist.sf$minDisBup <- round(mindist.sf$minDisBup, 2)
mindist.sf$minDisMet <- round(mindist.sf$minDisMet, 2)
mindist.sf$minDisNalV <- round(mindist.sf$minDisNalV, 2)

#### FIN ----