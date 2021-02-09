#### About ----
# This code prepares the count data for all 3 MOUDs, counts the number of MOUD types within the 30 min range (0, 1, 2, or 3), 
# and maps ZCTAs by this variable.

#### Set up ----

library(tmap)
library(sf)
library(tidyverse)
library(RColorBrewer)

#### Prepare data ----

# Combine count data for 3 MOUDs
count_data <- bupMeth %>% select(GEOID = ZCTA, count_in_range_buprenorphine, count_in_range_methadone)
count_data <- merge(count_data, nalviv.sf, by.x = "GEOID", by.y = "GEOID")
count_data <- count_data %>% select(GEOID, count_in_range_buprenorphine, count_in_range_methadone, count_in_range_naltrexone.vivitrol)

# Create new variable for counting number of medication types within range
count_data$type_count <- 0
count_data$type_count <- ifelse(count_data$count_in_range_buprenorphine > 0 &
                                  count_data$count_in_range_methadone > 0 &
                                  count_data$count_in_range_naltrexone.vivitrol > 0, "3",
                                ifelse(count_data$count_in_range_buprenorphine > 0 &
                                         count_data$count_in_range_methadone > 0 &
                                         count_data$count_in_range_naltrexone.vivitrol == 0, "2",
                                       ifelse(count_data$count_in_range_buprenorphine > 0 &
                                                count_data$count_in_range_methadone == 0 &
                                                count_data$count_in_range_naltrexone.vivitrol == 0, "1", 
                                              ifelse(count_data$count_in_range_buprenorphine > 0 &
                                                       count_data$count_in_range_naltrexone.vivitrol > 0 &
                                                       count_data$count_in_range_methadone == 0, "2",
                                                     ifelse(count_data$count_in_range_buprenorphine == 0 &
                                                            count_data$count_in_range_methadone > 0 &
                                                              count_data$count_in_range_naltrexone.vivitrol > 0, "2", 
                                                            ifelse(count_data$count_in_range_buprenorphine == 0 &
                                                                     count_data$count_in_range_methadone > 0 &
                                                                     count_data$count_in_range_naltrexone.vivitrol == 0, "1",
                                                                   ifelse(count_data$count_in_range_buprenorphine == 0 &
                                                                          count_data$count_in_range_methadone == 0 &
                                                                            count_data$count_in_range_naltrexone.vivitrol > 0, "1", "0")))))))

count_data$type_count <- factor(count_data$type_count, levels = c('0', '1', '2', '3'))

# Merge with zip geometry, set projection
count.sf <- merge(zips_clean, count_data, by.x = "GEOID10", by.y = "GEOID") %>%
  st_set_crs(4326) %>%
  st_transform("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")

str(count.sf)

# Save data
write.csv(count_data, "data_final/type_count_data.csv")

#### Map ----

conditional_map <- 
  tm_shape(count.sf) +
  tm_fill(col = "type_count",
          palette = "RdYlBu",
          title = "Number of MOUDs") +
  tm_shape(states) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE,
            main.title = "Access to Number of MOUDs within 30 Minutes")

tmap_save(conditional_map, "output/MOUDtype_map.png")
