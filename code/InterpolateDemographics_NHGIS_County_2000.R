
# Libraries
library(dplyr)
library(stringr)
library(tidycensus)
library(sf)

# If running in RStudio, uncomment this
setwd(getSrcDirectory(function(){})[1])


# Import Data
print("Loading data!")
cnty_full_data <- read.csv('../data_raw/nhgis/2000/nhgis0022_ds146_2000_county.csv')
cnty_sample_data <- read.csv('../data_raw/nhgis/2000/nhgis0022_ds151_2000_county.csv')
trct_demos <- read.csv('../data_raw/nhgis/2000/nhgis0020_ds146_2000_tract.csv')
cnty2000 <- st_read('../data_raw/nhgis/geometryFiles/2000/US_county_2000.shp')
cnty2010 <- st_read('../data_raw/nhgis/geometryFiles/2010/US_county_2010.shp')
trct2000 <- st_read('../data_raw/nhgis/geometryFiles/2000/US_tract_2000.shp') 

cnty_data <- cnty_sample_data |>
  select(GISJOIN, GKT001, GKT003, GKT005,
         GKT007,  GKT009, GKT011, GKT013,
         GKT015,  GKT017, GKT019, GKT021,
         GKT023,  GKT025, GKT027, GKT029,
         GKT031,  GKT002, GKT004, GKT006,
         GKT008,  GKT010, GKT012, GKT014,
         GKT016,  GKT018, GKT020, GKT022,
         GKT024,  GKT026, GKT028, GKT030,
         GKT032,  GLD001) |>
  merge(cnty_full_data, by='GISJOIN')

cnty_data <- cnty_data |>
  rename(
    whitePop   = FMR001, blackPop   = FMR002, amIndPop   = FMR003, asianPop    = FMR004,
    pacIsPop   = FMR005, mAgeUnd5   = FMZ001, mAgeUnder5 = FMZ001,  mAge5_9    = FMZ002,
    mAge10_14  = FMZ003, mAge15_17  = FMZ004, mAge18_19  = FMZ005,  mAge20     = FMZ006,
    mAge21     = FMZ007, mAge22_24  = FMZ008, mAge25_29  = FMZ009,  mAge30_34  = FMZ010,
    mAge35_39  = FMZ011, mAge40_44  = FMZ012, mAge45_49  = FMZ013,  mAge50_54  = FMZ014,
    mAge55_59  = FMZ015, mAge60_61  = FMZ016, mAge62_64  = FMZ017,  mAge65_66  = FMZ018,
    mAge67_69  = FMZ019, mAge70_74  = FMZ020, mAge75_79  = FMZ021,  mAge80_84  = FMZ022,
    mAgeOver85 = FMZ023, fAgeUnder5 = FMZ024, fAge5_9    = FMZ025,  fAge10_14  = FMZ026,
    fAge15_17  = FMZ027, fAge18_19  = FMZ028, fAge20     = FMZ029,  fAge21     = FMZ030,
    fAge22_24  = FMZ031, fAge25_29  = FMZ032, fAge30_34  = FMZ033,  fAge35_39  = FMZ034,
    fAge40_44  = FMZ035, fAge45_49  = FMZ036, fAge50_54  = FMZ037,  fAge55_59  = FMZ038,
    fAge60_61  = FMZ039, fAge62_64  = FMZ040, fAge65_66  = FMZ041,  fAge67_69  = FMZ042,
    fAge70_74  = FMZ043, fAge75_79  = FMZ044, fAge80_84  = FMZ045,  fAgeOver85 = FMZ046,
    mNoSchool  = GKT001, m0_4       = GKT002, m5_6       = GKT003,   m7_8      = GKT004,
    m9         = GKT005, m10        = GKT006, m11        = GKT007,   m12       = GKT008,
    mHS        = GKT009, mLtlClg    = GKT010, mSmClg     = GKT011,   mAss      = GKT012,
    mBach      = GKT013, mMas       = GKT014, mProf      = GKT015,   mDoc      = GKT016,
    fNoSchool  = GKT017, f0_4       = GKT018, f5_6       = GKT019,   f7_8      = GKT020,
    f9         = GKT021, f10        = GKT022, f11        = GKT023,   f12       = GKT024,
    fHS        = GKT025, fLtlClg    = GKT026, fSmClg     = GKT027,   fAss      = GKT028,
    fBach      = GKT029, fMas       = GKT030, fProf      = GKT031,   fDoc      = GKT032,
    disPop     = GLD001, totPop     = FL5001, hispPop    = FMC001)

cnty_data <- cnty_data |>
  mutate(
    noHSDeg = mNoSchool + m0_4 + m5_6 + m7_8 + m9 + m10 + m11 + m12 +
               fNoSchool + f0_4 + f5_6 + f7_8 + f9 + f10 + f11 + f12,
    edSmpl  = (mNoSchool + fNoSchool + m0_4 + f0_4 + m5_6 + f5_6 + m7_8 + f7_8 + 
                 m9 + f9 + m10 + f10 + m11 + f11 + m12 + f12 + mHS + fHS +
                 mLtlClg + fLtlClg + mSmClg + fSmClg + mAss + fAss + mBach + 
                 fBach + mMas + fMas + mProf + fProf + mDoc + fDoc),
    age18_64 = mAge18_19 + mAge20 + mAge21 + mAge22_24 + mAge25_29 + mAge30_34 +
                mAge35_39 + mAge40_44 + mAge45_49 + mAge50_54 + mAge55_59 + mAge60_61 +
                mAge62_64 + fAge18_19 + fAge20 + fAge21 + fAge22_24 + fAge25_29 +
                fAge30_34 + fAge35_39 + fAge40_44 + fAge45_49 + fAge50_54 + fAge55_59 +
                fAge60_61 + fAge62_64, 
    age0_4   = mAgeUnder5 + fAgeUnder5,
    age5_14  = mAge5_9 + mAge10_14 + fAge5_9 + fAge10_14,
    age15_19 = mAge15_17 + fAge15_17 + mAge18_19 + fAge18_19,
    age20_24 = mAge20 + mAge21 + mAge22_24 + fAge20 + fAge21 + fAge22_24,
    age15_44 = mAge15_17 + mAge18_19 + mAge20 + mAge21 + mAge22_24 + mAge25_29 +
                mAge30_34 + mAge35_39 + mAge40_44 + fAge15_17 + fAge18_19 + fAge20 +
                fAge21 + fAge22_24 + fAge25_29 + fAge30_34 + fAge35_39 + fAge40_44,
    age45_49 = mAge45_49 + fAge45_49,
    age50_54 = mAge50_54 + fAge50_54,
    age55_59 = mAge55_59 + fAge55_59,
    age60_64 = mAge60_61 + mAge62_64 + fAge60_61 + fAge62_64,
    ageOv65  = mAge65_66 + mAge67_69 + mAge70_74 + mAge75_79 + mAge80_84 +
                mAgeOver85 + fAge65_66 + fAge67_69 + fAge70_74 + fAge75_79 + fAge80_84 +
                fAgeOver85          
  ) |>
  select(
    GISJOIN, totPop, age18_64, age0_4, age5_14, age15_19, age20_24, age15_44, age45_49, 
    age50_54, age55_59, age60_64, ageOv65, hispPop, whitePop, blackPop, 
    amIndPop, asianPop, pacIsPop, noHSDeg, edSmpl, disPop
  )

cnty2000 <- cnty2000 |>
  merge(cnty_data, by='GISJOIN') |>
  st_transform(st_crs(cnty2010))

pop_weights <- trct2000 |>
  merge(trct_demos, by="GISJOIN") |>
  select(GISJOIN, FL5001) |>
  rename(totPop = FL5001) |>
  st_transform(st_crs(cnty2010))

cnty2000_on_2010 <- interpolate_pw(
  from = cnty2000,
  to = cnty2010,
  to_id = 'GEOID10',
  extensive = TRUE,
  weights = pop_weights,
  weight_column = 'totPop',
  weight_placement = 'surface'
)

cnty2000_on_2010 <- cnty2000_on_2010 |>
  rename(GEOID = GEOID10) |>
  filter(substr(GEOID, start=1, stop=2) !="72") |>
  st_drop_geometry()

write.csv(
  cnty2000_on_2010, 
  "../data_raw/nhgis/2000DataInterpolatedCounty.csv", row.names=FALSE
  )
