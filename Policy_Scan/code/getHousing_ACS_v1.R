# Author : Moksha Menghaney
# Date : August 19th, 2020
# This piece of code will genreate HS01 tables for Policy Scan.

library(tidycensus)
library(tidyverse)
library(tmap)
library(sf)
library(tigris)

# update this for your drive!
geometryFilesLoc <- './opioid-policy-scan/Policy_Scan/data_final/geometryFiles/'
#census_api_key("9cd7bfa4819ef1c36ca81f52c8a0796dfd2ce2bf", install = TRUE)


## identify variables from B25002: OCCUPANCY STATUS
#  1. Total Units           B25002_001 Estimate!!Total	
#  2. Occupancy : Occupied  B25002_002 Estimate!!Total!!Occupied	
#  3. Occupancy : Vacant    B25002_003 Estimate!!Total!!Vacant	

## identify variables from B25024: UNITS IN STRUCTURE
#  1. Type : Mobile home    B25024_010	Estimate!!Total!!Mobile home, Base B25024_001 should be same as B25002_001

## identify variables from B25003 : TENURE
#  1. Status: Occupied        B25003_001 Estimate!!Total	Occupied Units
#  2. Status: Owner Occupied  B25003_002 Estimate!!Total!!Owner occupied Units
#  3. Status: Renter Occupied B25003_003 Estimate!!Total!!Renter occupied Units

## identify variables from B25026: TOTAL POPULATION IN OCCUPIED HOUSING UNITS BY TENURE BY YEAR HOUSEHOLDER MOVED INTO UNIT
#  1. Year : Tot Pop   OwnOcc B25026_002 Estimate!!Total population in occupied housing units!!Owner occupied	
#  2. Year : 1990_1999 OwnOcc B25026_007 Estimate!!Total population in occupied housing units!!Owner occupied!!Moved in 1990 to 1999
#  3. Year : <1989     OwnOcc B25026_008 Estimate!!Total population in occupied housing units!!Owner occupied!!Moved in 1989 or earlier	
#  4. Year : Tot Pop   RenOcc 25026_009	Estimate!!Total population in occupied housing units!!Renter occupied	
#  5. Year : 1990_1999 RenOcc B25026_014 Estimate!!Total population in occupied housing units!!Renter occupied!!Moved in 1990 to 1999	
#  6. Year : <1989     RenOcc B25026_015 Estimate!!Total population in occupied housing units!!Renter occupied!!Moved in 1989 or earlier	


## initialize variables
yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
filename <- c("C","Z","S")


## set the ACS variables
variablestoFetch <- data.frame(cbind( c('B25002_001','B25002_002','B25002_003','B25024_010','B25003_001','B25003_002','B25003_003',
                                        'B25026_002','B25026_007','B25026_008','B25026_009' ,'B25026_014','B25026_015'),
                                      c('totUnits','occupied','vacant','mobileHome','occUnits','ownOcc','renOcc',
                                        'popOwnOcc','popO_90_99','popO_bfr89','popRenOcc','popR_90_99','popR_bfr89')))
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
  
  varDf$occP    <-  round(varDf$occupied*100/varDf$totUnits,2)
  varDf$vacantP    <-  round(varDf$vacant*100/varDf$totUnits,2)
  varDf$mobileP <-  round(varDf$mobileHome*100/varDf$totUnits,2)
  varDf$lngTermP<-  round(100*(varDf$popO_90_99 + varDf$popO_bfr89 + varDf$popR_90_99 + varDf$popR_bfr89)/(varDf$popOwnOcc + varDf$popRenOcc),2)
  varDf$rentalP <-  round(varDf$renOcc*100/(varDf$occUnits),2)
  
  # get ALAND area to calcuate units per square mile
  if(shapetoFetch[i] == 'county'){
      baseGeo <- read_sf(paste0(geometryFilesLoc,'tl_2018_county/counties2018.shp'))
    } else if(shapetoFetch[i] == 'zcta'){
      baseGeo <- read_sf(paste0(geometryFilesLoc,'tl_2018_zcta/zctas2018.shp'))
    }else if(shapetoFetch[i] == 'state'){
      baseGeo <- read_sf(paste0(geometryFilesLoc,'tl_2018_state/states2018.shp'))
    }
  
    st_geometry(baseGeo) <- NULL
    baseGeo <- data.frame(baseGeo[,grepl('\\bGEOID|ALAND', colnames(baseGeo))]) #aland in sq meters
    baseGeo$areaSqMile <- baseGeo[,grep('ALAND',colnames(baseGeo))]/2590000 # sqmiles
    colnames(baseGeo)[grep('GEOID',colnames(baseGeo), fixed = TRUE)] <- 'GEOID'
    varDf <- merge(varDf,baseGeo[,c('GEOID','areaSqMile')], by.x = 'GEOID', by.y = 'GEOID')
    varDf$unitDens <- varDf$totUnits/varDf$areaSqMile
    
    varDf <- varDf[,c('GEOID','totUnits','occP','vacantP','mobileP','lngTermP','rentalP','unitDens')]
    write.csv(varDf,paste0('HS01_',yeartoFetch,"_",filename[i],".csv"),row.names = FALSE)
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

varDf$occP    <-  round(varDf$occupied*100/varDf$totUnits,2)
varDf$vacantP <-  round(varDf$vacant*100/varDf$totUnits,2)
varDf$mobileP <-  round(varDf$mobileHome*100/varDf$totUnits,2)
varDf$lngTermP<-  round(100*(varDf$popO_90_99 + varDf$popO_bfr89 + varDf$popR_90_99 + varDf$popR_bfr89)/(varDf$popOwnOcc + varDf$popRenOcc),2)
varDf$rentalP <-  round(varDf$renOcc*100/(varDf$popOwnOcc + varDf$popRenOcc),2)

baseGeo <- read_sf(paste0(geometryFilesLoc,'tl_2018_tract/tracts2018.shp'))
st_geometry(baseGeo) <- NULL
baseGeo <- data.frame(baseGeo[,grepl('\\bGEOID|ALAND', colnames(baseGeo))])#aland in sq meters
baseGeo$areaSqMile <- baseGeo[,grep('ALAND',colnames(baseGeo))]/2590000 # sqmiles
colnames(baseGeo)[grep('GEOID',colnames(baseGeo))] <- 'GEOID'
varDf <- merge(varDf,baseGeo[,c('GEOID','areaSqMile')], by.x = 'GEOID', by.y = 'GEOID')
varDf$unitDens <- varDf$totUnits/varDf$areaSqMile

varDf <- varDf[,c('GEOID','totUnits','occP','vacantP','mobileP','lngTermP','rentalP','unitDens')]
write.csv(varDf,paste0('HS01_',yeartoFetch,"_T",".csv"), row.names = FALSE)
