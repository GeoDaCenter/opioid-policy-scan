#### About ----

# Author : Susan Paykin
# Date : January 13, 2021
# Updated : Nov 2, 2021
# About: This code cleans and prepares data on Alcohol Outlet Density for U.S. states, counties, census tracts, and zip codes. 

#### Code outline ----

# Step 1) Wrangle alcohol outlet location data
# Step 2) Prepare data: Calculate total outlets per geography, total land area, total population
# Step 3) Calculate outlet density per land area and per capita for each spatial scale
# Note: Outlet density per land area is calculated as: *Total outlets / Land area in sq mi*,
#       Outlet density per capita is calculated as: *Total outlets / total population*
# Step 4) Save final datasets

#### Wrangle alcohol outlet location data ----

# Set up 
library(tidyverse)
library(sf)
library(tmap)

setwd("~/git/opioid-policy-scan/")

## Original data cleaning - skip to next section, loading alcohol outlet csv ##

# # Load full business dataset
# biz <- read.table("data_raw/2019_Business_Academic_QCQ.txt", sep = ",", header = TRUE)
# 
# # Filter for alcohol outlets (NAICS 445310 - Beer, Wine, & Liquor Stores)
# alc_outlets <- 
#   biz %>% 
#   filter(str_detect(Primary.NAICS.Code, "^445310"))
# sort((unique(alc_outlets$State))) #Note: includes U.S. states, D.C., Puerto Rico, Virgin Islands, Guam, FM, MP
# 
# # Select relevant variables
# names(alc_outlets)
# unique(alc_outlets$Primary.NAICS.Code)
# 
# alc_outlets_clean <- alc_outlets %>%
#   select(Company, Address.Line.1, City, State, FIPS.Code, ZipCode, County.Code, Census.Tract, Primary.NAICS.Code, Latitude, Longitude)
# 
# # Save alcohol outlets dataset 
# #write.csv(alc_outlets_clean, "data_raw/alc_outlets_raw.csv")


# Load  alcohol outlets dataset
alc_outlets_clean <- read.csv("data_raw/alc_outlets_raw.csv")

# Add leading zeroes to zip code
alc_outlets_clean$ZipCode <- sprintf("%05d", alc_outlets_clean$ZipCode)

alc_outlets_clean <- alc_outlets_clean %>% 
  select(Company, Address.Line.1, City, State, FIPS.Code, ZipCode, County.Code, Census.Tract, Primary.NAICS.Code, Latitude, Longitude)

# Convert Longitude variable to numeric
alc_outlets_clean$Longitude <- as.numeric(alc_outlets_clean$Longitude)
str(alc_outlets_clean)
which(is.na(alc_outlets_clean$Longitude)) # observation 7444 is missing longitude
alc_outlets_clean <- alc_outlets_clean[-7444, ]

# Convert to spatial data
alc_outlets.sf <- st_as_sf(alc_outlets_clean, 
                           coords = c("Longitude", "Latitude"),
                           crs = 4326) 

#### State data ----

# Read in geometry data
states_geom <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")

states <- states_geom %>%
  select(GEOID, STATE = STUSPS, ALAND)

# Divide land area (sq meters) by 2,590,000 to get sq miles
states$areaSqMi <- round(states$ALAND/2590000, 2)

# Count number of outlets in states
state_count <- alc_outlets_clean %>%
  group_by(State) %>%
  count()

# Merge total number of outlets to state area
states_merge <- merge(states, state_count, by.x = "STATE", by.y = "State") %>% st_drop_geometry()

# Prepare population data 
state_pop <- read.csv("data_final/DS01_S.csv")
head(state_pop)

# Add leading 0s
state_pop$STATEFP <- sprintf("%02d", state_pop$STATEFP)

# Clean state pop data
state_pop <- state_pop %>%
  select(STATEFP, totPopE)

# Merge population data
states_merge <- merge(states_merge, state_pop, by.x = "GEOID", by.y = "STATEFP")

##### County data ---- 

# Read in geometry
counties_geom <- st_read("data_final/geometryFiles/tl_2018_county/counties2018.shp")
head(counties_geom)

# Select relevant variables
counties <- counties_geom %>%
  select(STATEFP, COUNTYFP, NAME, ALAND)

counties <- counties %>% transform(FIPS.Code = paste0(STATEFP, COUNTYFP))

# Divide land area (sq meters) by 2,590,000 to get sq miles
counties$areaSqMi <- counties$ALAND/2590000
head(counties)

# Add leading 0s
alc_outlets_clean$FIPS.Code <- sprintf("%05d", as.numeric(alc_outlets_clean$FIPS.Code))

# Count number of outlets by county, remove territories
counties_count <- data.frame(alc_outlets_clean %>%
                               filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
                                group_by(FIPS.Code) %>%
                                count())
head(counties_count)
                                
# Merge total number outlets to counties
counties_merge_count <- merge(counties, counties_count, by = "FIPS.Code", all=TRUE) %>%
  st_drop_geometry()
head(counties_merge_count)

# Prepare population data
county_pop <- read.csv("data_final/DS01_C.csv")

# Add leading 0s
county_pop$COUNTYFP <- sprintf("%05d", county_pop$COUNTYFP)

# Merge population data
counties_merge <- merge(counties_merge_count, county_pop, by.x = "FIPS.Code", by.y = "COUNTYFP", all = TRUE) %>%
  select(FIPS.Code, STATEFP, NAME, areaSqMi, totPopE, alcTotal = n)
head(counties_merge)

##### Tract data ----- 

# Read in geometry
tracts_geom <- st_read("data_final/geometryFiles/tl_2018_tract/tracts2018.shp") %>% st_drop_geometry()
head(tracts_geom)

# Select relevant variables
tracts <- tracts_geom %>%
  select(STATEFP, COUNTYFP, TRACTCE, ALAND)
tracts <- tracts %>% transform(FIPS.Code = paste0(STATEFP, COUNTYFP, TRACTCE))
head(tracts)

# Divide land area (sq meters) by 2,590,000 to get sq miles
tracts$areaSqMi <- tracts$ALAND/2590000

# Add leading 0s to Alcohol Outlets - Census.Tract
alc_outlets_clean$Census.Tract <- sprintf("%06d", alc_outlets_clean$Census.Tract)

# Create new variable - full tract GEOID
alc_outlets_clean <- alc_outlets_clean %>% 
  transform(GEOID = paste0(FIPS.Code, Census.Tract))

# Count number of outlets by tract, remove territories
tract_count <- data.frame(alc_outlets_clean %>%
                             filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
                             group_by(GEOID) %>%
                             count())

# Merge total number of outlets to tract area
tract_merge_count <- merge(tracts, tract_count, by.x = "FIPS.Code", by.y = "GEOID", all.x = TRUE)
head(tract_merge_count)

# Prepare population data 
tract_pop <- read.csv("data_final/DS01_T.csv") %>% 
  select(GEOID, totPopE)
head(tract_pop)

# Add leading 0s
tract_pop$GEOID <- sprintf("%011s", tract_pop$GEOID)

# Merge population data
tract_merge <- merge(tract_merge_count, tract_pop, by.x = "FIPS.Code", by.y = "GEOID", all = TRUE)
head(tract_merge)

##### Zip Code data ---- 

# Read in geometry file
zips_geom <- st_read("data_final/geometryFiles/tl_2018_zcta")
head(zips_geom)

# Select relevant variables
zctas <- zips_geom %>%
  select(ZCTA5CE10, ALAND10) %>%
  st_drop_geometry()
head(zctas)

# Divide land area (sq meters) by 2,590,000 to get sq miles
zctas$areaSqMi <- zctas$ALAND10/2590000
head(zctas)

length(unique(alc_outlets_clean$ZipCode)) # 12,706 unique zip codes in alc outlets dataset
      
# Count number of outlets by zip code, remove territories
zcta_count <- data.frame(alc_outlets_clean %>%
  filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
  group_by(ZipCode) %>%
  count())
head(zcta_count)

# Merge total number of outlets to zip area
zcta_merge <- merge(zctas, zcta_count, by.x = "ZCTA5CE10", by.y = "ZipCode", all.x = TRUE)
head(zcta_merge)

# Prepare zip code population data
zip_pop <- read.csv("data_final/DS01_Z.csv") %>%
  select(ZCTA, totPopE)
head(zip_pop)

# Add leading 0s
zip_pop$ZCTA <- sprintf("%05d", zip_pop$ZCTA)

# Merge pop data with count data
zcta_merge <- merge(zcta_merge, zip_pop, by.x = "ZCTA5CE10", by.y = "ZCTA", all.x = TRUE)

##### Calculate outlet density per land area and per capita ----

##### State density ---- 
states_dens <- states_merge %>%
  select(STATEFP = GEOID, state = STATE, areaSqMi, totPopE, alcTotal = n) %>%
  mutate(alcDens = round(alcTotal / areaSqMi, 4),  alcPerCap = round(alcTotal / totPopE, 4)) %>%
  format(scientific = FALSE)

head(states_dens)

##### County density ----
counties_dens <- counties_merge %>%
  select(COUNTYFP = FIPS.Code, STATEFP, county = NAME, areaSqMi, totPopE, alcTotal) %>%
  mutate(alcDens = round(alcTotal / areaSqMi, 4), alcPerCap = round(alcTotal / totPopE, 4)) %>%
  format(scientific = FALSE)

head(counties_dens)

#### Tract density ---- 
tract_dens <- tract_merge %>%
  select(GEOID = FIPS.Code, STATEFP, COUNTYFP, TRACTCE, areaSqMi, totPopE, alcTotal = n) %>%
  mutate(alcDens = round(alcTotal / areaSqMi, 2), alcPerCap = round(alcTotal / totPopE, 2)) %>%
  format(scientific = FALSE)

head(tract_dens)

##### Zip code density ----- 
zcta_dens <- zcta_merge %>%
  select(ZCTA = ZCTA5CE10, areaSqMi, totPopE, alcTotal = n) %>%
  mutate(alcDens = round(alcTotal / areaSqMi, 2), alcPerCap = round(alcTotal / totPopE, 2)) %>%
  format(scientific = FALSE)

head(zcta_dens)

#### Save final datasets ----

write.csv(states_dens, "data_final/BE03_S.csv", row.names = FALSE)
write.csv(counties_dens, "data_final/BE03_C.csv", row.names = FALSE)
write.csv(tract_dens, "data_final/BE03_T.csv", row.names = FALSE)
write.csv(zcta_dens, "data_final/BE03_Z.csv", row.names = FALSE)


######## FIN #########
