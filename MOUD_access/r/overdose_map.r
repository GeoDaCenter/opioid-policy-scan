#### Set up ---- 

library(tmap)
library(sf)
library(tidyverse)

#### CDC WONDER 2018 data----

# Load and clean data
drug_deaths <- read.csv("data_raw/Drug-induced causes 2018.csv")

drug_deaths <- drug_deaths[,2:8]

drug_deaths <- drug_deaths %>% 
  filter(!is.na(State.Code)) %>%
  filter(!State == "Alaska") %>%
  filter(!State == "Hawaii")
  
drug_deaths$County.Code <- sprintf("%05s", as.character(drug_deaths$County.Code))
drug_deaths$Deaths <- as.numeric(drug_deaths$Deaths)
drug_deaths$Population <- as.numeric(drug_deaths$Population)

# Merge with county geometry
drug_deaths.sf <- merge(county_clean, drug_deaths, by.x="GEOID", by.y = "County.Code", all.x = TRUE)

# Map 
death_map <- 
tm_shape(drug_deaths.sf) +
  tm_fill("Deaths",
          title = "Deaths (CDC)",
          style = "quantile")


#### County Health Rankings 2018 data ----

# Load and clean data
OD <- read.csv("data_raw/2018 County Health Rankings Data - v2.xls")

# Select variable - Drug overdose deaths = Number of drug poisoning deaths per 100,000 population
OD <- OD %>% select(FIPS, State, County, DrOverdMrtRt)

OD$FIPS <- sprintf("%05s", as.character(OD$FIPS))

# Merge with geometry
OD.sf <- merge(county_clean, OD, by.x="GEOID", by.y="FIPS")
str(OD.sf)

# Map
overdose_map <- 
  tm_shape(OD.sf) +
  tm_fill("DrOverdMrtRt", 
          title = "Overdose rate (CHR)",
          style = "quantile")



#### Compare CDC & CHR maps ----

tmap_arrange(death_map, overdose_map)


#### FIN ----


