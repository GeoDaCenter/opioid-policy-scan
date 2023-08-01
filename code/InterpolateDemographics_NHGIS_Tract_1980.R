
## Author: Ashlynn Wimer
## Date: 6/30/23

## This R File creates the DS01_1980 data table. It takes in 1980 Split Tract
## level data for total population, race, Hispanic descent, and age, mutates and
## renames these variables into relevant counts, aggregates them to tract level,
## imputes the tracts to 2010 census tracts. It does a similar process separately
## to the education variables, merges the results. Lastly, it calculates the 
## final needed variables before saving to data final.
## Split tract data is used as tract level data suffers loses to suppression.
## For more, see this link: https://forum.ipums.org/t/1980-census-age-data/5362/2

## A lot of data is being transformed, so expect it to take a few (>10) minutes
## to run to completion, with total duration depending on your system specs.

##### Data Sources: ######
## This file uses the IPUMS NHGIS tables NT1, NT7, NT8, and NT10A. These data
## tables are based on the 1980 Census Summary Tape File 1, which is our ultimate
## source.
## It also uses the Longitudinal Tract Database (LTDB) census crosswalk file 
## for 1980 to to 2010.

library(dplyr)
library(stringr)

setwd(getSrcDirectory(function(){})[1])


### Load Data ###
print("Loading data!")
crosswalk_80_10 <- read.csv("../data_raw/crosswalk/crosswalk_1980_2010.csv")
split_tract_demos_data <- read.csv("../data_raw/nhgis/1980/nhgis0016_ds104_1980_tract_080.csv")
split_tract_ed_data <- read.csv("../data_raw/nhgis/1980/nhgis0021_ds107_1980_tract_080.csv")

split_tract_data <- split_tract_ed_data |>
  select(GISJOIN, DHM001, DHM002, DHM003, DHM004, DHM005) |>
  merge(split_tract_demos_data, by="GISJOIN")

# In hopes of speeding up the sheet
rm(split_tract_demos_data)
rm(split_tract_ed_data)

# Rename to ease debugging + legibility
print("Transforming initial dataset!")
split_tract_data <- split_tract_data |>
  rename(
    ageUnd1     = C67001, age1_2         = C67002,
    age3_4      = C67003, age5           = C67004,
    age6        = C67005, age7_9         = C67006,
    age10_13    = C67007, age14          = C67008,
    age15       = C67009, age16          = C67010,
    age17       = C67011, age18          = C67012,
    age19       = C67013, age20          = C67014,
    age21       = C67015, age22_24       = C67016, 
    age25_29    = C67017, age30_34       = C67018, 
    age35_44    = C67019, age45_54       = C67020,
    age55_59    = C67021, age60_61       = C67022, 
    age62_64    = C67023, age65_74       = C67024, 
    age75_84    = C67025, ageOv85        = C67026,
    notHispPop  = C9E001, mexicanPop     = C9E002, 
    prPop       = C9E003, cubanPop       = C9E004,
    otherHisp   = C9E005, whitePop       = C9D001, 
    blackPop    = C9D002, contigAmIndPop = C9D003, 
    inuitPop    = C9D004, unanganPop     = C9D005, 
    japanesePop = C9D006, chinesePop     = C9D007, 
    filipinoPop = C9D008, koreanPop      = C9D009, 
    indianPop   = C9D010, vietnamesePop  = C9D011, 
    hawaiinPop  = C9D012, guamanianPop   = C9D013, 
    samoanPop   = C9D014, otherPop       = C9D015,
    totPop      = C7L001, elementary     = DHM001,
    hghschl1_3  = DHM002, hghschl4       = DHM003,
    college1_3  = DHM004, college4orMore = DHM005)  

## Aggregate into relevant variables
split_tract_data <- split_tract_data |>
  mutate(
    age0_4   = ageUnd1  + age1_2   + age3_4,
    age5_14  = age5     + age6     + age7_9    + age10_13 + age14,
    age18_64 = age18    + age19    + age20     + age21    + age22_24 + age25_29 + age30_34 + age35_44 + age45_54 + age55_59 + age60_61 + age62_64,
    age15_19 = age15    + age16    + age17     + age18    + age19,
    age20_24 = age20    + age21    + age22_24,
    age15_44 = age15    + age16    + age17     + age18    + age19 + age20 + age21 + age22_24 + age25_29 + age30_34 + age35_44,
    age55_59 = age55_59,
    age60_64 = age60_61 + age62_64,
    ageOv65  = age65_74 + age75_84 + ageOv85,
    hispPop  = mexicanPop + prPop + cubanPop + otherHisp,
    amIndPop = contigAmIndPop + inuitPop + unanganPop,
    asianPop = japanesePop + chinesePop + filipinoPop + koreanPop + indianPop + vietnamesePop,
    pacIsPop = hawaiinPop + guamanianPop + samoanPop,
    NoHSPop  = elementary + hghschl1_3,
    edSampl = elementary + hghschl1_3 + hghschl4 + college1_3 + college4orMore
    )

## Select only relevant variables
split_tract_data <- split_tract_data |>
  select(GISJOIN, STATEA, COUNTYA, PLACEA, TRACTA, 
         age18_64, age0_4, age5_14, age15_19, age20_24, 
         age15_44, age55_59, age60_64, ageOv65, hispPop, 
         amIndPop, asianPop, pacIsPop, totPop, whitePop, 
         blackPop, NoHSPop, edSampl) 


## Recombine partial census tracts into whole census tracts
# Pad keys  
split_tract_data$STATEA <- str_pad(split_tract_data$STATEA, width=2, side='left', pad='0')
split_tract_data$COUNTYA <- str_pad(split_tract_data$COUNTYA, width=3, side='left', pad='0')

# GISJOIN is needed in order to get the actual TRACTA
# This is because Census Tract codes are of form XXXX.YY, where the .YY
# is optional. Unfortunately, the TRACTA variable simply drops the period and
# all leading 0s, making it impossible to differentiate tract 101 from 1.01
# as both would have TRACTA 101.

# GISJOIN preserves the uniqueness of Tract Codes, but also contains the PLACEA
# if it exists, so we have to do casework by whether or not there is a PLACEA.

has_placea <- !is.na(split_tract_data$PLACEA)
split_tract_data$GISJOIN <- ifelse(has_placea,
                                   str_pad(split_tract_data$GISJOIN, width=21, side='right', pad='0'),
                                   str_pad(split_tract_data$GISJOIN, width=17, side='right', pad='0'))

split_tract_data$TRACTA <- ifelse(has_placea, 
                                  substr(split_tract_data$GISJOIN, start=16, stop=21),
                                  substr(split_tract_data$GISJOIN, start = 12, stop=17))

split_tract_data$FIPS <- paste(split_tract_data$STATEA, split_tract_data$COUNTYA, split_tract_data$TRACTA, sep="")


tracts_1980 <- tibble(
  STATEA = character(), COUTNYA = character(),
  TRACTA = character(), FIPS = character(),
  totPop = integer(),   age18_64 = integer(),
  age0_4 = integer(),   age5_14 = integer(),  
  age15_19 = integer(), age20_24 = integer(), 
  age15_44 = integer(), age55_59 = integer(), 
  age60_64 = integer(), ageOv65 = integer(),  
  hispPop = integer(),  whitePop = integer(), 
  blackPop = integer(), amIndPop = integer(), 
  asianPop = integer(), pacIsPop = integer(),
  NoHSPop  = integer(), edSampl  = integer()
)
print("Combining split census tracts into whole census tracts!")
n <- 0
for (fips in unique(split_tract_data$FIPS)) {
  n <- n+1
  if ( n%%1000==0 ) { print(paste("Done with ", n, " tracts!", sep="")) }
  
  split_tract_indices <- which(split_tract_data$FIPS == fips)
  
  tracts_1980 <- tracts_1980 |> 
    add_row(
      STATEA   =      split_tract_data[split_tract_indices[1], "STATEA"] ,
      COUTNYA  =      split_tract_data[split_tract_indices[1], "COUNTYA"],
      TRACTA   =      split_tract_data[split_tract_indices[1], "TRACTA"] ,
      FIPS     =      split_tract_data[split_tract_indices[1], "FIPS"]   ,
      totPop   = sum( split_tract_data[split_tract_indices, "totPop"]   ),
      age18_64 = sum( split_tract_data[split_tract_indices, "age18_64"] ),
      age0_4   = sum( split_tract_data[split_tract_indices, "age0_4"]   ),
      age5_14  = sum( split_tract_data[split_tract_indices, "age5_14"]  ),
      age15_19 = sum( split_tract_data[split_tract_indices, "age15_19"] ),
      age20_24 = sum( split_tract_data[split_tract_indices, "age20_24"] ),
      age15_44 = sum( split_tract_data[split_tract_indices, "age15_44"] ),
      age55_59 = sum( split_tract_data[split_tract_indices, "age55_59"] ),
      age60_64 = sum( split_tract_data[split_tract_indices, "age60_64"] ),
      ageOv65  = sum( split_tract_data[split_tract_indices, "ageOv65"]  ),
      hispPop  = sum( split_tract_data[split_tract_indices, "hispPop"]  ),
      whitePop = sum( split_tract_data[split_tract_indices, "whitePop"] ),
      blackPop = sum( split_tract_data[split_tract_indices, "blackPop"] ),
      amIndPop = sum( split_tract_data[split_tract_indices, "amIndPop"] ),
      asianPop = sum( split_tract_data[split_tract_indices, "asianPop"] ),
      pacIsPop = sum( split_tract_data[split_tract_indices, "pacIsPop"] ),
      NoHSPop  = sum( split_tract_data[split_tract_indices, "NoHSPop"]  ),
      edSampl  = sum( split_tract_data[split_tract_indices, "edSampl"]  )
    )
}

print("Done combining all split tracts!")

# Clean our crosswalk keys to be compatible with our FIPS.
crosswalk_80_10$trtid80 <- crosswalk_80_10$trtid80 |> str_pad(side='left', width=11, pad='0')
crosswalk_80_10$trtid10 <- crosswalk_80_10$trtid10 |> str_pad(side='left', width=11, pad='0')

# Create an "all 0" tibble for the 2010 tracts to be additively upated.
tracts_2010 <- tibble(
  FIPS = unique(crosswalk_80_10$trtid10), 
  totPop   = 0, age18_64 = 0,
  age0_4   = 0, age5_14  = 0, 
  age15_19 = 0, age20_24 = 0, 
  age15_44 = 0, age55_59 = 0, 
  age60_64 = 0, ageOv65  = 0, 
  hispPop  = 0, whitePop = 0, 
  blackPop = 0, amIndPop = 0, 
  asianPop = 0, pacIsPop = 0,
  noHSPop  = 0, edSampl  = 0
)

print("Interpolating whole 1980 census tracts to 2010 census tracts!")

# For each row in the big 1980 tracts dataframe...
for (tracts_1980_row_number in 1:nrow(tracts_1980)) {
  
  # Find all appearances of that row's 1980 FIPS in our crosswalk...
  tract_fips_1980 <- tracts_1980[[tracts_1980_row_number, "FIPS"]]
  rows_where_crosswalk_matches <- which(crosswalk_80_10$trtid80 == tract_fips_1980) # list OR NA
  has_matches <- !(any(is.na(rows_where_crosswalk_matches)))
  
  # Grab all 2010 FIPS codes associated with our 1980 FIPS code...
  if (has_matches) {
    relevant_tract_fips_10 <- crosswalk_80_10[rows_where_crosswalk_matches, "trtid10"]
    
    # For each such 2010 FIPS code...
    for (tract_fips_10 in relevant_tract_fips_10) {
      
      # Ge the relevant weight and row in tracts_2010...
      tract_80_weight <- crosswalk_80_10[which(crosswalk_80_10$trtid10 == tract_fips_10 & crosswalk_80_10$trtid80 == tract_fips_1980), "weight"]
      tracts_2010_row <- which(tracts_2010$FIPS == tract_fips_10)
      
      # And update the row's attributes with the 1980 tracts contributions.
      tracts_2010[tracts_2010_row, ] <- c(
        FIPS     = tracts_2010[tracts_2010_row, "FIPS"    ],
        totPop   = tracts_2010[tracts_2010_row, "totPop"  ] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'totPop'  ],
        age18_64 = tracts_2010[tracts_2010_row, "age18_64"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age18_64'],
        age0_4   = tracts_2010[tracts_2010_row, "age0_4"  ] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age0_4'  ],
        age5_14  = tracts_2010[tracts_2010_row, "age5_14" ] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age5_14' ], 
        age15_19 = tracts_2010[tracts_2010_row, "age15_19"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age15_19'], 
        age20_24 = tracts_2010[tracts_2010_row, "age20_24"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age20_24'],
        age15_44 = tracts_2010[tracts_2010_row, "age15_44"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age15_44'],
        age55_59 = tracts_2010[tracts_2010_row, "age55_59"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age55_59'],
        age60_64 = tracts_2010[tracts_2010_row, "age60_64"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'age60_64'],
        ageOv65  = tracts_2010[tracts_2010_row, "ageOv65" ] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'ageOv65' ], 
        hispPop  = tracts_2010[tracts_2010_row, "hispPop" ] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'hispPop' ],
        whitePop = tracts_2010[tracts_2010_row, "whitePop"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'whitePop'],
        blackPop = tracts_2010[tracts_2010_row, "blackPop"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'blackPop'],
        amIndPop = tracts_2010[tracts_2010_row, "amIndPop"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'amIndPop'], 
        asianPop = tracts_2010[tracts_2010_row, "asianPop"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'asianPop'], 
        pacIsPop = tracts_2010[tracts_2010_row, "pacIsPop"] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'pacIsPop'],
        noHSPop  = tracts_2010[tracts_2010_row, "noHSPop" ] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'NoHSPop' ],
        edSampl  = tracts_2010[tracts_2010_row, "edSampl" ] + tract_80_weight * tracts_1980[tracts_1980_row_number, 'edSampl' ]
      )
    }
  }
  
  # Update on our progress.
  if (tracts_1980_row_number %% 1000 == 0) { 
    print(paste("Done with ", tracts_1980_row_number, " tracts!", sep="")) 
  }
}
print("Done interpolating!")

# Save the result.
write.csv(tracts_2010, 
          "../data_raw/nhgis/1980DataInterpolated.csv", 
          row.names=FALSE)
