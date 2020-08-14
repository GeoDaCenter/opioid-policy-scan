library(tidycensus)
library(tidyverse)

setwd("/Users/yashbansal/Desktop/CSDS_RA/Opioid/Policy scan/")
census_api_key("9cd7bfa4819ef1c36ca81f52c8a0796dfd2ce2bf")


## DP02 select social characteristics
## DP03 economic characteristics 
## DP04 housing characteristics
## DP05 demographics

## identify variables from DP05 table
#  1. Total Population  DP05_0001	Estimate!!SEX AND AGE!!Total population
#  2. Race : White      DP05_0037 Estimate!!RACE!!Total population!!One race!!White
#  3. Race : Black      DP05_0038 Estimate!!RACE!!Total population!!One race!!Black or African American
#  4. Race : Hispanic   DP05_0071	Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Hispanic or Latino (of any race)	
#  5. Age  : <5         DP05_0005	Estimate!!SEX AND AGE!!Total population!!Under 5 years	
#  6. Age  : 5-9 yrs    DP05_0006	Estimate!!SEX AND AGE!!Total population!!5 to 9 years	
#  7. Age  : 10-14 yrs  DP05_0007	Estimate!!SEX AND AGE!!Total population!!10 to 14 years	
#  8. Age  : Age 15-19  DP05_0008	Estimate!!SEX AND AGE!!Total population!!15 to 19 years	
#  9. Age  : Age 20-24  DP05_0009	Estimate!!SEX AND AGE!!Total population!!20 to 24 years	
#  10.Age  : Age 25-34  DP05_0010	Estimate!!SEX AND AGE!!Total population!!25 to 34 years	
#  11.Age  : Age 35-44  DP05_0011	Estimate!!SEX AND AGE!!Total population!!35 to 44 years
#  12.Age  : Age >=65   DP05_0029 Estimate!!SEX AND AGE!!Total population!!65 years and over	

## identify variables from DP02 table
#  1.Edu   : Pop >=25   B06009_001Estimate!!Total	- Population 25 years and over
#  2.Edu   : < HS       B06009_002Estimate!!Total!!Less than high school graduate	
#  3.Ins   : NonIns Pop DP02_0070 Estimate!!DISABILITY STATUS OF THE CIVILIAN NONINSTITUTIONALIZED POPULATION!!Total Civilian Noninstitutionalized Population	
#  4.Dis   : Disab      DP02_0071 Estimate!!DISABILITY STATUS OF THE CIVILIAN NONINSTITUTIONALIZED POPULATION!!Total Civilian Noninstitutionalized Population!!With a disability	

## set variables
yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
variablestoFetch <- data.frame(cbind( c('DP05_0001','DP05_0037','DP05_0038','DP05_0071','DP05_0005','DP05_0006',
                                        'DP05_0007','DP05_0008','DP05_0009','DP05_0010','DP05_0011','DP05_0029',
                                        'B06009_001','B06009_002','DP02_0070','DP02_0071'),
                                      c('totPop','white','black','hispanic','age0_4','age5_9','age10_14',
                                        'age15_19','age20_24','age25_34','age35_44','ageOv65',
                                        'popOver25','eduNoHS','nonInsPop','disab')))
colnames(variablestoFetch) <- c('code','name')
variablestoFetch$code <- as.character(variablestoFetch$code)
variablestoFetch$name <- as.character(variablestoFetch$name)

# fetch and save each shape
for (i in 1:length(shapetoFetch))
{
  populationGeo <- get_acs(geography = shapetoFetch[i], variables = c("DP05_0001"),
                           year = yeartoFetch, geometry = TRUE) # with geometry
  
  variables <- get_acs(geography = shapetoFetch[i], variables = variablestoFetch$code,
                       year = yeartoFetch, geometry = FALSE) # w/o geometry 
  
  variables <- data.frame(variables)
  variables <- variables[,c("GEOID","variable","estimate")] # drop name and margin
  varDf <- reshape(variables,idvar = 'GEOID',timevar = 'variable',direction = 'wide') # long to wide
  colnames(varDf) <- gsub("estimate.","",colnames(varDf))
  colnames(varDf)[-1] <- variablestoFetch$name[match(colnames(varDf)[-1],variablestoFetch$code)]
  
  varDf$pctWhite  <-  varDf$white/varDf$totPop
  varDf$pctBlack  <-  varDf$black/varDf$totPop
  varDf$pctHisp   <-  varDf$hispanic/varDf$totPop
  varDf$disb      <-  varDf$disab/varDf$nonInsPop
  varDf$pctNoHS   <-  varDf$eduNoHS/varDf$popOver25
  varDf$onsPop    <-  varDf$totPop - varDf$nonInsPop
  varDf$pctPop15_24 <-  (varDf$age15_19 + varDf$age20_24)/varDf$totPop
  varDf$pctPopUnder45 <-(varDf$age0_4 + varDf$age5_9 + varDf$age10_14 + varDf$age15_19 + varDf$age20_24 + 
                           varDf$age25_34 + varDf$age35_44)/varDf$totPop
  varDf$pctPopOver65  <-varDf$ageOv65/varDf$totPop
  
  # merge with geo file
  populationGeo  <- merge(populationGeo, varDf, by.x = 'GEOID', by.y = 'GEOID', all.x = TRUE)
  
  write.csv(varDf,paste0('Demographics_',shapetoFetch[i],"_",yeartoFetch,".csv"))
  tmap_save(tm = tm_shape(populationGeo) +tm_fill("pctPopOver65", n =5, style = "fisher", palette = "YlGnBu")+
           tm_borders(col = "grey25", alpha = 0.3) +
           tm_layout(frame = FALSE, legend.title.size = 0.9, legend.outside = TRUE),
          filename = paste0('Demographics_',shapetoFetch[i],"_",yeartoFetch,".png"))
  # ggplot(populationGeo) + 
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
populationGeo  <- merge(populationGeo, varDf, by.x = 'GEOID', by.y = 'GEOID', all.x = TRUE)

write.csv(varDf,paste0('Demographics_tract_',yeartoFetch,".csv"))
# tmap_save(tm = tm_shape(populationGeo) +tm_fill("pctPopOver65", n =5, style = "fisher", palette = "YlGnBu")+
#             tm_borders(col = "grey25", alpha = 0.3) +
#             tm_layout(frame = FALSE, legend.title.size = 0.9, legend.outside = TRUE),
#           filename = paste0('Demographics_',shapetoFetch[i],"_",yeartoFetch,".png"))


# "DP05_0037","DP05_0038", "DP05_0071",
# "DP05_0005","DP05_0006","DP05_0007","DP05_0008",
# "DP05_0009","DP05_0010","DP05_0011","DP05_0029",
# "DP02_0058","DP02_0066","DP02_0070","DP02_0071")
#  