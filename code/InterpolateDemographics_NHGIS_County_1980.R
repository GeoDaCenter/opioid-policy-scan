# Author: Ashlynn Wimer
# Date: July 11th, 2023
# About: This R Script takes in 1980 county level census data and runs a population
# weighted interpolation using tidycensus::interpolate_pw to transform them to
# 2010 county shapes. The population weights used are at the 1980 county
# subdivision level. 

# Libraries
library(dplyr)
library(stringr)
library(tidycensus)
library(sf)

# If running in RStudio, uncomment this
# setwd(getSrcDirectory(function(){})[1])


# Import Data
print("Loading data!")
cnty_full_data <- read.csv('../data_raw/nhgis/1980/nhgis0022_ds104_1980_county.csv')
cnty_sample_data <- read.csv('../data_raw/nhgis/1980/nhgis0022_ds107_1980_county.csv')
cntySbdv_pop_data <- read.csv('../data_raw/nhgis/1980/nhgis0027_ds104_1980_cty_sub.csv')
cnty1980 <- st_read('../data_raw/nhgis/geometryFiles/1980/US_county_1980_conflated.shp')
cnty2010 <- st_read('../data_raw/nhgis/geometryFiles/2010/US_county_2010.shp')
cntySbdv1980 <- st_read('../data_raw/nhgis/geometryFiles/1980/US_mcd_1980.shp')


# Transform Data
print("Transforming Data!")
cnty_data <- cnty_sample_data |>
  select(GISJOIN, DHM001, DHM002, DHM003, DHM004, DHM005) |>
  merge(cnty_full_data, by="GISJOIN")
names(cnty_full_data)
cnty_data <- cnty_data |>
  rename(
    ageUnd1     = C67001, age1_2         = C67002,
    age3_4      = C67003, age5           = C67004,
    age6        = C67005, age7_9         = C67006,
    age10_13    = C67007, age14          = C67008,
    age15       = C67009, age16          = C67010,
    age17       = C67011, age18          = C67012,
    age19       = C67013, age20          = C67014,
    age21       = C67015, age22_24       = C67016, 
    age25_29    = C67017, age30_34       = C67018, 
    age35_44    = C67019, age45_54       = C67020,
    age55_59    = C67021, age60_61       = C67022, 
    age62_64    = C67023, age65_74       = C67024, 
    age75_84    = C67025, ageOv85        = C67026,
    notHispPop  = C9E001, mexicanPop     = C9E002, 
    prPop       = C9E003, cubanPop       = C9E004,
    otherHisp   = C9E005, whitePop       = C9D001, 
    blackPop    = C9D002, contigAmIndPop = C9D003, 
    inuitPop    = C9D004, unanganPop     = C9D005, 
    japanesePop = C9D006, chinesePop     = C9D007, 
    filipinoPop = C9D008, koreanPop      = C9D009, 
    indianPop   = C9D010, vietnamesePop  = C9D011, 
    hawaiinPop  = C9D012, guamanianPop   = C9D013, 
    samoanPop   = C9D014, otherPop       = C9D015,
    totPop      = C7L001, elementary     = DHM001,
    hghschl1_3  = DHM002, hghschl4       = DHM003,
    college1_3  = DHM004, college4orMore = DHM005)

cnty_data <- cnty_data |>
  mutate(
    age0_4   = ageUnd1  + age1_2   + age3_4,
    age5_14  = age5     + age6     + age7_9    + age10_13 + age14,
    age18_64 = age18    + age19    + age20     + age21    + age22_24 + age25_29 + age30_34 + age35_44 + age45_54 + age55_59 + age60_61 + age62_64,
    age15_19 = age15    + age16    + age17     + age18    + age19,
    age20_24 = age20    + age21    + age22_24,
    age15_44 = age15    + age16    + age17     + age18    + age19 + age20 + age21 + age22_24 + age25_29 + age30_34 + age35_44,
    age55_59 = age55_59,
    age60_64 = age60_61 + age62_64,
    ageOv65  = age65_74 + age75_84 + ageOv85,
    hispPop  = mexicanPop + prPop + cubanPop + otherHisp,
    amIndPop = contigAmIndPop + inuitPop + unanganPop,
    asianPop = japanesePop + chinesePop + filipinoPop + koreanPop + indianPop + vietnamesePop,
    pacIsPop = hawaiinPop + guamanianPop + samoanPop,
    NoHSPop  = elementary + hghschl1_3,
    edSampl = elementary + hghschl1_3 + hghschl4 + college1_3 + college4orMore
  )

cnty_data <- cnty_data |>
  select(GISJOIN, STATEA, COUNTYA, 
         age18_64, age0_4, age5_14, age15_19, age20_24, 
         age15_44, age55_59, age60_64, ageOv65, hispPop, 
         amIndPop, asianPop, pacIsPop, totPop, whitePop, 
         blackPop, NoHSPop, edSampl) 

cnty1980 <- cnty1980 |>
  merge(cnty_data, by="GISJOIN") |>
  st_transform(st_crs(cnty2010))

print("Final preparation before interpolating..")
cnty2010$GEOID <- paste(
  str_pad(cnty2010$STATEFP10, width=2, side='left', pad='0'),
  str_pad(cnty2010$COUNTYFP10, width=3, side='left', pad='0'),
  sep='0'
  )

cnty2010 <- cnty2010 |>
  select(GISJOIN, GEOID, NAME10)

# Create population weights
pop_weights <- cntySbdv1980 |>
  merge(cntySbdv_pop_data, by='GISJOIN') |>
  st_transform(st_crs(cnty2010)) |>
  rename(totPop = C7L001)

# Run the interpolation algorithm
print("Interpolating!")
cnty1980_on_2010 <- interpolate_pw(
  from = cnty1980,
  to = cnty2010,
  to_id = 'GEOID',
  extensive = T,
  weights = pop_weights,
  weight_column = 'totPop',
  weight_placement = 'surface'
)

# Filter out PR data
# Alaska NAs are left in for posterity.
cnty1980_on_2010 <- cnty1980_on_2010 |> 
  filter(substr(GEOID, start=1, stop=2) != "72") |>
  st_drop_geometry()

# Save
write.csv(cnty1980_on_2010, "../data_raw/nhgis/1980InterpolatedDataCounty.csv")