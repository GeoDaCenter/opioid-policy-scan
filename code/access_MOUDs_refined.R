#### ABOUT
# This script adds refined spatial access metrics at the ZCTA level to the existing minimum distance access metrics.

library(tidyverse)
library(sf)

# Load full refined access metrics dataset
all_access <- read.csv("opioid-projects/moud_zip_svi/data_final/allaccess_SVI_rurality_pop.csv")

str(all_access)

all_access_zip <- all_access %>%
  select(ZCTA = originGEOID,
         metMinDis = minDisMet, #methadone
         metTime = time_to_nearest_methadone, 
         metCount = count_in_range_methadone, 
         metScore = methadone_score, 
         bupMinDis = minDisBup, #buprenorphine
         bupTime = time_to_nearest_buprenorphine, 
         bupCount = count_in_range_buprenorphine, 
         bupScore = buprenorphine_score, 
         nalMinDis = minDisNalV, #naltrexone
         nalTime = time_to_nearest_naltrexone.vivitrol, 
         nalCount = count_in_range_naltrexone.vivitrol, 
         nalScore = naltrexone.vivitrol_score)

all_access_zip$ZCTA <- sprintf("%05d", all_access_zip$ZCTA)
all_access_zip$ZCTA <- as.character(all_access_zip$ZCTA)


#access01_z <- read.csv("opioid-policy-scan/data_final/Access01_Z.csv")

#access01_z_new <- left_join(access01_z, all_access_zip)
#access01_z_new <- access01_z_new %>% 
#  select(2:11)

# access01_z_new <- 
#   access01_z_new %>% rename(
#        moudMinDis = minDisMOUD,
#        metMinDis = minDisMeth, 
#        bupMinDis = minDisBup,
#        nalMinDis = minDisNalV)
       
# Save final data
write.csv(all_access_zip, "opioid-policy-scan/data_final/Access01_Z.csv", row.names = FALSE)
