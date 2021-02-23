#### About ----
# This code cleans and prepares data for mapping U.S. ZCTAs by their RUCA code classification. 

#### Set up ----

library(tmap)
library(sf)
library(tidyverse)

#### Clean and prepare data ----

# Load data
rucaZ <- read.csv("data_raw/HS02_RUCA_Z.csv")
rucaZ$ZIP_CODE <- sprintf("%05s", as.character(rucaZ$ZIP_CODE))

# Merge with zip geometry
rucaZ.sf <- merge(zips_clean, rucaZ, by.x = "ZCTA5CE10", by.y = "ZIP_CODE") %>%
  st_set_crs(4326) %>%
  st_transform(crs)
str(rucaZ.sf)

#### Map ----

# Create color scheme option
ruca.cols <- c("#66c2a5", "#8da0cb", "#fc8d62")

# Map
ruca_map <-
  tm_shape(rucaZ.sf) +
  tm_fill(col = "rurality",
          title = "Classification",
          palette = "Set3") +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Rural, Suburban, Urban Stratification by ZCTA")

# Map with regional divisions
ruca_map.divs <-
  tm_shape(rucaZ.sf) +
  tm_fill(col = "rurality",
          title = "Classification",
          palette = "Set3") +
  tm_shape(states) +
  tm_borders(lwd = 0.5) +
  tm_shape(divisions) +
  tm_borders(col = "#362827", lwd = 2.5) +
  tm_layout(frame = FALSE, main.title = "Rural, Suburban, Urban Stratification by ZCTA")

tmap_save(ruca_map.divs, "output/ruca_map.divs.png")

#### FIN ----
