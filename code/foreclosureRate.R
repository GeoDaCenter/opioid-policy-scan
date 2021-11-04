##### About ----

# Author : Susan Paykin
# Date Created : January 26, 2021
# About: This code will:
# - Load and clean 2008 NSP2 dataset on foreclosures, save datasets for tract
# - load and clean 2014-2018 mean mortgage delingquency rate data, save datasets for county and state

##### Set up ----

library(sf)
library(tmap)
library(tidyverse)
library(stringr)

setwd("~/git/opioid-policy-scan/")

#### Load and clean data ----

# Load tract-level foreclosure data
foreclosure1 <- read.csv("data_raw/NSP2 - US Total.csv")
foreclosure2 <- read.csv("data_raw/NSP2 - US Total2.csv")

foreclosure <- rbind(foreclosure1, foreclosure2)
foreclosure$geoid <- as.numeric(foreclosure$geoid)

# Add leading 0s to tract GEOID
foreclosure$geoid <- str_pad(foreclosure$geoid, 11, pad = "0")
foreclosure$geoid <- as.character(foreclosure$geoid)

# Extract the first 5 digits to create ctyGEOID
foreclosure$ctyGEOID <- substr(foreclosure$geoid, 1, 5)

# Relevant variables: 
# fordq_num = Estimated number of mortages to start foreclosure process or be seriously delinquent in past 2 years
# fordq_rate = Estimated percent of mortgages to start foreclosure process or be seriously delinquent in past 2 years

#### Tract variables ----

foreclosureT <- foreclosure %>% 
  select(GEOID = geoid, state = sta, county = cntyname, ctyGEOID, fordq_rate, fordq_num)

foreclosureT$fordq_rate <- as.numeric(sub("%", "", foreclosure$fordq_rate))
foreclosureT$fordq_num <- as.numeric(foreclosure$fordq_num)

foreclosureT <- foreclosureT %>% 
  group_by(GEOID, state, county, ctyGEOID) %>%
  summarise(across(c("fordq_rate", "fordq_num"), ~ mean(.x)))

tracts <- st_read("data_final/geometryFiles/tl_2018_tract/tracts2018.shp") %>% st_drop_geometry()

foreclosure_tract <- merge(tracts, foreclosureT, by = "GEOID", all.x = TRUE) %>%
  select(GEOID, STATEFP, COUNTYID = COUNTYFP, TRACTCE, ST = state, COUNTY = county, fordq_rate, fordq_num)

#### County variables ----

# Load county geography
counties <- st_read("data_final/geometryFiles/tl_2018_county/counties2018.shp") %>% st_drop_geometry()
head(counties)

counties <- counties %>% transform(ctyGEOID = paste0(STATEFP, COUNTYFP))

foreclosureC <- foreclosureT %>% 
  group_by(ctyGEOID, state, county) %>%
  summarise(across(c("fordq_rate", "fordq_num"), ~ round(mean(.x, na.rm = TRUE), 2)))

foreclosure_county <- merge(counties, foreclosureC, by = "ctyGEOID", all.x = TRUE) %>%
  select(COUNTYFP = ctyGEOID, STATEFP, COUNTYID = COUNTYFP, ST = state, COUNTY = county, fordq_rate, fordq_num)

#### State variables ----
foreclosureS <- foreclosureT %>% 
  group_by(state) %>%
  summarise(across(c("fordq_rate", "fordq_num"), ~ round(mean(.x, na.rm = TRUE), 2)))

states <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp") %>% st_drop_geometry()

# State variables
foreclosure_state <- merge(states, foreclosureS, by.x = "STUSPS", by.y = "state", all.x = TRUE) %>%
  select(STATEFP, ST = STUSPS, STATE = NAME, fordq_rate, fordq_num)

#### Save final datasets ---- 

write.csv(foreclosure_tract, "data_final/EC04_T.csv", row.names = FALSE)
write.csv(foreclosure_county, "data_final/EC04_C.csv", row.names = FALSE)
write.csv(foreclosure_state, "data_final/EC04_S.csv", row.names = FALSE)


# Additional data source, not included in final datasets as of 4/9/21:

# County & State: 90+ Day Delinquency data, 2014-2018

# # Load county data
# mortgages_co_raw <- read.csv("data_raw/CountyMortgagesPercent-90-plusDaysLate-thru-2019-12.csv")
# head(mortgages_co_raw)
# 
# # Create variable - mean 2014-2018 delinquency rate
# mortgages_co_raw <- mortgages_co_raw %>% mutate(dq_rate = rowMeans(.[, 6:64]))
# mortgages_co_raw$dq_rate <- sprintf(mortgages_co_raw$dq_rate, fmt = '%#.2f')
# 
# # Save total rate
# mortgages_co <- mortgages_co_raw %>% select(GEOID = FIPSCode, state = State, co_name = Name, dq_rate) 
# mortgages_co$dq_rate <- as.numeric(mortgages_co$dq_rate)
# 
# # Aggregate by state
# mortgages_st <- mortgages_co %>%
#   group_by(state) %>%
#   summarise(dq_rate = round(mean(dq_rate), 2))

#### FIN ----