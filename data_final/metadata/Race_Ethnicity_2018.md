**Meta Data Name**: Race and Ethnicity Variables  
**Date Added**: July 8, 2021  
**Author**: Moksha Menghaney & Susan Paykin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Social

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

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

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| % White  | WhiteP | Percentage of population with race identified as white alone | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| % Black  | BlackP | Percentage of population with race identified as Black or African American alone | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| % Hispanic | HispP | Percentage of population with ethnicity identified as of Hispanic or Latinx origin | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| % American Indian | AmIndP | Percentage of population with race identified as Native American or Alaska Native alone | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| % Asian  | AsianP | Percentage of population with race identified as Asian alone | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| % Native Hawaiian | PacIsP | Percentage of population with race identified as Native Hawaiian and Other Pacific Islander alone | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| % Other | OtherP | Percentage of Population with race not mentioned in any of the options above (includes two race or more races) | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |

### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average.

### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as blank or _NA_.
