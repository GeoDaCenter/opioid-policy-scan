library(tidycensus)
library(tidyverse)
library(tmap)
library(geojsonio)

setwd("/Users/yashbansal/Desktop/CSDS_RA/Opioid/Policy scan/code")
census_api_key("9cd7bfa4819ef1c36ca81f52c8a0796dfd2ce2bf")


## DP02 select social characteristics
## DP03 economic characteristics 
## DP04 housing characteristics
## DP05 demographics

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
#  2. Age  : Age 15-19  S0101_C01_005 Estimate!!Total!!Total population!!AGE!!15 to 19 years	
#  3. Age  : Age 20-24  S0101_C01_006	Estimate!!Total!!Total population!!AGE!!20 to 24 years
#  4. Age  : Age >=65   S0101_C01_030 Estimate!!Total!!Total population!!SELECTED AGE CATEGORIES!!65 years and over	
#  5. Age  : Age 15-44  S0101_C01_024 Estimate!!Total!!Total population!!SELECTED AGE CATEGORIES!!15 to 44 years	
#  6. Age  : Age 5-14   S0101_C01_020 Estimate!!Total!!Total population!!SELECTED AGE CATEGORIES!!5 to 14 years	

## identify variables from B06009: PLACE OF BIRTH BY EDUCATIONAL ATTAINMENT IN THE UNITED STATES
#  1. Pop : PopOver25   B06009_001 Estimate!!Total	Pop over 25
#  2. Edy : <HS         B06009_002 Estimate!!Total!!Less than high school graduate	Univ Pop over 25

## identify variables from DP02 table
#  1.Dis   : Disab      DP02_0071P Percent Estimate!!DISABILITY STATUS OF THE CIVILIAN NONINSTITUTIONALIZED POPULATION!!Total Civilian Noninstitutionalized Population	

## set variables
yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
variablestoFetch <- data.frame(cbind( c('B02001_001','B02001_002','B02001_003','B02001_004','B02001_005','B02001_006',
                                        'B03003_003','S0101_C01_002','S0101_C01_005','S0101_C01_006' ,'S0101_C01_030','S0101_C01_024','S0101_C01_020',
                                        'B06009_001','B06009_002','DP02_0071P'),
                                      c('totPop','white','black','americanInd','asian','pacificIs',
                                        'hispanic','age0_4','age15_19','age20_24','ageOv65','age15_44','age5_14',
                                        'popOver25','eduNoHS','pctDisab')))
colnames(variablestoFetch) <- c('code','name')
variablestoFetch$code <- as.character(variablestoFetch$code)
variablestoFetch$name <- as.character(variablestoFetch$name)

# fetch and save each shape
for (i in 1:length(shapetoFetch))
{
  baseGeo <- get_acs(geography = shapetoFetch[i], variables = c("DP05_0001"),
                           year = yeartoFetch, geometry = TRUE) # with geometry
  baseGeo <- baseGeo[,c('GEOID','NAME')]
  geojson_write(baseGeo, file = paste0(shapetoFetch[i],"_",yeartoFetch,".geojson"))
  
  variables <- get_acs(geography = shapetoFetch[i], variables = variablestoFetch$code,
                       year = yeartoFetch, geometry = FALSE) # w/o geometry 
  
  variables <- data.frame(variables)
  variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
  varDf <- reshape(variables,idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
  colnames(varDf) <- gsub("estimate.","",colnames(varDf))
  colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]
  
  varDf$otherRace <-  varDf$totPop - (varDf$white + varDf$black + varDf$americanInd + varDf$asian + varDf$pacificIs)
  varDf$pctWhite  <-  round(varDf$white*100/varDf$totPop,2)
  varDf$pctBlack  <-  round(varDf$black*100/varDf$totPop,2)
  varDf$pctAmInd  <-  round(varDf$americanInd*100/varDf$totPop,2)
  varDf$pctAsian  <-  round(varDf$asian*100/varDf$totPop,2)
  varDf$pctPacIs  <-  round(varDf$pacificIs*100/varDf$totPop,2)
  varDf$pctOther  <-  round(varDf$otherRace*100/varDf$totPop,2)
  varDf$pctHisp   <-  round(varDf$hispanic*100/varDf$totPop,2)
  varDf$pctNoHS   <-  round(varDf$eduNoHS*100/varDf$popOver25,2)
  #varDf$InsPop    <-  varDf$totPop - varDf$nonInsPop
  varDf$pct15_24  <-   round((varDf$age15_19 + varDf$age20_24)*100/varDf$totPop,2)
  varDf$pctUnder45<-  round((varDf$age0_4 + varDf$age5_14 + varDf$age15_44)*100/varDf$totPop,2)
  varDf$pctOver65 <-  round(varDf$ageOv65*100/varDf$totPop,2)
  
  # merge with geo file
  baseGeo  <- merge(baseGeo, varDf, by.x = 'GEOID', by.y = 'GEOID', all.x = TRUE)
  
  write.csv(varDf,paste0('Demographics_',shapetoFetch[i],"_",yeartoFetch,".csv"))
  tmap_save(tm = tm_shape(baseGeo) +tm_fill("pctOver65", n =5, style = "fisher", palette = "YlGnBu")+
           tm_borders(col = "grey25", alpha = 0.3) +
           tm_layout(frame = FALSE, legend.title.size = 0.9, legend.outside = TRUE),
          filename = paste0('PopOver65_',shapetoFetch[i],"_",yeartoFetch,".png"))
  tmap_save(tm = tm_shape(baseGeo) +tm_fill("pctBlack", n =5, style = "fisher", palette = "YlGnBu")+
              tm_borders(col = "grey25", alpha = 0.3) +
              tm_layout(frame = FALSE, legend.title.size = 0.9, legend.outside = TRUE),
            filename = paste0('AfricanAmerican_',shapetoFetch[i],"_",yeartoFetch,".png"))
  # ggplot(baseGeo) + 
  #   geom_sf(aes(fill = PctHisp), color = NA) + 
  #   coord_sf(datum = NA) + 
  #   theme_minimal() + 
  #   scale_fill_viridis_c()
}

## api not working correctly for "tract" so need to run it separately
# get counties
counties <- tigris::counties(year = yeartoFetch)
counties$STATEFP <- as.numeric(counties$STATEFP)
counties$COUNTYFP <- as.numeric(counties$COUNTYFP)


variables <- map2_df(.x = as.numeric(counties$STATEFP), .y = as.numeric(counties$COUNTYFP), 
                  ~ get_acs(geography = "tract", state = .x,
                            county = .y, variables = variablestoFetch$code,
                            year = yeartoFetch, geometry = FALSE))

variables <- data.frame(variables)
variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
varDf <- reshape(variables,idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
colnames(varDf) <- gsub("estimate.","",colnames(varDf))
colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]

varDf$pctWhite  <-  varDf$white/varDf$totPop
varDf$pctBlack  <-  varDf$black/varDf$totPop
varDf$pctHisp   <-  varDf$hispanic/varDf$totPop
varDf$disb      <-  varDf$disab/varDf$nonInsPop
varDf$pctNoHS   <-  1 - (varDf$eduOverHS/varDf$popOver25)
varDf$insPop    <-  varDf$totPop - varDf$nonInsPop
varDf$pctPop15_24 <-  (varDf$age15_19 + varDf$age20_24)/varDf$totPop
varDf$pctPopUnder45 <-(varDf$age0_4 + varDf$age5_9 + varDf$age10_14 + varDf$age20_24 + 
                         varDf$age25_34 + varDf$age35_44)/varDf$totPop
varDf$pctPopOver65  <-varDf$ageOv65/varDf$totPop

# merge with geo file
baseGeo  <- merge(baseGeo, varDf, by.x = 'GEOID', by.y = 'GEOID', all.x = TRUE)

write.csv(varDf,paste0('Demographics_tract_',yeartoFetch,".csv"))
# tmap_save(tm = tm_shape(baseGeo) +tm_fill("pctPopOver65", n =5, style = "fisher", palette = "YlGnBu")+
#             tm_borders(col = "grey25", alpha = 0.3) +
#             tm_layout(frame = FALSE, legend.title.size = 0.9, legend.outside = TRUE),
#           filename = paste0('Demographics_',shapetoFetch[i],"_",yeartoFetch,".png"))


# "DP05_0037","DP05_0038", "DP05_0071",
# "DP05_0005","DP05_0006","DP05_0007","DP05_0008",
# "DP05_0009","DP05_0010","DP05_0011","DP05_0029",
# "DP02_0058","DP02_0066","DP02_0070","DP02_0071")
#  