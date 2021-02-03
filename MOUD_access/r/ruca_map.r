#### Set up ----

library(tmap)
library(sf)
library(tidyverse)

### ZCTA Rural/Urban/Suburban stratification ----

# Load and clean
rucaZ <- read.csv("raw_data/HS02_RUCA_Z.csv")
rucaZ$ZIP_CODE <- sprintf("%05s", as.character(rucaZ$ZIP_CODE))

# Merge with geometry
rucaZCTA.sf <- merge(zips_clean, rucaZ, by.x = "ZCTA5CE10", by.y = "ZIP_CODE")
str(rucaZCTA.sf)

# Map
ruca_map_Z <-
  tm_shape(rucaZCTA.sf) +
  tm_fill(col = "rurality",
          title = "Type") +
  tm_layout(frame = FALSE, main.title = "Rural, Suburban, Urban Stratification by ZCTA")

#### County Rural/Urban/Suburban stratification ----

# Load and clean county population data
rucaC <- read.csv("raw_data/HS02_C.csv")
rucaCounty <- rucaC %>% select(GEOID, rcaUrbP, rcaSubrbP, rcaRuralP)
rucaCounty$GEOID <- sprintf("%05s", as.character(rucaCounty$GEOID))

# Create rurality variable categorizing Urban, Suburban, Rural by greatest population percentage
rucaCounty$rurality <- ifelse(rucaCounty$rcaUrbP > rucaCounty$rcaSubrbP & rucaCounty$rcaUrbP > rucaCounty$rcaRuralP, "Urban",
                              ifelse(rucaCounty$rcaSubrbP > rucaCounty$rcaUrbP & rucaCounty$rcaSubrbP > rucaCounty$rcaRuralP, "Suburban",
                                     ifelse(rucaCounty$rcaRuralP > rucaCounty$rcaUrbP || rucaCounty$rcaSubrbP, "Rural")))

rucaCounty$rurality <- factor(rucaCounty$rurality, levels = c('Urban', 'Suburban', 'Rural'))

# Read in county geometry
countyGeom <- st_read("data_raw/tl_2018_county/counties2018.shp")
str(countyGeom)

# Filter out AK (02) and HI (15)
county_clean <- countyGeom %>% filter(!grepl("^02", GEOID), !grepl("^15", GEOID))

#plot(st_geometry(county_clean))

# Merge ruca data with geometry
rucaCounty.sf <- merge(county_clean, rucaCounty, by.x = "GEOID", by.y = "GEOID")
str(rucaCounty.sf)

# Map
ruca_map_C <- 
  tm_shape(rucaCounty.sf) +
  tm_fill(col = "rurality",
          title = "Type") +
  tm_layout(frame = FALSE, main.title = "Rural, Suburban, Urban Stratification by County")

#### FIN ----
