**Meta Data Name**: 2018 Race and Ethnicity variables, part of the Demographic Social dataset  
**Last Modified**: October 16th, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
DS01 - Policy Scan Environment Report at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* DS01_T  
* DS01_Z  
* DS01_C  
* DS01_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table B02001, B03002, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
B02001 : Provides breakdown by Race of the total population. <br>
B03002 : Hispanic or Latino origin by race table, provides ethnicity breakdown of the total population.

### Description of Data Processing: 
The following variables were included from **B02001**:  
  1.	Estimate; Race – Total Population  
  2.	Estimate; Race – White alone 
  3.	Estimate; Race – Black or African American alone 
  4.	Estimate; Race – American Indian and Alaska Native alone 
  5.	Estimate; Race – Asian alone 
  6.	Estimate; Race – Native Hawaiian and Other Pacific Islander alone 

The following variables were included from **B03002**:
  1.	Estimate; Hispanic or Latino – Total  

----------
* Percentage for each racial/ethnic group was calculated as: *estimate for the group / total population*, e.g.
  -  *% White = White alone / Total population* 
  -  *% Other  = 1 - (% White alone + % Black alone + % American Indian alone + % Asian alone + % Native Hawaiian alone)*

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % White  | whiteP | Percentage of Population with Race identified as White alone |
| % Black  | blackP | Percentage of Population with Race identified as Black or African American alone |
| % American Indian | amIndP | Percentage of Population with Race identified as American Indian and Alaska Native alone |
| % Asian  | asianP | Percentage of Population with Race identified as Asian alone |
| % Native Hawaiian | pacIsP | Percentage of Population with Race identified as Native Hawaiian and Other Pacific Islander alone |
| % Other | otherP | Percentage of Population with Race not mentioned in any of the options above (includes two race or more races) |
| % Hispanic | hispP | Percentage of Population with Ethnicity identified as of Hispanic or Latino origin |

### Data Limitations:
n/a

### Comments/Notes:
n/a
