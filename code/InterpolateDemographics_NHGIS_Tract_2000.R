# Author : Ashlynn Wimer
# Date : July 5th, 2023
# About : This R script takes four different census datasets on on 2000 Census 
# Tracts, lightly transforms them refactors them, and then interpolates them to 
# 2010 Census tract geometries using Longitudinal Tract Database (LTDB) 
# crosswalk files, and then saves them for later processing.
# The initial census data is from NHGIS IPUMS.

# As this script takes quite a while to fully run, it includes occassional updates
# in the console to help users gauge its progress.

# Libraries
library(dplyr)
library(stringr)

## Uncomment if running this in RStudio.
setwd(getSrcDirectory(function(){})[1])

# Load Data 
print("Loading data!")
crosswalk_00_10 <- read.csv("../data_raw/crosswalk/crosswalk_2000_2010.csv")
tract_2000_pop <- read.csv("../data_raw/nhgis/2000/nhgis0020_ds146_2000_tract.csv")
tract_2000_demos <- read.csv("../data_raw/nhgis/2000/nhgis0013_ds146_2000_tract.csv")
tract_2000_education <- read.csv("../data_raw/nhgis/2000/nhgis0013_ds151_2000_tract.csv")
tract_2000_economic_and_disability <- read.csv("../data_raw/nhgis/2000/nhgis0020_ds151_2000_tract.csv")

print("Transforming initial dataset!")

# Rename and pare down population dataframe.
tract_2000_pop <- tract_2000_pop |>
  rename(totPop = FL5001) |>
  select(GISJOIN, totPop)

# Rename demographic data.
tract_2000_demos <- tract_2000_demos |>
  rename(
    whitePop = FMR001, blackPop = FMR002,
    amIndPop = FMR003, asianPop = FMR004,
    pacIsPop = FMR005) |>
  rename(
    hispPop = FMC001
  ) |>
  rename(
    mAgeUnd5   = FMZ001,
    mAgeUnder5 = FMZ001,  mAge5_9    = FMZ002,
    mAge10_14  = FMZ003,  mAge15_17  = FMZ004,
    mAge18_19  = FMZ005,  mAge20     = FMZ006,
    mAge21     = FMZ007,  mAge22_24  = FMZ008,
    mAge25_29  = FMZ009,  mAge30_34  = FMZ010,
    mAge35_39  = FMZ011,  mAge40_44  = FMZ012,
    mAge45_49  = FMZ013,  mAge50_54  = FMZ014,
    mAge55_59  = FMZ015,  mAge60_61  = FMZ016,
    mAge62_64  = FMZ017,  mAge65_66  = FMZ018,
    mAge67_69  = FMZ019,  mAge70_74  = FMZ020,
    mAge75_79  = FMZ021,  mAge80_84  = FMZ022,
    mAgeOver85 = FMZ023,  fAgeUnder5 = FMZ024,
    fAge5_9    = FMZ025,  fAge10_14  = FMZ026,
    fAge15_17  = FMZ027,  fAge18_19  = FMZ028,
    fAge20     = FMZ029,  fAge21     = FMZ030,
    fAge22_24  = FMZ031,  fAge25_29  = FMZ032,
    fAge30_34  = FMZ033,  fAge35_39  = FMZ034,
    fAge40_44  = FMZ035,  fAge45_49  = FMZ036,
    fAge50_54  = FMZ037,  fAge55_59  = FMZ038,
    fAge60_61  = FMZ039,  fAge62_64  = FMZ040,
    fAge65_66  = FMZ041,  fAge67_69  = FMZ042,
    fAge70_74  = FMZ043,  fAge75_79  = FMZ044,
    fAge80_84  = FMZ045,  fAgeOver85 = FMZ046
  )

# Mutate and pare down demographics data.
tract_2000_demos <- tract_2000_demos |>
  mutate(
    age18_64 = mAge18_19 + mAge20 + mAge21 + mAge22_24 + mAge25_29 + mAge30_34 +mAge35_39 + mAge40_44 + mAge45_49 + mAge50_54 + mAge55_59 + mAge60_61 + mAge62_64 + fAge18_19 + fAge20 + fAge21 + fAge22_24 + fAge25_29 + fAge30_34 + fAge35_39 + fAge40_44 + fAge45_49 + fAge50_54 + fAge55_59 + fAge60_61 + fAge62_64, 
    age0_4   = mAgeUnder5 + fAgeUnder5,
    age5_14  = mAge5_9 + mAge10_14 + fAge5_9 + fAge10_14,
    age15_19 = mAge15_17 + fAge15_17 + mAge18_19 + fAge18_19,
    age20_24 = mAge20 + mAge21 + mAge22_24 + fAge20 + fAge21 + fAge22_24,
    age15_44 = mAge15_17 + mAge18_19 + mAge20 + mAge21 + mAge22_24 + mAge25_29 + mAge30_34 + mAge35_39 + mAge40_44 + fAge15_17 + fAge18_19 + fAge20 + fAge21 + fAge22_24 + fAge25_29 + fAge30_34 + fAge35_39 + fAge40_44,
    age45_49 = mAge45_49 + fAge45_49,
    age50_54 = mAge50_54 + fAge50_54,
    age55_59 = mAge55_59 + fAge55_59,
    age60_64 = mAge60_61 + mAge62_64 + fAge60_61 + fAge62_64,
    ageOv65  = mAge65_66 + mAge67_69 + mAge70_74 + mAge75_79 + mAge80_84 + mAgeOver85 + fAge65_66 + fAge67_69 + fAge70_74 + fAge75_79 + fAge80_84 + fAgeOver85
  ) |>
  select(
    GISJOIN, STATEA, COUNTYA, NAME, TRACTA,
    age18_64, age0_4, age5_14, age15_19, age20_24, age15_44, age45_49, 
    age50_54, age55_59, age60_64, ageOv65, hispPop, whitePop, blackPop, 
    amIndPop, asianPop, pacIsPop
  )

# Rename, mutate, and pare down education data.
tract_2000_education <- tract_2000_education |>
  rename(
    mNoSchool = GKT001, m0_4    = GKT002,
    m5_6      = GKT003, m7_8    = GKT004,
    m9        = GKT005, m10     = GKT006,
    m11       = GKT007, m12     = GKT008,
    mHS       = GKT009, mLtlClg = GKT010,
    mSmClg    = GKT011, mAss    = GKT012,
    mBach     = GKT013, mMas    = GKT014,
    mProf     = GKT015, mDoc    = GKT016,
    fNoSchool = GKT017, f0_4    = GKT018,
    f5_6      = GKT019, f7_8    = GKT020,
    f9        = GKT021, f10     = GKT022,
    f11       = GKT023, f12     = GKT024,
    fHS       = GKT025, fLtlClg = GKT026,
    fSmClg    = GKT027, fAss    = GKT028,
    fBach     = GKT029, fMas    = GKT030,
    fProf     = GKT031, fDoc    = GKT032
  ) |>
  mutate(
    noHSDeg = mNoSchool + m0_4 + m5_6 + m7_8 + m9 + m10 + m11 + m12 + fNoSchool + f0_4 + f5_6 + f7_8 + f9 + f10 + f11 + f12,
    edSmpl  = (mNoSchool + fNoSchool + m0_4 + f0_4 + m5_6 + f5_6 + m7_8 + f7_8 + 
                 m9 + f9 + m10 + f10 + m11 + f11 + m12 + f12 + mHS + fHS +
                 mLtlClg + fLtlClg + mSmClg + fSmClg + mAss + fAss + mBach + 
                 fBach + mMas + fMas + mProf + fProf + mDoc + fDoc)
  ) |>
  select(GISJOIN, noHSDeg, edSmpl)

# Renaem, mutate, and pare down economics data.
tract_2000_economic_and_disability <- tract_2000_economic_and_disability |>
  rename(
    disPop = GLD001, perCapInc = GNW001,
    mUnem  = GLR002, fUnem     = GLR004,
    povPop = GN6001
  ) |>
  mutate(
    unemPop = mUnem + fUnem
  ) |>
  select(GISJOIN, disPop, perCapInc, unemPop, povPop)

# Merge into a large dataframe, and mutate in a FIPS to work with LTDB files.
tracts_2000 <- tract_2000_pop |>
  merge(tract_2000_demos, by="GISJOIN") |>
  merge(tract_2000_education, by="GISJOIN") |>
  merge(tract_2000_economic_and_disability, by='GISJOIN') |>
  mutate(
    FIPS = paste(
      str_pad(STATEA, side='left', width=2, pad='0'), 
      str_pad(COUNTYA, side='left', width=3, pad='0'),
      str_pad(TRACTA, side='left', width=6, pad='0'),
      sep=""
    )
  )

# Prepare crosswalk table keys for compatability with our FIPS.
crosswalk_00_10$trtid00 <- crosswalk_00_10$trtid00 |> str_pad(width = 11, side='left', pad='0')
crosswalk_00_10$trtid10 <- crosswalk_00_10$trtid10 |> str_pad(width = 11, side='left', pad='0')

# Generate an "all 0s" tibble to be updated additively. 
tracts_2010 <- tibble(
  FIPS = unique(crosswalk_00_10$trtid10), totPop = 0,
  age18_64  = 0, age0_4   = 0, age5_14   = 0, age15_19  = 0, 
  age20_24  = 0, age15_44 = 0, age45_49  = 0, age50_54  = 0, 
  age55_59  = 0, age60_64 = 0, agOver65  = 0, whitePop  = 0, 
  blackPop  = 0, hispPop  = 0, amIndPop  = 0, asianPop  = 0, 
  pacIsPop  = 0, NoHSDeg  = 0, disPop    = 0, perCapInc = 0, 
  unemPop   = 0, povPop   = 0, edSmpl    = 0
)

# For every row in the big 2000 tracts df...
for (tracts_2000_row_number in 1:nrow(tracts_2000)) {
  
  # Find all appearances of that row's 2000 FIPS in our crosswalk...
  tract_fips_2000 <- tracts_2000[[tracts_2000_row_number, "FIPS"]]
  rows_where_crosswalk_matches <- which(crosswalk_00_10$trtid00 == tract_fips_2000) # list OR NA
  has_matches <- !(any(is.na(rows_where_crosswalk_matches)))
  
  # Grab the 2010 FIPS associated with the 2000 FIPS...
  if (has_matches) {
    relevant_tract_fips_10 <- crosswalk_00_10[rows_where_crosswalk_matches, "trtid10"]
    
    # For each such 2010 FIPS...
    for (tract_fips_10 in relevant_tract_fips_10) {
      
      # Get the relevant weight and row in tracts_2010...
      weight <- crosswalk_00_10[which(crosswalk_00_10$trtid10 == tract_fips_10 & crosswalk_00_10$trtid00 == tract_fips_2000), "weight"]
      tracts_2010_row <- which(tracts_2010$FIPS == tract_fips_10)
      
      # And update the row's attributes with relevant contributions.
      tracts_2010[tracts_2010_row, ] <- c(
        FIPS     = tracts_2010[tracts_2010_row, "FIPS"],
        totPop   = tracts_2010[tracts_2010_row, "totPop"]   + weight * tracts_2000[tracts_2000_row_number, 'totPop'],
        age18_64 = tracts_2010[tracts_2010_row, "age18_64"] + weight * tracts_2000[tracts_2000_row_number, 'age18_64'],
        age0_4   = tracts_2010[tracts_2010_row, "age0_4"]   + weight * tracts_2000[tracts_2000_row_number, 'age0_4'],
        age5_14  = tracts_2010[tracts_2010_row, "age5_14"]  + weight * tracts_2000[tracts_2000_row_number, 'age5_14'], 
        age15_19 = tracts_2010[tracts_2010_row, "age15_19"] + weight * tracts_2000[tracts_2000_row_number, 'age15_19'], 
        age20_24 = tracts_2010[tracts_2010_row, "age20_24"] + weight * tracts_2000[tracts_2000_row_number, 'age20_24'],
        age15_44 = tracts_2010[tracts_2010_row, "age15_44"] + weight * tracts_2000[tracts_2000_row_number, 'age15_44'],
        age44_49 = tracts_2010[tracts_2010_row, "age45_49"] + weight * tracts_2000[tracts_2000_row_number, 'age45_49'],
        age50_54 = tracts_2010[tracts_2010_row, "age50_54"] + weight * tracts_2000[tracts_2000_row_number, 'age50_54'],
        age55_59 = tracts_2010[tracts_2010_row, "age55_59"] + weight * tracts_2000[tracts_2000_row_number, 'age55_59'],
        age60_64 = tracts_2010[tracts_2010_row, "age60_64"] + weight * tracts_2000[tracts_2000_row_number, 'age60_64'],
        agOver65 = tracts_2010[tracts_2010_row, "agOver65"] + weight * tracts_2000[tracts_2000_row_number, 'ageOv65'], 
        whitePop = tracts_2010[tracts_2010_row, "whitePop"] + weight * tracts_2000[tracts_2000_row_number, 'whitePop'],
        blackPop = tracts_2010[tracts_2010_row, "blackPop"] + weight * tracts_2000[tracts_2000_row_number, 'blackPop'],
        hispPop  = tracts_2010[tracts_2010_row, "hispPop"]  + weight * tracts_2000[tracts_2000_row_number, 'hispPop'],
        amIndPop = tracts_2010[tracts_2010_row, "amIndPop"] + weight * tracts_2000[tracts_2000_row_number, 'amIndPop'], 
        asianPop = tracts_2010[tracts_2010_row, "asianPop"] + weight * tracts_2000[tracts_2000_row_number, 'asianPop'], 
        pacIsPop = tracts_2010[tracts_2010_row, "pacIsPop"] + weight * tracts_2000[tracts_2000_row_number, 'pacIsPop'],
        NoHSDeg  = tracts_2010[tracts_2010_row, "NoHSDeg"]  + weight * tracts_2000[tracts_2000_row_number, 'noHSDeg'],
        disPop   = tracts_2010[tracts_2010_row, 'disPop']   + weight * tracts_2000[tracts_2000_row_number, 'disPop'],
        perCapInc = tracts_2010[tracts_2010_row, "perCapInc"] + weight * tracts_2000[tracts_2000_row_number, 'perCapInc'],
        unemployedPop = tracts_2010[tracts_2010_row, "unemPop"] + weight * tracts_2000[tracts_2000_row_number, 'unemPop'],
        povPop  = tracts_2010[tracts_2010_row, "povPop"] + weight * tracts_2000[tracts_2000_row_number, 'povPop'],
        edSmpl  = tracts_2010[tracts_2010_row, 'edSmpl'] + weight * tracts_2000[tracts_2000_row_number, "edSmpl"]
      )
    }
  }
  
  # Update on progress. 
  if (tracts_2000_row_number %% 1000 == 0) { 
    print(paste("Done with ", tracts_2000_row_number, " tracts!", sep="")) 
  }
}
print("Done interpolating!\nSaving and then done.")

# Save the result.
write.csv(tracts_2010, "../data_raw/nhgis/2000DataInterpolated.csv", row.names=FALSE)

