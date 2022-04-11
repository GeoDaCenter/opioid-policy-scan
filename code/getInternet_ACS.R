# Author : Qinyun Lin
# Date : April 10th, 2022
# This piece of code will generate No Internet Access variable for EC tables for Policy Scan.

library(tidycensus)
library(tidyverse)
library(tmap)
library(geojsonio)
library(tigris)

#census_api_key("key", install = TRUE)

## identify variables from B28002
##B28002_001: Estimate!!Total:
##B28002_002: Estimate!!Total:!!Estimate!!Total:!!With an Internet subscription"
##B28002_012: Estimate!!Total:!!Internet access without a subscription
##B28002_013: Estimate!!Total:!!No Internet access

## initialize variables
yeartoFetch <- 2019
shapetoFetch <- c("county","zcta","state")
filename <- c("C","Z","S")

# Look at variables
vars <- load_variables(2019, "acs5", cache = TRUE)
View(vars)
vars[vars$name == "B28002_013",]$label
## "Estimate!!Total:!!No Internet access"
vars[vars$name == "B28002_012",]$label
## ""Estimate!!Total:!!Internet access without a subscription""
vars[vars$name == "B28002_011",]$label
## "Estimate!!Total:!!With an Internet subscription!!Other service with no other type of Internet subscription""
vars[vars$name == "B28002_002",]$label
## ""Estimate!!Total:!!With an Internet subscription""
vars[vars$name == "B28002_001",]$label
## ""Estimate!!Total:"

## set the ACS variables
variablestoFetch <- data.frame(cbind( c('B28002_002','B28002_012','B28002_013', 'B28002_001'),
                                      c('IntSub','IntNoSub','noInt','total')))
colnames(variablestoFetch) <- c('code','name')
variablestoFetch$code <- as.character(variablestoFetch$code)
variablestoFetch$name <- as.character(variablestoFetch$name)

for (i in 1:length(shapetoFetch)){
  variables <- get_acs(geography = shapetoFetch[i], variables = variablestoFetch$code,
                       year = yeartoFetch, geometry = FALSE)
  variables <- data.frame(variables)
  variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
  varDf <- reshape(variables, idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
  colnames(varDf) <- gsub("estimate.","",colnames(varDf))
  colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]
  varDf$IntSubPct <-  round(varDf$IntSub*100/varDf$total, 2)
  varDf$IntNoSubPct <-  round(varDf$IntNoSub*100/varDf$total, 2)
  varDf$NoIntPct <-  round(varDf$noInt*100/varDf$total, 2)
  varDf$year <- yeartoFetch
  write.csv(varDf,paste0('EC05_',yeartoFetch,"_",filename[i],".csv"), row.names = FALSE)
}

## for tracts
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
varDf <- reshape(variables, idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
colnames(varDf) <- gsub("estimate.","",colnames(varDf))
colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]
varDf$IntSubPct <-  round(varDf$IntSub*100/varDf$total, 2)
varDf$IntNoSubPct <-  round(varDf$IntNoSub*100/varDf$total, 2)
varDf$NoIntPct <-  round(varDf$noInt*100/varDf$total, 2)
varDf$year <- yeartoFetch
write.csv(varDf, "EC05_2019_T.csv", row.names = FALSE)

