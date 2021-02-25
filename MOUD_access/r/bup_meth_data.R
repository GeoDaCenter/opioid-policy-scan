#### Set up ----

library(tidyverse)

#### Buprenorphone data ---- 

# Load data
bup_data <- read.csv("data_raw/accesstoBup.csv")

# Clean data
bup_data$ZCTA <- sprintf("%05d", bup_data$ZCTA)

# Enable spatial: Merge with zip geom, set projection to EPSG 102003
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

#### Methadone data ----

# Load data
meth_data <- read.csv("data_raw/accesstoMeth.csv")

# Clean data
meth_data$ZCTA <- sprintf("%05d", meth_data$ZCTA)

# Merge bup+meth data for future handling
bupMeth <- merge(bup_data, meth_data, by = "ZCTA")

# Enable spatial: Merge meth data with zip geom
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

#### Save access datasets ----

write.csv(bup_data, "data_final/bup_access.csv")
write.csv(meth_data, "data_final/meth_access.csv")

#### FIN ----


