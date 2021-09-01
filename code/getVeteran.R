# # Author : Ally Muszynski
# Date : September 1, 2021
# About: This piece of code will generate Veteran Status variable for EC tables for Policy Scan

#working directory
library(tidyverse)
library(sf)
library(dplyr)
library(raster)

#read in raw data
VetStatZCTA <- read.csv("/Desktop/nhgis0025_csv/nhgis0025_ds239_20185_2018_zcta.csv")
VetStatTract <- read.csv("/Desktop/nhgis0032_csv/nhgis0032_ds239_20185_2018_tract.csv")
VetStatCounty <- read.csv("/Desktop/nhgis0033_csv/nhgis0033_ds239_20185_2018_county.csv")
VetStatState <- read.csv("/Desktop/nhgis0031_csv/nhgis0031_ds239_20185_2018_state.csv")

#select relevant variables 
Vet_Z <- VetStatZCTA %>%
  dplyr::select(GISJOIN, YEAR, ZCTA5A, AJ02E001, AJ02E002, AJ02E004, AJ02E005, AJ02E007, AJ02E008, AJ02E010, AJ02E011, AJ02E013, AJ02E014, AJ02E016, AJ02E017, AJ02E019, AJ02E020, AJ02E022, AJ02E023, AJ02E025, AJ02E026, AJ02E028, AJ02E029, AJ02E031, AJ02E032, AJ02E034, AJ02E035, AJ02E037, AJ02E038  
  )
Vet_T <- VetStatTract %>%
  dplyr::select(GISJOIN, YEAR, TRACTA, AJ02E001, AJ02E002, AJ02E004, AJ02E005, AJ02E007, AJ02E008, AJ02E010, AJ02E011, AJ02E013, AJ02E014, AJ02E016, AJ02E017, AJ02E019, AJ02E020, AJ02E022, AJ02E023, AJ02E025, AJ02E026, AJ02E028, AJ02E029, AJ02E031, AJ02E032, AJ02E034, AJ02E035, AJ02E037, AJ02E038 
  )
Vet_C <- VetStatCounty %>%
  dplyr::select(GISJOIN, YEAR, COUNTY, AJ02E001, AJ02E002, AJ02E004, AJ02E005, AJ02E007, AJ02E008, AJ02E010, AJ02E011, AJ02E013, AJ02E014, AJ02E016, AJ02E017, AJ02E019, AJ02E020, AJ02E022, AJ02E023, AJ02E025, AJ02E026, AJ02E028, AJ02E029, AJ02E031, AJ02E032, AJ02E034, AJ02E035, AJ02E037, AJ02E038 
  )
Vet_S <- VetStatState %>%
  dplyr::select(GISJOIN, YEAR, STATE, AJ02E001, AJ02E002, AJ02E004, AJ02E005, AJ02E007, AJ02E008, AJ02E010, AJ02E011, AJ02E013, AJ02E014, AJ02E016, AJ02E017, AJ02E019, AJ02E020, AJ02E022, AJ02E023, AJ02E025, AJ02E026, AJ02E028, AJ02E029, AJ02E031, AJ02E032, AJ02E034, AJ02E035, AJ02E037, AJ02E038 
  )


#rename columns
colnames(Vet_T) <- c("GEOID", "YEAR", "TRACTCE", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")
colnames(Vet_Z) <- c("GEOID", "YEAR", "ZCTA", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")
colnames(Vet_C) <- c("GEOID", "YEAR", "COUNTYFP", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")
colnames(Vet_S) <- c("GEOID", "YEAR", "STATEFP", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")

#find percent veteran population
Vet_T <- Vet_T %>% 
  dplyr::mutate(PctVet = TotalVetPop/TotalPop*100)
Vet_Z <- Vet_Z %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)
Vet_C <- Vet_C %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)
Vet_S <- Vet_S %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)

#save dataset
write.csv(Vet_T, "/MAARC/Vet/DS04_T.csv")
write.csv(Vet_Z, "/MAARC/Vet/DS04_Z.csv")
write.csv(Vet_C, "/MAARC/Vet/DS04_C.csv")
write.csv(Vet_S, "/MAARC/Vet/DS04_S.csv")

