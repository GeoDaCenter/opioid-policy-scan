# Author : Moksha Menghaney
# Date : October 22nd, 2020
# This piece of code will clean MOUD file, add Vivitrol and 
# create new csv and .gpkg

library(sf)
library(tmap)
library(tidyverse)


## update these for your drive!
geometryFilesLoc <- './opioid-policy-scan/Policy_Scan/data_final/geometryFiles/'
rawDataFilesLoc <- './opioid-policy-scan/Policy_Scan/data_raw/'
outputFilesLoc <- './opioid-policy-scan/Policy_Scan/data_final/moud/'
  
counties <- st_read(paste0(geometryFilesLoc,'tl_2018_county/counties2018.shp')) %>% 
  st_transform(crs = 4326) %>% select(GEOID,NAME,geometry)

mouds <- 
  st_read(paste0(rawDataFilesLoc,'us-wide-moud.gpkg'), layer='us-wide-moud') %>% 
  st_transform(crs = 4326) ## has entire set duplicated, cleaning that
dim(mouds)

mouds <- mouds[!duplicated(mouds),]
dim(mouds)
head(mouds)

# add counties
mouds <- st_join(mouds, counties) %>% select(-county) %>% rename(countyName = NAME,
                                                                 countyGEOID = GEOID)

# vivitrol data
vivitrol <- read.csv(paste0(rawDataFilesLoc,"vivitrol_providers.csv"), header = TRUE) %>% mutate(ID = row_number()-1)
geocodedVivitrol <- read.csv(paste0(rawDataFilesLoc,"out_geocoded.csv"), header= TRUE) 
vivitrol <- merge(vivitrol, geocodedVivitrol, all.x = TRUE) 
vivitrol <- st_as_sf(vivitrol, coords = c("Longitude", "Latitude"), crs = 4326) %>%
  select(name, street, CITY, STATE, ZIP, geometry)

vivitrol <- st_join(vivitrol, counties) %>% rename(countyName = NAME,
                                                  countyGEOID = GEOID,
                                                  name1 = name,
                                                  street1 = street,
                                                  city = CITY,
                                                  state = STATE,
                                                  zip = ZIP,
                                                  geom = geometry)
vivitrol$category <- 'vivitrol'
vivitrol$name2 <- NA
vivitrol$street2 <- NA
vivitrol$zip4 <- NA
vivitrol$source <- 'vivitrolWeb'

## merge and save
mouds$source <- 'SAMHSA'
mouds <- rbind(mouds, vivitrol)
table(as.factor(mouds$category))

mouds$category <- ifelse(mouds$category =='vivitrol' | mouds$category =='naltrexone',
                         'naltrexone/vivitrol',mouds$category)

table(as.factor(mouds$category), as.factor(mouds$source))

mouds[,c('Longitude','Latitude')] <- st_coordinates(mouds)

write.csv(mouds,paste0(outputFilesLoc,'us-wide-moudsCleaned.csv'))
st_write(mouds,paste0(outputFilesLoc,'us-wide-moudsCleaned.gpkg'))
