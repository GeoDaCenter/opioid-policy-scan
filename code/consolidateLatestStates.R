# Author: Ashlynn Wimer
# Date: 8/1/2023
# About: This R Script merges the most recent OEPS v1.0 state level data into
# single, consolidated files.

### Libraries

library(dplyr)
library(stringr)
library(readxl)

### Empty Table

states <- sf::st_read('../data_final/geometryFiles/state/states2018.shp') |>
  sf::st_drop_geometry() |>
  select(G_STATEFP, GEOID, STUSPS) |>
  mutate(GEOID = str_pad(GEOID, 2, 'left', '0'))

### Demographics

## DS01

# 52 states found
# Additional state is PR

ds01 <- read.csv('../data_final/DS01_S.csv') |>
  select(-year, -STATEFP) |>
  mutate(childrenP = round(100 * (age18_64 + ageOv65) / totPopE), 2)

states <- merge(states, ds01, by='G_STATEFP')

rm(ds01)

## DS04

# 52 states found
# Additional is PR

ds04 <- read.csv('../data_final/DS04_S.csv') |>
  select(STATEFP, TotalVetPop, VetPercent) |>
  mutate(STATEFP = str_pad(STATEFP, 2, side='left', pad='0'))

states <- merge(states, ds04, by.x='GEOID', by.y='STATEFP')

rm(ds04)

## DS05

# 52 states found
# Additional is PR

ds05 <- read.csv('../data_final/DS05_S.csv') |>
  select(G_STATEFP, totalP_hh, nonRel_fhhR, nonRel_nfhhR)

states <- merge(states, ds05, by='G_STATEFP')

rm(ds05)

## DS06

# 51 states found, as expected

ds06 <- read.csv('../data_final/DS06_S.csv') |>
  select(-STATEFP)

states <- merge(states, ds06, by='G_STATEFP')

rm(ds06)

### Economic

## EC01

# 52 states found
# Additional is PR

ec01 <- read.csv('../data_final/EC01_S.csv') |>
  select(-STATEFP, -year)

states <- merge(states, ec01, by='G_STATEFP')

rm(ec01)

## EC02

# 52 states found
# Additional is PR

ec02 <- read.csv('../data_final/EC02_S.csv') |>
  select(-STATEFP, -year)

states <- merge(states, ec02, by='G_STATEFP')

rm(ec02)

## EC03

# 52 states found
# Additional is PR

ec03 <- read.csv('../data_final/EC03_S.csv') |>
  select(-STATEFP, -year)

states <- merge(states, ec03, by='G_STATEFP')

rm(ec03)

## EC04

# 51 found 
# 51 expected

ec04 <- read.csv('../data_final/EC04_S.csv') |>
  select(-STATEFP, -ST, -STATE)

states <- merge(states, ec04, by='G_STATEFP')

rm(ec04)

## EC05

# 52 states found
# Additional is PR

ec05 <- read.csv('../data_final/EC05_S.csv') |>
  select(-GEOID, -year, -total)

states <- merge(states, ec05, by='G_STATEFP')

rm(ec05)


## Additional Economic

# 51 states found, expected

addEcon <- read.csv('../data_raw/additionalEconomicDataState.csv') |>
  select(-GEOID)

states <- merge(states, addEcon, by='G_STATEFP')

rm(addEcon)

### Built Environment

## BE01

# 51 states found, expected

be01 <- read.csv('../data_final/BE01_S.csv') |>
  select(-STATEFP)

states <- merge(states, be01, by='G_STATEFP')

rm(be01)

## BE03

# 51 states found, expected

be03 <- read.csv('../data_final/BE03_S.csv') |>
  select(-state, -STATEFP, -totPopE)

states <- merge(states, be03, by='G_STATEFP')

rm(be03)

## BE05

# 51 states found, expected

be05 <- read.csv('../data_final/BE05_S.csv') |>
  select(-STATEFP)

states <- merge(states, be05, by='G_STATEFP')

rm(be05)

## BE06

# 49 states found, 51 expected
# FIPS 03, 07, 14, 43 are additional
# Those are reserved for possible future use
# with American Samoa, Canal Zone,
# Guam, and PR

be06 <- read.csv('../data_final/BE06_ndvi_S.csv') |>
  select(-X, -state_fips)

states <- merge(states, be06, by='G_STATEFP', all.x = T)

rm(be06)

## BE07

be07 <- read.csv('../data_final/BE07_S.csv') |>
  select(-STATEFP)

states <- merge(states, be07, by='G_STATEFP')

rm(be07)

### Access

# All access variables have 56 states
# The additional states have FIPS 60, 66, 69, 72, 78,
# meaning they're all territories.

## Access01

access01 <- read.csv('../data_final/Access01_S.csv') |>
  select(-STATEFP)

states <- merge(states, access01, by='G_STATEFP')

rm(access01)

## Access02

access02 <- read.csv('../data_final/Access02_S.csv')  |>
  select(-STATEFP, -cntT) |>
  rename(FqhcCtTmDr = cntTimeDrive,
         FqhcAvTmDr = avTimeDrive,
         FqhcTmDrP  = pctTimeDrive)

states <- merge(states, access02, by='G_STATEFP')

rm(access02)

## Access03

access03 <- read.csv('../data_final/Access03_S.csv') |>
  select(G_STATEFP,
         HospCtTmDr = cntTimeDrive,
         HospAvTmDr = avTimeDrive,
         HospTmDrP  = pctTimeDrive
  )

states <- merge(states, access03, by='G_STATEFP')

rm(access03)

## Access04


access04 <- read.csv('../data_final/Access04_S.csv') |>
  select(G_STATEFP,
         RxCtTmDr = cntTimeDrive,
         RxAvTmDr = avTimeDrive,
         RxTmDrP  = pctTimeDrive)

states <- merge(states, access04, by='G_STATEFP')

rm(access04)

## Access05

access05 <- read.csv('../data_final/Access05_S.csv') |>
  select(G_STATEFP,
         MhCtTmDr = cntTimeDrive,
         MhAvTmDr = avTimeDrive,
         MhTmDrP  = pctTimeDrive)

states <- merge(states, access05, by='G_STATEFP')

rm(access05)

## Access06

access06 <- read.csv('../data_final/Access06_S.csv') |>
  select(G_STATEFP,
       SutpCtTmDr = cntTimeDrive,
       SutpAvTmDr = avTimeDrive,
       SutpTmDrP  = pctTimeDrive)

states <- merge(states, access06, by='G_STATEFP')

rm(access06)

## Access07

access07 <- read.csv('../data_final/Access07_S.csv') |>
  mutate(G_STATEFP = paste('G', str_pad(STATEFP, 2, 'left', '0'), sep='')) |>
  select(G_STATEFP,
       OtpCtTmDr = cntTimeDrive,
       OtpAvTmDr = avTimeDrive,
       OtpTmDrP  = pctTimeDrive)

states <- merge(states, access07, by='G_STATEFP')

rm(access07)


### Health

## Health01

# 50 found, 51 expected
# One of the 50 is actually a sum row
# Hawaii, Alaska are missing

health01 <- read.csv('../data_final/Health01_S.csv') |>
  select(-pop, -rawDeathRt, -state, -STATEFP) |>
  rename(DrgRlDth = deaths)

states <- merge(states, health01, by='G_STATEFP', all.x = TRUE)

rm(health01)

## Health02

health02p <- read.csv('../data_final/Health02_S_Prevalence.csv') |>
  select(STATEFP, 
         TotHcv     = State.Cases, 
         MlHcv      = Male.Cases, 
         FmHcv      = Female.Cases, 
         Un50Hcv    = Age.Less.than.50.Cases, 
         A50_74Hcv  = Age.50.74.Cases, 
         Ov75Hcv    = Age.75.Plus.Cases, 
         blkHcv     = Black.Non.Hispanic.Cases, 
         nonBlkHcv  = Non.Black.Other.Cases) |>
  mutate(G_STATEFP  = paste('G', str_pad(STATEFP, 2, 'left', '0'), sep='')) |>
  select(-STATEFP)

states <- merge(states, health02p, by='G_STATEFP')

rm(health02p)

# Read in 2013 mortality data
health02m13 <- read_xlsx("../data_raw/HepVu_State_Mortality_2013.xlsx")

# Massage the .xlsx data into a table
names <- health02m13[3,]
health02m13 <- health02m13[4:nrow(health02m13),]
colnames(health02m13) <- names

health02m13 <- health02m13 |> 
  mutate(GEOID = str_pad(`GEO ID`, 2, 'left', '0')) |>
  select(-Year, -`State Abbreviation`, -State, -`GEO ID`) |>
  select(HcvD13     = `State Death Cases`, 
         MlHcvD13   = `Male Death Cases`, 
         FlHcvD13   = `Female Death Cases`, 
         AmInHcvD13 = `American Indian/Alaska Native Death Cases`, 
         AsPiHcvD13 = `Asian or Pacific Islander Death Cases`, 
         BlkHcvD13  = `Black Death Cases`, 
         HspHcvD13 = `Hispanic Death Cases`, 
         U50HcvD13  = `Age Less than 50 Death Cases`, 
         A50_74HcvD13 = `Age 50-74 Death Cases`, 
         O75HcvD13  = `Age 75 Plus Death Cases`, 
         GEOID) |>
  mutate(HcvD13 = as.numeric(HcvD13),
         MlHcvD13 = as.numeric(MlHcvD13),
         FlHcvD13 = as.numeric(FlHcvD13),
         AmInHcvD13 = as.numeric(AmInHcvD13),
         AsPiHcvD13 = as.numeric(AsPiHcvD13),
         BlkHcvD13 = as.numeric(BlkHcvD13),
         HspHcvD13 = as.numeric(HspHcvD13),
         U50HcvD13 = as.numeric(U50HcvD13),
         A50_74HcvD13 = as.numeric(A50_74HcvD13),
         O75HcvD13 = as.numeric(O75HcvD13))

states <- merge(states, health02m13, by='GEOID')

rm(names)
rm(health02m13)

health02m <- read.csv('../data_final/Health02_S_Mortality.csv') |>
  select(STATEFP, 
         HcvD14     = State.Death.Cases_2014,
         MlHcvD14   = Male.Death.Cases_2014,
         FlHcvD14   = Female.Death.Cases_2014,
         AmInHcvD14 = American.Indian.Alaska.Native.Death.Cases_2014,
         AsPiHcvD14 = Asian.or.Pacific.Islander.Death.Cases_2014,
         BlkHcvD14  = Black.Death.Cases_2014,
         HspHcvD14  = Hispanic.Death.Cases_2014,
         U50HcvD14  = Age.Less.than.50.Death.Cases_2014,
         A50_74HcvD14 = Age.50.74.Death.Cases_2014,
         O75HcvD14  = Age.75.Plus.Death.Cases_2014,
         HcvD15     = State.Death.Cases_2015,
         MlHcvD15   = Male.Death.Cases_2015,
         FlHcvD15   = Female.Death.Cases_2015,
         AmInHcvD15 = American.Indian.Alaska.Native.Death.Cases_2015,
         AsPiHcvD15 = Asian.or.Pacific.Islander.Death.Cases_2015,
         BlkHcvD15  = Black.Death.Cases_2015,
         HspHcvD15  = Hispanic.Death.Cases_2015,
         U50HcvD15  = Age.Less.than.50.Death.Cases_2015,
         D50_74Hcv15 = Age.50.74.Death.Cases_2015,
         O75HcvD15  = Age.75.Plus.Death.Cases_2015,
         HcvD16     = State.Death.Cases_2016,
         MlHcvD16   = Male.Death.Cases_2016,
         FlHcvD16   = Female.Death.Cases_2016,
         AmInHcvD16 = American.Indian.Alaska.Native.Death.Cases_2016,
         AsPiHcvD16 = Asian.or.Pacific.Islander.Death.Cases_2016,
         BlkHcvD16  = Black.Death.Cases_2016,
         HspHcvD16  = Hispanic.Death.Cases_2016,
         U50HcvD16  = Age.Less.than.50.Death.Cases_2016,
         A50_74HcvD16 = Age.50.74.Death.Cases_2016,
         O75HcvD16  = Age.75.Plus.Death.Cases_2016,
         HcvD17     = State.Death.Cases_2017,
         MlHcvD17   = Male.Death.Cases_2017,
         FlHcvD17   = Female.Death.Cases_2017,
         AmInHcvD17 = American.Indian.Alaska.Native.Death.Cases_2017,
         AsPiHcvD17 = Asian.or.Pacific.Islander.Death.Cases_2017,
         BlkHcvD17  = Black.Death.Cases_2017,
         HspHcvD17  = Hispanic.Death.Cases_2017,
         U50HcvD17  = Age.Less.than.50.Death.Cases_2017,
         A50_74HcvD17 = Age.50.74.Death.Cases_2017,
         O75HcvD17  = Age.75.Plus.Death.Cases_2017
        ) |>
  mutate(G_STATEFP = paste('G', str_pad(STATEFP, 2, 'left', '0'), sep = '')) |>
  select(-STATEFP)

states <- merge(states, health02m, by='G_STATEFP')

rm(health02m)

states <- mutate(states,
    AvHcvD     = round((HcvD13     + HcvD14     + HcvD15     + HcvD16     + HcvD17    ) / 5, 2),
    AvMlHcvD   = round((MlHcvD13   + MlHcvD14   + MlHcvD15   + MlHcvD16   + MlHcvD17  ) / 5, 2),
    AvFlHcvD   = round((FlHcvD13   + FlHcvD14   + FlHcvD15   + FlHcvD16   + FlHcvD17  ) / 5, 2),
    AvAmInHcvD = round((AmInHcvD13 + AmInHcvD14 + AmInHcvD15 + AmInHcvD16 + AmInHcvD17) / 5, 2),
    AvAsPiHcvD = round((AsPiHcvD13 + AsPiHcvD14 + AsPiHcvD15 + AsPiHcvD16 + AsPiHcvD17) / 5, 2),
    AvBlkHcvD  = round((BlkHcvD13  + BlkHcvD14  + BlkHcvD15  + BlkHcvD16  + BlkHcvD17 ) / 5, 2),
    AvHspHcvD  = round((HspHcvD13  + HspHcvD14  + HspHcvD15  + HspHcvD16  + HspHcvD17 ) / 5, 2),
    AvU50HcvD  = round((U50HcvD13  + U50HcvD14  + U50HcvD15  + U50HcvD16  + U50HcvD17 ) / 5, 2),
    Av50_74HcvD= round((A50_74HcvD13 + A50_74HcvD14 + D50_74Hcv15 + A50_74HcvD16 + A50_74HcvD17) / 5, 2),
    AvO75HcvD  = round((O75HcvD13  + O75HcvD14  + O75HcvD15  + O75HcvD16  + O75HcvD17 ) / 5, 2)
    )

## Health03

health03 <- read.csv('../data_final/Health03_S.csv') |>
  select(-STATEFP)

states <- merge(states, health03, by='G_STATEFP')

rm(health03)

## Health04 

# After the last OEPS release, HepVu released 2020 Narcotic Overdose data.
# We replicate the generation of the initial opioidIndicators.R script below on
# the additional data.

health04 <- read_xlsx("../data_raw/HepVu_State_Opioid_Indicators.xlsx", skip = 3) |>
  select(GEOID = `GEO ID`,
         opPrscRt20 = `Opioid Prescription Rate`,
         prMisuse20 = `Pain Reliever Misuse Percent`,
         odMortRt14 = `Narcotic Overdose Mortality Rate 2014`,
         odMortRt15 = `Narcotic Overdose Mortality Rate 2015`,
         odMortRt16 = `Narcotic Overdose Mortality Rate 2016`,
         odMortRt17 = `Narcotic Overdose Mortality Rate 2017`,
         odMortRt18 = `Narcotic Overdose Mortality Rate 2018`,
         odMortRt19 = `Narcotic Overdose Mortality Rate 2019`,
         odMortRt20 = `Narcotic Overdose Mortality Rate 2020`) |>
  mutate(
    GEOID = str_pad(GEOID, width=2, side='left', pad='0'),
    odMortRtAv = round( rowMeans( across( odMortRt16:odMortRt20)), 2)
    )

states <- merge(states, health04, by='GEOID')

rm(health04)

### Policy

## PS03

ps03 <- read.csv("../data_final/PS03_2017_S.csv") |>
  select(-STATEFP, -Year)

states <- merge(states, ps03, by='G_STATEFP')

rm(ps03)

## PS04

ps04 <- read.csv('../data_final/PS04_2018_S.csv') |>
  select(-STATEFP, -Year)

states <- merge(states, ps04, by='G_STATEFP')

rm(ps04)

## PS05

ps05 <- read.csv('../data_final/PS05_2017_S.csv') |>
  select(-STATEFP, -Year)

states <- merge(states, ps05, by='G_STATEFP')

rm(ps05)

## PS06

ps06 <- read.csv('../data_final/PS06_2019_S.csv') |>
  select(G_STATEFP, TtlMedExp = TtlMedExpN)

states <- merge(states, ps06, by='G_STATEFP')

rm(ps06)

## PS07

# All files were saved as strings with 

ps07 <- read.csv('../data_final/PS07_2018_S.csv') |>
  select(-STATEFP, -Year) |>
  mutate(
    TtlMedExp  = str_replace_all(TtlMedExp,  '\\D', ''),
    TradFedExp = str_replace_all(TradFedExp, '\\D', ''),
    TradSttExp = str_replace_all(TradSttExp, '\\D', ''),
    ExpnFedExp = str_replace_all(ExpnFedExp, '\\D', ''),
    ExpnSttExp = str_replace_all(ExpnSttExp, '\\D', '')
    )

states <- merge(states, ps07, by='G_STATEFP') 

rm(ps07)

## PS08

ps08 <- read.csv('../data_final/PS08_2019_S.csv') |>
  select(-STATEFP, -STUSPS, -NAME)

states <- merge(states, ps08, by='G_STATEFP')

rm(ps08)

## PS09

ps09 <- read.csv('../data_final/PS09_2017_S.csv') |>
  select(-STATEFP) |>
  rename(MdMarijLaw = MedMarijLaw)

states <- merge(states, ps09, by='G_STATEFP')

rm(ps09)

## PS11

ps11 <- read.csv('../data_final/PS11_S.csv') |>
  select(-STATEFP, -state)

states <- merge(states, ps11, by='G_STATEFP')

### Cleaning

# Round all decimals
states <- mutate_if(states, is.numeric, round, digits=2)

# NA is coded as -1 in some of our data
states[states == -1] <- NA

# Reorder

states <- states |>
  select(
    G_STATEFP, GEOID, STUSPS, totPopE, totalP_hh, TotalVetPop, totUnits, 
    totWrkE, whiteP, blackP, amIndP, asianP, pacIsP, otherP, hispP, childrenP, 
    a15_24P, und45P, ovr65P, age0_4, age5_14, age15_19, age20_24, age15_44, 
    age45_49, age50_54, age55_59, age60_64, ageOv65, ageOv18, age18_64, disbP, 
    noHSP, VetPercent, nonRel_fhhR, nonRel_nfhhR, BED_COUNT, POINT_IN_TIME, 
    YEARLY_BED_COUNT, unempP, povP, MedInc, pciE, fordq_rate, fordq_num, 
    GiniCoeff, eduP, hghRskP, hltCrP, retailP, essnWrkE, essnWrkP, NoIntPct, 
    vacantP, mobileP, lngTermP, rentalP, unitDens, areaSqMi, alcTotal, alcDens, 
    alcPerCap, dissim.b, inter.bw, iso.b, dissim.h, inter.hw, iso.h, dissim.a, 
    inter.aw, iso.a, ndvi, parkArea, stateArea, cover, cntT, cntBupT, cntMetT, 
    cntNalT, avBupTime, avMetTime, avNalTime, pctBupT, pctMetT, pctNalT, 
    FqhcCtTmDr, FqhcAvTmDr, FqhcTmDrP, HospCtTmDr, HospAvTmDr, HospTmDrP, 
    RxCtTmDr, RxAvTmDr, RxTmDrP, MhCtTmDr, MhAvTmDr, MhTmDrP, SutpCtTmDr, 
    SutpAvTmDr, SutpTmDrP, OtpCtTmDr, OtpAvTmDr, OtpTmDrP, DrgRlDth, TotHcv, 
    MlHcv, FmHcv, Un50Hcv, A50_74Hcv, Ov75Hcv, blkHcv, nonBlkHcv, HcvD13, 
    MlHcvD13, FlHcvD13, AmInHcvD13, AsPiHcvD13, BlkHcvD13, HspHcvD13, U50HcvD13, 
    A50_74HcvD13, O75HcvD13, HcvD14, MlHcvD14, FlHcvD14, AmInHcvD14, AsPiHcvD14, 
    BlkHcvD14, HspHcvD14, U50HcvD14, A50_74HcvD14, O75HcvD14, HcvD15, MlHcvD15, 
    FlHcvD15, AmInHcvD15, AsPiHcvD15, BlkHcvD15, HspHcvD15, U50HcvD15, 
    D50_74Hcv15, O75HcvD15, HcvD16, MlHcvD16, FlHcvD16, AmInHcvD16, AsPiHcvD16, 
    BlkHcvD16, HspHcvD16, U50HcvD16, A50_74HcvD16, O75HcvD16, HcvD17, MlHcvD17, 
    FlHcvD17, AmInHcvD17, AsPiHcvD17, BlkHcvD17, HspHcvD17, U50HcvD17, 
    A50_74HcvD17, O75HcvD17, AvHcvD, AvMlHcvD, AvFlHcvD, AvAmInHcvD, AvAsPiHcvD, 
    AvBlkHcvD, AvHspHcvD, AvU50HcvD, Av50_74HcvD, AvO75HcvD, pcp_total, sp_total, 
    opPrscRt20, prMisuse20, odMortRt14, odMortRt15, odMortRt16, odMortRt17, 
    odMortRt18, odMortRt19, odMortRt20, odMortRtAv, AnyPDMPfr, AnyPDMPHfr, OpPDMPfr, 
    MsAcPDMPfr, ElcPDMPfr, AnyPDMPdt, AnyPDMPHdt, OpPDMPdt, MsAcPDMPdt, 
    ElcPDMPdt, AnyGSLdt, GSLArrdt, AnyGSLfr, GSLArrfr, AnyNaldt, NalPrStdt, 
    NalPresdt, AnyNalfr, NalPrStfr, NalPresfr, TtlMedExp.x, TtlMedExp.y, 
    TradFedExp, TradSttExp, ExpnFedExp, ExpnSttExp, expSSP, noPrphLw, ntPrFrDsSy, 
    PrExcInj, PrNtRefInj, noLwRmUnc, MdMarijLaw, crrctExp_S, plcFireExp_S, 
    healthExp_S, wlfrExp_S, crrctExp_L, plcFireExp_L, healthExp_L, wlfrExp_L, 
    crrctExp_T, plcFireExp_T, healthExp_T, wlfrExp_T
  )

names <- read.csv("../data_raw/rename_tables/state.csv")

if (all(names(states) == names[,1])) {
  colnames(states) <- names[,2]
} else {
  print('ohno')
}

write.csv(states, "../data_final/consolidated/S_Latest.csv", row.names=F)
