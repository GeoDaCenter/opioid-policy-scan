#### ABOUT
# This script adds refined spatial access metrics at the ZCTA level to the existing minimum distance access metrics.

library(tidyverse)
library(sf)

# Load full refined access metrics dataset
all_access <- read.csv("opioid-projects/MOUD_access/data_final/allaccess_SVI_rurality_pop.csv")

str(all_access)

all_access_zip <- all_access %>%
  select(GEOID = originGEOID,
         minDisMet, time_to_nearest_methadone, count_in_range_methadone, methadone_score, #methadone
         minDisBup, time_to_nearest_buprenorphine, count_in_range_buprenorphine, buprenorphine_score, #buprenorphine
         minDisNalV, time_to_nearest_naltrexone = time_to_nearest_naltrexone.vivitrol, 
         count_in_range_naltrexone = count_in_range_naltrexone.vivitrol, 
         naltrexone_score = naltrexone.vivitrol_score #naltrexone
         )

write.csv(all_access_zip, "opioid-policy-scan/data_final/Access01_Z.csv")
