# Author : Moksha Menghaney
# Date : Sep 16th, 2020
# This piece of code will generate Essential Worker variable for EC tables for Policy Scan.

library(tidycensus)
library(tidyverse)
library(tmap)
library(geojsonio)
library(tigris)

# will be sourcing data from S2401 table
# essential workers =   
# Management,  Business, Science, and Arts Occupations: Education, Legal, Community Service, Arts, and Media Occupations
# Healthcare Practitioners and Technical Occupations
# Service Occupations: Healthcare Support Occupations:
# Service Occupations: Protective Service Occupations:
# Service Occupations: Food Preparation and Serving Related Occupations:
# Service Occupations: Building and Grounds Cleaning and Maintenance Occupations:
# Natural Resources, Construction, and Maintenance Occupations:	Farming, Fishing, and Forestry Occupations:
# Natural Resources, Construction, and Maintenance Occupations:	Construction and Extraction Occupations:
# Natural Resources, Construction, and Maintenance Occupations: Installation, Maintenance, and Repair Occupations:
# Production, Transportation, and Material Moving Occupations: Transportation Occupations:
# Production, Transportation, and Material Moving Occupations: Material Moving Occupations:

sProfileVar18 <- load_variables(2018,"acs5/subject", cache = TRUE) %>% 
                      filter(str_detect(name, 'S2401_C01')) %>% 
                        mutate(label = str_replace(label, "Estimate!!Total!!Civilian employed population 16 years and over!!",""))

# strsToDetect <- str_to_sentence(c('Estimate!!Total!!Civilian employed population 16 years and over',
#                                   'Community and Social Service Occupations',
#                                   'Healthcare Practitioners and Technical Occupations',
#                                   'Healthcare Support Occupations','Protective Service Occupations',
#                                   'Food Preparation and Serving Related Occupations','Building and Grounds Cleaning and Maintenance Occupations',
#                                   'Farming, Fishing, and Forestry Occupations','Construction and Extraction Occupations',
#                                   'Installation, Maintenance, and Repair Occupations','Transportation Occupations',
#                                   'Material Moving Occupations'))
# 
# sProfileVar18$toSel <- 0
# sProfileVar18[str_which(string = sProfileVar18$label, pattern = paste(strsToDetect,collapse = '|')),"toSel"] <- 1

# tribble design and variable identification derived from CMAP calculations
# /***************************************************************************************
#   *    Title: CMAP-REPOS/essentialworkers
#   *    Author: Matt Stern
#   *    Date: Sep 16, 2020
#   *    Availability: https://github.com/CMAP-REPOS/essentialworkers

occsToSelect <- tribble(~variable, ~type,
                     "S2401_C01_001", "total",
                     "S2401_C01_002", "no",
                     "S2401_C01_003", "no",
                     "S2401_C01_004", "no",
                     "S2401_C01_005", "no",
                     "S2401_C01_006", "no",
                     "S2401_C01_007", "no",
                     "S2401_C01_008", "no",
                     "S2401_C01_009", "no",
                     "S2401_C01_010", "no",
                     "S2401_C01_011", "yes",
                     "S2401_C01_012", "no",
                     "S2401_C01_013", "no",
                     "S2401_C01_014", "no",
                     "S2401_C01_015", "yes",
                     "S2401_C01_016", "no",
                     "S2401_C01_017", "no",
                     "S2401_C01_018", "no",
                     "S2401_C01_019", "yes",
                     "S2401_C01_020", "yes",
                     "S2401_C01_021", "no",
                     "S2401_C01_022", "no",
                     "S2401_C01_023", "yes",
                     "S2401_C01_024", "yes",
                     "S2401_C01_025", "no",
                     "S2401_C01_026", "no",
                     "S2401_C01_027", "no",
                     "S2401_C01_028", "no",
                     "S2401_C01_029", "no",
                     "S2401_C01_030", "yes",
                     "S2401_C01_031", "yes",
                     "S2401_C01_032", "yes",
                     "S2401_C01_033", "no",
                     "S2401_C01_034", "no",
                     "S2401_C01_035", "yes",
                     "S2401_C01_036", "yes")

# ***************************************************************************************/                         

## initialize variables
yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
filename <- c("C","Z","S")


## set the ACS variables
variablestoFetch <- data.frame(occsToSelect %>% filter(type != 'no') %>% select(variable))

# fetch and save each shape
for (i in 1:length(shapetoFetch))
{
  
  variables <- get_acs(geography = shapetoFetch[i], variables = variablestoFetch$variable,
                       year = yeartoFetch, geometry = FALSE) %>%  # w/o geometry 
                select(GEOID, variable, estimate) %>% 
                mutate(type = ifelse(variable == 'S2401_C01_001','total','essential'))
  variables <- variables %>% group_by(GEOID, type) %>% summarize(check = n(), value = sum(estimate))
  
  try(if(dim(variables %>% filter(!check %in% c(1,11)))[1] > 0) stop("check n, missing values"))
  
  varDf <- dcast(variables, GEOID~type, value.var = 'value')
  
  varDf$essentialPct <-  round(varDf$essential*100/varDf$total,2)
  varDf$year <- yeartoFetch
  
  colnames(varDf) <- c('GEOID','essnWrkE','wrkPopE','essnWrkP','year')
  varDf <- varDf[,c('GEOID','year','essnWrkE','wrkPopE','essnWrkP')]
  write.csv(varDf,paste0('EC02_',yeartoFetch,"_",filename[i],".csv"), row.names = FALSE)
}

## for tracts
states <- tigris::states(year = yeartoFetch)
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

variables <- map_df(.x = as.numeric(states$STATEFP),
                    ~ get_acs(geography = "tract", state = .x,
                              variables = variablestoFetch$variable,
                              year = yeartoFetch, geometry = FALSE))

variables <- variables %>% select(GEOID, variable, estimate) %>% mutate(type = ifelse(variable == 'S2401_C01_001','total','essential'))
variables <- variables %>% group_by(GEOID, type) %>% summarize(check = n(), value = sum(estimate))

try(if(dim(variables %>% filter(!check %in% c(1,11)))[1] > 0) stop("check n, missing values"))

varDf <- dcast(variables, GEOID~type, value.var = 'value')

varDf$essentialPct <-  round(varDf$essential*100/varDf$total,2)
varDf$year <- yeartoFetch

colnames(varDf) <- c('GEOID','essnWrkE','wrkPopE','essnWrkP','year')
varDf <- varDf[,c('GEOID','year','essnWrkE','wrkPopE','essnWrkP')]
write.csv(varDf,paste0('EC02_',yeartoFetch,"_T",".csv"), row.names = FALSE)
