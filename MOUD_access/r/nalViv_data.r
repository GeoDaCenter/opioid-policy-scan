#### Set up ----

library(tidyverse)

#### Load and clean data ----

# Load data
NalViv_data <- read.csv("data_raw/NaltrexoneVivtrolCalcs_fromMoksha/accesstoNalVivitrol.csv")

# Clean zip code data
NalViv_data$ZCTA <- sprintf("%05d", NalViv_data$ZCTA)

# Enable spatial: Merge nalviv data with zip geom
nalviv.sf <- merge(zips_clean, NalViv_data, by.x = "GEOID10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

# Filter variables
nalviv.sf <- nalviv.sf %>% select(GEOID = GEOID10, count_in_range_naltrexone.vivitrol, time_to_nearest_naltrexone.vivitrol, naltrexone.vivitrol_score, geometry)
str(nalviv.sf)

##### Save csv data ---

write.csv(NalViv_data, "data_final/nalviv_access.csv")

#### FIN ----

