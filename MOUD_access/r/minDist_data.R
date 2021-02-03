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

#### FIN ----