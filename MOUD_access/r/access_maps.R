#### About ----
# This script generates maps for access metrics across across MOUD and dialysis resources at the U.S. zip code level (ZCTA). 
# The access metrics include: 1) Driving time to nearest resource, 2) Count of resources within 30 Mins, 3) Access score, and 4) Minimum Euclidean distance to nearest resource.

#### Set up ----

library(sf)
library(USAboundaries)
library(tidyverse)
library(tmap)
library(tigris)
library(RColorBrewer)

# Create function - clip to continental US 
clip_to_continental_us <- function(sf) {
  
  continental_bbox <- st_as_sfc("POLYGON((-126.3 50.6, -66.0 50.6, -66.0 20.1, -126.3 20.1, -126.3 50.6))") %>% 
    st_as_sf(crs = 4326) %>% 
    st_transform(st_crs(sf))
  
  continental_sf <- st_intersection(continental_bbox, sf)
  
}

# Set CRS - EPSG 102003
crs <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

##### Geometry data ----

# State geometry
states <- us_states()
states <- states %>% filter(!stusps %in% c("AK", "HI", "PR"))

# ZCTA geometry
zips <- st_read("data_raw/tl_2018_zcta/zctas2018.shp")
zips_clean <- zips %>% clip_to_continental_us()

# Census Regional Divisions geometry
divisions <- st_read("data_raw/tl_2018_divisions/cb_2018_us_division_500k.shp")
divisions <- divisions %>% st_transform(crs) %>% clip_to_continental_us()

  
#### Buprenorphine maps ----

# Driving time map
bup_time_map <- 
tm_shape(bup.sf) +
  tm_fill(col = "time_to_nearest_buprenorphine", 
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Driving Time")

tmap_save(bup_time_map, "output/bup_access/bup_time_map.png")

# Driving time map - DIVISIONS
bup_time_regions.map <- 
  tm_shape(bup.sf) +
  tm_fill(col = "time_to_nearest_buprenorphine", 
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(lwd = 0.5) +
  tm_shape(divisions) +
  tm_borders(col = "#362827", lwd = 2.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Driving Time")

tmap_save(bup_time_regions.map, "output/bup_access/bup_time_map.divs.png")

# Count in 30 min. map
bup_count_map <- 
  tm_shape(bup.sf) +
  tm_fill(col = "count_cat",
          palette = "RdYlBu",
          title = "Count") +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Count within 30 Minutes")

tmap_save(bup_count_map, "output/bup_count_map.png")

# Access score map
bup_score_map <- 
  tm_shape(bup.sf) +
  tm_fill(col = "buprenorphine_score",
          palette = "RdYlBu",
          title = "Score") +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Score")

tmap_save(bup_score_map, "output/bup_score_map.png")

# Minimum distance map 
bup_mindist_map <- 
  tm_shape(mindist.sf) +
  tm_fill(col = "minDisBup",
          palette = "-RdYlBu",
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Minimum Distance")

tmap_save(bup_mindist_map, "output/bup_access/bup_mindist_map.png")


#### Methadone maps ----

# Driving time map
meth_time_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "time_to_nearest_methadone", 
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Driving Time")

tmap_save(meth_time_map, "output/meth_time_map.png")

# Driving time map - DIVISIONS
meth_time_divisions.map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "time_to_nearest_methadone", 
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(lwd = 0.5) +
  tm_shape(divisions) +
  tm_borders(col = "#362827", lwd = 2.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Driving Time")

tmap_save(meth_time_divisions.map, "output/meth_access/meth_time_map.divs.png")

# Count in 30 min. map
meth_count_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "count_cat",
          palette = "RdYlBu",
          title = "Count") +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Count")

tmap_save(meth_count_map, "output/meth_access/meth_count_map.png")

meth_count_map.divs <- 
  tm_shape(meth.sf) +
  tm_fill(col = "count_cat",
          palette = "RdYlBu",
          title = "Count") +
  tm_shape(states) +
  tm_borders(lwd = 0.5) +
  tm_shape(divisions) +
  tm_borders(col = "#362827", lwd = 2.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Count")

tmap_save(meth_count_map.divs, "output/meth_access/meth_count_map.divs.png")

# Access score map
meth_score_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "methadone_score",
          palette = "RdYlBu",
          title = "Score", 
          style = "fixed",
          breaks = c(0, 0.2, 0.7, 1.5, 2, 3)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Score")

tmap_save(meth_score_map, "output/meth_access/meth_score_map.png")

# Minimum distance map 
meth_mindist_map <- 
  tm_shape(mindist.sf) +
  tm_fill(col = "minDisMet",
          palette = "-RdYlBu",
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Minimum Distance")

tmap_save(meth_mindist_map, "output/meth_access/meth_mindist_map.png")



#### Nalaxotrone / Vivitrol maps ----

# Driving time map
nalviv_time_map <- 
  tm_shape(nalviv.sf) +
  tm_fill(col = "time_to_nearest_naltrexone.vivitrol", 
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltrexone: Driving Time")

tmap_save(nalviv_time_map, "output/nalViv_access/nalviv_time_map.png")

# Driving time map - DIVISIONS
nalviv_time_map.divs <- 
  tm_shape(nalviv.sf) +
  tm_fill(col = "time_to_nearest_naltrexone.vivitrol", 
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(lwd = 0.5) +
  tm_shape(divisions) +
  tm_borders(col = "#362827", lwd = 2.5) +
  tm_layout(frame = FALSE, main.title = "Naltrexone: Driving Time")

tmap_save(nalviv_time_map.divs, "output/nalViv_access/nalviv_time_map.divs.png")

# Count in 30 min. map
nalviv_count_map <- 
  tm_shape(nalviv.sf) +
  tm_fill(col = "count_in_range_naltrexone.vivitrol",
          palette = "RdYlBu",
          title = "Count",
          style = "fixed",
          breaks = c(0, 1, 5, 20, 50, 100, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltrexone: Count")

tmap_save(nalviv_count_map, "output/nalViv_access/nalviv_count_map.png")

# Access score map
nalviv_score_map <- 
  tm_shape(nalviv.sf) +
  tm_fill(col = "naltrexone.vivitrol_score",
          palette = "RdYlBu",
          title = "Score",
          style = "fixed",
          breaks = c(0, 0.6, 1.2, 1.8, 2.4, 3)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltrexone: Score")

tmap_save(nalviv_score_map, "output/nalViv_access/nalviv_score_map.png")

# Min Distance map
nalviv_mindist_map <- 
  tm_shape(mindist.sf) +
  tm_fill(col = "minDisNalV",
          palette = "-RdYlBu",
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltrexone: Minimum Distance")

tmap_save(nalviv_mindist_map, "output/nalViv_access/nalviv_mindist_map.png")

#### Dialysis maps ----

# Driving time map
dialysis_time_map <-
  tm_shape(dialysis.sf) +
  tm_fill(col = "time_to_nearest_dialysis",
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Dialysis: Driving Time")

tmap_save(dialysis_time_map, "output/dialysis_access/dialysis_time_map.png")

# Driving time map - DIVISIONS
dialysis_time_map.divs <-
  tm_shape(dialysis.sf) +
  tm_fill(col = "time_to_nearest_dialysis",
          palette = "-RdYlBu",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(lwd = 0.5) +
  tm_shape(divisions) +
  tm_borders(col = "#362827", lwd = 2.5) +
  tm_layout(frame = FALSE, main.title = "Dialysis: Driving Time")

tmap_save(dialysis_time_map.divs, "output/dialysis_access/dialysis_time_map.divs.png")

# Min Distance map
dialysis_mindist_map <- 
  tm_shape(mindist.sf) +
  tm_fill(col = "minDisDial",
          palette = "-RdYlBu",
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Dialysis: Minimum Distance")

tmap_save(dialysis_mindist_map, "output/dialysis_mindist_map.png")

#### Reference maps -----

division_map <-
  tm_shape(divisions) +
  tm_borders() +
  tm_layout(frame = FALSE)
division_map

#### FIN ----


