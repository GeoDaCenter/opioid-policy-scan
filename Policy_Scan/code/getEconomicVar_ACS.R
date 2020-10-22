# Author : Moksha Menghaney
# Date : Sep 16th, 2020
# This piece of code will generate Unemployment rate, Poverty rate, Per capita income  for EC tables for Policy Scan.


library(tidycensus)
library(tidyverse)
library(tmap)

## identify variables from DP03: SELECTED ECONOMIC CHARACTERISTICS
#  1. Unemp : DP03_0009P Percent Estimate!!EMPLOYMENT STATUS!!Civilian labor force!!Unemployment Rate

## identify variables from S1701: POVERTY STATUS IN THE PAST 12 MONTHS
#  1. Poverty : S1701_C03_001 Estimate!!Percent below poverty level

## identify variables from B19301: PER CAPITA INCOME IN THE PAST 12 MONTHS (IN 2018 INFLATION-ADJUSTED DOLLARS)
#  1. Income : B19301_001 Estimate!!Per capita income in the past 12 months (in 2018 inflation-adjusted dollars)


## initialize variables
yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
filename <- c("C","Z","S")


## set the ACS variables
variablestoFetch <- data.frame(cbind( c('DP03_0009P','S1701_C03_001','B19301_001'),
                                      c('unempP','povP','pciE')))
colnames(variablestoFetch) <- c('code','name')
variablestoFetch$code <- as.character(variablestoFetch$code)
variablestoFetch$name <- as.character(variablestoFetch$name)

# fetch and save each shape
for (i in 1:length(shapetoFetch))
{

  variables <- get_acs(geography = shapetoFetch[i], variables = variablestoFetch$code,
                       year = yeartoFetch, geometry = FALSE) # w/o geometry 
  
  variables <- data.frame(variables)
  variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
  varDf <- reshape(variables,idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
  colnames(varDf) <- gsub("estimate.","",colnames(varDf))
  colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]
  
  varDf$year <- yeartoFetch
  
  
  varDf <- varDf[,c('GEOID','year','unempP','povP','pciE')]
  write.csv(varDf,paste0('EC03_',yeartoFetch,"_",filename[i],".csv"), row.names = FALSE)
}

## api not working correctly for "tract" so need to run it separately
# get counties
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

varDf$year <- yeartoFetch


varDf <- varDf[,c('GEOID','year','unempP','povP','pciE')]
write.csv(varDf,paste0('EC03_',yeartoFetch,"_T",".csv"), row.names = FALSE)
