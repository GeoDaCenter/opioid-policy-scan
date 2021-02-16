#### Set up ----

library(tmap)
library(sf)
library(tidyverse)
library(RColorBrewer)

# Set CRS - EPSG 102003
crs <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

### ZCTA Rural/Urban/Suburban stratification ----

# Load and clean
rucaZ <- read.csv("data_raw/HS02_RUCA_Z.csv")
rucaZ$ZIP_CODE <- sprintf("%05s", as.character(rucaZ$ZIP_CODE))

# Merge with geometry
rucaZ.sf <- merge(zips_clean, rucaZ, by.x = "ZCTA5CE10", by.y = "ZIP_CODE") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

str(rucaZ.sf)

ruca.cols <- c("#ece2f0", "#a6bddb", "#1c9099")

# Map
ruca_map_Z <-
  tm_shape(rucaZ.sf) +
  tm_fill(col = "rurality",
          title = "Classification",
          palette = ruca.cols) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Rural, Suburban, Urban Stratification by ZCTA")

tmap_save(ruca_map_Z, "output/ruca_Z.png")



#### County Rural/Urban/Suburban stratification ----

# # Load and clean county population data
# rucaCounty <- read.csv("raw_data/HS02_C.csv")
# rucaCounty <- rucaCounty %>% select(GEOID, rcaUrbP, rcaSubrbP, rcaRuralP)
# rucaCounty$GEOID <- sprintf("%05s", as.character(rucaCounty$GEOID))
# 
# # Create rurality variable categorizing Urban, Suburban, Rural by greatest population percentage
# rucaCounty$rurality <- ifelse(rucaCounty$rcaUrbP > rucaCounty$rcaSubrbP & rucaCounty$rcaUrbP > rucaCounty$rcaRuralP, "Urban",
#                               ifelse(rucaCounty$rcaSubrbP > rucaCounty$rcaUrbP & rucaCounty$rcaSubrbP > rucaCounty$rcaRuralP, "Suburban",
#                                      ifelse(rucaCounty$rcaRuralP > rucaCounty$rcaUrbP & rucaCounty$rcaSubrbP, "Rural", 
#                                             ifelse(rucaCounty$rcaUrbP == rucaCounty$rcaSubrbP & rucaCounty$rcaRuralP > rucaCounty$rcaSubrbP, "Rural", 
#                                                    ifelse(rucaCounty$rcaUrbP == rucaCounty$rcaSubrbP & rucaCounty$rcaRuralP > rucaCounty$rcaSubrbP, "Rural",
#                                                           ifelse(rucaCounty$rcaSubrbP == rucaCounty$rcaRuralP & rucaCounty$rcaSubrbP > rucaCounty$rcaUrbP, "Suburban",
#                                                           "Suburban"))))))
# 
# rucaCounty$rurality <- factor(rucaCounty$rurality, levels = c('Urban', 'Suburban', 'Rural'))
# 
# # Read in county geometry
# countyGeom <- st_read("data_raw/tl_2018_county/counties2018.shp")
# str(countyGeom)
# 
# # Filter out AK (02) and HI (15)
# county_clean <- countyGeom %>% filter(!grepl("^02", GEOID), !grepl("^15", GEOID))
# 
# # Merge ruca data with geometry
# rucaCounty.sf <- merge(county_clean, rucaCounty, by.x = "GEOID", by.y = "GEOID")
# str(rucaCounty.sf)
# 
# # Map
# ruca_map_C <- 
#   tm_shape(rucaCounty.sf) +
#   tm_fill(col = "rurality",
#           title = "Type", 
#           showNA = FALSE) +
#   tm_layout(frame = FALSE, main.title = "Rural, Suburban, Urban Stratification by County")
# ruca_map_C

#### FIN ----
