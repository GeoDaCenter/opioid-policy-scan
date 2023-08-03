# Author: Ashlynn Wimer
# Date: 7/31/2023
# About: This script merges the zip level files to create a large zip data frame.


### Libraries

library(stringr)
library(dplyr)

## Uncomment if running in RStudio
# setwd(getSrcDirectory(function(){})[1])


### Prepare the starting table

zipDf <- sf::st_read("../data_final/geometryFiles/zcta/zctas2018.shp") |>
  sf::st_drop_geometry() |>
  select(G_ZCTA, GEOID)

### Demographics

## DS01

# 33120 zips, we expected 32990
# Missing ZIPs appear to belong primarily to PR.
# Additionally, this reveals that our shapefile contains
# 96799, which appears to belong to American Samoa. 
# We keep that ZIP for now but may remove it in a later 
# version of this script.

ds01 <- read.csv("../data_final/DS01_Z.csv") |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-year, -ZCTA, -G_ZCTA) |>
  mutate(childP = (totPopE - age18_64 - ageOv65) / totPopE)

zipDf <- zipDf |> merge(ds01, by='GEOID', all.x = TRUE)

rm(ds01)

## DS03

# 39121 ZIPs found, we expected 32990. 
# The missing ZIPs are usually populated, and appear to have
# resulted from a bad CW.
# Over 102 zips are also in zipDf but missing from DS03,
# so in a sense we have 16% data loss. 
ds03 <- read.csv("../data_final/DS03_Z.csv") |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZIP, -ZCTA)

zipDf <- zipDf |> merge(ds03, by='GEOID', all.x = TRUE)

rm(ds03)

## DS04

# 32982 found, 32990 expected.
# 131 zips in the DS04_Z table are due to Puerto Rico
# 139 zips in the ZipDf table not in DS04_Z are in a variety of places,
# including Pennsylvania.
ds04 <- read.csv('../data_final/DS04_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(totVetPop = TotalVetPop, VetPercent, GEOID)

zipDf <- zipDf |> merge(ds04, by='GEOID', all.x = TRUE)

rm(ds04)

## DS05

# 33120 zips found, 32990 expected
# Additional zips appaer to be primarily due to PR
# American Samoa strikes again in zipDf.
ds05 <- read.csv('../data_final/DS05_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, totalP_hh, nonRel_fhhR, nonRel_nfhhR)

zipDf <- zipDf |> merge(ds05, by='GEOID', all.x = TRUE)

rm(ds05)

## DS06

# 32990 found, 32990 expected!!
ds06 <- read.csv("../data_final/DS06_Z.csv") |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, BED_COUNT, POINT_IN_TIME, YEARLY_BED_COUNT)


zipDf <- zipDf |> merge(ds06, by='GEOID')

rm(ds06)

### Economic

## EC01

# 33120 found, 32990 expected
# Missing in ec01 appears to be due to PR
# American Samoa strikes again. 
ec01 <- read.csv('../data_final/EC01_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZCTA, -year)

zipDf <- zipDf |> merge(ec01, by='GEOID', all.x = TRUE)

rm(ec01)

## EC02

# 33120 found, 32990 expected
# Same issues as EC01.
ec02 <- read.csv('../data_final/EC02_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZCTA, -year)

zipDf <- zipDf |> merge(ec02, by='GEOID', all.x = TRUE)

rm(ec02)

## EC03

# 33120 found, 32990 expected
# Same issues as EC01.
ec03 <- read.csv('../data_final/EC03_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZCTA, -year)

zipDf <- zipDf |> merge(ec03, by='GEOID', all.x = TRUE)

rm(ec03)

## EC05 

# 33120 found, 32990 expected
# Same issues as above.
ec05 <- read.csv('../data_final/EC05_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-year, -G_ZCTA, -ZCTA)

zipDf <- zipDf |> merge(ec05, by='GEOID', all.x = TRUE)

rm(ec05)

## Additional Economic Data

# 32989 found, 32990 expected
# Missing is American Somoa 
addEcon <- read.csv('../data_raw/additionalEconomicDataZip.csv') |>
  mutate(GEOID = str_pad(GEOID, width=5, side='left', pad='0'))

zipDf <- zipDf |> merge(addEcon, by='GEOID', all.x=TRUE)

rm(addEcon)

### Built Environment

## BE01

# 32989 found, 32990 expected.
# American Samoa is the additional ZIP.
be01 <- read.csv("../data_final/BE01_Z.csv") |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-ZCTA, -G_ZCTA)

zipDf <- zipDf |> merge(be01, by='GEOID', all.x = TRUE)

rm(be01)

## BE02

# 41164 found, 32990 expected. The USDA does *not* play games.
# A good chunk of them are from PR.
# Others are just the USDA being more granular than the CB, seemingly.
# 22 zips from zipDf are not in BE02, so we perform a right merge.
be02 <- read.csv('../data_final/BE02_RUCA_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZCTA)

zipDf <- zipDf |> merge(be02, by='GEOID', all.x = TRUE)

rm(be02)

## BE03

# 32990 found, 32990 expected
be03 <- read.csv('../data_final/BE03_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZCTA, -totPopE)

zipDf <- zipDf |> merge(be03, by='GEOID', all.x = TRUE)

rm(be03)

## BE05

# 39122 found, expected 32990
# Extensive mismatch appears to be due to use a potentially shady crosswalk.
be05 <- read.csv("../data_final/BE05_Z.csv") |>
  mutate(GEOID = str_pad(ZIP, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZIP)

zipDf <- zipDf |> merge(be05, by='GEOID', all.x=TRUE)

rm(be05)

## BE06

# 55053 zips found.
# Appears to be because we have duplicate key variables.
be06 <- read.csv("../data_final/BE06_NDVI_Z.csv") |>
  mutate(GEOID = str_pad(ZIP, width=5, side='left', pad='0')) |>
  select(GEOID, ndvi) |>
  group_by(GEOID) |>
  summarize(mean(ndvi))

zipDf <- zipDf |> merge(be06, by='GEOID', all.x = TRUE)

rm(be06)

### Access variables

# Access02 through Access07 feature 33144 zips when 32990 are expected.
# The excess data in every case is due to Puerto Rico and other territories

## Access01

# 32990 rows, 32990 expected!
access01 <- read.csv("../data_final/Access01_Z.csv") |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(-G_ZCTA, -ZCTA)

zipDf <- zipDf |> merge(access01, by='GEOID', all.x = TRUE)

rm(access01)

## Access02
access02 <- read.csv('../data_final/Access02_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, minDisFQHC, timeDriveFQHC = timeDrive, countDriveFQHC = countDrive)

zipDf <- zipDf |> merge(access02, by='GEOID', all.x = TRUE)

rm(access02)

## Access03
access03 <- read.csv('../data_final/Access03_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, minDisHosp, timeDriveHosp = timeDrive, countDriveHosp = countDrive)

zipDf <- zipDf |> merge(access03, by='GEOID', all.x = TRUE)

rm(access03)

## Access04
access04 <- read.csv('../data_final/Access04_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, minDisRx, timeDriveRx = timeDrive, countDriveRx = countDrive)

zipDf <- zipDf |> merge(access04, by='GEOID', all.x = TRUE)

rm(access04)

## Access05
access05 <- read.csv('../data_final/Access05_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, minDisMH, timeDriveMh = timeDrive, countDriveMh = countDrive)

zipDf <- zipDf |> merge(access05, by='GEOID', all.x = TRUE)

rm(access05)

## Access06
access06 <- read.csv('../data_final/Access06_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, minDisSUT, timeDriveSUT = timeDrive, countDriveSUT = countDrive)

zipDf <- zipDf |> merge(access06, by='GEOID', all.x = TRUE)

rm(access06)

## Access07
access07 <- read.csv('../data_final/Access07_Z.csv') |>
  mutate(GEOID = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  select(GEOID, minDisOTP, countDriveOTP = countDrive, timeDriveOTP = timeDrive)

zipDf <- zipDf |> merge(access07, by='GEOID', all.x = TRUE)

rm(access07)

## Reorder

zipDf <- zipDf |>
  select(GEOID, totPopE, totalP_hh, totVetPop, totUnits, totWrkE, whiteP, 
         blackP, amIndP, asianP, pacIsP, otherP, hispP, childP, 
         a15_24P, und45P, ovr65P, age0_4, age5_14, age15_19, age20_24, 
         age15_44, age45_49, age50_54, age55_59, age60_64, ageOv65, ageOv18, 
         age18_64, disbP, noHSP, VetPercent, nonRel_fhhR, nonRel_nfhhR, BED_COUNT, 
         POINT_IN_TIME, YEARLY_BED_COUNT, unempP, povP, MedInc, pciE, GiniCoeff, 
         eduP, hghRskP, hltCrP, retailP, essnWrkE, essnWrkP, NoIntPct, 
         vacantP, mobileP, lngTermP, rentalP, unitDens, RUCA1, RUCA2, 
         rurality, areaSqMi, alcTotal, alcDens, alcPerCap, dissim.b, inter.bw, 
         iso.b, dissim.h, inter.hw, iso.h, dissim.a, inter.aw, iso.a, 
         `mean(ndvi)`, moudMinDis, bupMinDis, bupTimeDrive, bupCountDrive30, metMinDis, metTimeDrive, 
         metCountDrive30, nalMinDis, nalTimeDrive, nalCountDrive30, bupTimeWalk, bupCountWalk60, bupCountWalk30, 
         metTimeWalk, metCountWalk60, metCountWalk30, nalTimeWalk, nalCountWalk60, nalCountWalk30, bupTimeBike, 
         bupCountBike60, bupCountBike30, metTimeBike, metCountBike60, metCountBike30, nalTimeBike, nalCountBike60, 
         nalCountBike30, minDisFQHC, timeDriveFQHC, countDriveFQHC, minDisHosp, timeDriveHosp, countDriveHosp, 
         minDisRx, timeDriveRx, countDriveRx, minDisMH, timeDriveMh, countDriveMh, 
         minDisSUT, timeDriveSUT, countDriveSUT, minDisOTP, countDriveOTP, timeDriveOTP, SVIS, 
         SVI_THEME1, SVI_THEME2, SVI_THEME3, SVI_THEME4
  )

## Rename

names <- read.csv('../data_raw/rename_tables/zip.csv')

if (all(names(zipDf) == names[,1])) {
  colnames(zipDf) <- names[,2]
} else {
  print("Something is wrong!!!!")
}

## Clean

zipDf <- zipDf |> mutate_if(is.numeric, round, digits=2)

## Save
write.csv(zipDf, "../data_final/consolidated/Z_Latest.csv", row.names=FALSE)
