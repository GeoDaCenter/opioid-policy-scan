**Meta Data Name**: Veteran Population  
**Date Added**: July 21, 2021  
**Author**: Ally Muszynski  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Social

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table B21001, at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Table:
B21001 : Provides breakdown by veteran population by total population

### Description of Data Processing: 
The following variables were included from the source data:
1. Total population 
2. Total veteran population;

These rates were calculated using sex by age by veteran status for the civilian population 18 years and over.

----------
* Percentage for veteran group population was calculated as: *estimate for the group / totalpopulation*, e.g. *% Veteran = Veteran population / Total population* 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total Veteran Population  | TotVetPop | Total veteran population | 2010, Latest | Tract, Zip*, County, State |
| Percent Veteran  |  VetP  | Percent of population that are veterans | 2010, Latest | Tract, Zip*, County, State |

### Data Limitations
These rates were calculated using sex by age by veteran status for the civilian population 18 years and over.  
*Note that the Zip code scale data is only available for the "latest" file.
  
### Comments/Notes
**Note on missing data:** Missing and/or unavailable data are represented as blank cells or _NA_.
