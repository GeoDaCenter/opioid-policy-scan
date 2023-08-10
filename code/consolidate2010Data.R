
# Author: Ashlynn Wimer
# Date: 8/9/23
# About: This script pulls and consolidates zip, tract, state, 
# and county level data for the OEPS v2 database. 


##### Libraries -------

library(dplyr)
library(stringr)
library(tidycensus)
library(tidyr)
library(purrr)

##### Variables -------


## Decennial Census Variables --

dc_variables <- c(
  # -------------------- Tot Pop -------------------- #
  'TotPop'    = 'P003001',
  # --------------- Race and Ethnicity -------------- #
  'whitePop'   = 'P003002', 'blackPop'   = 'P003003',
  'amIndPop'   = 'P003004', 'asianPop'   = 'P003005',
  'pacIsPop'   = 'P003006', 'otherPop'   = 'P003007',
  'twoPlsPop'  = 'P003008', 'hispPop'    = 'P011002',
  # ------------------ Age Data --------------------- #
  'ageMl0_4'   = 'P012003', 'ageMl5_9'   = 'P012004',
  'ageMl10_14' = 'P012005', 'ageMl15_17' = 'P012006',
  'ageMl18_19' = 'P012007', 'ageMl20'    = 'P012008',
  'ageMl21'    = 'P012009', 'ageMl22_24' = 'P012010',
  'ageMl25_29' = 'P012011', 'ageMl30_34' = 'P012012',
  'ageMl35_39' = 'P012013', 'ageMl40_44' = 'P012014',
  'ageMl45_49' = 'P012015', 'ageMl50_54' = 'P012016',
  'ageMl55_59' = 'P012017', 'ageMl60_61' = 'P012018',
  'ageMl62_64' = 'P012019', 'ageMl65_66' = 'P012020',
  'ageMl67_69' = 'P012021', 'ageMl70_74' = 'P012022',
  'ageMl75_79' = 'P012023', 'ageMl80_84' = 'P012024',
  'ageMlOv85'  = 'P012025', 'ageFm0_4'   = 'P012027',
  'ageFm5_9'   = 'P012028', 'ageFm10_14' = 'P012029',
  'ageFm15_17' = 'P012030', 'ageFm18_19' = 'P012031',
  'ageFm20'    = 'P012032', 'ageFm21'    = 'P012033',
  'ageFm22_24' = 'P012034', 'ageFm25_29' = 'P012035',
  'ageFm30_34' = 'P012036', 'ageFm35_39' = 'P012037',
  'ageFm40_44' = 'P012038', 'ageFm45_49' = 'P012039',
  'ageFm50_54' = 'P012040', 'ageFm55_59' = 'P012041',
  'ageFm60_61' = 'P012042', 'ageFm62_64' = 'P012043',
  'ageFm65_66' = 'P012044', 'ageFm67_69' = 'P012045',
  'ageFm70_74' = 'P012046', 'ageFm75_79' = 'P012047',
  'ageFm80_84' = 'P012048', 'ageFmOv85'  = 'P012049'
)


acs_variables <- c(
  # --------------- Unemployment ---------------- #
  NMMLFU    = 'B12006_006',  NMMLF  = 'B12006_004',
  NMFLFU    = 'B12006_011',  NMFLF  = 'B12006_009',
  MMLFU     = 'B12006_017',  MMLF   = 'B12006_015',
  MFLFU     = 'B12006_022',  MFLF   = 'B12006_020',
  SMLFU     = 'B12006_028',  SMLF   = 'B12006_026',
  SFLFU     = 'B12006_033',  SFLF   = 'B12006_031',
  WMLFU     = 'B12006_039',  WMLF   = 'B12006_037',
  WFLFU     = 'B12006_044',  WFLF   = 'B12006_042',
  DMLFU     = 'B12006_050',  DMLF   = 'B12006_048',
  DFLFU     = 'B12006_055',  DFLF   = 'B12006_053',
  # ----------------- Income -------------------- #
  pci       = 'B19301_001',  cntPov = 'B06012_002', 
  cntPovUni = 'B06012_001',
  # ---------- Educational Attainment ----------- #
  popOver25 = 'B06009_001',  NoHs   = 'B06009_002',
  # ----------- Veteran Population  ------------- #
  VetUni    = 'B21001_001',  VetPop = 'B21001_002',
  # ---------------- Disability ----------------- #,
  DisbP = 'DP02_0071P'
)

## American Community Survey Variables --

## State FIPS for data pulls --
state_fips <- tigris::fips_codes |>
  filter(! state_code %in% c('60', '72', '66', '69', '78', '74')) |>
  select(state_code) |> unique()

state_fips <- state_fips$state_code

##### Tract -------

## Pull Data ----

ds01_dc <- map_dfr(
  .x = state_fips, 
  ~ get_decennial(
      geography = 'tract', 
      variables = dc_variables, 
      state     = .x,
      sumfile   = 'sf1',
      year      = 2010)
    )

ds01_acs <- map_dfr(
  .x = state_fips,
  ~ get_acs(
    geography = 'tract',
    variables = acs_variables,
    state = .x,
    year=2012
  )
)

## Clean and Mutate Data ----

ds01_dc <- ds01_dc |>
  select(-NAME) |>
  spread(variable, value) |>
  mutate(
    # ------- Age Columns --------- #
    Age0_4   = ageMl0_4 + ageFm0_4,
    Age5_14  = ageMl5_9 + ageFm5_9 + ageMl10_14 + ageFm10_14,
    Age15_19 = ageMl15_17 + ageFm15_17 + ageMl18_19 + ageFm18_19,
    Age20_24 = ageMl20 + ageFm20 + ageMl21 + ageFm21 + ageMl22_24 + ageFm22_24,
    Age15_44 = Age15_19 + Age20_24 + ageMl25_29 + ageFm25_29 + ageMl30_34 + ageFm30_34 +
                ageMl35_39 + ageFm35_39 + ageMl40_44 + ageFm40_44,
    Age45_49 = ageMl45_49 + ageFm45_49,
    Age50_54 = ageMl50_54 + ageFm50_54,
    Age55_59 = ageMl55_59 + ageFm55_59,
    Age60_64 = ageMl60_61 + ageFm60_61 + ageMl62_64 + ageFm62_64,
    AgeOv65  = ageMl65_66 + ageFm65_66 + ageMl67_69 + ageFm67_69 + 
                ageMl70_74 + ageFm70_74 + ageMl75_79 + ageFm75_79 + ageMl80_84 +
                ageFm80_84 + ageMlOv85 + ageFmOv85,
    Age18_64 = Age15_44 + Age45_49 + Age50_54 + Age55_59 + Age60_64 
                - ageMl15_17 - ageFm15_17,
    AgeOv18 = Age18_64 + AgeOv65,
    A15_24P = round( 100 * (Age15_19 + Age20_24) / TotPop, 2),
    Und45P  = round( 100 * (Age0_4 + Age5_14 + Age15_44) / TotPop, 2),
    Ovr65P  = round( 100 * AgeOv65 / TotPop, 2),
    # ------- Race and Ethnicity Percents --------- #
    WhiteP   = round( 100 * whitePop / TotPop, 2),
    BlackP   = round( 100 * blackPop / TotPop, 2),
    AmIndP   = round( 100 * amIndPop / TotPop, 2),
    AsianP   = round( 100 * asianPop / TotPop, 2),
    PacIsP   = round( 100 * pacIsPop / TotPop, 2),
    OtherP   = round( 100 * (otherPop + twoPlsPop) / TotPop, 2),
    HispP    = round( 100 * hispPop  / TotPop, 2)
  ) |> 
  select(GEOID, TotPop, WhiteP, BlackP, AmIndP, AsianP, PacIsP, OtherP, HispP,
         Age0_4, Age5_14, Age15_19, Age20_24, Age15_44, Age45_49, Age50_54, Age55_59,
         Age60_64, AgeOv65, Age18_64, AgeOv18, A15_24P, Und45P, Ovr65P)

ds01_acs <- ds01_acs |>
  select(-NAME, -moe) |>
  spread(variable, estimate) |>
  mutate(
    NoHsP = round( 100 * NoHs / popOver25, 2),
    VetP  = round( 100 * VetPop / VetUni,  2),
    UnempP = round(100 * (NMMLFU + NMFLFU + MMLFU +  
                            MFLFU + SMLFU + SFLFU +  
                            WMLFU + WFLFU + DMLFU +  
                            DFLFU) / 
                     (NMMLFU + NMMLF + NMFLFU + NMFLF + 
                        SMLFU  + SMLF  + SFLFU  + SFLF + 
                        MMLFU  + MMLF  + MFLFU  + MFLF + 
                        WMLFU  + WMLF  + WFLFU  + WFLF + 
                        DMLFU  + DFLF  + DFLFU  + DFLF), 
                   2),
    PovP   = round(100 * cntPov / cntPovUni, 2)) |> 
  select(GEOID, TotVet = VetPop, NoHsP, VetP, DisbP, UnempP, PovP)


## Merge ----

tracts2010 <- merge(ds01_dc, ds01_acs, by='GEOID')

## Save ----

write.csv(tracts2010, '../data_final/consolidated/T_2010.csv', row.names=F)

##### Zip -------

## Pull Data ----

ds01_dc_zcta <- map_dfr(
  .x = state_fips, 
  ~ get_decennial(
    geography = 'zcta', 
    variables = dc_variables, 
    state     = .x,
    sumfile   = 'sf1',
    year      = 2010)
)

ds01_acs_zcta <- get_acs(
    geography = 'zcta',
    variables = acs_variables,
    year=2012
  )

## Clean and Mutate Data ----

ds01_dc_zcta <- ds01_dc_zcta |>
  select(-NAME) |>
  spread(variable, value) |>
  mutate(
    # ------- Age Columns --------- #
    Age0_4   = ageMl0_4 + ageFm0_4,
    Age5_14  = ageMl5_9 + ageFm5_9 + ageMl10_14 + ageFm10_14,
    Age15_19 = ageMl15_17 + ageFm15_17 + ageMl18_19 + ageFm18_19,
    Age20_24 = ageMl20 + ageFm20 + ageMl21 + ageFm21 + ageMl22_24 + ageFm22_24,
    Age15_44 = Age15_19 + Age20_24 + ageMl25_29 + ageFm25_29 + ageMl30_34 + ageFm30_34 +
      ageMl35_39 + ageFm35_39 + ageMl40_44 + ageFm40_44,
    Age45_49 = ageMl45_49 + ageFm45_49,
    Age50_54 = ageMl50_54 + ageFm50_54,
    Age55_59 = ageMl55_59 + ageFm55_59,
    Age60_64 = ageMl60_61 + ageFm60_61 + ageMl62_64 + ageFm62_64,
    AgeOv65  = ageMl65_66 + ageFm65_66 + ageMl67_69 + ageFm67_69 + 
      ageMl70_74 + ageFm70_74 + ageMl75_79 + ageFm75_79 + ageMl80_84 +
      ageFm80_84 + ageMlOv85 + ageFmOv85,
    Age18_64 = Age15_44 + Age45_49 + Age50_54 + Age55_59 + Age60_64 
    - ageMl15_17 - ageFm15_17,
    AgeOv18 = Age18_64 + AgeOv65,
    A15_24P = round( 100 * (Age15_19 + Age20_24) / TotPop, 2),
    Und45P  = round( 100 * (Age0_4 + Age5_14 + Age15_44) / TotPop, 2),
    Ovr65P  = round( 100 * AgeOv65 / TotPop, 2),
    # ------- Race and Ethnicity Percents --------- #
    WhiteP   = round( 100 * whitePop / TotPop, 2),
    BlackP   = round( 100 * blackPop / TotPop, 2),
    AmIndP   = round( 100 * amIndPop / TotPop, 2),
    AsianP   = round( 100 * asianPop / TotPop, 2),
    PacIsP   = round( 100 * pacIsPop / TotPop, 2),
    OtherP   = round( 100 * (otherPop + twoPlsPop) / TotPop, 2),
    HispP    = round( 100 * hispPop  / TotPop, 2)
  ) |> 
  select(GEOID, TotPop, WhiteP, BlackP, AmIndP, AsianP, PacIsP, OtherP, HispP,
         Age0_4, Age5_14, Age15_19, Age20_24, Age15_44, Age45_49, Age50_54, Age55_59,
         Age60_64, AgeOv65, Age18_64, AgeOv18, A15_24P, Und45P, Ovr65P)

ds01_acs_zcta <- ds01_acs_zcta |>
  select(-NAME, -moe) |>
  spread(variable, estimate) |>
  mutate(
    NoHsP = round( 100 * NoHs / popOver25, 2),
    VetP  = round( 100 * VetPop / VetUni,  2),
    UnempP = round(100 * (NMMLFU + NMFLFU + MMLFU +  
                            MFLFU + SMLFU + SFLFU +  
                            WMLFU + WFLFU + DMLFU +  
                            DFLFU) / 
                     (NMMLFU + NMMLF + NMFLFU + NMFLF + 
                        SMLFU  + SMLF  + SFLFU  + SFLF + 
                        MMLFU  + MMLF  + MFLFU  + MFLF + 
                        WMLFU  + WMLF  + WFLFU  + WFLF + 
                        DMLFU  + DFLF  + DFLFU  + DFLF), 
                   2),
    PovP   = round(100 * cntPov / cntPovUni, 2),
  ) |> 
  select(GEOID, NoHsP, VetP, UnempP, PovP, PciE = pci, DisbP)

## Merge ----

zcta <- merge(ds01_dc_zcta, ds01_acs_zcta, by='GEOID') |>
  mutate(GEOID = substr(GEOID, 3, 7))

## Save ----

write.csv(zcta, '../data_final/consolidated/Z_2010.csv', row.names=F)

##### County -------

## Pull data ----

ds01_dc_c <- get_decennial(
  geography = 'county', 
  variables = dc_variables, 
  sumfile   = 'sf1',
  year      = 2010
  )

ds01_acs_c <- get_acs(
  geography = 'county',
  variables = acs_variables,
  year = 2012
  )

## Mutate and clean data ----

ds01_dc_c <- ds01_dc_c |>
  select(-NAME) |>
  spread(variable, value) |>
  mutate(
    # ----------------------------- Age Columns ------------------------------ #
    Age0_4   = ageMl0_4 + ageFm0_4,
    Age5_14  = ageMl5_9 + ageFm5_9 + ageMl10_14 + ageFm10_14,
    Age15_19 = ageMl15_17 + ageFm15_17 + ageMl18_19 + ageFm18_19,
    Age20_24 = ageMl20 + ageFm20 + ageMl21 + ageFm21 + ageMl22_24 + ageFm22_24,
    Age15_44 = Age15_19 + Age20_24 + ageMl25_29 + ageFm25_29 + ageMl30_34 + ageFm30_34 +
      ageMl35_39 + ageFm35_39 + ageMl40_44 + ageFm40_44,
    Age45_49 = ageMl45_49 + ageFm45_49,
    Age50_54 = ageMl50_54 + ageFm50_54,
    Age55_59 = ageMl55_59 + ageFm55_59,
    Age60_64 = ageMl60_61 + ageFm60_61 + ageMl62_64 + ageFm62_64,
    AgeOv65  = ageMl65_66 + ageFm65_66 + ageMl67_69 + ageFm67_69 + 
      ageMl70_74 + ageFm70_74 + ageMl75_79 + ageFm75_79 + ageMl80_84 +
      ageFm80_84 + ageMlOv85 + ageFmOv85,
    Age18_64 = Age15_44 + Age45_49 + Age50_54 + Age55_59 + Age60_64 
    - ageMl15_17 - ageFm15_17,
    AgeOv18 = Age18_64 + AgeOv65,
    A15_24P = round( 100 * (Age15_19 + Age20_24) / TotPop, 2),
    Und45P  = round( 100 * (Age0_4 + Age5_14 + Age15_44) / TotPop, 2),
    Ovr65P  = round( 100 * AgeOv65 / TotPop, 2),
    # -------------------- Race and Ethnicity Percents ----------------------- #
    WhiteP   = round( 100 * whitePop / TotPop, 2),
    BlackP   = round( 100 * blackPop / TotPop, 2),
    AmIndP   = round( 100 * amIndPop / TotPop, 2),
    AsianP   = round( 100 * asianPop / TotPop, 2),
    PacIsP   = round( 100 * pacIsPop / TotPop, 2),
    OtherP   = round( 100 * (otherPop + twoPlsPop) / TotPop, 2),
    HispP    = round( 100 * hispPop  / TotPop, 2)
  ) |> 
  select(
    GEOID,    TotPop,   WhiteP,   BlackP,   AmIndP, 
    AsianP,   PacIsP,   OtherP,   HispP,    Age0_4, 
    Age5_14,  Age15_19, Age20_24, Age15_44, Age45_49, 
    Age50_54, Age55_59, Age60_64, AgeOv65,  Age18_64, 
    AgeOv18,  A15_24P,  Und45P,   Ovr65P
  )

ds01_acs_c <- ds01_acs_c |>
  select(-NAME, -moe) |>
  spread(variable, estimate) |>
  mutate(
    NoHsP = round( 100 * NoHs / popOver25, 2),
    VetP  = round( 100 * VetPop / VetUni,  2),
    UnempP = round(100 * (NMMLFU + NMFLFU + MMLFU +  
                            MFLFU + SMLFU + SFLFU +  
                            WMLFU + WFLFU + DMLFU +  
                            DFLFU) / 
                     (NMMLFU + NMMLF + NMFLFU + NMFLF + 
                        SMLFU  + SMLF  + SFLFU  + SFLF + 
                        MMLFU  + MMLF  + MFLFU  + MFLF + 
                        WMLFU  + WMLF  + WFLFU  + WFLF + 
                        DMLFU  + DFLF  + DFLFU  + DFLF), 
                   2),
    PovP   = round(100 * cntPov / cntPovUni, 2),
  ) |> 
  select(GEOID, NoHsP, VetP, UnempP, PovP, PciE = pci)

## Merge ----

cnty <- merge(ds01_dc_c, ds01_acs_c, by='GEOID') 

## Save ----

write.csv(cnty, '../data_final/consolidated/C_2010.csv', row.names=F)

##### States ------

## Pull data ----

ds01_dc_s <- get_decennial(
  geography = 'state', 
  variables = dc_variables, 
  sumfile   = 'sf1',
  year      = 2010
)

ds01_acs_s <- get_acs(
  geography = 'state',
  variables = acs_variables,
  year = 2012
)

## Mutate and clean data ----

ds01_dc_s <- ds01_dc_s |>
  select(-NAME) |>
  spread(variable, value) |>
  mutate(
    # ------- Age Columns --------- #
    Age0_4   = ageMl0_4 + ageFm0_4,
    Age5_14  = ageMl5_9 + ageFm5_9 + ageMl10_14 + ageFm10_14,
    Age15_19 = ageMl15_17 + ageFm15_17 + ageMl18_19 + ageFm18_19,
    Age20_24 = ageMl20 + ageFm20 + ageMl21 + ageFm21 + ageMl22_24 + ageFm22_24,
    Age15_44 = Age15_19 + Age20_24 + ageMl25_29 + ageFm25_29 + ageMl30_34 + ageFm30_34 +
      ageMl35_39 + ageFm35_39 + ageMl40_44 + ageFm40_44,
    Age45_49 = ageMl45_49 + ageFm45_49,
    Age50_54 = ageMl50_54 + ageFm50_54,
    Age55_59 = ageMl55_59 + ageFm55_59,
    Age60_64 = ageMl60_61 + ageFm60_61 + ageMl62_64 + ageFm62_64,
    AgeOv65  = ageMl65_66 + ageFm65_66 + ageMl67_69 + ageFm67_69 + 
      ageMl70_74 + ageFm70_74 + ageMl75_79 + ageFm75_79 + ageMl80_84 +
      ageFm80_84 + ageMlOv85 + ageFmOv85,
    Age18_64 = Age15_44 + Age45_49 + Age50_54 + Age55_59 + Age60_64 
    - ageMl15_17 - ageFm15_17,
    AgeOv18 = Age18_64 + AgeOv65,
    A15_24P = round( 100 * (Age15_19 + Age20_24) / TotPop, 2),
    Und45P  = round( 100 * (Age0_4 + Age5_14 + Age15_44) / TotPop, 2),
    Ovr65P  = round( 100 * AgeOv65 / TotPop, 2),
    # ------- Race and Ethnicity Percents --------- #
    WhiteP   = round( 100 * whitePop / TotPop, 2),
    BlackP   = round( 100 * blackPop / TotPop, 2),
    AmIndP   = round( 100 * amIndPop / TotPop, 2),
    AsianP   = round( 100 * asianPop / TotPop, 2),
    PacIsP   = round( 100 * pacIsPop / TotPop, 2),
    OtherP   = round( 100 * (otherPop + twoPlsPop) / TotPop, 2),
    HispP    = round( 100 * hispPop  / TotPop, 2)
  ) |> 
  select(GEOID, TotPop, WhiteP, BlackP, AmIndP, AsianP, PacIsP, OtherP, HispP,
         Age0_4, Age5_14, Age15_19, Age20_24, Age15_44, Age45_49, Age50_54, Age55_59,
         Age60_64, AgeOv65, Age18_64, AgeOv18, A15_24P, Und45P, Ovr65P)

ds01_acs_s <- ds01_acs_s |>
  select(-NAME, -moe) |>
  spread(variable, estimate) |>
  mutate(
    NoHsP = round( 100 * NoHs / popOver25, 2),
    VetP  = round( 100 * VetPop / VetUni,  2),
    UnempP = round(100 * (NMMLFU + NMFLFU + MMLFU +  
                            MFLFU + SMLFU + SFLFU +  
                            WMLFU + WFLFU + DMLFU +  
                            DFLFU) / 
                     (NMMLFU + NMMLF + NMFLFU + NMFLF + 
                        SMLFU  + SMLF  + SFLFU  + SFLF + 
                        MMLFU  + MMLF  + MFLFU  + MFLF + 
                        WMLFU  + WMLF  + WFLFU  + WFLF + 
                        DMLFU  + DFLF  + DFLFU  + DFLF), 
                   2),
    PovP   = round(100 * cntPov / cntPovUni, 2),
  ) |> 
  select(GEOID, NoHsP, VetP, UnempP, PovP, PciE = pci)

## Merge ----

state <- merge(ds01_dc_s, ds01_acs_s, by="GEOID")

## Save ----

write.csv(state, '../data_final/consolidated/S_2010.csv', row.names = F)
