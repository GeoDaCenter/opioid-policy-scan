# Visualize metrics -------------------------------------------------------
library(sf)
library(tmap)
library(tidyverse)

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

# write_sf(continental_zips, "data-output/continental_zips.gpkg")

continental_zips <- read_sf("data-output/continental_zips.gpkg")

continental_states <- st_intersection(states, continental_bbox)


# Calculate hinge breaks (this is right skewed data so only need upfence)

get_hinge_breaks <- function(df, variable) {
  
  values <- dplyr::pull(df, variable)
  
  qv <- unname(quantile(values))
  iqr <- qv[4] - qv[2]
  upfence <- qv[4] + 1.5 * iqr
  
  breaks <- unname(quantile(values))
  breaks[5] <- upfence
  breaks[6] <- max(values)
  
  breaks
}

bup_breaks <- get_hinge_breaks(continental_zips, "bup_min_dists_mi")
meth_breaks <- get_hinge_breaks(continental_zips, "meth_min_dists_mi")
nal_breaks <- get_hinge_breaks(continental_zips, "nal_min_dists_mi")

# tmap time!


# Buprenorphine Viz -------------------------------------------------------

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

mb_fisher <- 
  # tm_shape(continental_states) +
  # tm_fill("grey") +
  tm_shape(continental_zips) +
  tm_fill("bup_min_dists_mi", 
          n = 5,
          style = "fisher", 
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Buprenorphine Access Metrics") +
  tm_credits("Natural Breaks")

# takes 5 minutes to run
tmap_save(mb_fisher, "output/bup_us_min_dist_fisher.png")
beepr::beep()



# Methadone Viz -----------------------------------------------------------

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

mm_fisher <- tm_shape(continental_zips) +
  tm_fill("meth_min_dists_mi", 
          n = 5,
          style = "fisher", 
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Methadone Access Metrics") +
  tm_credits("Natural Breaks")

# takes 5 minutes to run
tmap_save(mm_fisher, "output/meth_us_min_dist_fisher.png")
beepr::beep()


mm_sd <- tm_shape(continental_zips) +
  tm_fill("meth_min_dists_mi", 
          n = 6,
          style = "sd", 
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = "-RdBu") +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Methadone Access Metrics") +
  tm_credits("Standard Deviation")

# takes 5 minutes to run
tmap_save(mm_sd, "output/meth_us_min_dist_sd.png")
beepr::beep()


# Naltrexone Viz ----------------------------------------------------------

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


mn_fisher <- tm_shape(continental_zips) +
  tm_fill("nal_min_dists_mi", 
          n = 5,
          style = "fisher",
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Naltrexone Access Metrics") +
  tm_credits("Natural Breaks")

# takes 5 minutes to run
tmap_save(mn_fisher, "output/nal_us_min_dist_fisher.png")
beepr::beep()



# Summary stats / viz -----------------------------------------------------

# Pivot to long for plotting
continental_zips_long <- continental_zips %>% 
  st_drop_geometry() %>% 
  rename(Buprenorphine = bup_min_dists_mi,
         Methadone = meth_min_dists_mi,
         Naltrexone = nal_min_dists_mi) %>% 
  select(zip = ZCTA5CE10, Buprenorphine, Methadone, Naltrexone) %>% 
  pivot_longer(-zip, names_to = "medication", values_to = "min_dist")


# Boxplots
bps <- continental_zips_long %>% 
ggplot(aes(x = medication, y = min_dist)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Min Distance to Nearest by Medication", x = "Medication", y = "Mininum Distance to Nearest (mi)")

ggsave("output/min_dist_boxplots.png", bps, width = 6, height = 4)


# Histograms
h <- ggplot(continental_zips_long, aes(x = min_dist)) +
  geom_histogram(bins = 50) +
  facet_wrap(~medication) +
  theme_minimal() +
  labs(title = "Distribution of Minimum Distances by Medication", x = "Minimum Distance to Resource (mi)", y = "Count")

ggsave("output/min_dist_hists.png", h, width = 6, height = 4)


# Summary stats (really hacky way to do this...)

ss <- cbind(
  bup_min_dist = round(summary(continental_zips$bup_min_dists_mi), 2),
  meth_min_dist = round(summary(continental_zips$meth_min_dists_mi), 2),
  nal_min_dist = round(summary(continental_zips$nal_min_dists_mi), 2)) %>% 
  as.data.frame() %>% 
  rownames_to_column()

write.csv(ss, "output/us_metric_summary_stats.csv")


# Explore outliers --------------------------------------------------------


meth_outliers <- filter(continental_zips, meth_min_dists_mi >= 100)

mmo <- tm_shape(meth_outliers) +
  tm_fill("meth_min_dists_mi", 
          breaks = meth_breaks, 
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Methadone Access Metrics - Outliers")

tmap_save(mmo, "output/meth_outliers.png")
beepr::beep()

