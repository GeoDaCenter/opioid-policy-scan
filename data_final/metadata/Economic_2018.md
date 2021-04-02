**Meta Data Name**: Economic Variables
**Last Modified**: October 22nd, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
EC03 at 4 spatial scales. Files can be found [here](/data_final).
* EC03_T  
* EC03_Z  
* EC03_C  
* EC03_S  

### Data Source(s) Description:  

Variables were obtained from the [2014 - 2018 American Community Survey (ACS)](https://data.census.gov), table B19301, DP03, B19301, at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level.

### Description of Data Source Tables:

B19301 : Per Capita Income in the past 12 months (in 2018 inflation-adjusted dollars) <br>
DP03: Selected Economic Characteristics <br>
S1701: Poverty status in the past 12 months

### Description of Data Processing: 
The following variables were included from **B19301**:
  1. Estimate; Per capita income in the past 12 months (in 2018 inflation-adjusted dollars)
  
The following variables were included from **DP03**:
  1. Percent Estimate; Unemployment Rate
 
The following variables were included from **S1701**:
  1. Percent Estimate; Percent below poverty level
  
  
### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Unemployment Rate | unempP | Unemployment Rate |
| Poverty Rate | povP | Percent below poverty level |
| Per Capita Income | pciE | Per capita income in the past 12 months (in 2018 inflation-adjusted dollars) |

### Data Limitations:
n/a

### Comments/Notes:
n/a
