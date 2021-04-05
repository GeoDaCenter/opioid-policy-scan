##### ABOUT ----

# This code loads and cleans data on primary care and specialist providers at the U.S. census tract, county, and state levels. 

#### SET UP ----

library(tidyverse)
library(dplyr)
library(tmap)
library(sf)

#### LOAD DATA ----

# Read in data
pcp_raw <- read.csv("Policy_Scan/data_raw/raw_pcp_t_103113_1.csv")

names(pcp_raw)
head(pcp_raw)

# Clean up data
pcp_raw$STATE <- sprintf("%02d", pcp_raw$STATE)
pcp_raw$COUNTY <- sprintf("%05d", pcp_raw$COUNTY)
pcp_raw$TRACT <- sprintf("%06d", pcp_raw$TRACT)

#### PREPARE FOR SPATIAL ANALYSIS ----

# State
pcp_state <- pcp_raw %>%
  select(state = STATE, county = COUNTY, pcp_total = TG_DOC, sp_total = TS_DOC) %>%
  group_by(state) %>%
  summarise(pcp_total = sum(pcp_total),
            sp_total = sum(sp_total))

# County
pcp_county <- pcp_raw %>%
  select(state = STATE, county = COUNTY, pcp_total = TG_DOC, sp_total = TS_DOC) %>%
  group_by(state, county) %>%
  summarise(pcp_total = sum(pcp_total),
            sp_total = sum(sp_total))

# Tract
pcp_tract <- pcp_raw %>%
  mutate(geoid = paste0(pcp$state, pcp$county, pcp$tract)) %>%
  select(geoid, state = STATE, county = COUNTY, tract = TRACT, pcp_total = TG_DOC, sp_total = TS_DOC)

#### SAVE DATA ----

write.csv(pcp_tract, "Policy_Scan/data_final/Health03_T.csv")
write.csv(pcp_county, "Policy_Scan/data_final/Health03_C.csv")
write.csv(pcp_state, "Policy_Scan/data_final/Health03_S.csv")

#### FIN ----