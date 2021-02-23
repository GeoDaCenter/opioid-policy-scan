#### Set up ----

library(tidyverse)

#### Clean data ---- 

# Load data
dial_data <- read.csv("data_raw/accesstoDialysis.csv")

# Clean data
dial_data$ZCTA <- sprintf("%05d", dial_data$ZCTA)

#### Enable spatial ----

# Merge data with geom
dialysis.sf <- merge(zips_clean, dial_data, by.x = "GEOID10", by.y = "ZCTA") %>%
  st_set_crs(4326) %>%
  st_transform(crs)

# Filter variables
dialysis.sf <- dialysis.sf %>% select(GEOID = GEOID10, time_to_nearest_dialysis, count_in_range_dialysis, geometry)
str(dialysis.sf)

##### FIN ----
