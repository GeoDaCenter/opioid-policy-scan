
# Author: Ashlynn Wimer
# Date: 8/10/23
# About: This script crosswalks the 1980 tract level data onto 2010 ZCTAs. 

##### Library -------

library(dplyr)
library(stringr)

##### Data -------

tracts <- read.csv('../data_raw/nhgis/2000DataInterpolated.csv') |>
  mutate(GEOID  = str_pad(FIPS, width=11, side='left', pad='0'),
         income = perCapInc * totPop) |>
  select(-povPop)

totUnits <- read.csv('../data_final/consolidated/T_2000.csv') |>
  mutate(GEOID   = str_pad(GEOID, width=11, side='left', pad='0'),
         VacUnit = VacantP * TotUnits) |>
  select(GEOID, TotUnits, VacUnit)
  
pov_lab <- read.csv('../data_final/EC03_T_2000_DC.csv') |>
  mutate(GEOID = str_pad(FIPS, width=11, side='left', pad='0'),
         povPop = povP * povUni,
         unempPop = UnempP * labor) |>
  select(GEOID, unempPop, labor, povPop, povUni) 

tracts <- merge(tracts, totUnits, by='GEOID') |> merge(pov_lab, by='GEOID') 

rm(totUnits)
rm(pov_lab)

cw <- readxl::read_xlsx('../data_raw/crosswalk/TRACT_ZIP_032012.xlsx')

# Create an "all 0" tibble for the 2010 tracts to be additively upated.
zips_2010 <- tibble(
  ZCTA = unique(cw$ZIP), 
  TotPop   = 0, TotUnits = 0,
  Age18_64 = 0, Age0_4   = 0, 
  Age5_14  = 0, Age15_19 = 0, 
  Age20_24 = 0, Age15_44 = 0, 
  Age45_49 = 0, Age50_54 = 0,
  Age55_59 = 0, Age60_64 = 0, 
  AgeOv65  = 0, HispPop  = 0, 
  WhitePop = 0, BlackPop = 0, 
  AmIndPop = 0, AsianPop = 0, 
  PacIsPop = 0, NoHsPop  = 0, 
  EdSampl  = 0, povPop   = 0, 
  povUni   = 0, unempPop = 0, 
  labor    = 0, disbPop  = 0,
  VacUnit  = 0
)

print("Interpolating whole 1990 census tracts on 2010 geometries to 2010 ZCTA geometries!")

# For each row in the big tracts dataframe...
for (tract_row in 1:nrow(tracts)) {
  
  # Find all appearances of that row's GEOID in our crosswalk...
  tract_geoid <- tracts[[tract_row, "GEOID"]]
  rows_where_crosswalk_matches <- which(cw$TRACT == tract_geoid) # list OR NA
  
  has_matches <- !(any(is.na(rows_where_crosswalk_matches)))
  
  # Grab all 2010 ZCTAs associated with our tract GEOID...
  if (has_matches) {
    relevant_rows <- cw[rows_where_crosswalk_matches, ]
    # For each such 2010 ZCTA code...
    for (relevant_row_num in 1:nrow(relevant_rows)) {
      
      relevant_row <- relevant_rows[relevant_row_num, ]
      
      # Get the relevant weight and row in zips_2010
      
      ##zip <- which(zips_2010$ZCTA == zcta)
      ## tot_ratio <- cw[which((cw$ZIP == zcta & cw$TRACT == tract_geoid)), "TOT_RATIO"]
      
      zcta <- relevant_row$ZIP
      res_ratio <- relevant_row$RES_RATIO
      
      zips_row <- which(zips_2010$ZCTA == zcta)
      
      # And update the row's attributes with the tracts contributions.
      zips_2010[zips_row, ] <- c(
        ZCTA      = zips_2010[ zips_row, "ZCTA"    ],
        TotPop    = zips_2010[ zips_row, "TotPop"  ] + res_ratio * tracts[ tract_row, 'totPop'   ],
        TotUnits  = zips_2010[ zips_row, 'TotUnits'] + res_ratio * tracts[ tract_row, 'TotUnits' ],
        Age18_64  = zips_2010[ zips_row, 'Age18_64'] + res_ratio * tracts[ tract_row, 'age18_64' ],
        Age0_4    = zips_2010[ zips_row, 'Age0_4'  ] + res_ratio * tracts[ tract_row, 'age0_4'   ],
        Age5_14   = zips_2010[ zips_row, 'Age5_14' ] + res_ratio * tracts[ tract_row, 'age5_14'  ],
        Age15_19  = zips_2010[ zips_row, 'Age15_19'] + res_ratio * tracts[ tract_row, 'age15_19' ],
        Age20_24  = zips_2010[ zips_row, 'Age20_24'] + res_ratio * tracts[ tract_row, 'age20_24' ],
        Age15_44  = zips_2010[ zips_row, 'Age15_44'] + res_ratio * tracts[ tract_row, 'age15_44' ],
        Age45_49  = zips_2010[ zips_row, 'Age45_49'] + res_ratio * tracts[ tract_row, 'age45_49' ],
        Age50_54  = zips_2010[ zips_row, 'Age50_54'] + res_ratio * tracts[ tract_row, 'age50_54' ],
        Age55_59  = zips_2010[ zips_row, 'Age55_59'] + res_ratio * tracts[ tract_row, 'age55_59' ],
        Age60_64  = zips_2010[ zips_row, 'Age60_64'] + res_ratio * tracts[ tract_row, 'age60_64' ],
        AgeOv65   = zips_2010[ zips_row, 'AgeOv65' ] + res_ratio * tracts[ tract_row, 'agOver65' ],
        HispPop   = zips_2010[ zips_row, 'HispPop' ] + res_ratio * tracts[ tract_row, 'hispPop'  ],
        WhitePop  = zips_2010[ zips_row, 'WhitePop'] + res_ratio * tracts[ tract_row, 'whitePop' ],
        BlackPop  = zips_2010[ zips_row, 'BlackPop'] + res_ratio * tracts[ tract_row, 'blackPop' ],
        AmIndPop  = zips_2010[ zips_row, 'AmIndPop'] + res_ratio * tracts[ tract_row, 'amIndPop' ],
        AsianPop  = zips_2010[ zips_row, 'AsianPop'] + res_ratio * tracts[ tract_row, 'asianPop' ],
        PacIsPop  = zips_2010[ zips_row, 'PacIsPop'] + res_ratio * tracts[ tract_row, 'pacIsPop' ],
        NoHsPop   = zips_2010[ zips_row, 'NoHsPop' ] + res_ratio * tracts[ tract_row, 'NoHSDeg'  ],
        EdSampl   = zips_2010[ zips_row, 'EdSampl' ] + res_ratio * tracts[ tract_row, 'edSmpl'   ],
        povPop    = zips_2010[ zips_row, 'povPop'  ] + res_ratio * tracts[ tract_row, 'povPop'   ],
        povUni    = zips_2010[ zips_row, 'povUni'  ] + res_ratio * tracts[ tract_row, 'povUni'   ],
        unempPop  = zips_2010[ zips_row, 'unempPop'] + res_ratio * tracts[ tract_row, 'unempPop' ],
        labor     = zips_2010[ zips_row, 'labor'   ] + res_ratio * tracts[ tract_row, 'labor'    ],
        disbPop   = zips_2010[ zips_row, 'disbPop' ] + res_ratio * tracts[ tract_row, 'disPop'   ],
        VacUnit   = zips_2010[ zips_row, 'VacUnit' ] + res_ratio * tracts[ tract_row, 'VacUnit'  ]  
      )
    }
  }
  
  # Update on our progress.
  if (tract_row %% 1000 == 0) { 
    print(paste("Done with", tract_row, "tracts!", sep=" ")) 
  }
}

zips_2010s <- zips_2010 |>
  mutate(
    HispP     = round(100 * HispPop  / TotPop,  2),
    WhiteP    = round(100 * WhitePop / TotPop,  2),
    BlackP    = round(100 * BlackPop / TotPop,  2),
    AmIndP    = round(100 * AmIndPop / TotPop,  2),
    AsianP    = round(100 * AsianPop / TotPop,  2),
    PacIsP    = round(100 * PacIsPop / TotPop,  2),
    OtherP    = round(100 * (TotPop - WhitePop - BlackPop - AmIndPop - AsianPop - PacIsPop) / TotPop,  2),
    NoHsP     = round(100 * NoHsPop  / EdSampl, 2),
    childrenP = round(100 * (TotPop - Age18_64 - AgeOv65) / TotPop, 2),
    A15_24P   = round(100 * (Age15_19 + Age20_24) / TotPop, 2),
    Ov65P     = round(100 * AgeOv65 / TotPop, 2),
    Und45P    = round(100 * (Age0_4 + Age5_14 + Age15_44) / TotPop, 2),
    UnempP    = round(100 * unempPop / labor, 2),
    PovP      = round(100 * povPop / povUni, 2),
    DisbP     = round(100 * disbPop  / (TotPop - Age0_4), 2),
    VacantP   = round(VacUnit / TotUnits, 2),
    TotPop    = round(TotPop),
    TotUnits  = round(TotUnits),
    Age18_64  = round(Age18_64),
    Age0_4    = round(Age0_4),
    Age5_14   = round(Age5_14),
    Age15_19  = round(Age15_19),
    Age20_24  = round(Age20_24),
    Age15_44  = round(Age15_44),
    Age45_49  = round(Age45_49),
    Age50_54  = round(Age50_54),
    Age55_59  = round(Age55_59),
    Age60_64  = round(Age60_64),
    AgeOv65   = round(AgeOv65)
  ) |>
  select(
    ZCTA,     TotPop,   TotUnits, Age18_64, Age0_4,   Age5_14, Age15_19, Age20_24, 
    Age15_44, Age45_49, Age50_54, Age55_59, Age60_64, AgeOv65, A15_24P,  Ov65P,  
    Und45P,   WhiteP,   BlackP,   AmIndP,   AsianP,   PacIsP,  OtherP,   NoHsP,
    DisbP,    UnempP,   PovP, VacantP
  )

# Filter to only relevant zips. 
relevant_zips <- cw |> filter(TRACT %in% tracts$GEOID)
zips_2010s <- zips_2010s |> filter(ZCTA %in% relevant_zips$ZIP)

# Save
write.csv(zips_2010s, '../data_final/consolidated/Z_2000.csv', row.names = F)
