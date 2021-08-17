**Meta Data Name**: Demographic Variables  
**Last Modified**: October 22, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
DS01 at 4 spatial scales. Files can be found [here](/data_final).
* DS01_T  
* DS01_Z  
* DS01_C  
* DS01_S  

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
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % Less than High School degree  | noHSP | Percentage of population 25 years and over, less than a high school degree |
| % Population Disabled  | disbP | Percentage of civilian non institutionalized population with a disability |

### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average.

### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as -999. 
