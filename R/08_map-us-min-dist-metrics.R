# Visualize metrics -------------------------------------------------------
library(sf)
library(tmap)
library(dplyr)

zip_access <- read_sf("data-output/us_min_dists.gpkg")
zip_access <- zip_access %>% 
  st_transform(102003)

states <- read_sf("data-output/states.gpkg")
states <- states %>% 
  st_set_crs(4326) %>% 
  st_transform(102003)


# Only visualize continental US
continental_bbox <- st_as_sfc("POLYGON((-126.3 50.6, -66.0 50.6, -66.0 20.1, -126.3 20.1, -126.3 50.6))") %>% 
  st_as_sf(crs = 4326) %>% 
  st_transform(102003)

continental_zips <- st_intersection(continental_bbox, zip_access)

continental_states <- st_intersection(states, continental_bbox)


# Calculate hinge breaks (this is right skewed data so only need upfence)

get_hinge_breaks <- function(variable) {
  
  values <- dplyr::pull(zip_access, variable)
  
  qv <- unname(quantile(values))
  iqr <- qv[4] - qv[2]
  upfence <- qv[4] + 1.5 * iqr
  
  breaks <- unname(quantile(values))
  breaks[5] <- upfence
  breaks[6] <- max(values)
  
  breaks
}

bup_breaks <- get_hinge_breaks("bup_min_dists_mi")
meth_breaks <- get_hinge_breaks("meth_min_dists_mi")
nal_breaks <- get_hinge_breaks("nal_min_dists_mi")


# tmap time!

mb <- 
  # tm_shape(continental_states) +
  # tm_fill("grey") +
  tm_shape(continental_zips) +
  tm_fill("bup_min_dists_mi", 
          breaks = bup_breaks, 
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Buprenorphine Access Metrics")

# takes 5 minutes to run
tmap_save(mb, "output/bup_us_min_dist.png")
beepr::beep()


mm <- tm_shape(continental_zips) +
  tm_fill("meth_min_dists_mi", 
          breaks = meth_breaks, 
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Methadone Access Metrics")

# takes 5 minutes to run
tmap_save(mm, "output/meth_us_min_dist.png")
beepr::beep()


mn <- tm_shape(continental_zips) +
  tm_fill("nal_min_dists_mi", 
          breaks = nal_breaks, 
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Naltrexone Access Metrics")

# takes 5 minutes to run
tmap_save(mn, "output/nal_us_min_dist.png")
beepr::beep()

