library(tidyverse)
library(dplyr)
library(tmap)
library(sf)

# Read in data
pcp_raw <- read.csv("Policy_Scan/data_raw/raw_pcp_t_103113_1.csv")

names(pcp_raw)
head(pcp_raw)

# Clean data
pcp_raw$STATE <- sprintf("%02d", pcp_raw$STATE)
pcp_raw$COUNTY <- sprintf("%05d", pcp_raw$COUNTY)
pcp_raw$TRACT <- sprintf("%06d", pcp_raw$TRACT)

# Tract
pcp_tract <- pcp_raw %>%
  mutate(geoid = paste0(pcp$state, pcp$county, pcp$tract)) %>%
  select(geoid, state = STATE, county = COUNTY, tract = TRACT, pcp_total = TG_DOC, sp_total = TS_DOC)

# County
pcp_county <- pcp_raw %>%
  select(state = STATE, county = COUNTY, pcp_total = TG_DOC, sp_total = TS_DOC) %>%
  group_by(state, county) %>%
  summarise(pcp_total = sum(pcp_total),
            sp_total = sum(sp_total))

str(pcp_county)

# State
pcp_state <- pcp_raw %>%
  select(state = STATE, county = COUNTY, pcp_total = TG_DOC, sp_total = TS_DOC) %>%
  group_by(state) %>%
  summarise(pcp_total = sum(pcp_total),
            sp_total = sum(sp_total))

str(pcp_state)

# Save data
write.csv(pcp_tract, "Policy_Scan/data_final/Health03_T.csv")
write.csv(pcp_county, "Policy_Scan/data_final/Health03_C.csv")
write.csv(pcp_state, "Policy_Scan/data_final/Health03_S.csv")


# variable: TG_DOC 
# Primary Care physicians
# Number of clinically active Primary Care physicians in the area
# Source: AMA, 2010
# pg 5 - https://data.nber.org/dartmouthatlas/pcsa/Data_Dictionary_PCSAv3.1_Sept2013.pdf

# variable: TS_DOC
# Specialist physicians
# Number of clinically active Specialist physicians in the area
# Source: AMA, 2010
# pg 5 - https://data.nber.org/dartmouthatlas/pcsa/Data_Dictionary_PCSAv3.1_Sept2013.pdf

# Final variables:  geoid, stategp, countyfp, tractce, pcp_total, sp_total
