**Meta Data Name**: Demographic Variables  
**Date Added**: October 22, 2020  
**Author**: Moksha Menghaney  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka

### Theme: 
Social

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), Table B06009, DP02, at State, County, Tract and ZIP Code Tabulation Area (ZCTA) levels. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
B06009 : Place of birth by Educational Attainment <br>
DP02 : Selected Social Characteristics, provides the percentage of disabled population

### Description of Data Processing: 
The following variables were included from **B06009**:
  * Estimate; Total Population 25 years and over 
  * Estimate; Educational Attainment  – Less than high school graduate (for population 25 years and over)
  
The following variables were included from **DP02**:
  * Percent Estimate; Disability Status of the Civilan NonInstitutionalized Population

**Percentage of population with less than a high school degree** was calculated as: *total population with less than high school degree, age 25+ / total population of age 25+*

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| % Less than High School degree  | NoHsP | Percentage of population 25 years and over, less than a high school degree | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |
| % Population Disabled  | DisbP | Percentage of civilian non institutionalized population with a disability | 2000, 2010, Latest | Tract, Zip*, County, State |

### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average.  
*Note that the Zip code scale data is only available for the "latest" file.
### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as -999. 
