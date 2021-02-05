#### About ----
# This code wrangles U.S. CDC WONDER data on underlying cause of death from drug-induced causes from 2009-2018.  
# Dataset: Underlying Cause of Death, 1999-2019


#### Set up ---- 

library(tmap)
library(sf)
library(sp)
library(tidyverse)

#### CDC cause of death data // County ----

# Load drug-related death data
drug_related <- read.csv("data_raw/Drug-related causes 2009-2018.csv")

# Filter out AK, HI
drug_related <- drug_related %>%
  filter(!is.na(State.Code)) %>%
  filter(!State == "Alaska") %>%
  filter(!State == "Hawaii")

# Clean
drug_related$Deaths <- as.numeric(drug_related$Deaths)
drug_related$Population <- as.numeric(drug_related$Population)
drug_related$County.Code <- sprintf("%05s", as.character(drug_related$County.Code))
drug_related$State.Code <- sprintf("%02s", as.character(drug_related$State.Code))

# Create crude rate, normalized per 100K Pop
drug_related$Crude.Rate <- round((drug_related$Deaths / drug_related$Population) * 100000, 1)

# Merge with county geometry
drug_related.sf <- merge(county_clean, drug_related, by.x="GEOID", by.y = "County.Code", all.x = TRUE) %>%
  st_set_crs(4326) %>%
  st_transform("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")

# Code NAs as 0, for mapping
drug_related.sf <- drug_related.sf %>% replace(is.na(.), 0)


# Map 
drug_related_map <- 
  tm_shape(drug_related.sf) +
  tm_fill("Crude.Rate",
          title = "Drug-Related Death Rate \nper 100K Population",
          style = "fixed",
          breaks = c(-Inf, 5, 10, 15, 20, 25, 30, Inf),
          textNA = "Low Deaths") +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5)
  
drug_related_map


#### FIN ----


