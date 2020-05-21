# Map dialysis places

dialysis_continental <- clip_to_continental_us(dialysis_access) %>% 
  st_transform(102003)

dialysis_breaks <- as.numeric(get_hinge_breaks(dialysis_continental, "dialysis_dists"))

d <- 
  tm_shape(dialysis_continental) +
  tm_fill("dialysis_dists",
          breaks = c(0, 5, 10, 15, 30, 150),
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Dialysis Access Metrics")

tmap_save(d, "output/dialysis_us_min_dist_fixed.png")
beepr::beep()
