library(sf)
library(tmap)
library(tidyverse)

hiv <- read_sf("data-output/01_hiv_testing.gpkg")
hcv <- read_sf("data-output/01_hcv_testing.gpkg")
moud <- read_sf("data-output/02_moud-all.gpkg")
nalox <- read_sf("data-output/01_nalox.gpkg")
fqhc <- read_sf("data-output/01_fqhc.gpkg")

zips <- st_read("data-output/va_1107_nonsensitive.gpkg")
counties <- read_sf("data-output/il_counties.gpkg")
counties <- mutate(counties, County = toupper(County))

zips_high_vul <- zips %>% 
  st_transform(32616) %>% 
  mutate(
    high_vul = as.factor(case_when(
      varankhcv == 9 ~ 2,
      varankhcv == 8 ~ 1,
      TRUE ~ 0)),
    high_vul = fct_relevel(high_vul, 
                           function(x) sort(x, decreasing = TRUE)))

levels(zips_high_vul$high_vul) <- c("Top 10% Vulnerable", "Top 20% Vulnerable", "Less Vulnerable")

# Vulnerability Map ------------------------------------------------------------
hcv_vulnerability <- tm_shape(zips_high_vul, unit = "mi") +
  tm_fill("high_vul", 
          palette = c("#EC2E21", "#FDA446", "#EFEFEF"), 
          title = "Vulnerable Zip Codes") +
tm_shape(counties) +
  tm_borders(col = "grey") +
  tm_text("County", col = "grey70", size = 0.5) +
tm_layout(frame = TRUE,
          legend.position = c(0.03, 0.065)) +
tm_compass(position = c(0.03, 0.15)) +
tm_scale_bar(breaks = c(0, 10, 20, 40, 80),
             position = c(0.03, 0.03))


hcv_vul_map <- hcv_vulnerability +
  tm_layout(main.title = "HCV Vulnerable Zip Codes, Illinois, 2017")
  
tmap_save(hcv_vul_map, "output/hcv_vul_map.png")

# HIV Testing
hiv_map <- hcv_vulnerability +
  tm_shape(hiv) + 
  tm_symbols(col = "black", size = 0.3, border.col = "white") +
  tm_layout(main.title = "HIV Testing Resources by HCV Vulnerable Zip Code, Illinois, 2017",
            main.title.size = 0.8,
            main.title.position = "center")

# HCV Testing
hcv_map <- hcv_vulnerability +
  tm_shape(hcv) + 
  tm_symbols(col = "black", size = 0.3, border.col = "white") +
  tm_layout(main.title = "HCV Testing Resources by HCV Vulnerable Zip Code, Illinois, 2017",
            main.title.size = 0.8,
            main.title.position = "center")

# Nalox
nalox_map <- hcv_vulnerability +
  tm_shape(nalox) + 
  tm_symbols(col = "black", size = 0.3, border.col = "white") +
  tm_layout(main.title = "Naloxone Pharmacies by HCV Vulnerable Zip Code, Illinois, 2017",
            main.title.size = 0.8,
            main.title.position = "center")

# MOUD
moud_map <- hcv_vulnerability +
  tm_shape(moud) + 
  tm_symbols(col = "black", size = 0.3, border.col = "white") +
  tm_layout(main.title = "MOUD by HCV Vulnerable Zip Code, Illinois, 2017",
            main.title.size = 0.8,
            main.title.position = "center")

tmap_save(moud_map, "moud.png")
tmap_save(nalox_map, "nalox.png")
tmap_save(hiv_map, "hiv.png")
tmap_save(hcv_map, "hcv.png")


# Cook County maps --------------------------------------------------------

cook_county <- read_sf("data-output/cook.gpkg")
comm_areas <- read_sf("data/Boundaries - Community Areas (current).geojson")
comm_areas <- st_transform(comm_areas, 32616)

cook_zips <- st_intersection(zips_high_vul, cook_county)
cook_hiv <- st_intersection(hiv, cook_county)

cook_base <- tm_shape(cook_county, unit = "mi") +
  tm_borders(col = "grey") +
tm_shape(cook_zips) +
  tm_fill("high_vul", 
          palette = c("#EC2E21", "#FDA446", "#EFEFEF"), 
          title = "Vulnerable Zip Codes") +
  tm_shape(cook_hiv) +
  tm_symbols(col = "black", size = 0.3, border.col = "white") +
  tm_shape(comm_areas) +
  tm_borders(col = "white")
  
cook_base +
  tm_shape(cook_hiv) +
  tm_symbols(col = "black", size = 0.3, border.col = "white") + 
  tm_layout(main.title = "HIV Testing Resources, Suburban Cook County, 2017",
            main.title.size = 1)
