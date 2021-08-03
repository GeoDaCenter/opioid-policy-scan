# Author : Qinyun LIn
# Date : April 12, 2021
# This code select SVI variables from the raw data. 

library(tidyverse)

# read in raw data
tractSVI <- read.csv("data_raw/SVI/SVI2018_US.csv")

# select ranking variables
tractSVI <- tractSVI  %>% 
  select(FIPS, starts_with("RPL_"))

names(tractSVI) <- c("FIPS", "SVIth1", "SVIth2", "SVIth3", "SVIth4", "SVIS")

write.csv(tractSVI, "data_final/DS03_T.csv", row.names = F)

# read in raw data
countySVI <- read.csv("data_raw/SVI/SVI2018_US_COUNTY.csv")

# select ranking variables
countySVI <- countySVI  %>% 
  select(FIPS, starts_with("RPL_"))

names(countySVI) <- c("FIPS", "SVIth1", "SVIth2", "SVIth3", "SVIth4", "SVIS")

write.csv(countySVI, "data_final/DS03_C.csv", row.names = F)
