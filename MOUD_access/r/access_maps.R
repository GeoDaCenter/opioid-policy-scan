#### Set up ----

library(sf)
library(USAboundaries)
library(tidyverse)
library(tmap)
library(tigris)
library(RColorBrewer)

# Function - clip to continental US 

clip_to_continental_us <- function(sf) {
  
  continental_bbox <- st_as_sfc("POLYGON((-126.3 50.6, -66.0 50.6, -66.0 20.1, -126.3 20.1, -126.3 50.6))") %>% 
    st_as_sf(crs = 4326) %>% 
    st_transform(st_crs(sf))
  
  continental_sf <- st_intersection(continental_bbox, sf)
  
}

# Set CRS - EPSG 102003
crs <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

##### Load geometry data ----

# States data
states <- us_states()
states <- states %>% filter(!stusps %in% c("AK", "HI", "PR"))

# ZCTA data
zips <- st_read("data_raw/tl_2018_zcta/zctas2018.shp")
zips_clean <- zips %>% clip_to_continental_us()

#### Buprenorphine maps ----

# Merge buprenorphine data with zip geom, set projection to EPSG 102003
bup.sf <- merge(zips_clean, bup_data, by.x = "ZCTA5CE10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

# Filter variables
bup.sf <- bup.sf %>% select(GEOID = GEOID10, count_in_range_buprenorphine, time_to_nearest_buprenorphine, buprenorphine_score, geometry)
str(bup.sf)

# Round score variable
bup.sf$buprenorphine_score <- round(bup.sf$buprenorphine_score, 2)

# Create categorical variable for count mapping
bup.sf$count_cat <- ""
bup.sf$count_cat <- ifelse(bup.sf$count_in_range_buprenorphine == 0, "0", 
                            ifelse(bup.sf$count_in_range_buprenorphine == 1, "1", 
                                   ifelse(bup.sf$count_in_range_buprenorphine >= 2 & bup.sf$count_in_range_buprenorphine <= 5, "2 to 5", 
                                          ifelse(bup.sf$count_in_range_buprenorphine >= 6 & bup.sf$count_in_range_buprenorphine <= 10, "6 to 10", "More than 10"))))

bup.sf <- bup.sf %>%
  mutate(cat = cut(count_in_range_buprenorphine, breaks = c(0, 1, 2, 5, 10, Inf),
                   labels = c(0, 1, 2, 3, 4))) %>%
  arrange(cat)

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

tmap_save(bup_time_map, "output/bup_time_map.png")

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

# Merge meth data with zip geom
meth.sf <- merge(zips_clean, meth_data, by.x = "GEOID10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

# Filter variables
meth.sf <- meth.sf %>% select(GEOID = GEOID10, count_in_range_methadone, time_to_nearest_methadone, methadone_score, geometry)
str(meth.sf)

# Round score variable
meth.sf$methadone_score <- round(meth.sf$methadone_score, 2)

# Create categorical variable for count mapping
meth.sf$count_cat <- ""
meth.sf$count_cat <- ifelse(meth.sf$count_in_range_methadone == 0, "0", 
                            ifelse(meth.sf$count_in_range_methadone == 1, "1", 
                                   ifelse(meth.sf$count_in_range_methadone >= 2 & meth.sf$count_in_range_methadone <= 5, "2 to 5", 
                                          ifelse(meth.sf$count_in_range_methadone >= 6 & meth.sf$count_in_range_methadone <= 10, "6 to 10", "More than 10"))))

meth.sf <- meth.sf %>%
  mutate(cat = cut(count_in_range_methadone, breaks = c(0, 1, 2, 5, 10, Inf),
                   labels = c(0, 1, 2, 3, 4))) %>%
  arrange(cat)

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

# Merge nalviv data with zip geom
nalviv.sf <- merge(zips_clean, NalViv_data, by.x = "GEOID10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

# Filter variables
nalviv.sf <- nalviv.sf %>% select(GEOID = GEOID10, count_in_range_naltrexone.vivitrol, time_to_nearest_naltrexone.vivitrol, naltrexone.vivitrol_score, geometry)
str(nalviv.sf)

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

# Merge dialysis data with geom
dialysis.sf <- merge(zips_clean, dial_data, by.x = "GEOID10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

# Filter variables
dialysis.sf <- dialysis.sf %>% select(GEOID = GEOID10, time_to_nearest_dialysis, count_in_range_dialysis, geometry)
str(dialysis.sf)

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

tmap_save(dialysis_time_map, "output/dialysis_time_map.png")

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


#### FIN ----


