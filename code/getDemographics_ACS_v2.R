# Author : Moksha Menghaney, updated by Susan Paykin
# Date : August 17, 2020
# Last modified : March 30, 2021
# This piece of code will generate DS01 tables for Policy Scan.

library(tidycensus)
library(tidyverse)
library(tmap)
library(geojsonio)
library(tigris)

# Set working directory
setwd("~/git/opioid-policy-scan")

#census_api_key("key", install = TRUE)

## identify variables from B02001: RACE table
#  1. Total Population  B02001_001 Estimate!!Total	
#  2. Race : White      B02001_002 Estimate!!Total!!White alone	
#  3. Race : Black      B02001_003 Estimate!!Total!!Black or African American alone	
#  4. Race : AmInd      B02001_004 Estimate!!Total!!American Indian and Alaska Native alone	
#  5. Race : Asian      B02001_005 Estimate!!Total!!Asian alone	
#  6. Race : PacificIs  B02001_006 Estimate!!Total!!Native Hawaiian and Other Pacific Islander alone	

## identify variables from B03002: HISPANIC OR LATINO ORIGIN BY RACE
#  1. Ethi : Hispanic   B03003_003 Estimate!!Total!!Hispanic or Latino	B03003_001 total pop

## identify variables from S0101 : AGE & SEX
#  1. Age  : <5         S0101_C01_002 Estimate!!Total!!Total population!!AGE!!Under 5 years	
#  2. Age  : Age 5-14   S0101_C01_020 Estimate!!Total!!Total population!!SELECTED AGE CATEGORIES!!5 to 14 years	
#  3. Age  : Age 15-19  S0101_C01_005 Estimate!!Total!!Total population!!AGE!!15 to 19 years
#  4. Age  : Age 20-24  S0101_C01_006	Estimate!!Total!!Total population!!AGE!!20 to 24 years
#  5. Age  : Age 15-44  S0101_C01_024 Estimate!!Total!!Total population!!SELECTED AGE CATEGORIES!!15 to 44 years
#  6. Age  : Age 45-49  S0101_C01_011	Estimate!!Total!!Total population!!AGE!!45 to 49 years
#  7. Age  : Age 50-54  S0101_C01_012	Estimate!!Total!!Total population!!AGE!!50 to 54 years
#  8. Age  : Age 55-59  S0101_C01_013	Estimate!!Total!!Total population!!AGE!!55 to 59 years
#  9. Age  : Age 60-64  S0101_C01_014	Estimate!!Total!!Total population!!AGE!!60 to 64 years
#  10. Age  : Age >=65  S0101_C01_030 Estimate!!Total!!Total population!!SELECTED AGE CATEGORIES!!65 years and over	
#  11. Age  : Age >=18  S0101_C02_026	Estimate!!Percent!!Total population!!SELECTED AGE CATEGORIES!!18 years and over

## identify variables from B06009: PLACE OF BIRTH BY EDUCATIONAL ATTAINMENT IN THE UNITED STATES
#  1. Pop : PopOver25   B06009_001 Estimate!!Total	Pop over 25
#  2. Edy : <HS         B06009_002 Estimate!!Total!!Less than high school graduate	Univ Pop over 25

## identify variables from DP02 table
#  1.Dis   : Disab      DP02_0071P Percent Estimate!!DISABILITY STATUS OF THE CIVILIAN NONINSTITUTIONALIZED POPULATION!!Total Civilian Noninstitutionalized Population	

## initialize variables
yeartoFetch <- 2018
shapetoFetch <- c("county", "zip code tabulation area", "state")
filename <- c("C","Z","S")


## set the ACS variables
variablestoFetch <- data.frame(cbind( c('B02001_001','B02001_002','B02001_003','B02001_004','B02001_005','B02001_006', 'B03003_003',
                                        'S0101_C01_002','S0101_C01_020','S0101_C01_005','S0101_C01_006','S0101_C01_024', 'S0101_C01_011',
                                        'S0101_C01_012', 'S0101_C01_013', 'S0101_C01_014', 'S0101_C01_030', 'S0101_C01_026',
                                        'B06009_001','B06009_002','DP02_0071P'),
                                      c('totPopE','white','black','amerInd','asian','pacificIs','hispanic',
                                        'age0_4', 'age5_14', 'age15_19','age20_24','age15_44', 'age45_49', 
                                        'age50_54', 'age55_59', 'age60_64', 'ageOv65', 'ageOv18',
                                        'popOver25','eduNoHS','disbP')))
colnames(variablestoFetch) <- c('code','name')
variablestoFetch$code <- as.character(variablestoFetch$code)
variablestoFetch$name <- as.character(variablestoFetch$name)

# fetch and save each shape
for (i in 1:length(shapetoFetch)){
  
  variables <- get_acs(geography = shapetoFetch[i], variables = variablestoFetch$code,
                       year = yeartoFetch, geometry = FALSE) # w/o geometry 
  
  variables <- data.frame(variables)
  variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
  varDf <- reshape(variables,idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
  colnames(varDf) <- gsub("estimate.","",colnames(varDf))
  colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]
  
  varDf$otherRace <-  varDf$totPopE - (varDf$white + varDf$black + varDf$amerInd + varDf$asian + varDf$pacificIs)
  varDf$whiteP  <-  round(varDf$white*100/varDf$totPopE,2)
  varDf$blackP  <-  round(varDf$black*100/varDf$totPopE,2)
  varDf$amIndP  <-  round(varDf$amerInd*100/varDf$totPopE,2)
  varDf$asianP  <-  round(varDf$asian*100/varDf$totPopE,2)
  varDf$pacIsP  <-  round(varDf$pacificIs*100/varDf$totPopE,2)
  varDf$otherP  <-  round(varDf$otherRace*100/varDf$totPopE,2)
  varDf$hispP   <-  round(varDf$hispanic*100/varDf$totPopE,2)
  varDf$noHSP   <-  round(varDf$eduNoHS*100/varDf$popOver25,2)
  #varDf$InsPop    <-  varDf$totPopE - varDf$nonInsPop
  varDf$age18_64 <- round(varDf$ageOv18 - varDf$ageOv65,2) 
  varDf$a15_24P  <-   round((varDf$age15_19 + varDf$age20_24)*100/varDf$totPopE,2)
  varDf$und45P<-  round((varDf$age0_4 + varDf$age5_14 + varDf$age15_44)*100/varDf$totPopE,2)
  varDf$ovr65P <-  round(varDf$ageOv65*100/varDf$totPopE,2)
  varDf$year <- yeartoFetch
  
  varDf <- varDf[,c('GEOID','year','totPopE','whiteP','blackP','amIndP','asianP','pacIsP',
                    'otherP','hispP','noHSP', 
                    'age0_4', 'age5_14', 'age15_19','age20_24','age15_44', 'age45_49', 
                    'age50_54', 'age55_59', 'age60_64', 'ageOv65', 'ageOv18',
                    'age18_64', 'a15_24P', 'und45P', 'ovr65P', 'disbP')]
  write.csv(varDf,paste0('data_final/DS01_',yeartoFetch,"_",filename[i],".csv"), row.names = FALSE)

}

## API not working correctly for Tracts, so need to run it separately

states <- tigris::states(year = yeartoFetch)
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

variables <- map_df(.x = as.numeric(states$STATEFP),
                  ~ get_acs(geography = "tract", state = .x,
                            variables = variablestoFetch$code,
                            year = yeartoFetch, geometry = FALSE))

variables <- data.frame(variables)
variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
varDf <- reshape(variables,idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
colnames(varDf) <- gsub("estimate.","",colnames(varDf))
colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]

varDf$otherRace <-  varDf$totPopE - (varDf$white + varDf$black + varDf$amerInd + varDf$asian + varDf$pacificIs)
varDf$whiteP  <-  round(varDf$white*100/varDf$totPopE,2)
varDf$blackP  <-  round(varDf$black*100/varDf$totPopE,2)
varDf$amIndP  <-  round(varDf$amerInd*100/varDf$totPopE,2)
varDf$asianP  <-  round(varDf$asian*100/varDf$totPopE,2)
varDf$pacIsP  <-  round(varDf$pacificIs*100/varDf$totPopE,2)
varDf$otherP  <-  round(varDf$otherRace*100/varDf$totPopE,2)
varDf$hispP   <-  round(varDf$hispanic*100/varDf$totPopE,2)
varDf$noHSP   <-  round(varDf$eduNoHS*100/varDf$popOver25,2)
#varDf$InsPop    <-  varDf$totPopE - varDf$nonInsPop
varDf$age18_64 <- round(varDf$ageOv18 - varDf$ageOv65,2) 
varDf$a15_24P  <-   round((varDf$age15_19 + varDf$age20_24)*100/varDf$totPopE,2)
varDf$und45P<-  round((varDf$age0_4 + varDf$age5_14 + varDf$age15_44)*100/varDf$totPopE,2)
varDf$ovr65P <-  round(varDf$ageOv65*100/varDf$totPopE,2)
varDf$year <- yeartoFetch

varDf <- varDf[,c('GEOID','year','totPopE','whiteP','blackP','amIndP','asianP','pacIsP',
                  'otherP','hispP','noHSP', 
                  'age0_4', 'age5_14', 'age15_19','age20_24','age15_44', 'age45_49', 
                  'age50_54', 'age55_59', 'age60_64', 'ageOv65', 'ageOv18',
                  'age18_64', 'a15_24P', 'und45P', 'ovr65P', 'disbP')]

write.csv(varDf,paste0('DS01_',yeartoFetch,"_T",".csv"), row.names = FALSE)

### For ZCTA

states <- tigris::states(year = yeartoFetch)
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

variables <- map_df(.x = as.numeric(states$STATEFP),
                    ~ get_acs(geography = "zcta",
                              variables = variablestoFetch$code,
                              year = yeartoFetch, geometry = FALSE))

variables <- data.frame(variables)
variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
varDf <- reshape(variables,idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
colnames(varDf) <- gsub("estimate.","",colnames(varDf))
colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]

varDf$otherRace <-  varDf$totPopE - (varDf$white + varDf$black + varDf$amerInd + varDf$asian + varDf$pacificIs)
varDf$whiteP  <-  round(varDf$white*100/varDf$totPopE,2)
varDf$blackP  <-  round(varDf$black*100/varDf$totPopE,2)
varDf$amIndP  <-  round(varDf$amerInd*100/varDf$totPopE,2)
varDf$asianP  <-  round(varDf$asian*100/varDf$totPopE,2)
varDf$pacIsP  <-  round(varDf$pacificIs*100/varDf$totPopE,2)
varDf$otherP  <-  round(varDf$otherRace*100/varDf$totPopE,2)
varDf$hispP   <-  round(varDf$hispanic*100/varDf$totPopE,2)
varDf$noHSP   <-  round(varDf$eduNoHS*100/varDf$popOver25,2)
#varDf$InsPop    <-  varDf$totPopE - varDf$nonInsPop
varDf$age18_64 <- round(varDf$ageOv18 - varDf$ageOv65,2) 
varDf$a15_24P  <-   round((varDf$age15_19 + varDf$age20_24)*100/varDf$totPopE,2)
varDf$und45P<-  round((varDf$age0_4 + varDf$age5_14 + varDf$age15_44)*100/varDf$totPopE,2)
varDf$ovr65P <-  round(varDf$ageOv65*100/varDf$totPopE,2)
varDf$year <- yeartoFetch

varDf <- varDf[,c('GEOID','year','totPopE','whiteP','blackP','amIndP','asianP','pacIsP',
                  'otherP','hispP','noHSP', 
                  'age0_4', 'age5_14', 'age15_19','age20_24','age15_44', 'age45_49', 
                  'age50_54', 'age55_59', 'age60_64', 'ageOv65', 'ageOv18',
                  'age18_64', 'a15_24P', 'und45P', 'ovr65P', 'disbP')]

varDf$GEOID <- substr(varDf$GEOID, 3, varDf$GEOID)

write.csv(varDf,paste0('data_final/DS01_',yeartoFetch,"_Z",".csv"), row.names = FALSE)

### Code NAs as -999 ----

ds01_t <- read.csv("data_final/DS01_2018_T.csv")
ds01_z <- read.csv("data_final/DS01_2018_Z.csv")
ds01_c <- read.csv("data_final/DS01_2018_C.csv")
ds01_s <- read.csv("data_final/DS01_2018_S.csv")

ds01_t[is.na(ds01_t)] <- -999
ds01_z[is.na(ds01_z)] <- -999
ds01_c[is.na(ds01_c)] <- -999
ds01_s[is.na(ds01_s)] <- -999

# Resave final datasets
write.csv(ds01_t, "data_final/DS01_T.csv")
write.csv(ds01_z, "data_final/DS01_Z.csv")
write.csv(ds01_c, "data_final/DS01_C.csv")
write.csv(ds01_s, "data_final/DS01_S.csv")
