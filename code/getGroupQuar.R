# # Author : Ally Muszynski
# Date : September 24, 2021
# About: This piece of code will generate Homeless Status variable for EC tables for Policy Scan

#working directory
library(tidyverse)
library(sf)
library(dplyr)
library(raster)
library(rgeos)
library(rgeos)
library(rgdal)

#read in raw data GroupQuarterVar from IPUMS
GroupQuarterState <- read.csv("/Homeless/nhgis0034_csv/nhgis0034_ds239_20185_2018_state.csv")
GroupQuarterCounty <- read.csv("/Homeless/nhgis0035_csv/nhgis0035_ds239_20185_2018_county.csv")
GroupQuarterTract <- read.csv("/Homeless/nhgis0036_csv/nhgis0036_ds239_20185_2018_tract.csv")
GroupQuarterZCTA <- read.csv("/Homeless/nhgis0037_csv/nhgis0037_ds239_20185_2018_zcta.csv")

#select relevant variables 
GroupQuarterTract <- GroupQuarterTract %>%
  dplyr::select(GISJOIN, YEAR, TRACTA, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  ) 
GroupQuarterCounty <- GroupQuarterCounty %>%
  dplyr::select(GISJOIN, YEAR, COUNTY, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  )
GroupQuarterState <- GroupQuarterState %>%
  dplyr::select(GISJOIN, YEAR, STATE, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  )
GroupQuarterZCTA <- GroupQuarterZCTA %>%
  dplyr::select(GISJOIN, YEAR, ZCTA5A, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  )             

#rename columns
colnames(GroupQuarterTract) <- c("GEOID", "YEAR", "TRACTCE", "TotalPop", "UnrelHouse", "GroupDwell", "GroupQuar")
colnames(GroupQuarterCounty) <- c("GEOID", "YEAR", "COUNTYFP", "TotalPop", "UnrelHouse", "GroupDwell", "GroupQuar")
colnames(GroupQuarterState) <- c("GEOID", "YEAR", "STATEFP", "TotalPop","UnrelHouse", "GroupDwell", "GroupQuar")
colnames(GroupQuarterZCTA) <- c("GEOID", "YEAR", "ZCTA", "TotalPop", "UnrelHouse", "GroupDwell", "GroupQuar")

#find rate of homelessness
GroupQuarterTract <- GroupQuarterTract %>% 
  dplyr::mutate(GrpQuarPct = GroupQuar/TotalPop*100)
GroupQuarterCounty <- GroupQuarterCounty %>% 
  dplyr::mutate(GrpQuarPct = GroupQuar/TotalPop*100)
GroupQuarterState <- GroupQuarterState %>% 
  dplyr::mutate(GrpQuarPct = GroupQuar/TotalPop*100)
GroupQuarterZCTA <- GroupQuarterZCTA %>% 
  dplyr::mutate(GrpQuarPct = GroupQuar/TotalPop*100)

#find percent homeless population in one household compared to total population
GroupQuarterTract <- GroupQuarterTract %>% 
  dplyr::mutate(UnrelPct = UnrelHouse/TotalPop*100)
GroupQuarterCounty <- GroupQuarterCounty %>% 
  dplyr::mutate(UnrelPct = UnrelHouse/TotalPop*100)
GroupQuarterState <- GroupQuarterState %>% 
  dplyr::mutate(UnrelPct = UnrelHouse/TotalPop*100)
GroupQuarterZCTA <- GroupQuarterZCTA %>% 
  dplyr::mutate(UnrelPct = UnrelHouse/TotalPop*100)

#Remove extra characters from GEOID
GroupQuarterTract = GroupQuarterTract %>% mutate(GEOID = sub(".", "", GEOID))
GroupQuarterCounty = GroupQuarterCounty %>% mutate(GEOID = sub(".", "", GEOID))
GroupQuarterState = GroupQuarterState %>% mutate(GEOID = sub(".", "", GEOID))
GroupQuarterZCTA = GroupQuarterZCTA %>% mutate(GEOID = sub(".", "", GEOID))

#save datasets
write.csv(GroupQuarterTract, "/Homeless/DS05_T.csv")
write.csv(GroupQuarterCounty, "/Homeless/DS05_C.csv")
write.csv(GroupQuarterState, "/Homeless/DS05_S.csv")
write.csv(GroupQuarterZCTA, "/Homeless/DS05_Z.csv")
