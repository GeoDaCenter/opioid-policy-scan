
# Author: Ashlynn Wimer
# Date: 8/17/23
# About: This R Script cleans and refactors the merged county level data table.

#### Libraries ----

library(dplyr)
library(stringr)

#### Script ----

## Read in and Clean Data
cnty_data <- read.csv('../data_final/county_consolidation/C_Latest.csv') |>
  mutate(
    ChildrenP  = round((TotPopGeoA - AgeOv18) / TotPopGeoA, 2),
    PcpPer100k = round((TotPcp / TotPopGeoA) * 100000, 2),
    SpPer100k  = round((TotSp / TotPopGeoA) * 100000, 2),
    GEOID = str_pad(GEOID, width=5, side='left', pad='0')
  )

access_07_c <- read.csv('../data_final/Access01_C.csv') |>
  mutate(COUNTYFP = str_pad(COUNTYFP, width=5, side='left', pad='0')) |>
  rename(GEOID = COUNTYFP)

## Merge
cnty_data <- merge(cnty_data, access_07_c, by='GEOID')  

## Select
cnty_data <- cnty_data |>
  select(
    GEOID,      TotPopGeoA, TotPopHh,   TotVetPop,   TotUnits,   TotWrkE,    
    WhiteP,     BlackP,     AmIndP,     AsianP,      PacISP,     OtherP, 
    HispP,      ChildrenP,  A15_24P,    Und45P,      Ovr65P,     Age0_4, 
    Age5_14,    Age15_19,   Age20_24,   Age15_44,    Age45_49,   Age50_54, 
    Age55_59,   Age60_64,   AgeOv65,    AgeOv18,     Age18_64,   DisbP, 
    NoHSP,      VetP,       NonRelFhhP, NonRelNfhhP, BedCnt,     PntInTm, 
    YrlyBedCnt, UnempP,     PovP,       MedInc,      PciE,       ForDqP, 
    ForDqTot,   GiniCoeff,  EduP,       HghRskP,     HltCrP,     RetailP, 
    EssnWrkE,   EssnWrkP,   NoIntP,     VacantP,     MobileP,    LngTermP, 
    RentalP,    UnitDens,   AreaSqMi,   AlcTot,      AlcDens,    AlcPerCap, 
    DissimBW,   InterBW,    IsoBW,      DissimHW,    InterHW,    IsoHW, 
    DissimAW,   InterAW,    IsoAW,      Ndvi,        TotNumTrtC, NTBupDr30, 
    BupCtTmBk,  BupCtTmWk,  NTMetDr30,  MetCtTmBk,   MetCtTmWk,  NTNalDr30, 
    NalCtTmBk,  NalCtTmWk,  BupTmDr,    BupAvTmBk,   BupAvTmWk,  MetTmDr, 
    MetAvTmBk,  MetAvTmWk,  NalTmDr,    NalAvTmBk,   NalAvTmWk,  TBupDr30P, 
    BupTmBkP,   BupTmWkP,   TMetDr30P,  MetTmBkP,    MetTmWkP,   TNalDr30P, 
    NalTmBkP,   NalTmWkP,   NFqhcDr30,  FqhcTmDr,    TFqhcDr30P, NTHospDr30, 
    HospTmDr,   THospDr30P, NTRxDr30,   RxTmDr,      TRxDr30P,   NTMhDr30, 
    MhTmDr,     TMhDr30P,   NTSutDr30,  SutTmDr,     TSutDr30P,  NTOtpDr30, 
    OtpTmDr,    TOtpDr30P,  Deaths,     TotPcp,      TotSp,      PcpPer100k, 
    SpPer100k,  OpRxRt20,   OdMortRt14, OdMortRt15,  OdMortRt16, OdMortRt17, 
    OdMortRt18, OdMortRt19, OdMortRt20, RcaUrbP,     RcaSubrbP,  RcaRuralP, 
    note,       TotPop10,   UrbPop10,   RurlPop10,   CenRuralP,  DmySgrg, 
    DmyBlckBlt, PrcNtvRsrv, SviTh1,     SviTh2,      SviTh3,     SviTh4, 
    SviSmryRnk, TtlPrPpr,   FmlPrPpr,   MlPrPpr,     AapiPrPpr,  BlckPrPpr, 
    LtnxPrPpr,  NtvPrPpr,   WhtPrPpr,   TtlPrAPpr,   FmlPrAPpr,  MlPrAPpr, 
    AapiPrAPpr, BlckPrAPpr, LtnxPrAPpr, NtvPrAPpr,   WhtPrAPpr,  TtlPrPp, 
    FmlPrPp,    MlPrPp,     AapiPrPp,   BlckPrPp,    LtnxPrPp,   NtvPrPp, 
    WhtPrPp,    TtlPrAPp,   FmlPrAPp,   MlPrAPp,     AapiPrAPp,  BlckPrAPp, 
    LtnxPrAPp,  NtvPrAPp,   WhtPrAPp,   TtlJlPpr,    FmlJlPpr,   MlJlPpr, 
    AapiJlPpr,  BlckJlPpr,  LtnxJlPpr,  NtvJlPpr,    WhtJlPpr,   TtlJlAdmr, 
    TtlJlPrtr,  TtlJlPp,    FmlJlPp,    MlJlPp,      AapiJlPp,   BlckJlPp, 
    LtnxJlPp,   NtvJlPp,    WhtJlPp,    TtlJlAdm,    TtlJlPrt
  )

## Read in rename table
names <- read.csv('../data_raw/rename_tables/county.csv')

if ( all( names['Old'] == colnames(cnty_data) ) ) {
  colnames(cnty_data) <- names[['New']]
} else {
  print("Something is misaligned!")
}

View(cnty_data)

write.csv(cnty_data, '../data_final/consolidated/C_Latest.csv', row.names=F)

