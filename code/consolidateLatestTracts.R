# Author: Ashlynn Wimer
# Date: July 14th, 2023
# About: This file merges together all 2018 tract level data into a large
# file. Data exploration steps can be found in a seperate RMD.

### Libraries
library(dplyr)
library(stringr)


#setwd(getSrcDirectory(function(){})[1])

## This helper function is used to more concisely clean the GEOID columns,
## as that needs done for essentially every data set loaded.
clean_geoid <- function(df) {
  df$GEOID <- df$GEOID |> str_pad(width=11, side='left', pad='0')
  return(df)
}


### Data Merging

## Demographics

# DS01 has more tracts than our shapefile, but all excess tracts are essentially empty.
tracts_with_shapes <- sf::st_read("../data_final/geometryFiles/tract/tracts2018.shp") |>
  sf::st_drop_geometry() |>
  select(GEOID)
ds01 <- read.csv("../data_final/DS01_T.csv") |> clean_geoid() |>
  select(-G_GEOID, -year)

tractsTable <- ds01 |> filter(GEOID %in% tracts_with_shapes$GEOID)

rm(ds01)
rm(tracts_with_shapes)

# DS02 has fewer tracts than our shapefile due to its focus on the continental
# United States, so we left merge.
ds02 <- read.csv("../data_final/DS02_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
tractsTable <- tractsTable |> merge(ds02, by='GEOID', all=TRUE)

rm(ds02)

# DS03 is perfectly sized and merges cleanly.
ds03 <- read.csv("../data_final/DS03_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
tractsTable <- tractsTable |> merge(ds03, by='GEOID', all=FALSE)

rm(ds03)

# DS04 has a few interesting notes. First, although the OEPS website says that
# the data is from the 2017 ACS, it appears to have been pulled from IPUMS and
# actually correspond to 2018 data. 
# The excess tracts in it correspond to PR tracts and essentially empty tracts.
# The total population tab in it seems to correspond to the total
# civilian population over age 18, meaning that it doesn't quite match other
# total population measures. 
ds04 <- read.csv("../data_final/DS04_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
ds04 <- ds04 |> 
  rename(totCivPopOv18 = TotalPop) |> 
  select(-YEAR, -TRACTCE)

tractsTable <- tractsTable |> merge(ds04, by='GEOID')

rm(ds04)

# DS05 has excess columns, but they are all essentially empty.
# The total population column is also just a repeat of the DS01 column.
ds05 <- read.csv('../data_final/DS05_T.csv') |> clean_geoid() |>
  select(-G_GEOID)
ds05 <- ds05 |> select(-NAME, -totalP)

tractsTable <- tractsTable |> merge(ds05, by='GEOID')

rm(ds05)

# DS06 has excess columns that are all either essentialy empty or from PR.
# Also, oddly, DS05 is missing 75 rows present in the shapefile, so we 
# conduct a left join.
ds06 <- read.csv('../data_final/DS06_T.csv') |> clean_geoid() |>
  select(-G_GEOID)
tractsTable <- tractsTable |> merge(ds06, by='GEOID', all.x = TRUE)

rm(ds06)

## Economics

# EC01 has excess rows which are all essentially empty.
ec01 <- read.csv("../data_final/EC01_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
ec01 <- select(ec01, -year)

tractsTable <- tractsTable |> merge(ec01, by='GEOID')

rm(ec01)

# EC02 has excess rows which are all essentially empty.
ec02 <- read.csv('../data_final/EC02_T.csv') |> clean_geoid() |>
  select(-G_GEOID)
ec02 <- select(ec02, -year)

tractsTable <- tractsTable |> merge(ec02, by='GEOID')

rm(ec02)

# EC03 has excess rows which are all essentially empty.
ec03 <- read.csv("../data_final/EC03_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
ec03 <- select(ec03, -year)

tractsTable <- tractsTable |> merge(ec03, by='GEOID')

rm(ec03)

# EC04 matches our shapefile perfectly.
ec04 <- read.csv("../data_final/EC04_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
ec04 <- select(ec04, -STATEFP, -COUNTYID, -TRACTCE, -ST, -COUNTY)

tractsTable <- tractsTable |> merge(ec04, by='GEOID')

rm(ec04)

# EC05 has excess rows which are all essentially empty. 
# Also, it has a "total" variable which corresponds to total total households. 
ec05 <- read.csv("../data_final/EC05_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
ec05 <- ec05 |> select(-year) |> rename(totHH = total)

tractsTable <- tractsTable |> merge(ec05, by='GEOID')

rm(ec05)

## Physical Environment

# BE01 merges perfectly.
be01 <- read.csv('../data_final/BE01_T.csv') |> clean_geoid() |>
  select(-G_GEOID)

tractsTable <- tractsTable |> merge(be01, by='GEOID')

rm(be01)

# BE02 has 1,190 excess rows. All but 245 are in PR. The remaining 245
# rows appear to be the same rows that most of the above "has excess rows 
# which are essentially empty" datasets are missing, so they likely are not of 
# concern and instead emerge due to the same reason the other excess rows emerge.
be02 <- read.csv('../data_final/BE02_RUCA_T.csv') |> 
  clean_geoid() |>
  select(-G_GEOID)

tractsTable <- tractsTable |> merge(be02, by='GEOID', all.x = TRUE)

rm(be02)

# BE03 has excess rows, which are all essentially empty. Additionally, a few of
# it's non-string rows tend to read in as strings, so we have to convert them
# to numerics. This may result in a warning message about "adding NAs" -- no
# NAs are actually added, with this message instead being triggered by the 
# already present NA values in the columns.
be03 <- read.csv('../data_final/BE03_T.csv') |> 
  clean_geoid() |>
  select(-G_GEOID)
be03$alcDens <- as.numeric(be03$alcDens)
be03$alcPerCap <- as.numeric(be03$alcPerCap)
be03$areaSqMi <- as.numeric(be03$areaSqMi)
be03 <- select(be03, -STATEFP, -COUNTYFP, -TRACTCE, -totPopE)

tractsTable <- tractsTable |> merge(be03, by='GEOID')

rm(be03)

# BE06 has fewer rows than expected. This missing rows appear to belong to multiple
# states, so it is unclear exactly why they are present. We make a left merge anyway.
be06 <- read.csv("../data_final/BE06_NDVI_T.csv") |>
  rename(GEOID = tract_fips) |>
  clean_geoid() |>
  select(-cnty_geoid, -state_fips, -state, -cnty_fips, -X, -county, -G_GEOID)

tractsTable <- tractsTable |> merge(be06, by='GEOID', all.x=TRUE)

rm(be06)

### Access Datasets

# Nearly all of the Access tables have excess rows. They appear to have been introduced
# by the drive time metric calculations, although it is unclear where they 
# correspond to. Some of them are essentially empty, and others have data only 
# from the drive time calculations. 
# We exclude all such rows. 

# Access01
access01 <- read.csv("../data_final/Access01_T.csv") |> clean_geoid() |>
  select(-G_GEOID)
access01 <- access01 |> select(-STATEFP, -COUNTYFP, -TRACTCE)

tractsTable <- tractsTable |> merge(access01, by='GEOID')

rm(access01)

# Access02
access02 <- read.csv("../data_final/Access02_T.csv") |> clean_geoid() |>
  rename(TmDrFQHC = timeDrive,
         CntDrFQHC = countDrive,
         MinDisFQHC = minDisFQHC) |>
  select(-G_GEOID)

tractsTable <- tractsTable |> merge(access02, by='GEOID')

rm(access02)

# Access03
# This is the only table that merges cleanly.
access03 <- read.csv('../data_final/Access03_T.csv') |> clean_geoid() |>
  rename(TmDrHosp = timeDrive,
         CntDrHosp = countDrive,
         MinDisHosp = minDisHosp) |>
  select(-G_GEOID)

tractsTable <- tractsTable |> merge(access03, by='GEOID')

rm(access03)

# Access04
access04 <- read.csv('../data_final/Access04_T.csv') |> clean_geoid() |>
  rename(TmDrRx = timeDrive,
         CntDrRx = countDrive,
         MinDisRx = minDisRx) |>
  select(-G_GEOID)

tractsTable <- tractsTable |> merge(access04, by='GEOID')

rm(access04)

# Access05
access05 <- read.csv("../data_final/Access05_T.csv") |> clean_geoid() |>
  rename(TmDrMH = timeDrive,
         CntDrMH = countDrive,
         MinDisMH = minDisMH) |>
  select(-G_GEOID)

tractsTable <- tractsTable |> merge(access05, by='GEOID')

rm(access05)

# Access06
access06 <- read.csv("../data_final/Access06_T.csv") |> clean_geoid() |>
  rename(TmDrSUT = timeDrive,
         CntDrSUT = countDrive,
         MinDisSUT = minDisSUT) |>
  select(-G_GEOID)

tractsTable <- tractsTable |> merge(access06, by='GEOID')

rm(access06)


# Access07
access07 <- read.csv('../data_final/Access07_T.csv') |> clean_geoid() |>
  rename(TmDrOTP = timeDrive,
         CntDrOTP = countDrive,
         MinDisOTP = minDisOTP)

tractsTable <- tractsTable |> merge(access07, by='GEOID')

rm(access07)

# Health03 has GEOIDs not listed in the larger table, and is missing GEOIDs 
# that are found in the larger table.
# Most but not all of the missing GEOIDs correspond to "all 0s" data.
# We perform a left merge nonetheless.
health03 <- read.csv('../data_final/Health03_T.csv') |> clean_geoid() |>
  select(GEOID, pcp_total, sp_total)

tractsTable <- tractsTable |> merge(health03, by='GEOID', all.x = TRUE)

rm(health03)


# Additional Economic Data
# Has excess data, all of which is essentially 
# empty, so we can safely discard it.
econBonus <- read.csv('../data_raw/additionalEconomicData.csv') |>
  clean_geoid() |>
  select(-NAME)

tractsTable <- merge(tractsTable, econBonus, by='GEOID') 

rm(econBonus)

## SDOH Principal Components

# Has 71901 tracts, fewer than the 72837 in the full table.
# 3 of those tracts do not appear in the full table,
# and 939 of the tracts from the table do not appear in the 
# Principle Components dataset, for a total of 942 missing 
# tracts.

prinComps <- read.csv("../data_raw/us-sdoh-2014-v.csv") |>
  select(GEOID      = tract_fips,
         SocEcAdvIn = X1_SES, 
         LimMobInd  = X2_MOB, 
         UrbCoreInd = X3_URB,
         MicaInd    = X4_MICA) |>
  clean_geoid()

# Left merge in to avoid losing 942 tracts
tractsTable <- merge(tractsTable, prinComps, all.x = TRUE, by='GEOID')

rm(prinComps)


## ZIPS

# We pick a predominant ZIPs based of of the sums of their ratios contributed 
# to the census tract. When multiple ZIPs have equal "fitness" by this measure,
# we pick the first ZIP in the list.

# Future work should revise this to instead look at percent population attributed
# by a ZIP to a given tract.

cw2018 <- readxl::read_excel(path="../data_raw/ZIP_TRACT_122018.xlsx")

# For each tract, pick the zip(s) with the best fitness.
bestFits <- cw2018 |>
  mutate(fit = tot_ratio + bus_ratio + oth_ratio + res_ratio) |>
  group_by(tract) |>
  filter(fit == max(fit)) |>
  filter(tract %in% tractsTable$GEOID)

# For any tract where multiple zips have the best fitness, pick the first ZIP.
firstDupe <- bestFits |> filter(n() > 1) |> slice(1) # pick first of any dupes

# Subset down to only the first dupes.
bestFits <- bestFits |> 
  filter(n() == 1) |>
  rbind(firstDupe) |>
  select(zip, GEOID = tract)

# Merge
tractsTable <- tractsTable |> merge(bestFits, by = 'GEOID')

rm(bestFits)
rm(cw2018)
rm(firstDupe)

### Calculate Additional Variables

# ChildrenP -- percent of population strictly less than 18 years old.
tractsTable <- tractsTable |> 
  mutate(
    ChildrenP = ifelse(is.na(totPopE) | is.na(ageOv18), NA, (totPopE - ageOv18) / totPopE),
    PcpPerPop = (pcp_total / totPopE) * 100000,
    SpPerPop = (sp_total / totPopE) * 100000
  )

### Cleaning variables

# Add final key columns and move them to front
tractsTable <- tractsTable |> mutate(
  STATEFP = substr(GEOID, start=1, stop=2),
  COUNTYFP = substr(GEOID, start=3, stop=5),
  TRACTCE = substr(GEOID, start=6, stop=11)
) |>
  select(
    GEOID, TRACTCE, zip, COUNTYFP, STATEFP, totPopE, totalP_hh, 
    totVetPop = TotalVetPop, totUnits, totWrkE, whiteP, blackP, 
    amIndP, asianP, pacIsP, otherP, hispP, ChildrenP, a15_24P, 
    und45P, ovr65P, age0_4, age5_14, age15_19, age20_24, age15_44, 
    age45_49, age50_54, age55_59, age60_64, ageOv65, ageOv18, 
    age18_64, disbP, noHSP, PctVet, nonRel_fhhR, nonRel_nfhhR, 
    BED_COUNT, POINT_IN_TIME, YEARLY_BED_COUNT, unempP, povP, 
    MedInc, pciE, fordq_rate, fordq_num, GiniCoeff, eduP, hghRskP, 
    hltCrP, retailP, essnWrkE, essnWrkP, NoIntPct, vacantP, 
    mobileP, lngTermP, rentalP, unitDens, RUCA1, RUCA2, 
    rurality, areaSqMi, alcTotal, alcDens, alcPerCap, ndvi, 
    moudMinDis, bupMinDis, bupTimeDrive, bupCountDrive30, 
    metMinDis, metTimeDrive, metCountDrive30, nalMinDis, 
    nalTimeDrive, nalCountDrive30, bupTimeWalk, bupCountWalk60, 
    bupCountWalk30, metTimeWalk, metCountWalk60, metCountWalk30, 
    nalTimeWalk, nalCountWalk60, nalCountWalk30, bupTimeBike, 
    bupCountBike60, bupCountBike30, metTimeBike, metCountBike60,
    metCountBike30, nalTimeBike, nalCountBike60, nalCountBike30, 
    MinDisFQHC, TmDrFQHC, CntDrFQHC, MinDisHosp, TmDrHosp, 
    CntDrHosp, MinDisRx, TmDrRx, CntDrRx, MinDisMH, TmDrMH, 
    CntDrMH, MinDisSUT, TmDrSUT, CntDrSUT, MinDisOTP, TmDrOTP, 
    CntDrOTP, pcp_total, sp_total, PcpPerPop, SpPerPop, SocEcAdvIn, 
    LimMobInd, UrbCoreInd, MicaInd, SDOH, SVIth1, SVIth2, SVIth3, 
    SVIth4, SVIS
  )

# Round all numerics to two decimals
tractsTable <- tractsTable |> mutate_if(is.numeric, round, digits=2)

# Load the names change file
names <- read.csv("../data_raw/rename_tables/tract.csv")

# Check that names and tractsTable are identically ordered and rename
if (all(names(tractsTable) == names[1])) colnames(tractsTable) <- names[[2]] 

# Save the final file!
write.csv(tractsTable, "../data_final/consolidated/T_Latest.csv", row.names=FALSE)
