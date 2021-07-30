# # Author : Ally Muszynski
# Date : June 24, 2021
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
HomelessStatTract <- read.csv("/MAARC/nhgis0008_csv/nhgis0008_ds244_20195_2019_tract.csv")
HomelessStatZip <- read.csv("/MAARC/nhgis0008_csv/nhgis0008_ds244_20195_2019_zcta.csv")

#select relevant variables 
HomelessTract <- HomelessStatTract %>%
  dplyr::select(GISJOIN, YEAR, TRACTA, ALU6E001, ALU6E025, ALU6E026
) %>% 
  filter(YEAR=="2015-2019")
HomelessCounty <- HomelessStatTract %>%
  dplyr::select(GISJOIN, YEAR, COUNTY, ALU6E001, ALU6E025, ALU6E026
  ) %>% 
  filter(YEAR=="2015-2019")
HomelessState <- HomelessStatTract %>%
  dplyr::select(GISJOIN, YEAR, STATE, ALU6E001, ALU6E025, ALU6E026
  ) %>% 
  filter(YEAR=="2015-2019")
HomelessZip<- HomelessStatZip %>%
  dplyr::select(GISJOIN, YEAR, ZCTA5A, ALU6E001, ALU6E025, ALU6E026
  ) %>%             
  filter(YEAR=="2015-2019")

#rename columns
colnames(HomelessTract) <- c("GISJOIN", "YEAR", "TRACT", "TotalPop", "Non-relatedGroupDwelling", "GroupQuarters")
colnames(HomelessCounty) <- c("GISJOIN", "YEAR", "COUNTY", "TotalPop", "Non-relatedGroupDwelling", "GroupQuarters")
colnames(HomelessState) <- c("GISJOIN", "YEAR", "STATE", "TotalPop", "Non-relatedGroupDwelling", "GroupQuarters")
colnames(HomelessZip) <- c("GISJOIN", "YEAR", "ZCTA", "TotalPop", "Non-relatedGroupDwelling", "GroupQuarters")

#find percent homeless population
GroupQuarterTract <- HomelessTract %>% mutate(HomelessPercent = GroupQuarters/TotalPop*100)
GroupQuarterCounty <- HomelessCounty %>% mutate(HomelessPercent = GroupQuarters/TotalPop*100)
GroupQuarterState <- HomelessState %>% mutate(HomelessPercent = GroupQuarters/TotalPop*100)
GroupQuarterZCTA <- HomelessZip %>% mutate(HomelessPercent = GroupQuarters/TotalPop*100)

#save datasets
write.csv(GroupQuarterTract, "/MAARC/getHomelessTract.csv")
write.csv(GroupQuarterCounty, "//MAARC/getHomelessCounty.csv")
write.csv(GroupQuarterState, "/MAARC/getHomelessState.csv")
write.csv(GroupQuarterZCTA, "/MAARC/getHomelessZCTA.csv")

#Read in homeless census 
HomelessCensusTract <- read.csv("/MAARC/Homeless/Homeless/TractHomeless.csv")
HomelessCensusCounty <- read.csv("/MAARC/Homeless/Homeless/CountyHomeless.csv")
HomelessCensusState <- read.csv("/MAARC/Homeless/Homeless/StateHomeless.csv")
HomelessCensusZCTA <- read.csv("/MAARC/Homeless/Homeless/ZCTAHomeless.csv")

#select relevant variables 
HomelessCensus.Tract <- HomelessCensusTract %>%
  dplyr::select(GISJOIN, NAME, totbed, pitct, yrbed) 
HomelessCensus.County <- HomelessCensusCounty %>%
  dplyr::select(COUNTYFP, GEOID, totbed, pitct, yrbed) 
HomelessCensus.State <- HomelessCensusState %>%
  dplyr::select(STATEFP, GEOID, totbed, pitct, yrbed)
HomelessCensus.ZCTA<- HomelessCensusZCTA %>%
  dplyr::select(ZCTA5CE10, GEOID10, totbed, pitct, yrbed)

#rename columns
colnames(HomelessCensus.Tract) <- c("GEOID", "TRACT", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")
colnames(HomelessCensus.County) <- c("COUNTY", "GEOID", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")
colnames(HomelessCensus.State) <- c("GEOID", "STATE", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")
colnames(HomelessCensus.ZCTA) <- c("ZCTA", "GEOID", "BED_COUNT", "POINT_IN_TIME", "YEARLY_BED_COUNT")

#save datasets
write.csv(GHomelessCensus.Tract, "/MAARC/getHomelessCensusTract.csv")
write.csv(HomelessCensus.County, "/MAARC/getHomelessCensusCounty.csv")
write.csv(HomelessCensus.State, "/MAARC/getHomelessCensusState.csv")
write.csv(HomelessCensus.ZCTA, "/MAARC/getHomelessCensusZCTA.csv")
