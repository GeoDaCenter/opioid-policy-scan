# # Author : Ju He
# Date : August 3, 2023
# About: This piece of code will generate Veteran Status variable on county level for Policy Scan

#working directory
library(tidyverse)
library(sf)
library(dplyr)
library(raster)
library(stringr)

#read in raw data
VetStatCounty <- read.csv("the path to local veteran data")

# Method1
VetStatCounty <- VetStatCounty %>%
  mutate(geoid_number = paste(substring( GISJOIN,2, 3), substring(GISJOIN, 5, 7)))

# Method2
VetStatCounty <- VetStatCounty %>%
  mutate(geoid_number = as.character(as.integer(STATEA)*1000 + as.integer(COUNTYA)),
         geoid_number = ifelse(nchar(geoid_number)<5,paste0('0', geoid_number),geoid_number))

Vet_C <- VetStatCounty %>%
  dplyr::select(geoid_number, YEAR, COUNTY, AJ02E001, AJ02E002, AJ02E004, AJ02E005, AJ02E007, AJ02E008, AJ02E010, AJ02E011, AJ02E013, AJ02E014, AJ02E016, AJ02E017, AJ02E019, AJ02E020, AJ02E022, AJ02E023, AJ02E025, AJ02E026, AJ02E028, AJ02E029, AJ02E031, AJ02E032, AJ02E034, AJ02E035, AJ02E037, AJ02E038 
  )

#rename columns
colnames(Vet_C) <- c("COUNTYFP", "YEAR", "COUNTYNAME", "TotalPop", "TotalVetPop", "MalePop", "MaleVetPop", "Male18To34", "MaleVet18To34", "Male35To54", "MaleVet35To54", "Male55To64", "MaleVet55To64", "Male65To74", "MaleVet65To74", "Male75Plus", "MaleVet75Plus", "FemalePop", "FemaleVetPop", "Female18To34", "FemaleVet18To34", "Female35To54", "FemaleVet35To54", "Female55To64", "FemaleVet55To64", "Female65To74", "FemaleVet65To74", "Female75Plus", "FemaleVet75Plus")

Vet_C <- Vet_C %>% 
  dplyr::mutate(VetPercent = TotalVetPop/TotalPop*100)

#save dataset
write.csv(Vet_C, "the path you want to save the table")






