library(tidyverse)
library(data.table)
library(purrr)
library(stringr)
library(sf)

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

##### States ##### 

# Read in all CSVs 
state_files <- 
  list.files(pattern = "*_S.csv", full.names = FALSE)
statesDf <- lapply(state_files, read.csv)

#Rename dataframes 
names(statesDf) <- gsub(".csv","", state_files)

# names(statesDf) <- gsub(".csv","",
#                         list.files("data_final/", pattern = "*_S.csv",
#                                    full.names = FALSE),
#                                    fixed = TRUE)
# Add leading zero to FIPS
statesdf2 <- 
  Map(function(i, y) {
  statesDf[[i]][, 1] <- str_pad(statesDf[[i]][, 1], width = y, pad = "0")
  statesDf[[i]] # this gets returned
}, 
i = 1:length(statesDf), 
y = 2) 

#statesDf$Access01_S$STATEFP <- sprintf("%02s", statesDf$Access01_S$STATEFP)

# Create new ID variable, starting with G 
statesdf3 <- lapply(statesdf2, transform, "G_STATEFP" = statesdf2[[i]][,1])
# Reorder variables - move G_STATEFP to head
statesdf4 <- lapply(statesdf3, relocate, "G_STATEFP" %>% head())
# Add a G to start of G_STATEFP observations
statesdf5 <- lapply(statesdf4, transform, 
                    G_STATEFP = paste0("G", G_STATEFP))
#Rename variables
names(statesdf5) <- names(statesDf)

#### Export CSVs 

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Make filepaths from list names
names <- paste0(names(statesdf5), ".csv")
# Iterate over the list and the vector of list names to write csvs\
for(i in 1:length(statesdf5)) {
  write_csv(statesdf5[[i]], names[i])
}

##### Counties #####

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

# Read in all CSVs 
county_files <- 
  list.files(pattern = "*_C.csv", full.names = FALSE)
countyDf <- lapply(county_files, read.csv)

#Rename dataframes 
names(countyDf) <- gsub(".csv","", county_files)

# Add leading zero to FIPS
countydf2 <- 
  Map(function(i, y) {
    countyDf[[i]][, 1] <- str_pad(countyDf[[i]][, 1], width = y, pad = "0")
    countyDf[[i]] # this gets returned
  }, 
  i = 1:length(countyDf), 
  y = 5) 

# Create new ID variable, starting with G 
countydf3 <- lapply(countydf2, transform, "G_COUNTYFP" = countydf2[[i]][,1])
# Reorder variables - move G_COUNTYFP to head
countydf4 <- lapply(countydf3, relocate, "G_COUNTYFP" %>% head())
# Add a G to start of G_COUNTYFP observations
countydf5 <- lapply(countydf4, transform, 
                    G_COUNTYFP = paste0("G", G_COUNTYFP))
#Rename variables
names(countydf5) <- names(countyDf)

#### Export CSVs 

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Make filepaths from list names
names <- paste0(names(countydf5), ".csv")
# Iterate over the list and the vector of list names to write csvs\
for(i in 1:length(countydf5)) {
  write_csv(countydf5[[i]], names[i])
}

##### Zip Codes #####

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

# Read in all CSVs 
zip_files <- 
  list.files(pattern = "*_Z.csv", full.names = FALSE)
zipDf <- lapply(zip_files, read.csv)

#Rename dataframes 
names(zipDf) <- gsub(".csv","", zip_files)

# Add leading zero to FIPS
zipdf2 <- 
  Map(function(i, y) {
    zipDf[[i]][, 1] <- str_pad(zipDf[[i]][, 1], width = y, pad = "0")
    zipDf[[i]] # this gets returned
  }, 
  i = 1:length(zipDf), 
  y = 5) 

# Create new ID variable, starting with G 
zipdf3 <- lapply(zipdf2, transform, "G_ZCTA" = zipdf2[[i]][,1])
# Reorder variables - move G_ZCTA to head
zipdf4 <- lapply(zipdf3, relocate, "G_ZCTA" %>% head())
# Add a G to start of G_ZCTA observations
zipdf5 <- lapply(zipdf4, transform, 
                 G_ZCTA = paste0("G", G_ZCTA))
#Rename variables
names(zipdf5) <- names(zipDf)

#### Export CSVs 

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Make filepaths from list names
names <- paste0(names(zipdf5), ".csv")
# Iterate over the list and the vector of list names to write csvs\
for(i in 1:length(zipdf5)) {
  write_csv(zipdf5[[i]], names[i])
}

##### Census Tracts #####

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

# Read in all CSVs 
tract_files <- 
  list.files(pattern = "*_T.csv", full.names = FALSE)
tractDf <- lapply(tract_files, read.csv)

#Rename dataframes 
names(tractDf) <- gsub(".csv","", tract_files)

# Add leading zero to FIPS
tractdf2 <- 
  Map(function(i, y) {
    tractDf[[i]][, 1] <- str_pad(tractDf[[i]][, 1], width = y, pad = "0")
    tractDf[[i]] # this gets returned
  }, 
  i = 1:length(tractDf), 
  y = 11) 

# Create new ID variable, starting with G 
tractdf3 <- lapply(tractdf2, transform, "G_GEOID" = tractdf2[[i]][,1])
# Reorder variables - move G_GEOID to head
tractdf4 <- lapply(tractdf3, relocate, "G_GEOID" %>% head())
# Add a G to start of G_GEOID observations
tractdf5 <- lapply(tractdf4, transform, 
                   G_GEOID = paste0("G", G_GEOID))
#Rename variables
names(tractdf5) <- names(tractDf)

#### Export CSVs 

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Make filepaths from list names
names <- paste0(names(tractdf5), ".csv")
# Iterate over the list and the vector of list names to write csvs\
for(i in 1:length(tractdf5)) {
  write_csv(tractdf5[[i]], names[i])
}

##########################
##### GEOMETRY FILES #####
##########################

##### States Geometry #####

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

# Read in all CSVs 
state_geom <- st_read("geometryFiles/tl_2018_state/")

# Add leading zero to FIPS
state_geom$STATEFP <- sprintf("%02s", state_geom$STATEFP)

# Create new ID variable, starting with G 
state_geom2 <- state_geom %>% mutate(G_STATEFP = STATEFP)

# Reorder variables - move G_STATEFP var to head
state_geom3 <- state_geom2 %>% relocate("G_STATEFP" %>% head())

# Add G to start of G_STATEFP observations
state_geom4 <- state_geom3 %>% mutate(G_STATEFP = paste0("G", G_STATEFP))
  
#### Export files

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Write shapefiles
st_write(state_geom4, "states2018.shp")

##### County Geometry #####

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

# Read in all CSVs 
county_geom <- st_read("geometryFiles/tl_2018_county/")

# Add leading zero to FIPS
county_geom$GEOID <- sprintf("%05s", county_geom$GEOID)

# Create new ID variable, starting with G 
county_geom2 <- county_geom %>% mutate(G_COUNTYFP = GEOID)

# Reorder variables - move G_COUNTYFP var to head
county_geom3 <- county_geom2 %>% relocate("G_COUNTYFP" %>% head())

# Add G to start of G_COUNTYFP observations
county_geom4 <- county_geom3 %>% mutate(G_COUNTYFP = paste0("G", G_COUNTYFP))

#### Export files

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Write shapefiles
st_write(county_geom4, "counties2018.shp")

##### Zip Code Geometry #####

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

# Read in all CSVs 
zip_geom <- st_read("geometryFiles/tl_2018_zcta/")

# Add leading zero to FIPS
zip_geom$ZCTA5CE10 <- sprintf("%05s", zip_geom$ZCTA5CE10)

# Create new ID variable, starting with G 
zip_geom2 <- zip_geom %>% mutate(G_ZCTA = ZCTA5CE10)

# Reorder variables - move G_COUNTYFP var to head
zip_geom3 <- zip_geom2 %>% relocate("G_ZCTA" %>% head())

# Add G to start of G_COUNTYFP observations
zip_geom4 <- zip_geom3 %>% mutate(G_ZCTA = paste0("G", G_ZCTA))

#### Export files

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Write shapefiles
st_write(zip_geom4, "zctas2018.shp")

##### Census Tract Geometry #####

# Set WD
setwd("~/git/opioid-policy-scan/data_final")

# Read in all CSVs 
tract_geom <- st_read("geometryFiles/tl_2018_tract/")

# Add leading zero to FIPS
tract_geom$GEOID <- sprintf("%011s", tract_geom$GEOID)

# Create new ID variable, starting with G 
tract_geom2 <- tract_geom %>% mutate(G_GEOID = GEOID)

# Reorder variables - move G_COUNTYFP var to head
tract_geom3 <- tract_geom2 %>% relocate("G_GEOID" %>% head())

# Add G to start of G_COUNTYFP observations
tract_geom4 <- tract_geom3 %>% mutate(G_GEOID = paste0("G", G_GEOID))

#### Export files

# Reset WD 
setwd("~/git/opioid-policy-scan/data_final/test")

# Write shapefiles
st_write(tract_geom4, "tracts2018.shp")

