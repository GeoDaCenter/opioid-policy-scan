########### INFO ###########

# Author : Susan Paykin
# Date : January 13, 2021
# About: This code cleans and prepares data on Alcohol Outlet Density for U.S. states, counties, census tracts, and zip codes. 

# Step 1) Wrangle alcohol outlet location data

# Step 2) Prepare data: Calculate total outlets per geography, prepare total land area variables, prepare total population variables

# Step 3) Calculate outlet density per land area and per capita for each geography. 
# Note: Alcohol outlet density per land area is calculated as: *Total outlets / Land area in sq mi*,
#       Alcohol outlet density per capita is calculated as: *Total outlets / total population*

# Step 4) Save final datasets

########### CODE START ###########

#########
# Step 1) Wrangle alcohol outlet location data
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

# Convert Longitude variable to numeric
alc_outlets_clean$Longitude <- as.numeric(alc_outlets_clean$Longitude)
str(alc_outlets_clean)
which(is.na(alc_outlets_clean$Longitude)) # observation 7444 is missing longitude
alc_outlets_clean <- alc_outlets_clean[-7444, ]

# Convert to spatial data
alc_outlets.sf <- st_as_sf(alc_outlets_clean, 
                           coords = c("Longitude", "Latitude"),
                           crs = 4326) 

# Test plot
plot(st_geometry(alc_outlets.sf))

#########
# Step 2) Prepare data: Calculate total outlets per geography, prepare total land area variables, prepare total population variables
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

# Prepare population data 
state_pop <- read.csv("data_final/DS01_2018_S.csv")
head(state_pop)

stateF <- function(z)formatC(z, width = 2, format = "d", flag = "0")
# create character variables with zeroes
state_chr <- data.frame(stateF(state_pop$GEOID))
# rename variable
colnames(state_chr) <- "GEOID2"
#add back
state_pop <- cbind(state_pop, state_chr)
head(state_pop)

state_pop <- state_pop %>% select(GEOID2, totPopE)

# Merge population data
states_merge <- merge(states_merge, state_pop, by.x = "GEOID", by.y = "GEOID2")

##### COUNTY #####

# Read in geometry
counties_geom <- st_read("data_final/geometryFiles/tl_2018_county/counties2018.shp")

# Select relevant variables
counties <- counties_geom %>%
  select(STATEFP, COUNTYFP, NAME, ALAND)

counties <- counties %>% transform(FIPS.Code = paste0(STATEFP, COUNTYFP))
head(counties)
str(counties)

# Divide land area (sq meters) by 2,590,000 to get sq miles
counties$areaSqMi <- counties$ALAND/2590000

# Mutate county code 
#countycode <- function(z)formatC(z, width = 3, format = "d", flag = "0")
#countycode_chr <- data.frame(countycode(alc_outlets_clean$County.Code))
# rename variable
#colnames(countycode_chr) <- "CountyCode_chr"
# add to dataset
#alc_outlets_clean <- cbind(alc_outlets_clean, countycode_chr)

alc_outlets_clean$FIPS.Code <- as.numeric(alc_outlets_clean$FIPS.Code)

fips <- function(z)formatC(z, width = 5, format = "d", flag = "0")

fipschr <- data.frame(fips(alc_outlets_clean$FIPS.Code))
# rename variable
colnames(fipschr) <- "FIPS.Code_chr"
# add to dataset
alc_outlets_clean <- cbind(alc_outlets_clean, fipschr)

# Count number of outlets by county, remove territories

counties_count <- data.frame(alc_outlets_clean %>%
                               filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
                                group_by(FIPS.Code_chr) %>%
                                count())
                                
# Merge total number outlets to counties

counties_merge_count <- merge(counties, counties_count, by.x = "FIPS.Code", by.y = "FIPS.Code_chr", all=TRUE)

head(counties_merge)
counties_merge[is.na(counties_merge)] <- 0

# Prepare population data
county_pop <- read.csv("data_final/DS01_2018_C.csv")

countyfips <- data.frame(fips(county_pop$GEOID))
head(countyfips)
colnames(countyfips) <- "FIPS.Code_chr"
county_pop <- cbind(county_pop, countyfips)

county_pop <- county_pop %>% select(FIPS.Code_chr, totPopE)

# Merge population data
counties_merge <- merge(counties_merge_count, county_pop, by.x = "FIPS.Code", by.y = "FIPS.Code_chr", all = TRUE)
head(counties_merge)

##### TRACT #####

# Read in geometry
tracts_geom <- st_read("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")
str(tracts_geom)

# Select relevant variables
tracts <- tracts_geom %>%
  select(STATEFP, COUNTYFP, TRACTCE, NAME, ALAND)
tracts <- tracts %>% transform(FIPS.Code = paste0(STATEFP, COUNTYFP, TRACTCE))
head(tracts)

# Divide land area (sq meters) by 2,590,000 to get sq miles
tracts$areaSqMi <- tracts$ALAND/2590000

# Mutate census code
censuscode <- function(z)formatC(z, width = 6, format = "d", flag = "0")
censuscode_chr <- data.frame(censuscode(alc_outlets_clean$Census.Tract))
# rename variable
colnames(censuscode_chr) <- "Census.Tract_chr"
# add to dataset
alc_outlets_clean <- cbind(alc_outlets_clean, censuscode_chr)

alc_outlets_clean <- alc_outlets_clean %>% transform(T.FIPS.Code = paste0(FIPS.Code_chr, Census.Tract_chr))

# Count number of outlets by tract, remove territories
tract_count <- data.frame(alc_outlets_clean %>%
                             filter(!State %in% c("FM", "GU", "MP", "PR", "VI")) %>%
                             group_by(T.FIPS.Code) %>%
                             count())

# Merge total number of outlets to tract area
tract_merge_count <- merge(tracts, tract_count, by.x = "FIPS.Code", by.y = "T.FIPS.Code", all.x = TRUE)

#tract_merge_count <- tract_merge_count %>% st_drop_geometry()
tract_merge_count[is.na(tract_merge_count)] <- 0
head(tract_merge_count)

# Prepare population data 
tract_pop <- read.csv("data_final/DS01_2018_T.csv")
head(tract_pop)

#function to extract the last 6 characters
# substrRight <- function(x, n){
#   substr(x, nchar(x)-n+1, nchar(x))
# }
# tract_pop$tractGEO <- substrRight(tract_pop$GEOIDchr, 6)

tract_pop <- tract_pop %>% select(GEOID, totPopE)
head(tract_pop)

tract_pop$GEOID <- as.numeric(tract_pop$GEOID)

tract_pop <- tract_pop %>% mutate(GEOID = str_pad(string = GEOID, width = 11, side = "left", pad = 0))

#mutate(ID = str_pad(string = ID, width = 4, side = 'left', pad = 0))
#data2 <- data %>%  mutate(ID = ifelse(row_number()<= 95, paste0("0", ID), ID)) 
#data %>% mutate(ID = sprintf("%03d", ID))

# function for tract pop
#tractpop <- function(z)formatC(z, width = 11, format = "d", flag = "0") 
#tract_pop2 <- data.frame(tractpop(tract_pop$GEOID))


# Mutate census code
censuscode <- function(z)formatC(z, width = 6, format = "d", flag = "0")
censuscode_chr <- data.frame(censuscode(alc_outlets_clean$Census.Tract))
# rename variable
colnames(censuscode_chr) <- "Census.Tract_chr"
# add to dataset
alc_outlets_clean <- cbind(alc_outlets_clean, censuscode_chr)

# Merge population data
tract_merge <- merge(tract_merge_count, tract_pop, by.x = "FIPS.Code", by.y = "GEOID", all = TRUE)
tract_merge_nogeom <- tract_merge %>%st_drop_geometry()
#tract_merge2 <- merge(tract_pop, tract_count, by.x = "GEOID", by.y = "T.FIPS.Code", all.x = TRUE)
#tract_merge2[is.na(tract_merge2)] <- 0


#tract_merge <- merge(tracts, tract_merge2, by.x = "FIPS.Code", by.y = "GEOID", all.x = TRUE)

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

# Prepare zip code population data
zip_pop <- read.csv("data_final/DS01_2018_Z.csv")
head(zip_pop)

zip <- function(z)formatC(z, width = 5, format = "d", flag = "0")
# create character variables with zeroes
zipcode_chr <- data.frame(zip(zip_pop$GEOID))
# rename variable
colnames(zipcode_chr) <- "zipcode"
#add back
zip_pop <- cbind(zip_pop, zipcode_chr)

# get total population
zip_pop <- zip_pop %>% select(zipcode, totPopE)
head(zip_pop)

# merge pop data with count dat
zcta_merge <- merge(zcta_merge, zip_pop, by.x = "ZipCode_chr", by.y = "zipcode", all.x = TRUE)

###########
# Part 3) Calculate outlet density per land area and per capita, for each geography
###########

##### STATE #####
states_dens <- states_merge %>%
  select(GEOID, State = STATE, areaSqMi, totPopE, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi, alcPerCap = alcTotal / totPopE)
head(states_dens)

# state_map <- 
#   tm_shape(states_dens) +
#   tm_borders() +
#   tm_fill(col = "alcDens", alpha = 0.7, style = "quantile")
# state_map

##### COUNTY #####
counties_dens <- counties_merge %>%
  select(GEOID = FIPS.Code, STATEFP, COUNTYFP, NAME, areaSqMi, totPopE, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi, alcPerCap = alcTotal / totPopE)
head(counties_dens)
# plot to check
# tmap_mode("view")
# county_map <- 
#   tm_shape(counties_dens) +
#   tm_borders() +
#   tm_fill(col = "alcDens", alpha = 0.7, style = "quantile", id = "NAME")
# county_map  

##### TRACT #####
tract_dens <- tract_merge %>%
  select(GEOID = FIPS.Code, STATEFP, COUNTYFP, TRACTCE, areaSqMi, totPopE, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi, alcPerCap = alcTotal / totPopE)

tract_dens_nogm <- tract_dens %>% st_drop_geometry()

# plot to check
# tract_map <- 
#   tm_shape(tract_dens) +
#   tm_borders() +
#   tm_fill(col = "alcDens", alpha = 0.7, style = "quantile")
# tract_map

##### ZIP #####
zcta_dens <- zcta_merge %>%
  select(GEOID = ZipCode_chr, ZIPCODE = ZipCode_chr, areaSqMi, totPopE, alcTotal = n) %>%
  mutate(alcDens = alcTotal / areaSqMi, alcPerCap = alcTotal / totPopE)

# Part 4) Save final datasets

st_write(states_dens, "data_final/HS03_S.csv")
st_write(counties_dens, "data_final/HS03_C.csv")
st_write(tract_dens, "data_final/HS03_T.csv")
st_write(zcta_dens, "data_final/HS03_Z.csv")


######## FIN #########

