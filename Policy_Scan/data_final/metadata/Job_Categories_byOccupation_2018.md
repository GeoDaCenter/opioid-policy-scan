**Meta Data Name**: 2018 Job Category variables, part of the Economic Factors dataset  
**Last Modified**: October 22nd, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
EC02 - Policy Scan Environment Report at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* EC02_T  
* EC02_Z  
* EC02_C  
* EC02_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table S2401, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
S2401 : OCCUPATION BY SEX FOR THE CIVILIAN EMPLOYED POPULATION 16 YEARS AND OVER

### Description of Data Processing: 
All variables were included from S2401.

Percentage of population employed in Essential Jobs was calculated as : 
	* Sum of the workers employed in (
                 Community and social service occupations,
                 Healthcare practitioners and technical occupations,
                 Healthcare support occupations,
                 Protective service occupations,
                 Food preparation and serving related occupations,
                 Building and grounds cleaning and maintenance occupations,
                 Farming, fishing, and forestry occupations,
                 Construction and extraction occupations,
                 Installation, maintenance, and repair occupations,
                 Transportation occupations,
                 Material moving occupations) / (Total Civilian employed population 16 years and over)*


        
### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % Essential Workers  | essnWrkP | Percentage of Population Employed in Community and social service occupations, Healthcare practitioners and technical occupations, Healthcare support occupations,Protective service occupations,Food preparation and serving related occupations, Building and grounds cleaning and maintenance occupations,Farming, fishing, and forestry occupations, Construction and extraction occupations, Installation, maintenance, and repair occupations, Transportation occupations, Material moving occupations |

### Data Limitations:
n/a

### Comments/Notes:
n/a
