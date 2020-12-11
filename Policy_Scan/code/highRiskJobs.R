# Author : Moksha Menghaney
# Date : Sep 16th, 2020
# This piece of code will generate High Risk Jobs variable for EC tables for Policy Scan.


library(tidycensus)
library(tidyverse)
library(tmap)
library(reshape2)
library(tigris)

# will be sourcing data from S2403 table
# high risk jobs  =   
# Agriculture, forestry, fishing and hunting
# Mining, quarrying, and oil and gas extraction
# Construction
# Manufacturing
# Utilities

# separately (more covid related)
# Retail trade
# Educational services
# Health care and social assistance

sProfileVar18 <- load_variables(2018,"acs5/subject", cache = TRUE) %>% 
  filter(str_detect(name, 'S2403_C01')) %>% 
  mutate(label = str_replace(label, "Estimate!!Total!!Civilian employed population 16 years and over!!",""))

indsToSelect <- tribble(~variable, ~type,
                        "S2403_C01_001", "total",
                        "S2403_C01_002", "no",
                        "S2403_C01_003", "highRisk",
                        "S2403_C01_004", "highRisk",
                        "S2403_C01_005", "highRisk",
                        "S2403_C01_006", "highRisk",
                        "S2403_C01_007", "no",
                        "S2403_C01_008", "retail",
                        "S2403_C01_009", "no",
                        "S2403_C01_010", "no",
                        "S2403_C01_011", "highRisk",
                        "S2403_C01_012", "no",
                        "S2403_C01_013", "no",
                        "S2403_C01_014", "no",
                        "S2403_C01_015", "no",
                        "S2403_C01_016", "no",
                        "S2403_C01_017", "no",
                        "S2403_C01_018", "no",
                        "S2403_C01_019", "no",
                        "S2403_C01_020", "no",
                        "S2403_C01_021", "edu",
                        "S2403_C01_022", "hlthCare",
                        "S2403_C01_023", "no",
                        "S2403_C01_024", "no",
                        "S2403_C01_025", "no",
                        "S2403_C01_026", "no",
                        "S2403_C01_027", "no",)


## initialize variables
yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
filename <- c("C","Z","S")


## set the ACS variables
variablestoFetch <- data.frame(indsToSelect %>% filter(type != 'no') %>% select(variable))

# fetch and save each shape
for (i in 1:length(shapetoFetch))
{
  
  variables <- get_acs(geography = shapetoFetch[i], variables = variablestoFetch$variable,
                       year = yeartoFetch, geometry = FALSE) %>%  # w/o geometry 
                select(GEOID, variable, estimate) %>% left_join(indsToSelect, by = 'variable')
  
  
  variables <- variables %>% group_by(GEOID, type) %>% summarize(check = n(), value = sum(estimate))
  
  try(if(dim(variables %>% filter(!check %in% c(1,5)))[1] > 0) stop("check n, missing values"))
  
  varDf <- dcast(variables, GEOID~type, value.var = 'value')
  
  varDf$eduP <-  round(varDf$edu*100/varDf$total,2)
  varDf$hghRskP <-  round(varDf$highRisk*100/varDf$total,2)
  varDf$hltCrP <-  round(varDf$hlthCare*100/varDf$total,2)
  varDf$retailP <-  round(varDf$retail*100/varDf$total,2)
  
  varDf$year <- yeartoFetch
  
  colnames(varDf) <- c('GEOID','eduE','hghRskE','hltCrE','retailE','totWrkE','eduP','hghRskP','hltCrP','retailP','year')
  varDf <- varDf[,c('GEOID','year','totWrkE','eduP','hghRskP','hltCrP','retailP')]
  write.csv(varDf,paste0('EC01_',yeartoFetch,"_",filename[i],".csv"), row.names = FALSE)
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

variables <- variables %>% select(GEOID, variable, estimate) %>% left_join(indsToSelect, by = 'variable')
variables <- variables %>% group_by(GEOID, type) %>% summarize(check = n(), value = sum(estimate))

try(if(dim(variables %>% filter(!check %in% c(1,5)))[1] > 0) stop("check n, missing values"))

varDf <- dcast(variables, GEOID~type, value.var = 'value')

varDf$eduP <-  round(varDf$edu*100/varDf$total,2)
varDf$hghRskP <-  round(varDf$highRisk*100/varDf$total,2)
varDf$hltCrP <-  round(varDf$hlthCare*100/varDf$total,2)
varDf$retailP <-  round(varDf$retail*100/varDf$total,2)

varDf$year <- yeartoFetch

colnames(varDf) <- c('GEOID','eduE','hghRskE','hltCrE','retailE','totWrkE','eduP','hghRskP','hltCrP','retailP','year')
varDf <- varDf[,c('GEOID','year','totWrkE','eduP','hghRskP','hltCrP','retailP')]
write.csv(varDf,paste0('EC01_',yeartoFetch,"_T",".csv"), row.names = FALSE)
