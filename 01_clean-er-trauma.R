# Clean emergency depts data

library(tidyverse)
library(readxl)

ers <- read_excel("data/Emergency-Departments.xlsx")

ers_to_geocode <- 
  mutate(ers, ID = row_number()) %>% 
  separate(Location, into = c("CITY", "STATE"), sep = ", ") %>% 
  select(ID,
         ADDRESS = Hospital,
         CITY,
         STATE)

write_csv(ers_to_geocode, "data-output/ers_to_geocode.csv")

# Then go geocode it: https://geocoder.rcc.uchicago.edu/upload

ers_geocoded <- read_csv("data/ers_to_geocode_1570813925_geocoded.csv")

ers_final <- select(ers_geocoded, ID, Longitude, Latitude) %>% 
  left_join(ers_to_geocode, ers_geocoded, by = "ID")

write_csv(ers_final, "data-output/Emergency-Departments-geocoded.csv")
