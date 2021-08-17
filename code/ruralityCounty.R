# Author : Moksha Menghaney
# Date : October 27th, 2020
# This piece of code will generate county level urban/suburban/rural classification 
# for policy scan, files HS02


library(xlsx)
library(tidyverse)

geometryFilesLoc <- './opioid-policy-scan/data_final/geometryFiles/'
rawDataFilesLoc <- './opioid-policy-scan/data_raw/'
outputFilesLoc <- './opioid-policy-scan/data_final/'

### County Rurality from Census

censusCountyRurality <- read.xlsx(paste0(rawDataFilesLoc,'County_Rural_Lookup.xlsx'), sheet = 1, startRow =4)
censusCountyRurality <- censusCountyRurality[,1:8]
colnames(censusCountyRurality) <- c('GEOID','state','name','note','totPop10','urbPop10','rurlPop10','cenRuralP')
censusCountyRurality <- censusCountyRurality[!(is.na(censusCountyRurality$totPop10)), ]
censusCountyRurality$cenRuralP <- round(censusCountyRurality$cenRuralP/100,2)

### County Rurality using RUCA Codes
rucaCountyRurality <- read.csv(paste0(rawDataFilesLoc,'county_RUCA_rurality.csv'))
rucaCountyRurality$GEOID <- sprintf("%05s", as.character(rucaCountyRurality$GEOID))

countyRurality <- merge(rucaCountyRurality, censusCountyRurality,
                        by.x = 'GEOID', by.y = 'GEOID', all = TRUE) 


write.csv(countyRurality,paste0(outputFilesLoc,'HS02_C.csv'))
