**Meta Data Name**: Group Quarters   
**Last Modified**: September 24th, 2021  
**Author**: Ally Muszynski  

### Data Location: 
DS05 - 4 spatial scales. Files can be found [here](/data_final).
* DS05_T  
* DS05_Z  
* DS05_C  
* DS05_S  

### Data Source(s) Description:  
Variables were obtained from the 2013 - 2018 American Community Survey (ACS), table B09019 at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://data.census.gov. Additional information was obtained from the Department of Housing and Urban Development Homeless Census, 2018, table DP03 at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://www.huduser.gov.

### Description of Data Source Table:
B09019 : Provides breakdown of unhoused individuals living in group quarters.

### Description of Data Processing: 
The following variables were included from the source data:
1. Total population
2. Total unrelated group dwelling population under household with one primary owner
3. Total group dwelling population in household with more than one unrelated owner
4. Total group dwelling in publicly owned quarters
5. Rate of unrelated group dwelling under one roof with one primary home owner
6. Rate of group dwelling in publicly owned quarters

These rates were calculated using the group dwelling variable in the ACS.

----------
  * Percentage for homeless rate was calculated as: *estimate for the group / total population*, e.g.
-  *% group dwelling  = non-related group dwelling / Total population* \

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
  |:---------|:--------------------|:------------|
  | Total Population  | TotalPop | Total population |
  | Non-related Household  | UnrelHouse | Number of people under one roof that are not related to the primary resident |
  | Non-related Group Dwelling | GroupDwell | Number of people under one roof that are unrelated |
  | Group Dwelling | GroupQuar | Number of people in publicly owned group quarters|
  | Rate of  non-related household | UnrelPct | Estimate of people living in non-related households over total population |
  | Rate of group quarter dwelling | GrpQuarPct | Estimate of people living in group quarters over total population |
  
### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average.

### Comments/Notes:
For more information about how group dwelling rates have been used in homelessness and housing stability, please refer to https://www.census.gov/newsroom/press-releases/2020/special-operations-homelessness.html or https://www.americanprogress.org/issues/poverty/reports/2020/10/05/491122/count-people-where-they-are/.

**Note on missing data:** Missing and/or unavailable data are coded as blank cells or _NA_.


