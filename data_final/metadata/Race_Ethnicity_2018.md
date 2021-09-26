**Meta Data Name**: Race and Ethnicity Variables  
**Last Modified**: March 15, 2021  
**Author**: Moksha Menghaney & Susan Paykin 

### Data Location: 
DS01 at 4 spatial scales. Files can be found [here](/data_final).
* DS01_T  
* DS01_Z  
* DS01_C  
* DS01_S  

### Data Source(s) Description:  
Variables were obtained from the 2018 5-year average American Community Survey (ACS), table B02001, B03002, at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://data.census.gov.

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
| % White  | whiteP | Percentage of population with race identified as white alone |
| % Black  | blackP | Percentage of population with race identified as Black or African American alone |
| % Hispanic | hispP | Percentage of population with ethnicity identified as of Hispanic or Latinx origin |
| % American Indian | amIndP | Percentage of population with race identified as Native American or Alaska Native alone |
| % Asian  | asianP | Percentage of population with race identified as Asian alone |
| % Native Hawaiian | pacIsP | Percentage of population with race identified as Native Hawaiian and Other Pacific Islander alone |
| % Other | otherP | Percentage of Population with race not mentioned in any of the options above (includes two race or more races) |

### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average.

### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as blank or _NA_.
