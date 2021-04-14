##### INTRO ----

# Author : Susan Paykin
# Date Created : January 26, 2021
# About: This code will:
# - Load and clean 2008 NSP2 dataset on foreclosures, save datasets for tract
# - load and clean 2014-2018 mean mortgage delingquency rate data, save datasets for county and state

##### Set up ----

library(sf)
library(tmap)
library(tidyverse)
library(tigris)

setwd("~/git/opioid-policy-scan/")

#### Load and clean data ----

# Load foreclosure data
foreclosure1 <- read.csv("data_raw/NSP2 - US Total.csv")
foreclosure2 <- read.csv("data_raw/NSP2 - US Total2.csv")

foreclosure <- rbind(foreclosure1, foreclosure2)
str(foreclosure)

# Relevant variables: 
# fordq_rate = Estimated percent of mortgages to start foreclosure process or be seriously delinquent in past 2 years

#### Tract variables ----
foreclosure_tract <- foreclosure %>% select(GEOID = geoid, state = sta, county = cntyname, fordq_rate)
foreclosure_tract$fordq_rate <- as.numeric(sub("%", "", foreclosure$fordq_rate))

foreclosure_tract_clean <- left_join(foreclosure_tract, counties, by = c("county" = "NAMELSAD")) %>%
  select(GEOID = GEOID.x, COUNTYFP, county, STATEFP, state, fordq_rate)

#### County variables ----
foreclosure_county <- foreclosure_tract %>% 
  group_by(state, county) %>%
  summarise(fordq_rate = mean(fordq_rate))

counties <- counties()
str(counties)

foreclosure_co_clean <- left_join(foreclosure_county, states, by = c("state" = "STUSPS")) %>%
  select(county, STATEFP, state, fordq_rate)

foreclosure_co_clean2 <- left_join(foreclosure_co_clean, counties, by = c("county" = "NAMELSAD", 
                                                                       "STATEFP" = "STATEFP")) %>%
  select(COUNTYFP, county, STATEFP, state, fordq_rate)

#### State variables ----
foreclosure_state <- foreclosure_tract %>% 
  group_by(state) %>%
  summarise(fordq_rate = mean(fordq_rate))

states <- states()
str(states)

# State variables
foreclosure_st_clean <- left_join(foreclosure_state, states, by = c("state" = "STUSPS")) %>%
  select(STATEFP, state, fordq_rate)

#### Save final datasets ---- 

write.csv(foreclosure_tract_clean, "data_final/EC04_T.csv")
write.csv(foreclosure_co_clean2, "data_final/EC04_C.csv")
write.csv(foreclosure_st_clean, "data_final/EC04_S.csv")


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