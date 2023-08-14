
# Author: Ashlynn Wimer
# Date: 8/7/2023
# About: This R script combines the 1990 historic data on 2010 geometries, and aggregates
# from county level to state level.

#### Libraries ----

library(dplyr)
library(stringr)


#### Tracts ----

# Read in data

ds01 <- read.csv('../data_final/DS01_T_1990_NHGIS.csv') |>
  mutate(GEOID = str_pad(FIPS, width=11, side='left', pad='0')) |>
  select(-FIPS)
ec03 <- read.csv('../data_final/EC03_T_1990_DC.csv') |>
  mutate(GEOID = str_pad(FIPS, width=11, side='left', pad='0')) |>
  select(-FIPS, -X, -NAME, -year)
hs01 <- read.csv('../data_final/HS01_T_1990_DC.csv') |>
  mutate(GEOID = str_pad(FIPS, width=11, side='left', pad='0')) |>
  select(-FIPS, -X, -NAME, -year)

ds01 <- ds01 |> 
  mutate(childrenP = round(100 * (totPop - age18_64 - agOver65) / totPop, 2))

tracts <- merge(ds01, ec03, by='GEOID') |>
  merge(hs01, by='GEOID') |>
  select( 
    GEOID,     totPop,   totUnits, age18_64,  age0_4, 
    age5_14,   age15_19, age20_24, age15_44,  age45_49,
    age50_54,  age55_59, age60_64, agOver65,   Age15_24P, 
    Und45P,    Ovr65P,   WhiteP,   BlackP,    HispP,     
    AmIndP,    AsianP,   PacIsP,   OtherP,    NoHSP,     
    childrenP, povP,     UnempP,   occP,      vacantP
  )

names <- read.csv('../data_raw/rename_tables/1990.csv')

if (all(names(tracts) == names[,1])) {
  colnames(tracts) <- names[,2]
} else {
  print("Names are misaligned!!")
}

rm(names)

## Round off counts

tracts <- tracts |> 
  mutate(
    TotPop   = round(TotPop),
    TotUnits = round(TotUnits),
    Age18_64 = round(Age18_64),
    Age0_4   = round(Age0_4),
    Age5_14  = round(Age5_14),
    Age15_19 = round(Age15_19),
    Age20_24 = round(Age20_24),
    Age15_44 = round(Age15_44),
    Age45_49 = round(Age45_49),
    Age50_54 = round(Age50_54),
    Age55_59 = round(Age55_59),
    Age60_64 = round(Age60_64),
    AgeOv65  = round(AgeOv65)
  )

write.csv(tracts, "../data_final/consolidated/T_1990.csv", row.names=F)

rm(tracts)

#### Counties ---- 

ds01 <- read.csv('../data_final/DS01_C_1990_NHGIS.csv') |>
  mutate(GEOID = str_pad(GEOID, width=5, side='left', pad='0'),
         childrenP = round(100 * (totPop - age18_64 - agOver65) / totPop, 2) )
ec03 <- read.csv('../data_final/EC03_C_1990_DC.csv') |>
  mutate(GEOID = str_pad(FIPS, width=5, side='left', pad='0')) |>
  select(-FIPS, -NAME, -year)
hs01 <- read.csv('../data_final/HS01_C_1990_DC.csv') |>
  mutate(GEOID = str_pad(FIPS, width=5, side='left', pad='0')) |>
  select(-FIPS, -NAME, -X, -year)

cnty <- merge(ds01, ec03, by='GEOID') |>
  merge(hs01, by='GEOID') |>
  mutate(
    totPop   = round(totPop),
    totUnits = round(totUnits),
    age18_64 = round(age18_64),
    age0_4   = round(age0_4),
    age5_14  = round(age5_14),
    age15_19 = round(age15_19),
    age20_24 = round(age20_24),
    age15_44 = round(age15_44),
    age45_49 = round(age45_49),
    age50_54 = round(age50_54),
    age55_59 = round(age55_59),
    age60_64 = round(age60_64),
    agOver65  = round(agOver65)
  )

cntySave <- cnty |>
  select( 
    GEOID,     totPop,   totUnits, age18_64, age0_4, 
    age5_14,   age15_19, age20_24, age15_44, age45_49,
    age50_54,  age55_59, age60_64, agOver65, Age15_24P, 
    Und45P,    Ovr65P,   WhiteP,   BlackP,   HispP,
    AmIndP,    AsianP,   PacIsP,   OtherP,   NoHSP,
    childrenP, povP,     UnempP,   occP,     vacantP
  )

names <- read.csv('../data_raw/rename_tables/1990.csv')

if (all(names(cntySave) == names[,1])) {
  colnames(cntySave) <- names[,2]
} else {
  print("Names are misaligned!!")
}

cntySave |> write.csv('../data_final/consolidated/C_1990.csv', row.names=F)

##### States ----

states <- cnty |> mutate(
  STATEFP = substr(GEOID, start=1, stop=2)
) |>
  group_by(STATEFP) |>
  summarize(
    TotPop   = sum(totPop,             na.rm = T),
    TotUnits = sum(totUnits,           na.rm = T),
    Age18_64 = sum(age18_64,           na.rm = T),
    Age0_4   = sum(age0_4,             na.rm = T),
    Age5_14  = sum(age5_14,            na.rm = T),
    Age15_19 = sum(age15_19,           na.rm = T),
    Age20_24 = sum(age20_24,           na.rm = T),
    Age15_44 = sum(age15_44,           na.rm = T),
    Age45_49 = sum(age45_49,           na.rm = T),
    Age50_54 = sum(age50_54,           na.rm = T),
    Age55_59 = sum(age55_59,           na.rm = T),
    Age60_64 = sum(age60_64,           na.rm = T),
    AgeOv65  = sum(agOver65,            na.rm = T),
    WhitePop = sum(totPop * WhiteP,    na.rm = T),
    BlackPop = sum(totPop * BlackP,    na.rm = T),
    HispPop  = sum(totPop * HispP ,    na.rm = T),
    AmIndPop = sum(totPop * AmIndP,    na.rm = T),
    AsianPop = sum(totPop * AsianP,    na.rm = T),
    PacIsPop = sum(totPop * PacIsP,    na.rm = T),
    OtherPop = sum(totPop * OtherP,    na.rm = T),
    NoHSPop  = sum(edSampl * NoHSP,    na.rm = T),
    edSmpl   = sum(edSampl,            na.rm = T),
    PovPop   = sum(povUni * povP,      na.rm = T),
    povUni   = sum(povUni,             na.rm = T),
    UnempPop = sum(labor * UnempP,     na.rm = T),
    labor    = sum(labor,              na.rm = T),
    OccTot   = sum(occP * totUnits,    na.rm = T),
    VacTot   = sum(vacantP * totUnits, na.rm = T)
  ) |>
  mutate(
    Age15_24P = round(100 * (Age15_19 + Age20_24) / TotPop, 2),
    NoHsp     = round(NoHSPop  / edSmpl, 2),
    WhiteP    = round(WhitePop / TotPop, 2),
    BlackP    = round(BlackPop / TotPop, 2),
    HispP     = round(HispPop  / TotPop, 2),
    AmIndP    = round(AmIndPop / TotPop, 2),
    AsianP    = round(AsianPop / TotPop, 2),
    PacIsP    = round(PacIsPop / TotPop, 2),
    OtherP    = round(OtherPop / TotPop, 2),
    Und45P    = round(100 * (Age0_4 + Age5_14 + Age15_44) / (TotPop), 2),
    Ovr65P    = round(100 * (AgeOv65) / TotPop, 2),
    ChildrenP = round(100 * (TotPop - Age18_64 - AgeOv65) / TotPop, 2),
    PovP      = round(PovPop / povUni, 2),
    UnempP    = round(UnempPop / labor, 2),
    OccP      = round(OccTot / TotUnits, 2),
    VacantP   = round(VacTot / TotUnits, 2)
  ) |>
  select(
    STATEFP,   TotPop,   TotUnits, Age18_64,  Age0_4, 
    Age5_14,   Age15_19, Age20_24, Age15_44,  Age45_49,
    Age50_54,  Age55_59, Age60_64, AgeOv65,  Age15_24P, 
    Und45P,    Ovr65P,   WhiteP,   BlackP,   HispP,     
    AmIndP,    AsianP,   PacIsP,   OtherP,   NoHsp,     
    ChildrenP, PovP,     UnempP,   OccP,     VacantP
  )

states |> write.csv("../data_final/consolidated/S_1990.csv", row.names=F)
