library(tidyverse)
library(sf)
library(tmap)
library(RColorBrewer)

#### Prepare data ----

# Subset IL methadone data
il.meth.sf <- meth.sf %>% 
  filter(str_detect(GEOID, '^60|^61|^62')) %>%
  st_transform(4326)

# Subset IL min distance data
il.mindist.sf <- mindist.sf %>%
  filter(str_detect(GEOID, '^60|^61|^62')) %>%
  st_transform(4326)

# Subset IL state boundaries
il.geom <- states %>% filter(stusps == "IL") %>%
  st_transform(4326)

# Set color scheme

# test plot
tm_shape(il.meth.sf) +
  tm_borders()

#### Create categorical variable ---- 

# Create a count categorical variable for mapping
# il.meth.sf$count_cat <- ""
# il.meth.sf$count_cat <- ifelse(il.meth.sf$count_in_range_methadone == 0, "0",
#                                ifelse(il.meth.sf$count_in_range_methadone == 1, "1", 
#                                       ifelse(il.meth.sf$count_in_range_methadone >= 2 & il.meth.sf$count_in_range_methadone <= 5, "2 to 5",
#                                              ifelse(il.meth.sf$count_in_range_methadone >= 6 & il.meth.sf$count_in_range_methadone <= 9, "6 to 10",
#                                                     "More than 10"))))
# 
# il.meth.sf <- il.meth.sf %>%
#   mutate(cat = cut(count_in_range_methadone, breaks = c(0, 1, 2, 5, 10, Inf),
#                    labels = c(0, 1, 2, 3, 4))) %>%
#   arrange(cat)


#### Map ----

# Time to nearest provider
il1 <- 
  tm_shape(il.meth.sf) +
  tm_fill(col = "time_to_nearest_methadone", 
          palette = "Oranges",
          title = "Minutes",
          style = "fixed",
          breaks = c(0, 15, 30, 60, 90, Inf)) +
  tm_shape(il.geom) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Time to Nearest Resource")

il1

tmap_save(il1, "output/il_time.png")

# Count in 30 min. range

il2 <- 
  tm_shape(il.meth.sf) +
  tm_fill(col = "count_cat",
          palette = "-Oranges",
          title = "Count") +
  tm_shape(il.geom) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Number within 30 Minutes")

il2

tmap_save(il2, "output/il_count.png")

# Access score map
il3 <- 
  tm_shape(il.meth.sf) +
  tm_fill(col = "methadone_score",
          palette = "-Oranges",
          title = "Score",
          style = "jenks") +
  tm_shape(il.geom) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Access Score")

il3

tmap_save(il3, "output/il_score.png")

# Minimum distance map 
il4 <- 
  tm_shape(il.mindist.sf) +
  tm_fill(col = "minDisMet",
          palette = "Oranges",
          title = "Miles",
          style = "fixed",
          breaks = c(0, 10, 20, 30, 50, Inf)) +
  tm_shape(il.geom) +
  tm_borders(alpha = 0.7, lwd = 0.5) +
  tm_layout(frame = FALSE, main.title = "Minimum Distance")

il4

tmap_save(il4, "output/il_mindist.png")


# View in grid
il_access_maps <- tmap_arrange(il1, il2, il3, il4)
il_access_maps

tmap_save(il_access_maps, "output/il_access_maps.png")
