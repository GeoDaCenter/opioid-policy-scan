# # Author : Ally Muszynski
# Date : September 1, 2021
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
HomelessState <- read.csv("/Desktop/nhgis0034_csv/nhgis0034_ds239_20185_2018_state.csv")
HomelessCounty <- read.csv("/Desktop/nhgis0035_csv/nhgis0035_ds239_20185_2018_county.csv")
HomelessTract <- read.csv("/Desktop/nhgis0036_csv/nhgis0036_ds239_20185_2018_tract.csv")
HomelessZCTA <- read.csv("/Desktop/nhgis0037_csv/nhgis0037_ds239_20185_2018_zcta.csv")

#select relevant variables 
Homeless_T <- HomelessTract %>%
  dplyr::select(GISJOIN, YEAR, TRACTA, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  ) 
Homeless_C <- HomelessCounty %>%
  dplyr::select(GISJOIN, YEAR, COUNTY, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  )
Homeless_S <- HomelessState %>%
  dplyr::select(GISJOIN, YEAR, STATE, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  )
Homeless_Z <- HomelessZCTA %>%
  dplyr::select(GISJOIN, YEAR, ZCTA5A, AJXHE001, AJXHE023, AJXHE037,  AJXHE038
  )             


#rename columns
colnames(Homeless_T) <- c("GEOID", "YEAR", "TRACTCE", "TotalPop", "NonrelatedHousehold", "NonrelatedGroupDwelling", "GroupQuarters")
colnames(Homeless_C) <- c("GISJOIN", "YEAR", "COUNTYFP", "TotalPop", "NonrelatedHousehold", "NonrelatedGroupDwelling", "GroupQuarters")
colnames(Homeless_S) <- c("GISJOIN", "YEAR", "STATEFP", "TotalPop","NonrelatedHousehold", "NonrelatedGroupDwelling", "GroupQuarters")
colnames(Homeless_Z) <- c("GISJOIN", "YEAR", "ZCTA", "TotalPop", "NonrelatedHousehold", "NonrelatedGroupDwelling", "GroupQuarters")

#find percent homeless population in group quarter compared to total population
Homeless_T <- Homeless_T %>% 
  mutate(GroupQuarterPercent = GroupQuarters/TotalPop*100)
Homeless_C <- Homeless_C %>% 
 mutate(GroupQuarterPercent = GroupQuarters/TotalPop*100)
Homeless_S <- Homeless_S %>% 
  mutate(GroupQuarterPercent = GroupQuarters/TotalPop*100)
Homeless_Z <- Homeless_Z %>% 
  mutate(GroupQuarterPercent = GroupQuarters/TotalPop*100)

#find percent homeless population in one household compared to total population
Homeless_T <- Homeless_T %>% 
  mutate(NonrelatedHousePercent = NonrelatedHousehold/TotalPop*100)
Homeless_C <- Homeless_C %>% 
  mutate(NonrelatedHousePercent = NonrelatedHousehold/TotalPop*100)
Homeless_S <- Homeless_S %>% 
  mutate(NonrelatedHousePercent = NonrelatedHousehold/TotalPop*100)
Homeless_Z <- Homeless_Z %>% 
  mutate(NonrelatedHousePercent = NonrelatedHousehold/TotalPop*100)


#save datasets
write.csv(Homeless_T, "/Desktop/MAARC/Homeless/DS05_T.csv")
write.csv(Homeless_C, "/Desktop/MAARC/Homeless/DS05_C.csv")
write.csv(Homeless_S, "/Desktop/MAARC/Homeless/DS05_S.csv")
write.csv(Homeless_Z, "/Desktop/MAARC/Homeless/DS05_Z.csv")

#Read in homeless census 
HomelessCensusTract <- read.csv("/Desktop/TractHomeless.csv")
HomelessCensusCounty <- read.csv("/Desktop/CountyHomeless.csv")
HomelessCensusState <- read.csv("/Desktop/StateHomeless.csv")
HomelessCensusZCTA <- read.csv("/Desktop/ZCTAHomeless.csv")

#select relevant variables 
HomelessCensusTract <- HomelessCensusTract %>%
  dplyr::select(GISJOIN, NAME, totbed, pitct, yrbed) 
HomelessCensusCounty <- HomelessCensusCounty %>%
  dplyr::select(COUNTYFP, GEOID, totbed, pitct, yrbed) 
HomelessCensusState <- HomelessCensusState %>%
  dplyr::select(STATEFP, GEOID, totbed, pitct, yrbed)
HomelessCensusZCTA<- HomelessCensusZCTA %>%
  dplyr::select(ZCTA5CE10, GEOID10, totbed, pitct, yrbed)

#rename columns
colnames(HomelessCensusTract) <- c("GEOID", "TRACTCE", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")
colnames(HomelessCensusCounty) <- c("COUNTYFP", "GEOID", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")
colnames(HomelessCensusState) <- c("GEOID", "STATEFP", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")
colnames(HomelessCensusZCTA) <- c("ZCTA", "GEOID", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")

#save datasets
write.csv(HomelessCensusTract, "/Desktop/MAARC/Homeless/DS06_T.csv")
write.csv(HomelessCensusCounty, "/Desktop/MAARC/Homeless/DS06_C.csv")
write.csv(HomelessCensusState, "/Desktop/MAARC/Homeless/DS06_S.csv")
write.csv(HomelessCensusZCTA, "/Desktop/MAARC/Homeless/DS06_Z.csv")
