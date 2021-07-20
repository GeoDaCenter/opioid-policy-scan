# # Author : Ally Muszynski
# Date : June 24, 2021
# About: This piece of code will generate Veteran Status variable for EC tables for Policy Scan

#working directory
library(tidyverse)
library(sf)
library(dplyr)
library(raster)

#read in raw data
VetStatTract <- read.csv("getVeteran/nhgis0007_ds233_20175_2017_tract.csv",)
VetStatZip <- read.csv("getVeteran/nhgis0007_ds233_20175_2017_zcta.csv")

#select relevant variables 
VetTract <- VetStatTract %>%
  dplyr::select(GISJOIN, YEAR, STATE, COUNTY, TRACTA, AH3FE001, AH3FE002, AH3FE004, AH3FE005, AH3FE007, AH3FE008, AH3FE010, AH3FE011, AH3FE013, AH3FE014, AH3FE016, AH3FE017, AH3FE019, AH3FE020, AH3FE022, AH3FE023, AH3FE025, AH3FE026, AH3FE028, AH3FE029, AH3FE031, AH3FE032, AH3FE034, AH3FE035, AH3FE037, AH3FE038  
  ) %>% 
  filter(YEAR=="2013-2017")

VetZip<- VetStatZip %>%
  dplyr::select(GISJOIN, YEAR, ZCTA5A, AH3FE001, AH3FE002, AH3FE004, AH3FE005, AH3FE007, AH3FE008, AH3FE010, AH3FE011, AH3FE013, AH3FE014, AH3FE016, AH3FE017, AH3FE019, AH3FE020, AH3FE022, AH3FE023, AH3FE025, AH3FE026, AH3FE028, AH3FE029, AH3FE031, AH3FE032, AH3FE034, AH3FE035, AH3FE037, AH3FE038  
  ) %>%             
  filter(YEAR=="2013-2017")

#seperante county, state from tract data
VetTract <- VetStatTract %>%
  dplyr::select(GISJOIN, YEAR, TRACTA, AH3FE001, AH3FE002, AH3FE004, AH3FE005, AH3FE007, AH3FE008, AH3FE010, AH3FE011, AH3FE013, AH3FE014, AH3FE016, AH3FE017, AH3FE019, AH3FE020, AH3FE022, AH3FE023, AH3FE025, AH3FE026, AH3FE028, AH3FE029, AH3FE031, AH3FE032, AH3FE034, AH3FE035, AH3FE037, AH3FE038  
  ) %>% 
  filter(YEAR=="2013-2017")
VetCounty <- VetStatTract %>%
  dplyr::select(GISJOIN, YEAR, COUNTY, AH3FE001, AH3FE002, AH3FE004, AH3FE005, AH3FE007, AH3FE008, AH3FE010, AH3FE011, AH3FE013, AH3FE014, AH3FE016, AH3FE017, AH3FE019, AH3FE020, AH3FE022, AH3FE023, AH3FE025, AH3FE026, AH3FE028, AH3FE029, AH3FE031, AH3FE032, AH3FE034, AH3FE035, AH3FE037, AH3FE038  
  ) %>% 
  filter(YEAR=="2013-2017")
VetState <- VetStatTract %>%
  dplyr::select(GISJOIN, YEAR, STATE, AH3FE001, AH3FE002, AH3FE004, AH3FE005, AH3FE007, AH3FE008, AH3FE010, AH3FE011, AH3FE013, AH3FE014, AH3FE016, AH3FE017, AH3FE019, AH3FE020, AH3FE022, AH3FE023, AH3FE025, AH3FE026, AH3FE028, AH3FE029, AH3FE031, AH3FE032, AH3FE034, AH3FE035, AH3FE037, AH3FE038  
  ) %>% 
  filter(YEAR=="2013-2017")

#rename columns
colnames(VetTract) <- c("GISJOIN", "YEAR", "TRACT", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")
colnames(VetZip) <- c("GISJOIN", "YEAR", "ZCTA", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")
colnames(VetCounty) <- c("GISJOIN", "YEAR", "COUNTY", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")
colnames(VetState) <- c("GISJOIN", "YEAR", "STATE", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")

#find percent veteran population
VetTract <- VetTract %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)
VetZip <- VetZip %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)
VetCounty <- VetCounty %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)
VetState <- VetState %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)

#save dataset
write.csv(VetTract, "/MAARC/DS04_2017_T.csv")
write.csv(VetZip, "/MAARC/DS04_2017_Z.csv")
write.csv(VetCounty, "/MAARC/DS04_2017_C.csv")
write.csv(VetState, "/MAARC/DS04_2017_S.csv")
