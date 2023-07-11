
# Libraries
library(dplyr)
library(stringr)
library(tidycensus)
library(sf)

# If running in RStudio, uncomment this
setwd(getSrcDirectory(function(){})[1])


# Import Data
print("Loading data!")
cnty_full_data <- read.csv('../data_raw/nhgis/1990/nhgis0022_ds120_1990_county.csv')
cnty_sample_data <- read.csv('../data_raw/nhgis/1990/nhgis0022_ds123_1990_county.csv')
trct_demos <- read.csv('../data_raw/nhgis/1990/nhgis0020_ds120_1990_tract.csv')
cnty1990 <- st_read('../data_raw/nhgis/geometryFiles/1990/US_county_1990.shp')
cnty2010 <- st_read('../data_raw/nhgis/geometryFiles/2010/US_county_2010.shp')
trct1990 <- st_read('../data_raw/nhgis/geometryFiles/1990/US_tract_1990.shp') 

# Transform
cnty_data <- cnty_sample_data |>
  select(GISJOIN, E33001, E33002, E33003, E33004, E33005, E33006, E33007) |>
  merge(cnty_full_data, by='GISJOIN')
  
cnty_data <- cnty_data |>
  rename(
    whitePop          = EUZ001, blackPop            = EUZ002,
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
    otherMcrnsnRcePop = EUZ025, totPop              = ET1001,
    notHisp           = EU1001, mexicanHisp         = EU1002,
    prHisp            = EU1003, cubanHisp           = EU1004,
    otherHisp         = EU1005, ageUnd1             = ET3001,
    age1_2            = ET3002, age3_4              = ET3003,
    age5              = ET3004, age6                = ET3005,
    age7_9            = ET3006, age10_11            = ET3007,
    age12_13          = ET3008, age14               = ET3009,
    age15             = ET3010, age16               = ET3011,
    age17             = ET3012, age18               = ET3013,
    age19             = ET3014, age20               = ET3015,
    age21             = ET3016, age22_24            = ET3017,
    age25_29          = ET3018, age30_34            = ET3019,
    age35_39          = ET3020, age40_44            = ET3021,
    age45_49          = ET3022, age50_54            = ET3023,
    age55_59          = ET3024, age60_61            = ET3025,
    age62_64          = ET3026, age65_69            = ET3027,
    age70_74          = ET3028, age75_79            = ET3029,
    age80_84          = ET3030, ageOver85           = ET3031, 
    noHS              = E33001, hsNoGrad            = E33002, 
    hsOrEquiv         = E33003, collegeNoGrad       = E33004, 
    associates        = E33005, bachelors           = E33006, 
    graduateDeg       = E33007
    )

cnty_data <- cnty_data |>
  mutate(
    noHighSchoolDeg = noHS + hsNoGrad,
    edSampl         = noHS + hsNoGrad + hsOrEquiv + collegeNoGrad + associates + bachelors + graduateDeg,
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
    totPop   = totPop
  )


cnty1990 <- cnty1990 |> 
  merge(cnty_data, by='GISJOIN') |>
  st_transform(st_crs(cnty2010)) |>
  select(GISJOIN,
         age18_64, age0_4,   age5_14,  age15_19, 
         age20_24, age15_44, age45_49, age50_54, 
         age55_59, age60_64, agOver65, whitePop, 
         blackPop, hispPop,  amIndPop, asianPop, 
         pacIsPop, totPop,   noHighSchoolDeg,
         edSampl)

# Make population weights
pop_weights <- trct1990 |>
  merge(trct_demos, by='GISJOIN') |>
  select(GISJOIN, ET1001) |>
  rename(totPop = ET1001) |>
  st_transform(st_crs(cnty2010))

# Interpolate
print('Interpolating!')
cnty1990_on_2010 <- interpolate_pw(
  from = cnty1990,
  to = cnty2010,
  to_id = 'GEOID10',
  extensive = TRUE,
  weights = pop_weights,
  weight_column = 'totPop',
  weight_placement = 'surface') |>
  st_drop_geometry() |>
  filter(substr(GEOID10, start=1, stop=2) != "72") |>
  rename(GEOID = GEOID10)

print("Saving!")
write.csv(cnty1990_on_2010, "../data_raw/nhgis/1990InterpolatedCounties.csv", row.names=FALSE)


