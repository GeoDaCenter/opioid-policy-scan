library(sf)
library(tmap)
library(tidyverse)

mouds <- st_read("intmed_output/MOUDs/old_us-wide-moudsCleaned.gpkg")

mouds <- mouds %>% filter(category != "buprenorphine")

str(mouds)  
str(bup.clean.sf)

mouds_new <- mouds %>% select(name1, name2, street1, street2, city, state, zip, category, countyName, source, geom)

bup.clean.sf2 <- bup.clean.sf %>% select(name1, name2, street1 = addressLine1, street2 = addressLine2,
                                         city, state, zip = zipCode, category, countyName = county, source, geom = x)
str(bup.clean.sf2)
str(mouds_new)

mouds_final <- rbind(mouds_new, bup.clean.sf2)

unique(mouds_final$category)

# Export as geopackage, csv
st_write(mouds_final, "data_final/us-wide-moudsCleaned.gpkg")
write.csv(mouds_final, "data_final/us-wide-moudsCleaned.csv")
