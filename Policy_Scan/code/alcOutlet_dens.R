########### INFO ###########

# Author : Susan Paykin
# Date : January 13, 2021
# About: This code cleans and prepares data on Alcohol Outlet Density for U.S. states, counties, census tracts, and zip codes. 

# Part 1) Wrangle alcohol outlet location data

# Part 2) Calculate total outlet per geography, via point-in-polygon analysis

# Part 3) Calculate outlet density per land area, for each geography. 
## Note: Alcohol outlet density is calculated as: *Total outlets / Land area in sq mi*  

# Part 4) Save final datasets

############################

#########
# Part 1) Wrangle alcohol outlet location data
#########

# Set up 
library(tidyverse)
library(sf)
library(tmap)

setwd("~/git/opioid-policy-scan/Policy_Scan")

## Original data cleaning - skip to next section, loading alcohol outlet csv ##

# # Load full business dataset
# biz <- read.table("data_raw/2019_Business_Academic_QCQ.txt", sep = ",", header = TRUE)
# 
# names(biz)
# str(biz) #Variables include: Latitude, Longitude, census tracts (Census.Tract), states (FIPS.Code, State), County (County.Code), zip code (ZipCode)
# 
# # Filter for alcohol outlets (NAICS 445310 - Beer, Wine, & Liquor Stores)
# alc_outlets <- 
#   biz %>% 
#   filter(str_detect(Primary.NAICS.Code, "^445310"))
# sort((unique(alc_outlets$State))) #Note: includes U.S. states, D.C., Puerto Rico, Virgin Islands, Guam, FM, MP
# 
# # add leading zeroes to zip code
# # create function
# zip <- function(z)formatC(z, width = 5, format = "d", flag = "0") 
# 
# # create character variables with zeroes
# zipcode_chr <- data.frame(zip(alc_outlets$ZipCode))
# # rename variable
# colnames(zipcode_chr) <- "ZipCode_chr"
# 
# # Add to alc_outlets dataset
# alc_outlets <- cbind(alc_outlets, zipcode_chr)
# 
# # Select relevant variables
# names(alc_outlets)
# unique(alc_outlets$Primary.NAICS.Code)
# 
# alc_outlets_clean <- alc_outlets %>%
#   select(Company, Address.Line.1, City, State, FIPS.Code, ZipCode, ZipCode_chr, County.Code, Census.Tract, Primary.NAICS.Code, Latitude, Longitude)
# 
# # Save alcohol outlets dataset 
# #write.csv(alc_outlets_clean, "data_raw/alc_outlets_raw.csv")

## START HERE ## 

# Load  alcohol outlets dataset
alc_outlets_clean <- read.csv("data_raw/alc_outlets_raw.csv")

# add leading zeroes to zip code
# create function
zip <- function(z)formatC(z, width = 5, format = "d", flag = "0")

# create character variables with zeroes
zipcode_chr <- data.frame(zip(alc_outlets_clean$ZipCode_chr))
# rename variable
colnames(zipcode_chr) <- "ZipCode_chr2"

# Add to alc_outlets dataset
alc_outlets_clean <- cbind(alc_outlets_clean, zipcode_chr)
alc_outlets_clean <- alc_outlets_clean %>% 
  select(Company, Address.Line.1, City, State, FIPS.Code, ZipCode, ZipCode_chr2, County.Code, Census.Tract, Primary.NAICS.Code, Latitude, Longitude)

# Attempt 1: Convert to spatial data
alc_outlets.sf <- st_as_sf(alc_outlets_clean, 
                           coords = c("Longitude", "Latitude"),
                           crs = 4326) # Error! Missing values
str(alc_outlets_clean) # Error - Longitude is chr, need to convert to num

# Convert Longitude variable to numeric
alc_outlets_clean$Longitude <- as.numeric(alc_outlets_clean$Longitude)
str(alc_outlets_clean)
# Determine what is missing & remove
which(is.na(alc_outlets_clean$Longitude)) # observation 7444 is missing longitude
alc_outlets_clean <- alc_outlets_clean[-7444, ]

# Attempt 2: Convert to spatial data
alc_outlets.sf <- st_as_sf(alc_outlets_clean, 
                           coords = c("Longitude", "Latitude"),
                           crs = 4326) 

# Test plot
plot(st_geometry(alc_outlets.sf))

#########
# Part 2) Calculate total outlet per geography, via point-in-polygon analysis
#########

##### STATE #####

# Read in geometry data
states_geom <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")

states <- states_geom %>%
  select(GEOID, STATE = STUSPS, ALAND)
head(states)

# Divide land area (sq meters) by 2,590,000 to get sq miles
states$areaSqMi <- states$ALAND/2590000

# Count number of outlets in states
state_count <- alc_outlets_clean %>%
  group_by(State) %>%
  count()

# remove FM, GU, MP, PR, VI to match geometry file
state_count <- state_count %>%
  filter(!State %in% c("FM", "GU", "MP", "PR", "VI"))

# Merge total number of outlets to state area
states_merge <- merge(states, state_count, by.x = "STATE", by.y = "State")

##### COUNTY #####

# Read in geometry
counties_geom <- st_read("data_final/geometryFiles/tl_2018_county/counties2018.shp")

# Select relevant variables
counties <- counties_geom %>%
  select(STATEFP, COUNTYFP, NAME, ALAND)
str(counties)

# Divide land area (sq meters) by 2,590,000 to get sq miles
counties$areaSqMi <- counties$ALAND/2590000

# Mutate county code 
countycode <- function(z)formatC(z, width = 3, format = "d", flag = "0")
countycode_chr <- data.frame(countycode(alc_outlets_clean$County.Code))
# rename variable
colnames(countycode_chr) <- "CountyCode_chr"
# add to dataset
alc_outlets_clean <- cbind(alc_outlets_clean, countycode_chr)

# Count number of outlets by county, remove territories
counties_count <- data.frame(alc_outlets_clean %>%
                               filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
                               group_by(CountyCode_chr) %>%
                               count()
                             )

# Merge total number outlets to county
counties_merge <- merge(counties, counties_count, by.x = "COUNTYFP", by.y = "CountyCode_chr", all=TRUE)
counties_merge[is.na(counties_merge)] <- 0

##### TRACT #####

# Read in geometry
tracts_geom <- st_read("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")
str(tracts_geom)

# Select relevant variables
tracts <- tracts_geom %>%
  select(STATEFP, TRACTCE, NAME, ALAND)

# Divide land area (sq meters) by 2,590,000 to get sq miles
tracts$areaSqMi <- tracts$ALAND/2590000

# Mutate census code
censuscode <- function(z)formatC(z, width = 6, format = "d", flag = "0")
censuscode_chr <- data.frame(censuscode(alc_outlets_clean$Census.Tract))
# rename variable
colnames(censuscode_chr) <- "Census.Tract_chr"
# add to dataset
alc_outlets_clean <- cbind(alc_outlets_clean, censuscode_chr)

# Count number of outlets by tract, remove territories
tract_count <- data.frame(alc_outlets_clean %>%
                             filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
                             group_by(Census.Tract_chr) %>%
                             count())

# Merge total number of outlets to tract area
tract_merge <- merge(tracts, tract_count, by.x = "TRACTCE", by.y = "Census.Tract_chr", all = TRUE)
tract_merge[is.na(tract_merge)] <- 0
head(tract_merge)

##### ZIP CODE #####

# Read in geometry file
zips_geom <- st_read("data_final/geometryFiles/tl_2018_zcta")
str(zips_geom)

# Select relevant variables
zctas <- zips_geom %>%
  select(ZipCode_chr = ZCTA5CE10, ALAND10)
str(zctas)

# Divide land area (sq meters) by 2,590,000 to get sq miles
zctas$areaSqMi <- zctas$ALAND10/2590000

# Count number of outlets by zip code, remove territories
zcta_count <- data.frame(alc_outlets_clean %>%
  filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
  group_by(ZipCode_chr2) %>%
  count())

# Merge total number of outlets to zip area
zcta_merge <- merge(zctas, zcta_count, by.x = "ZipCode_chr", by.y = "ZipCode_chr2", all = TRUE)
zcta_merge[is.na(zcta_merge)] <- 0

###########
# Part 3) Calculate outlet density per land area, for each geography
###########

##### STATE #####
states_dens <- states_merge %>%
  select(STATEFP = GEOID, State = STATE, areaSqMi, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi)

state_map <- 
  tm_shape(states_dens) +
  tm_borders() +
  tm_fill(col = "alcDens", alpha = 0.7, style = "quantile")
state_map

##### COUNTY #####
counties_dens <- counties_merge %>%
  select(STATEFP, COUNTYFP, NAME, areaSqMi, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi)

# plot to check
tmap_mode("view")
county_map <- 
  tm_shape(counties_dens) +
  tm_borders() +
  tm_fill(col = "alcDens", alpha = 0.7, style = "quantile", id = "NAME")
county_map  

##### TRACT #####
tract_dens <- tract_merge %>%
  select(STATEFP, TRACTCE, areaSqMi, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi)

# plot to check
tract_map <- 
  tm_shape(tract_dens) +
  tm_borders() +
  tm_fill(col = "alcDens", alpha = 0.7, style = "quantile")
tract_map

##### ZIP #####
zcta_dens <- zcta_merge %>%
  select(ZIPCODE = ZipCode_chr, areaSqMi, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi)

# Part 4) Save final datasets

st_write(states_dens, "data_final/HS03_S.csv")
st_write(counties_dens, "data_final/HS03_C.csv")
st_write(tract_dens, "data_final/HS03_T.csv")
st_write(zcta_dens, "data_final/HS03_Z.csv")


######## FIN #########

