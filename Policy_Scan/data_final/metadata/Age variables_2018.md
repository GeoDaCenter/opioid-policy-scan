**Meta Data Name**: 2018 Age variables, part of the Demographic Social dataset  
**Last Modified**: August 21st, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
DS02 - Policy Scan Environment Report at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* DS02_T  
* DS02_Z  
* DS02_C  
* DS02_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table S0101, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
S0101 : AGE & SEX

### Description of Data Processing: 
The following variables were included from S0101:
  1.	Estimate; AGE – Under 5 years
  2.	Estimate; AGE – 15 to 19 years 
  3.	Estimate; AGE – 20 to 24 years
  4.	Estimate; SELECTED AGE CATEGORIES – 65 years and over
  5.	Estimate; SELECTED AGE CATEGORIES – 15 to 44 years
  6.	Estimate; SELECTED AGE CATEGORIES – 5 to 14 years

Three age categories were calculated using these variables, population between age 15-24, population under the age of 45 and population over the age of 65. 
All three variables were then converted to percentages using total population as the base.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % Population between 15-24  | pctPop15_24 | Percentage of population between ages of 15 & 24 |
| % Population under 45  | pctPopUnder45 | Percentage of population below 45 years of age |
| % Population over 65 | pctPopOver65 | Percentage of population over 65 |

### Data Limitations:
n/a

### Comments/Notes:
n/a
