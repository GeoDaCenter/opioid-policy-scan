library(sf)
library(tidygeocoder)
library(tmap)
library(tidyverse)

dialysis <- read_csv("data_raw/23ew-n7w9.csv")
head(dialysis)

dialysis$fullAdd <- paste(as.character(dialysis$`Address Line 1`), 
                          as.character(dialysis$`Address Line 2`),
                          as.character(dialysis$City),
                          as.character(dialysis$State),
                          as.character(dialysis$Zip))
dialysis_fulladd <- dialysis %>% 
  select(fullAdd)

test1 <- dialysis[1:1000,]
geoCodedtest1 <- test1 %>% 
  geocode(test1, address = 'fullAdd', 
          lat = latitude, long = longitude, method = 'cascade')

nrow(geoCodedtest1[is.na(geoCodedtest1$latitude),])
#463

test2 <- dialysis[1001:2000,]
geoCodedtest2 <- test2 %>% 
  geocode(test2, address = 'fullAdd', 
          lat = latitude, long = longitude, method = 'cascade')
nrow(geoCodedtest2[is.na(geoCodedtest2$latitude),])
#408

test3 <- dialysis[2001:3500,]
geoCodedtest3 <- test3 %>% 
  geocode(test3, address = 'fullAdd', 
          lat = latitude, long = longitude, method = 'cascade')
nrow(geoCodedtest3[is.na(geoCodedtest3$latitude),])

test4 <- dialysis[3501:5000,]
geoCodedtest4 <- test4 %>% 
  geocode(test4, address = 'fullAdd', 
          lat = latitude, long = longitude, method = 'cascade')
nrow(geoCodedtest4[is.na(geoCodedtest4$latitude),])

test5 <- dialysis[5001:6500,]
geoCodedtest5 <- test5 %>% 
  geocode(test5, address = 'fullAdd', 
          lat = latitude, long = longitude, method = 'cascade')
nrow(geoCodedtest5[is.na(geoCodedtest5$latitude),])

test6 <- dialysis[6501:7724,]
geoCodedtest6 <- test6 %>% 
  geocode(test6, address = 'fullAdd', 
          lat = latitude, long = longitude, method = 'cascade')
nrow(geoCodedtest6[is.na(geoCodedtest6$latitude),])

geoCoded <- bind_rows(geoCodedtest1, geoCodedtest2, geoCodedtest3, geoCodedtest4, geoCodedtest5, geoCodedtest6)
write.csv(geoCoded, "intmed_output/geoCoded.csv")

geoCoded <- geoCoded %>% 
  select(`Address Line 1`, `Address Line 2`, City, State, Zip, fullAdd, 
         latitude, longitude)
head(geoCoded)
