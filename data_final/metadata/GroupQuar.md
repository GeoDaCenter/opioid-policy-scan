**Meta Data Name**: Homeless Population  
**Last Modified**: July 30th, 2021  
**Author**: Ally Muszynski  

### Data Location: 
DS05 - 4 spatial scales. Files can be found [here](/data_final).
* DS05_T  
* DS05_Z  
* DS05_C  
* DS05_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table B09019 at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://data.census.gov. 

### Description of Data Source Table:
B09019 : Provides breakdown of unhoused individuals living in group quarters

### Description of Data Processing: 
The following variables were included from the source data:
1. Total population
2. Total group non-related group dwelling population
3. Total group dwelling population

Rates were calculated using group dwelling estimates for homelessness. 

----------
  * Percentage for homeless rate was calculated as: *estimate for the group / total population*, e.g.
-  *% group dwelling  = non-related group dwelling / Total population* \

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
  |:---------|:--------------------|:------------|
  | Total Population: Tract, County, State  | TotalPop | Total population |
  | Non-related Group Dwelling | Non-relatedGroupDwelling | Number of people under one roof that are unrelated |
  | Group Dwelling | GroupQuarters | Number of people under one roof |
  | Rate of Homelessness | HomelessPercent | Estimate of homelessness over total population |
  
### Data Limitations:
This data represents estimates as of the ACS 2019 5-year average. It is difficult to measure homelessness at a local and Federal level as the population is relatively mobile, homelessness can be cyclical and there are visibility issues for the homeless community, so the annual point in time count was used as a proxy for homelessness.

### Comments/Notes:
Point in time counts were geocoded from addresses provided then spatially joined with different levels of information to give a proxy for homelessness. 
[here](/https://docs.google.com/presentation/d/1rD77sVr92OaUWKWavb6j5cs0XLdReiKXEEG6fOPShYs/edit?usp=sharing) is the methodology for the proxy for homelessness and how data collection is performed.
**Note on missing data:** Missing and/or unavailable data are coded as -999. 


