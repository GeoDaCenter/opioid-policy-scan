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

# Merge min dist with zip geom, set projection
mindist.sf <- merge(zips_clean, mindist, by.x = "GEOID10", by.y = "GEOID") %>%
  st_set_crs(4326) %>%
  st_transform("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")

# Filter variables
mindist.sf <- mindist.sf %>% select(GEOID = GEOID10, minDisBup, minDisMet, minDisNalV, geometry)
str(mindist.sf)

# Code NAs as 9999s, for mapping
mindist.sf <- mindist.sf %>% replace(is.na(.), 9999)
mindist.sf$minDisBup <- round(mindist.sf$minDisBup, 2)
mindist.sf$minDisMet <- round(mindist.sf$minDisMet, 2)
mindist.sf$minDisNalV <- round(mindist.sf$minDisNalV, 2)

#### FIN ----