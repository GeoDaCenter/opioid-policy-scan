#### Set up ----

library(sf)
library(tidyverse)
library(tmap)
library(tigris)
library(RColorBrewer)


##### Load geometry data ----

# States data
states <- us_states()
states <- states %>% filter(!stusps %in% c("AK", "HI", "PR"))

# ZCTA data
zips <- st_read("data_raw/tl_2018_zcta/zctas2018.shp")

# Filter out AK, HI, PR
zips_clean <- zips %>% filter(!grepl("^999", ZCTA5CE10), !grepl("^998", ZCTA5CE10), !grepl("^997", ZCTA5CE10), !grepl("^996", ZCTA5CE10),!grepl("^995", ZCTA5CE10), #AK
                            !grepl("^009", ZCTA5CE10), !grepl("^008", ZCTA5CE10), !grepl("^007", ZCTA5CE10), !grepl("^006", ZCTA5CE10), #PR
                            !grepl("^969", ZCTA5CE10), !grepl("^968", ZCTA5CE10), !grepl("^967", ZCTA5CE10)) #HI


#### Buprenorphine maps ----

# Merge buprenorphine data with zip geom, set projection to EPSG 102003
bup.sf <- merge(zips_clean, bup_data, by.x = "ZCTA5CE10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")

# Filter variables
bup.sf <- bup.sf %>% select(GEOID = GEOID10, count_in_range_buprenorphine, time_to_nearest_buprenorphine, buprenorphine_score, geometry)
str(bup.sf)

# Time to nearest provider
bup_time_map <- 
tm_shape(bup.sf) +
  tm_fill(col = "time_to_nearest_buprenorphine", 
          palette = "-RdYlBu",
          alpha = 0.7,
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Time to Nearest Resource")

#tmap_save(bup_time_map, "output/bup_time_map.png")

# Count in 30 min. range
bup_count_map <- 
  tm_shape(bup.sf) +
  tm_fill(col = "count_in_range_buprenorphine",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Count",
          style = "fixed",
          breaks = c(0, 1, 5, 20, 50, 100, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Count within 30 Minutes")

#tmap_save(bup_count_map, "output/bup_count_map.png")

# Access score map
bup_score_map <- 
  tm_shape(bup.sf) +
  tm_fill(col = "buprenorphine_score",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Score",
          style = "fixed",
          breaks = c(0, 0.6, 1.2, 1.8, 2.4, 3)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Score within 30 Mins")

#tmap_save(bup_score_map, "output/bup_score_map.png")

# Minimum distance map 
bup_mindist_map <- 
  tm_shape(mindist.sf) +
  tm_fill(col = "minDisBup",
          palette = "-RdYlBu",
          alpha = 0.7,
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Minimum Distance")

#tmap_save(bup_mindist_map, "output/bup_mindist_map.png")


#### Methadone maps ----

# Merge meth data with zip geom
meth.sf <- merge(zips_clean, meth_data, by.x = "GEOID10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")

# Filter variables
meth.sf <- meth.sf %>% select(GEOID = GEOID10, count_in_range_methadone, time_to_nearest_methadone, methadone_score, geometry)
str(meth.sf)

# Time to nearest provider
meth_time_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "time_to_nearest_methadone", 
          palette = "-RdYlBu",
          alpha = 0.7,
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Time to Nearest Resource")

#tmap_save(meth_time_map, "output/meth_time_map.png")

# Count in 30 min. range
meth_count_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "count_in_range_methadone",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Count",
          style = "fixed",
          breaks = c(0, 1, 5, 20, 50, 75, 100)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Count within 30 Minutes")

#tmap_save(meth_count_map, "output/meth_count_map.png")

# Access score map
meth_score_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "methadone_score",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Score",
          style = "fixed",
          breaks = c(0, 0.6, 1.2, 1.8, 2.4, 3)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Score within 30 Mins")

#tmap_save(meth_score_map, "output/meth_score_map.png")

# Minimum distance map 
meth_mindist_map <- 
  tm_shape(mindist.sf) +
  tm_fill(col = "minDisMet",
          palette = "-RdYlBu",
          alpha = 0.7,
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Minimum Distance")

#tmap_save(meth_mindist_map, "output/meth_mindist_map.png")



#### Nalaxotrone / Vivitrol maps ----

# Merge nalviv data with zip geom
nalviv.sf <- merge(zips_clean, NalViv_data, by.x = "GEOID10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")

# Filter variables
nalviv.sf <- nalviv.sf %>% select(GEOID = GEOID10, count_in_range_naltrexone.vivitrol, time_to_nearest_naltrexone.vivitrol, naltrexone.vivitrol_score, geometry)
str(nalviv.sf)

# Time to nearest provider
nalviv_time_map <- 
  tm_shape(nalviv.sf) +
  tm_fill(col = "time_to_nearest_naltrexone.vivitrol", 
          palette = "-RdYlBu",
          alpha = 0.7,
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Time to Nearest Resource")

#tmap_save(nalviv_time_map, "output/nalviv_time_map.png")

# Count in 30 min. range
nalviv_count_map <- 
  tm_shape(nalviv.sf) +
  tm_fill(col = "count_in_range_naltrexone.vivitrol",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Count",
          style = "fixed",
          breaks = c(0, 1, 5, 20, 50, 100, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Count within 30 Minutes")

#tmap_save(nalviv_count_map, "output/nalviv_count_map.png")

# Access score map
nalviv_score_map <- 
  tm_shape(nalviv.sf) +
  tm_fill(col = "naltrexone.vivitrol_score",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Score",
          style = "fixed",
          breaks = c(0, 0.6, 1.2, 1.8, 2.4, 3)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Score within 30 Mins")

#tmap_save(nalviv_score_map, "output/nalviv_score_map.png")

# Min Distance
nalviv_mindist_map <- 
  tm_shape(mindist.sf) +
  tm_fill(col = "minDisNalV",
          palette = "-RdYlBu",
          alpha = 0.7,
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Minimum Distance")

#tmap_save(nalviv_mindist_map, "output/nalviv_mindist_map.png")



#### FIN ----
