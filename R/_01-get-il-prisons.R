library(rvest)
library(dplyr)
library(purrr)
library(readr)

# test 

prison_url <- read_html("https://www2.illinois.gov/idoc/facilities/Pages/correctionalfacilities.aspx")

prison_names <- html_nodes(prison_url, "a") %>% 
  html_text() %>% 
  .[93:120]

prison_links <- html_nodes(prison_url, "a") %>% 
  html_attr("href") %>% 
  .[93:120]

get_address <- function(url) {
  read_html(url) %>% 
    html_nodes("#ctl00_PlaceHolderMain_ctl07__ControlWrapper_RichHtmlField p:nth-child(1)") %>% 
    html_text()
}

prison_df <- cbind(prison_names, prison_links) %>% 
  as.data.frame(stringsAsFactors = FALSE) 

prison_address_df <- prison_df %>% 
  mutate(address = map(prison_links, get_address)) %>% 
  mutate(address = as.character(address))

write_csv(prison_address_df, "data-output/il_prisons.csv")

##### Geocoding

tmaptools::geocode_OSM("Big Muddy River Correctional Center")$coords[1]

prison_coords_df <- prison_names %>% 
  as_tibble() %>% 
  mutate(
    lon = map(prison_names, ~tmaptools::geocode_OSM(.)$coords[1]),
    lat = map(prison_names, ~tmaptools::geocode_OSM(.)$coords[2]))

lon <- map(prison_names, ~tmaptools::geocode_OSM(.)$coords[1])

## issue with geocoding Sheridan Correctional Center
