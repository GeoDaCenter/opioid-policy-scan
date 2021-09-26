#### About ----

# Author: Qinyun Lin & Susan Paykin
# Date Created: April 12, 2021
# Date Last Modified: August 4, 2021
# About: This code selects tract-level SVI variables from the raw data to produce tract-level and aggregated county-level datasets. 
# It also crosswalks the tract-level SVI data to ZCTA-level using weighted areal interpolation. 

##### Set up ----

library(tidyverse)
library(readxl)

setwd("~/git/opioid-policy-scan")

#### SVI - Tracts ----

# read in raw data
tractSVI <- read.csv("data_raw/SVI/SVI2018_US.csv")

# select ranking variables
tractSVI <- tractSVI  %>% 
  select(FIPS, starts_with("RPL_"))

# rename variables
names(tractSVI) <- c("FIPS", "SVIth1", "SVIth2", "SVIth3", "SVIth4", "SVIS")

# save final dataset
write.csv(tractSVI, "data_final/DS03_T.csv", row.names = F)

#### SVI - County ----

# read in raw data
countySVI <- read.csv("data_raw/SVI/SVI2018_US_COUNTY.csv")

# select ranking variables
countySVI <- countySVI  %>% 
  select(FIPS, starts_with("RPL_"))

# rename variables
names(countySVI) <- c("FIPS", "SVIth1", "SVIth2", "SVIth3", "SVIth4", "SVIS")

# save final data
write.csv(countySVI, "data_final/DS03_C.csv", row.names = F)

#### SVI - Zip code ----

# read in crosswalk file
ZIP_TRACT_122020 <- read_excel("data_raw/ZIP_TRACT_122020.xlsx", 
                               col_types = c("text", "text", "numeric", "numeric", "numeric", "numeric"))

ZIP_TRACT <- ZIP_TRACT_122020 %>%
  select(ZIP, TRACT, TOT_RATIO)

# read in tract SVI data
SVI2018_US <- read_csv("data_raw/SVI/SVI2018_US.csv") 

# filter for relevant variables
SVI <- SVI2018_US %>% 
  select(FIPS, RPL_THEME1, RPL_THEME2, RPL_THEME3, RPL_THEME4, RPL_THEMES)

# Code -999 as NAs for interpolation
SVI$RPL_THEME1[SVI$RPL_THEME1 == -999] <- NA
SVI$RPL_THEME2[SVI$RPL_THEME2 == -999] <- NA
SVI$RPL_THEME3[SVI$RPL_THEME3 == -999] <- NA
SVI$RPL_THEME4[SVI$RPL_THEME4 == -999] <- NA
SVI$RPL_THEMES[SVI$RPL_THEMES == -999] <- NA

# join SVI to tract-zcta crosswalk
SVI_ZIP <- left_join(SVI, ZIP_TRACT, by = c("FIPS" = "TRACT"))

no.join <- SVI[!SVI$FIPS %in% ZIP_TRACT$TRACT,]

no.join.zip <- ZIP_TRACT[!ZIP_TRACT$TRACT %in% SVI$FIPS,]
unique(no.join.zip$TRACT)

# weighted means
SVI_ZIP_clean <- SVI_ZIP %>% 
  group_by(ZIP) %>% 
  mutate(SVI_THEME1 = weighted.mean(RPL_THEME1, w = TOT_RATIO), #na.rm = T),
         SVI_THEME2 = weighted.mean(RPL_THEME2, w = TOT_RATIO), #na.rm = T),
         SVI_THEME3 = weighted.mean(RPL_THEME3, w = TOT_RATIO), #na.rm = T),
         SVI_THEME4 = weighted.mean(RPL_THEME4, w = TOT_RATIO), #na.rm = T),
         SVI_S = weighted.mean(RPL_THEMES, w = TOT_RATIO)) %>% #na.rm = T)) %>% 
  select(ZIP, starts_with("SVI")) %>% 
  distinct()

# make ZCTA variable numeric
SVI_ZIP_clean$ZCTA <- as.numeric(SVI_ZIP_clean$ZIP, na.rm=TRUE)

# prepare final data
final_data <- SVI_ZIP_clean %>% select(ZCTA, SVI_S, SVI_THEME1, SVI_THEME2, SVI_THEME3, SVI_THEME4)

# change NaN to -999
final_data[final_data == "NaN"] <- -999

# round estimates
final_data <- final_data %>%
  mutate_at(vars(starts_with("SVI_")), funs(round(., 2)))

# remove empty ZIP code row 
final_data <- final_data[-6,]

# save final dadta
write.csv(final_data, "data_final/DS03_Z.csv")
