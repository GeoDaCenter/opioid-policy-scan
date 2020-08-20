# Snippets of code and such

# 99_clean-cartova1025 ----------------------------------------------------

# Random fear that zip was not the same as zcta
cartova_1025_sf_zcta <- zips_sf %>%
  right_join(cartova_1025, by = c("zip" = "zcta")) %>% 
  rename(zcta = "zip.y")

st_write(cartova_1025_sf, "data-output/cartova_1025_sf.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
st_write(cartova_1025_sf_zcta, "data-output/cartova_1025_sf_zcta.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

test1 <- read_csv("data-output/cartova_1025_sf.csv") %>%
  rename(zip.y = zcta)
test2 <- read_csv("data-output/cartova_1025_sf_zcta.csv")

all_equal(test1, test2)


# 04_calc-nearest-zip-centroid --------------------------------------------

# Distance to centroid sandbox
distance_matrix_with_categories <- distance_matrix %>% 
  rbind(zips_centroids$ZCTA5CE10, .) %>%  
  janitor::row_to_names(1) %>% 
  cbind(Category = as.character(pt_master$Category), .) 

min_dists <- distance_matrix_with_categories %>% 
  group_by(Category) %>% 
  summarize_all(min)

min_dists_final <- min_dists %>% 
  pivot_longer(cols = starts_with("6"), names_to = "Zip", values_to = "Distance to Zip Centroid (m)") %>% 
  pivot_wider(Zip, names_from = "Category", values_from = "Distance to Zip Centroid (m)")

write_csv(min_dists_final, "data-output/min-dists-to-centroid.csv")


# Check it!

resource_categories <- as_tibble(as.character(unique(pt_master$Category)))

mutate(resource_categories, min_dists = map(value, calc_centroid_min_dist))

resource_category <- "Naloxone RX"

calc_centroid_min_dist <- function(resource_category) {
  resources <- filter(pt_master, Category == resource_category)
  
  distances <- st_distance(zips_centroids, resources) %>% 
    as.data.frame()
  
  min_distances <- distances %>%
    summarize_all(min) %>% 
    rbind(zips_centroids$ZCTA5CE10, .) %>%  
    janitor::row_to_names(1) %>% 
    cbind(Category = resource_category, .) %>% 
    pivot_longer(cols = starts_with("6"), names_to = "Zip", values_to = "Distance to Zip Centroid (m)") %>% 
    pivot_wider(Zip, names_from = "Category", values_from = "Distance to Zip Centroid (m)")
}


calc_centroid_min_dist(resource_category)

test <- slice(zips_centroids, 1)
one_test <- st_distance(test, test_resources)
min(one_test)





test_resources <- filter(distance_matrix_with_categories, Category == "ER Trauma Centers")

head_test <- st_distance(test_resources, zips_centroids) %>% 
  as.data.frame()

mins <- head_test %>% 
  summarise_all(min)

View(mins)

distance_matrix_with_categories %>% 
  filter(Category == "Naloxone RX") %>% 
  summarize(min(`61820`))
