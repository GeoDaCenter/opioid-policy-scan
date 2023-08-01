# Author : Ashlynn Wimer
# Date : July 5th, 2023
# About : This R script takes in interpolated tract level data from prior
# scripts and then transforms them into the final DS01 table.

# Libraries
library(dplyr)
library(stringr)

### 1980 Data ###
# Load data
tract_1980_2010 <- read.csv("../data_raw/nhgis/1980DataInterpolated.csv")

# Transform
tract_1980_2010 <- tract_1980_2010 |>
  mutate(
    Age15_24P = round(100 * (age15_19 + age20_24) / totPop, 2),
    Und45P    = round(100 * (age0_4 + age5_14 + age15_44) / totPop, 2),
    Ovr65P    = round(100 * (ageOv65 / totPop ), 2),
    WhiteP    = round(100 * (whitePop / totPop), 2),
    BlackP    = round(100 * (blackPop / totPop), 2),
    HispP     = round(100 * (hispPop / totPop ), 2),
    AmIndP    = round(100 * (amIndPop / totPop), 2),
    AsianP    = round(100 * (asianPop / totPop), 2),
    PacIsP    = round(100 * (pacIsPop / totPop), 2),
    OtherP    = round(100 * (totPop - whitePop - blackPop - amIndPop - asianPop - pacIsPop) / totPop, 2),
    NoHSP     = round(100 * (noHSPop) / (edSampl), 2),
    totPop    = round(totPop, 2),
    age18_64  = round(age18_64, 2),
    age0_4    = round(age0_4, 2),
    age5_14   = round(age5_14, 2),
    age15_19  = round(age15_19, 2),
    age20_24  = round(age20_24, 2),
    age15_44  = round(age15_44, 2),
    age55_59  = round(age55_59, 2),
    age60_64  = round(age60_64, 2),
    ageOv65   = round(ageOv65, 2)
  ) |>
  select(
    FIPS,     totPop,   age18_64, age0_4, 
    age5_14,  age15_19, age20_24, age15_44, 
    age55_59, age60_64, ageOv65,  Age15_24P, 
    Und45P,   Ovr65P,   WhiteP,   BlackP, 
    HispP,    AmIndP,   AsianP,   PacIsP, 
    OtherP,   NoHSP
    )

# Save to file
write.csv(tract_1980_2010, "../data_final/DS01_T_1980_NHGIS.csv", row.names=FALSE)

### 1990 Data ###
# Load data
tract_1990_2010 <- read.csv("../data_raw/nhgis/1990DataInterpolated.csv")

# Transform
## DisbP is excluded due to a lack of comparability.
tract_1990_2010 <- tract_1990_2010 |>
  mutate(
    Age15_24P = round(100 * (age15_19 + age20_24) / totPop, 2), 
    Und45P    = round(100 * (age0_4 + age5_14 + age15_44) / totPop, 2),
    Ovr65P    = round(100 * (agOver65) / totPop, 2),
    WhiteP    = round(100 * (whitePop / totPop), 2),
    BlackP    = round(100 * (blackPop / totPop), 2),
    HispP     = round(100 * (hispPop / totPop), 2),
    AmIndP    = round(100 * (amIndPop / totPop), 2),
    AsianP    = round(100 * (asianPop / totPop), 2),
    PacIsP    = round(100 * (pacIsPop / totPop), 2),
    OtherP    = round(100 * (totPop - whitePop - blackPop - amIndPop - asianPop - pacIsPop) / totPop, 2),
    NoHSP     = round(100 * (noHighSchoolDeg) / (edSampl), 2),
    totPop    = round(totPop, 2),
    age18_64  = round(age18_64, 2),
    age0_4    = round(age0_4, 2),
    age5_14   = round(age5_14, 2),
    age15_19  = round(age15_19, 2),
    age45_49  = round(age45_49, 2),
    age20_24  = round(age20_24, 2),
    age50_54  = round(age50_54, 2),
    age15_44  = round(age15_44, 2),
    age55_59  = round(age55_59, 2),
    age60_64  = round(age60_64, 2),
    agOver65  = round(agOver65, 2)
  ) |>
  select(
    FIPS,      totPop,   age18_64, age0_4, 
    age5_14,   age15_19, age20_24, age15_44, 
    age45_49,  age50_54, age55_59, age60_64, 
    agOver65,  Age15_24P, Und45P,   Ovr65P,   
    WhiteP,    BlackP,    HispP,    AmIndP,   
    AsianP,    PacIsP,    OtherP,   NoHSP
  )

# Save
write.csv(tract_1990_2010, "../data_final/DS01_T_1990_NHGIS.csv")

### 2000 Data ###
# Load data
tract_2000_2010 <- read.csv("../data_raw/nhgis/2000DataInterpolated.csv")

# Transform into DS01 variables
tract_2000_2010 <- tract_2000_2010 |>
  mutate(
    Age15_24P = round(100 * (age15_19 + age20_24) / totPop, 2), 
    Und45P    = round(100 * (age0_4 + age5_14 + age15_44) / totPop, 2),
    Ovr65P    = round(100 * (agOver65) / totPop, 2),
    WhiteP    = round(100 * (whitePop / totPop), 2),
    BlackP    = round(100 * (blackPop / totPop), 2),
    HispP     = round(100 * (hispPop / totPop), 2),
    AmIndP    = round(100 * (amIndPop / totPop), 2),
    AsianP    = round(100 * (asianPop / totPop), 2),
    PacIsP    = round(100 * (pacIsPop / totPop), 2),
    OtherP    = round(100 * (totPop - whitePop - blackPop - amIndPop - asianPop), 2),
    NoHSP     = round(100 * (NoHSDeg) / (edSmpl), 2),
    DisbP     = round(100 * (disPop) / (totPop - age0_4)),
    totPop    = round(totPop, 2),
    age18_64  = round(age18_64, 2),
    age0_4    = round(age0_4, 2),
    age5_14   = round(age5_14, 2),
    age15_19  = round(age15_19, 2),
    age45_49  = round(age45_49, 2),
    age20_24  = round(age20_24, 2),
    age50_54  = round(age50_54, 2),
    age15_44  = round(age15_44, 2),
    age55_59  = round(age55_59, 2),
    age60_64  = round(age60_64, 2),
    agOver65  = round(agOver65, 2)
  ) |>
  select(
    FIPS,      totPop,   age18_64, age0_4, 
    age5_14,   age15_19, age20_24, age15_44, 
    age45_49,  age50_54, age55_59, age60_64, 
    agOver65,  Age15_24P, Und45P,   Ovr65P,   
    WhiteP,    BlackP,    HispP,    AmIndP,   
    AsianP,    PacIsP,    OtherP,   NoHSP,    
    DisbP
  )

write.csv(tract_2000_2010, "../data_final/DS01_T_2000_NHGIS.csv")
