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


                            
          
#### Minimum distance data ----

# Merge min dist with zip geom
mindist.sf <- merge(zips_clean, mindist, by.x = "GEOID10", by.y = "GEOID")
# Filter variables
mindist.sf <- mindist.sf %>% select(GEOID = GEOID10, minDisBup, minDisMet, minDisNalV, geometry)
str(mindist.sf)

# Code NAs as 9999s, for mapping
mindist.sf <- mindist.sf %>% replace(is.na(.), 9999)
mindist.sf$minDisBup <- round(mindist.sf$minDisBup, 2)
mindist.sf$minDisMet <- round(mindist.sf$minDisMet, 2)
mindist.sf$minDisNalV <- round(mindist.sf$minDisNalV, 2)




#### Buprenorphine maps ----

# Merge buprenorphine data with zip geom
bup.sf <- merge(zips_clean, bup_data, by.x = "ZCTA5CE10", by.y = "GEOID")
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
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Time to Nearest Resource", main.title.size = 0.9)

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
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Count within 30 Minutes", main.title.size = 0.9)

# Access score map
bup_score_map <- 
  tm_shape(bup.sf) +
  tm_fill(col = "buprenorphine_score",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Score",
          style = "fixed",
          breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1.0)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Score within 30 Mins", main.title.size = 0.9)

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
  tm_layout(frame = FALSE, main.title = "Buprenorphine: Minimum Distance", main.title.size = 0.9)




#### Methadone maps ----

# Merge meth data with zip geom
meth.sf <- merge(zips_clean, meth_data, by.x = "GEOID10", by.y = "GEOID")
# Filter variables
meth.sf <- meth.sf %>% select(GEOID = GEOID10, count_in_range_methadone, time_to_nearest_methadone, methadone_score, geometry)
str(bup.sf)

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
  tm_layout(frame = FALSE, main.title = "Methadone: Time to Nearest Resource", main.title.size = 0.9)

# Count in 30 min. range
meth_count_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "count_in_range_methadone",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Count",
          style = "fixed",
          breaks = c(0, 1, 5, 20, 50, 100, Inf)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Count within 30 Minutes", main.title.size = 0.9)

# Access score map
meth_score_map <- 
  tm_shape(meth.sf) +
  tm_fill(col = "methadone_score",
          palette = "RdYlBu",
          alpha = 0.7,
          title = "Score",
          style = "fixed",
          breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1.0)) +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Methadone: Score within 30 Mins", main.title.size = 0.9)

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
  tm_layout(frame = FALSE, main.title = "Methadone: Minimum Distance", main.title.size = 0.9)




#### Nalaxotrone / Vivitrol maps ----

# Merge nalviv data with zip geom
nalviv.sf <- merge(zips_clean, NalViv_data, by.x = "GEOID10", by.y = "ZCTA")
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
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Time to Nearest Resource", main.title.size = 0.9)

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
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Count within 30 Minutes", main.title.size = 0.9)

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
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Score within 30 Mins", main.title.size = 0.9)

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
  tm_layout(frame = FALSE, main.title = "Naltexone/Vivitrol: Minimum Distance", main.title.size = 0.9)



#### FIN ----
