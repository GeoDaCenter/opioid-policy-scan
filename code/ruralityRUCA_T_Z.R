# Author : Moksha Menghaney
# Date : October 27th, 2020
# This piece of code will generate tract & zipcode level urban/suburban/rural classification for OEPS, files HS02
# It also generates county level % rurality metrics which is stored in raw files folder for further processing.

### Set up ----
library(xlsx)
library(tidyverse)

geometryFilesLoc <- './opioid-policy-scan/data_final/geometryFiles/'
rawDataFilesLoc <- './opioid-policy-scan/data_raw/'
outputFilesLoc <- './opioid-policy-scan/data_final/'

# Classifications finalized
urban <- c(1.0, 1.1)
suburban <- c(2.0, 2.1, 4.0, 4.1)
# everything else rural

### TRACT LEVEL ----

rucaTract <- openxlsx::read.xlsx(paste0(rawDataFilesLoc,'ruca2010revisedTract.xlsx'), 
                                 sheet = 1, startRow = 2, colNames = TRUE)

colnames(rucaTract) <- c('countyFIPS','State','County','tractFIPS','RUCA1',
                         'RUCA2','Pop_2010','Area_2010','PopDen_2010')

rucaTract$rurality <- ifelse(rucaTract$RUCA2 %in% urban, "Urban",
                             ifelse(rucaTract$RUCA2 %in% suburban, "Suburban", "Rural"))

rucaTract$rurality <- factor(rucaTract$rurality , levels= c('Urban','Suburban','Rural'))

write.csv(rucaTract %>% 
            select(tractFIPS, RUCA1, RUCA2, rurality) %>%
            mutate(RUCA1 = as.character(RUCA1),
                   RUCA2 = as.character(RUCA2)),
          paste0(outputFilesLoc,'HS02_RUCA_T.csv'), row.names = FALSE)

#### ZCTA LEVEL ----

rucaZipcode <- read.xlsx(paste0(rawDataFilesLoc,'RUCA2010zipcode.xlsx'), 
                         sheetName = 'Data', header = TRUE) %>% select(-c(STATE,ZIP_TYPE))

rucaZipcode$rurality <- ifelse(rucaZipcode$RUCA2 %in% urban, "Urban",
                             ifelse(rucaZipcode$RUCA2 %in% suburban, "Suburban", "Rural"))
rucaZipcode$rurality <- factor(rucaZipcode$rurality , levels= c('Urban','Suburban','Rural'))
rucaZipcode <- rucaZipcode %>% 
              mutate(RUCA1 = as.character(RUCA1),
                     RUCA2 = as.character(RUCA2))
write.csv(rucaZipcode,paste0(outputFilesLoc,'HS02_RUCA_Z.csv'),
                             row.names = FALSE)

### COUNTY LEVEL ----

# calculate % of tracts in county rural, urban, suburban
rucaCountyRurality <- rucaTract %>% 
                      select(countyFIPS, rurality) %>% 
                      count(countyFIPS, rurality) %>% 
                      group_by(countyFIPS) %>%
                      mutate(pct = n / sum(n))

rucaCountyRurality <- pivot_wider(rucaCountyRurality,id_cols = 'countyFIPS', 
                                  names_from = 'rurality',
                                  values_from = 'pct', values_fill = 0) %>% 
                      mutate(check = round(sum(Urban+Suburban+Rural),2))


## Check data and clean up
rucaCountyRurality[which(rucaCountyRurality$check !=1),]
rucaCountyRurality <- data.frame(rucaCountyRurality %>% 
                                   mutate(Urban = round(Urban,2),
                                          Suburban = round(Suburban,2),
                                          Rural = round(Rural,2)) %>%
                                   rename(GEOID = countyFIPS,
                                          rcaUrbP = Urban,
                                          rcaSubrbP = Suburban,
                                          rcaRuralP = Rural))

write.csv(rucaCountyRurality %>% select(-check), paste0(rawDataFilesLoc,'county_RUCA_rurality.csv'), 
                                     row.names = FALSE)

