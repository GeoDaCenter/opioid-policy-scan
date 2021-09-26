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

#Read in homeless census 
HomelessCensusTract <- read.csv("/Homeless/HomelessTract.csv")
HomelessCensusCounty <- read.csv("/Homeless/HomelessCounty.csv")
HomelessCensusState <- read.csv("/Homeless/HomelessState.csv")
HomelessCensusZCTA <- read.csv("/Homeless/HomelessZCTA.csv")

#select relevant variables 
HomelessCensusTract <- HomelessCensusTract %>%
  dplyr::select(TRACTCE, GEOID, TotBed, PITCt, YrBed) 
HomelessCensusCounty <- HomelessCensusCounty %>%
  dplyr::select(COUNTYFP, GEOID, TotBed, PITCt, YrCt) 
HomelessCensusState <- HomelessCensusState %>%
  dplyr::select(STATEFP, GEOID, NAME, TotBed, PITCt, YrBed) 
HomelessCensusZCTA<- HomelessCensusZCTA %>%
  dplyr::select(ZCTA5CE10, GEOID10, TotBed, PITCt, YrBed)

#rename columns
colnames(HomelessCensusTract) <- c("TRACTCE", "GEOID", "BedCt", "PITCt", "YrBed")
colnames(HomelessCensusCounty) <- c("COUNTYFP", "GEOID", "BedCt", "PITCt", "YrBed")
colnames(HomelessCensusState) <- c( "STATEFP", "GEOID", "BedCt", "PITCt", "YrBed")
colnames(HomelessCensusZCTA) <- c("ZCTA", "GEOID", "BedCt", "PITCt", "YrBed")

#replace zeros with NA values
HomelessCensusTract[HomelessCensusTract == 0] <- NA
HomelessCensusCounty[HomelessCensusCounty == 0] <- NA
HomelessCensusState[HomelessCensusState == 0] <- NA
HomelessCensusZCTA[HomelessCensusZCTA == 0] <- NA

#save datasets
write.csv(HomelessCensusTract, "/Homeless/DS06_T.csv")
write.csv(HomelessCensusCounty, "/Homeless/DS06_C.csv")
write.csv(HomelessCensusState, "/Homeless/DS06_S.csv")
write.csv(HomelessCensusZCTA, "/Homeless/DS06_Z.csv")
