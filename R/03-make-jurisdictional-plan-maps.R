library(sf)
library(tmap)
library(tidyverse)

resources <- read_sf("data-output/02_point-master.gpkg")

zips <- st_read("data-output/va_1107_nonsensitive.gpkg")
counties <- read_sf("data-output/il_counties.gpkg")
counties <- mutate(counties, County = toupper(County))

zips_high_vul <- zips %>% 
  mutate(
    high_vul = as.factor(case_when(
      varankhcv == 9 ~ 2,
      varankhcv == 8 ~ 1,
      TRUE ~ 0)),
    high_vul = fct_relevel(high_vul, 
                           function(x) sort(x, decreasing = TRUE)))

levels(zips_high_vul$high_vul) <- c("Top 10% Vulnerable", "Top 20% Vulnerable", "Less Vulnerable")

unique(resources$Category)

resources <- resources %>% 
  mutate(Category = case_when(
    Category == "HIV Testing" ~ "HIV Testing Resources",
    Category == "HCV Testing" ~ "HCV Testing Resources",
    Category == "Naloxone RX" ~ "Naloxone Distribution",
    Category == "FQHC Facility" ~ "Federally Qualified Health Centers",
    str_detect(Category, "MOUD") ~ "MOUD Resources"
  ))

# Vulnerability Maps -----------------------------------------------------------
tm_shape(zips_high_vul) +
  tm_fill("high_vul", 
          palette = c("#EC2E21", "#FDA446", "#EFEFEF"), 
          title = "Vulnerable Zip Codes") +
tm_shape(counties) +
  tm_borders(col = "grey") +
  tm_text("County", col = "grey70", size = 0.5) +
tm_layout(main.title = "Zip Codes Most Vulnerable to HCV Infection, IL, 2017",
          main.title.position = "center",
          main.title.size = 1,
          fontfamily = "Helvetica",
          panel.label.bg.color = "white",
          frame = FALSE) +
  tm_credits(c("Sources: \nNotes: \nAuthor: Center for Spatial Data Science, \nUniversity of Chicago \nCreated: November 14, 2019", ""), position = c("left", "bottom")) +
  tm_legend(legend.position = c("left", "top")) +
  # tm_scale_bar(position = c("left", "bottom")) +
  # tm_compass(position = c("left", "top"))


# Resource Facet Maps ----------------------------------------------------------
tm_shape(zips_high_vul) +
  tm_fill("high_vul", 
          palette = c("#EC2E21", "#FDA446", "#EFEFEF"), 
          title = "Vulnerable Zip Codes") +
tm_shape(counties) +
  tm_borders(col = "grey") +
  tm_text("County", col = "grey70", size = 0.5) +
tm_shape(resources) +
  tm_facets(by = "Category", ncol = 2, free.coords = FALSE) +
  tm_symbols(col = "black", size = 0.3, border.col = "white") + 
tm_layout(main.title = "HCV Vulnerability Assessment Maps\n",
            # main.title.size = 0.8,
            # main.title.position = "center",
            fontfamily = "Helvetica",
            panel.label.bg.color = "white") +
  tm_scale_bar(position = c("right", "bottom")) +
  tm_compass(position = c("left", "top"))

