# Author : Ashlynn Wimer
# Date : July 5th, 2023
# About : This R script will take in four different census datasets on 1990 
# tracts, lightly edit and refactor them, and then use the Longitudinal 
# Tract Database (LTDB) crosswalk files to interpolate them to 2010 tract 
# geometries.  The result is then saved for later use.
# The initial census data is from NHGIS IPUMS

# As this script takes quite a while to fully run, it occassionally provides
# updates in the console. 

# Libraries
library(dplyr)
library(stringr)

## Uncomment if running this in RStudio.
setwd(getSrcDirectory(function(){})[1])

# Load Data 
print("Loading data!")
crosswalk_90_10 <- read.csv("../data_raw/crosswalk/crosswalk_1990_2010.csv")
tract_1990_demos <- read.csv("../data_raw/nhgis/1990/nhgis0020_ds120_1990_tract.csv")
tract_1990_economic <- read.csv("../data_raw/nhgis/1990/nhgis0020_ds123_1990_tract.csv")
tract_1990_education <- read.csv('../data_raw/nhgis/1990/nhgis0013_ds123_1990_tract.csv')

print("Transforming initial dataset!")

# Rename variables to enable easier debugging later on.
tract_1990_demos <- tract_1990_demos |> # race variables 
  rename(whitePop          = EUZ001, blackPop            = EUZ002,
         contigAmIndPop    = EUZ003, inuitPop            = EUZ004,
         unanganPop        = EUZ005, chinesePop          = EUZ006,
         filipinoPop       = EUZ007, japanesePop         = EUZ008,
         indianPop         = EUZ009, koreanPop           = EUZ010,
         vietnamesePop     = EUZ011, cambodianPop        = EUZ012,
         hmongPop          = EUZ013, loatianPop          = EUZ014,
         thaiPop           = EUZ015, otherAsianPop       = EUZ016,
         hawaiinPop        = EUZ017, samoanPop           = EUZ018,
         tonganPop         = EUZ019, otherPlynsnPop      = EUZ020,
         guamianPop        = EUZ021, otherMcrnsnPop      = EUZ022,
         melanesianPop     = EUZ023, unspecPcfcIslndrPop = EUZ024,
         otherMcrnsnRcePop = EUZ025, totPop              = ET1001
         ) |> # ethnicity variables
  rename(notHisp   = EU1001, mexicanHisp = EU1002,
         prHisp    = EU1003, cubanHisp   = EU1004,
         otherHisp = EU1005
         ) |> # age
  rename(ageUnd1   = ET3001, age1_2   = ET3002,
         age3_4    = ET3003, age5     = ET3004,
         age6      = ET3005, age7_9   = ET3006,
         age10_11  = ET3007, age12_13 = ET3008,
         age14     = ET3009, age15    = ET3010,
         age16     = ET3011, age17    = ET3012,
         age18     = ET3013, age19    = ET3014,
         age20     = ET3015, age21    = ET3016,
         age22_24  = ET3017, age25_29 = ET3018,
         age30_34  = ET3019, age35_39 = ET3020,
         age40_44  = ET3021, age45_49 = ET3022,
         age50_54  = ET3023, age55_59 = ET3024,
         age60_61  = ET3025, age62_64 = ET3026,
         age65_69  = ET3027, age70_74 = ET3028,
         age75_79  = ET3029, age80_84 = ET3030,
         ageOver85 = ET3031)

# Education variables
tract_1990_education <- tract_1990_education |>
  rename(
    noHS        = E33001, hsNoGrad      = E33002,
    hsOrEquiv   = E33003, collegeNoGrad = E33004,
    associates  = E33005, bachelors     = E33006,
    graduateDeg = E33007
  ) |> 
  mutate(
    noHighSchoolDeg = noHS + hsNoGrad,
    edSampl         = noHS + hsNoGrad + hsOrEquiv + collegeNoGrad + associates + bachelors + graduateDeg
  ) |>
  select(GISJOIN, noHighSchoolDeg, edSampl)

# Economic variables
tract_1990_economic <- tract_1990_economic |>
  rename(
    unemployedMale = E4I003, unemployedFemale = E4I007,
    povUnder5      = E07013, pov5             = E07014,
    pov6_11        = E07015, pov12_17         = E07016,
    pov18_24       = E07017, pov25_34         = E07018,
    pov35_44       = E07019, pov45_54         = E07020,
    pov55_59       = E07021, pov60_64         = E07022,
    pov65_74       = E07023, povOver75        = E07024,
    perCapInc      = E01001
  ) |>
  mutate(
    unemployedPop = unemployedMale + unemployedFemale,
    poverty = povUnder5 + pov5 + pov6_11 + pov12_17 + pov18_24 + pov25_34 + pov35_44 + pov45_54 + pov55_59 + pov60_64 + pov65_74 + povOver75
  ) |>
  select(GISJOIN, unemployedPop, poverty, perCapInc)

# Merge into a large dataframe 
tracts_1990 <- tract_1990_demos |> 
  merge(tract_1990_education, by = 'GISJOIN') |>
  merge(tract_1990_economic, by = 'GISJOIN')

# Mutate in a new key column to neable crosswalking.
# Special care is taken to avoid an issue arrising from TRACTA ignoring
# the decimal in tractids. 
tracts_1990 <- tracts_1990 |>
  mutate(
    FIPS = paste(
      str_pad(STATEA, side='left', width=2, pad='0'), 
      str_pad(COUNTYA, side='left', width=3, pad='0'),
      ifelse(
        str_detect(ANPSADPI, "\\."), # if it has a decmial
        str_pad(TRACTA, width=6, side='left', pad='0'), # it pads easily
        str_pad( #otherwise, we have to pad with effort
          str_pad(TRACTA, width=4, side='left', pad='0'), 
          width=6, side='right', pad='0')
        ), 
      sep = ""))

# Mutate in final data variables, select only the necessary ones.
tracts_1990 <- tracts_1990 |>
  mutate(
    age18_64 = age18 + age19 + age20 + age21 + age22_24 + age25_29 + age30_34 + age35_39 + age40_44 + age45_49 + age50_54 + age55_59 + age60_61 + age62_64,
    age0_4   = ageUnd1 + age1_2 + age3_4,
    age5_14  = age5 + age6 + age7_9 + age10_11 + age12_13 + age14,
    age15_19 = age15 + age16 + age17 + age18 + age19,
    age20_24 = age20 + age21 + age22_24,
    age15_44 = age15 + age16 + age17 + age18 + age19 + age20 + age21 + age22_24 + age25_29 + age30_34 + age35_39 + age40_44,
    age45_49 = age45_49,
    age50_54 = age50_54,
    age55_59 = age55_59,
    age60_64 = age60_61 + age62_64,
    agOver65 = age65_69 + age70_74 + age75_79 + age80_84 + ageOver85,
    whitePop = whitePop,
    blackPop = blackPop,
    hispPop  = mexicanHisp + cubanHisp + prHisp + otherHisp,
    amIndPop = contigAmIndPop + inuitPop + unanganPop,
    asianPop = chinesePop + filipinoPop + japanesePop + indianPop + koreanPop + vietnamesePop + cambodianPop + hmongPop + loatianPop + thaiPop + otherAsianPop,
    pacIsPop = hawaiinPop + samoanPop + tonganPop + otherPlynsnPop + guamianPop + otherMcrnsnPop + melanesianPop + unspecPcfcIslndrPop + otherMcrnsnRcePop,
    totPop   = totPop,
    noHighSchoolDeg = noHighSchoolDeg
    ) |>
  select(GISJOIN, FIPS,
         age18_64, age0_4,   age5_14,  age15_19, 
         age20_24, age15_44, age45_49, age50_54, 
         age55_59, age60_64, agOver65, whitePop, 
         blackPop, hispPop,  amIndPop, asianPop, 
         pacIsPop, totPop,   noHighSchoolDeg,
         unemployedPop, poverty, perCapInc, edSampl)

print("Interpolating 1990 census tracts to 2010 census tracts!")

# Prepare crosswalk table keys for compatability with our FIPS.
crosswalk_90_10$trtid90 <- crosswalk_90_10$trtid90 |> str_pad(width = 11, side='left', pad='0')
crosswalk_90_10$trtid10 <- crosswalk_90_10$trtid10 |> str_pad(width = 11, side='left', pad='0')
# 01000300105 01003010500
# Generate an "all 0s" tibble to be updated when interpolating.
tracts_2010 <- tibble(
  FIPS = unique(crosswalk_90_10$trtid10), totPop   = 0,
  age18_64 = 0, age0_4   = 0, 
  age5_14  = 0, age15_19 = 0, 
  age20_24 = 0, age15_44 = 0, 
  age45_49 = 0, age50_54 = 0, 
  age55_59 = 0, age60_64 = 0, 
  agOver65 = 0, whitePop = 0, 
  blackPop = 0, hispPop  = 0, 
  amIndPop = 0, asianPop = 0, 
  pacIsPop = 0,  
  noHighSchoolDeg = 0,
  unemployedPop = 0, poverty = 0,
  perCapInc = 0, edSampl = 0
)

# For every row in tracts...
for (tracts_1990_row_number in 1:nrow(tracts_1990)) {
  
  # Find all appearances of that 1990 FIPS in the crosswalk...
  tract_fips_1990 <- tracts_1990[[tracts_1990_row_number, "FIPS"]]
  rows_where_crosswalk_matches <- which(crosswalk_90_10$trtid90 == tract_fips_1990) # list OR NA
  has_matches <- !(any(is.na(rows_where_crosswalk_matches)))
  
  if (!has_matches) {
    print(tracts_1990[tracts_1990_row_number])
  }
  
  # Grab the 2010 FIPS associated with the 1990 FIPS...
  if (has_matches) {
    relevant_tract_fips_10 <- crosswalk_90_10[rows_where_crosswalk_matches, "trtid10"]
    
    # For each such 2010 FIPS...
    for (tract_fips_10 in relevant_tract_fips_10) {
      
      # Get the relevant weight and row in tracts_2010...
      tract_90_weight <- crosswalk_90_10[which(crosswalk_90_10$trtid10 == tract_fips_10 & crosswalk_90_10$trtid90 == tract_fips_1990), "weight"]
      tracts_2010_row <- which(tracts_2010$FIPS == tract_fips_10)
      
      # And update the row's attributes with relevant contributions.
      tracts_2010[tracts_2010_row, ] <- c(
        FIPS     = tracts_2010[tracts_2010_row, "FIPS"],
        totPop   = tracts_2010[tracts_2010_row, "totPop"]   + tract_90_weight * tracts_1990[tracts_1990_row_number, 'totPop'],
        age18_64 = tracts_2010[tracts_2010_row, "age18_64"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age18_64'],
        age0_4   = tracts_2010[tracts_2010_row, "age0_4"]   + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age0_4'],
        age5_14  = tracts_2010[tracts_2010_row, "age5_14"]  + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age5_14'], 
        age15_19 = tracts_2010[tracts_2010_row, "age15_19"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age15_19'], 
        age20_24 = tracts_2010[tracts_2010_row, "age20_24"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age20_24'],
        age15_44 = tracts_2010[tracts_2010_row, "age15_44"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age15_44'],
        age45_49 = tracts_2010[tracts_2010_row, "age45_49"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age45_49'],
        age50_54 = tracts_2010[tracts_2010_row, "age50_54"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age50_54'],
        age55_59 = tracts_2010[tracts_2010_row, "age55_59"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age55_59'],
        age60_64 = tracts_2010[tracts_2010_row, "age60_64"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'age60_64'],
        ageOv65  = tracts_2010[tracts_2010_row, "agOver65"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'agOver65'], 
        whitePop = tracts_2010[tracts_2010_row, "whitePop"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'whitePop'],
        blackPop = tracts_2010[tracts_2010_row, "blackPop"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'blackPop'],
        hispPop  = tracts_2010[tracts_2010_row, "hispPop"]  + tract_90_weight * tracts_1990[tracts_1990_row_number, 'hispPop'],
        amIndPop = tracts_2010[tracts_2010_row, "amIndPop"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'amIndPop'], 
        asianPop = tracts_2010[tracts_2010_row, "asianPop"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'asianPop'], 
        pacIsPop = tracts_2010[tracts_2010_row, "pacIsPop"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'pacIsPop'],
        noHighSchoolDeg = tracts_2010[tracts_2010_row, "noHighSchoolDeg"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'noHighSchoolDeg'],
        unemployedPop = tracts_2010[tracts_2010_row, "unemployedPop"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'unemployedPop'],
        poverty = tracts_2010[tracts_2010_row, "poverty"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'poverty'],
        perCapInc = tracts_2010[tracts_2010_row, "perCapInc"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'perCapInc'],
        edSampl = tracts_2010[tracts_2010_row, "edSampl"] + tract_90_weight * tracts_1990[tracts_1990_row_number, 'edSampl'] 
      )
    }
  }
  
  # Update on progress.
  if (tracts_1990_row_number %% 1000 == 0) { 
    print(paste("Done with ", tracts_1990_row_number, " tracts!", sep="")) 
  }
}

print("Done interpolating!\nSaving and then done.")

# Save
write.csv(tracts_2010, "../data_raw/nhgis/1990DataInterpolated.csv")