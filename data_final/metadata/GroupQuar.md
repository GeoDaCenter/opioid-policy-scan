**Meta Data Name**: Group Quarters   
**Last Modified**: September 24th, 2021  
**Author**: Ally Muszynski  

### Data Location: 
DS05 - 4 spatial scales. Files can be found [here](/data_final).
* DS05_T  
* DS05_Z  
* DS05_C  
* DS05_S  


DS06 - 4 spatial scales. Files can be found [here](/data_final).
* DS06_T  
* DS06_Z  
* DS06_C  
* DS06_S  

### Data Source(s) Description:  
Variables were obtained from the 2013 - 2018 American Community Survey (ACS), table B09019 at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://data.census.gov. Additional information was obtained from the Department of Housing and Urban Development Homeless Census, 2018, table DP03 at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://www.huduser.gov.

### Description of Data Source Table:
B09019 : Provides breakdown of unhoused individuals living in group quarters.
DP03: Annual homeless census point in time and bed count.fields

### Description of Data Processing: 
The following variables were included from the source data:
1. Total population
2. Total group non-related group dwelling population
3. Total group dwelling population
4. Homeless shelter bed count
5. Homeless shelter point in time count
6. Homeless shelter yearly bed count

These rates were calculated using group dwelling and point in count estimates for homelessness. 

----------
  * Percentage for homeless rate was calculated as: *estimate for the group / total population*, e.g.
-  *% group dwelling  = non-related group dwelling / Total population* \

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
  |:---------|:--------------------|:------------|
  | Total Population  | UnrelHouse | Total population |
  | Non-related Group Dwelling | GroupDwell | Number of people under one roof that are unrelated |
  | Group Dwelling | GroupQuar | Number of people under one roof |
  | Rate of group quarter dwelling | GrpQuarPct | Estimate of people living in group quarters over total population |
  | Rate of unrelated household dwelling | UnrelPct | Estimate of unrelated individuals living in a private household over total population |

### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average. It is difficult to measure homelessness at a local and Federal level as the population is relatively mobile, homelessness can be cyclical and there are visibility issues for the homeless community, so group quarters variables were used as a proxy. Group quarters estimates unrelated individuals living under one roof.

### Comments/Notes:
Point in time counts were geocoded from addresses provided then spatially joined with different levels of information to give a proxy for homelessness. 
[Here](/https://docs.google.com/presentation/d/1rD77sVr92OaUWKWavb6j5cs0XLdReiKXEEG6fOPShYs/edit?usp=sharing) is the methodology for the proxy for homelessness and how data collection is performed.  

**Note on missing data:** Missing and/or unavailable data are coded as blank cells or _NA_.


