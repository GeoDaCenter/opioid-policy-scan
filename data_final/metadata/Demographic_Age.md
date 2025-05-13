**Meta Data Name**: Demegraphic and Age Variables  
**Date Added**: October 16, 2020  
**Author**: Moksha Menghaney & Susan Paykin, Wataru Morioka, Mahjabin Kabir Adrita 
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita

### Theme: 
Social 

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table S0101, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
S0101 : Age & Sex

### Description of Data Processing: 
The following variables were included from **S0101**:
  1.	Estimate; Age – Under 5 years
  2.	Estimate; Selected Age Categories – 5 to 14 years
  3.	Estimate; Age – 15 to 19 years 
  4.	Estimate; Age – 20 to 24 years 
  5.	Estimate; Selected Age Categories - 15 to 44 years
  6.	Estimate; Age - 45 to 49 years
  7.	Estimate; Age - 50 to 54 years
  8.	Estimate; Age - 55 to 59 years
  9.	Estimate; Age - 60 to 64 years
  10.	Estimate; Selected Age Categories – 65 years and over
  11.	Estimate; Selected Age Categories – 18 years and over

----------
Three age categories were calculated using these variables, population between age 15-24, population under the age of 45 and population over the age of 65. 
All three variables were then converted to percentages using total population as the base.

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total population | TotPop | Total population | 1980, 1990, 2000, Latest | Tract, Zip*, County, State |
| Percent female population         | FemP                | Percent of population identifying as female             | 2020, 2023           | Tract, ZCTA, County    |
| Average household size            | HHSize              | Average number of persons per household                 | 2020, 2023           | Tract, ZCTA, County    |
| Percent male population           | MaleP               | Percent of population identifying as male               | 2020, 2023           | Tract, ZCTA, County    |
| Median age                        | MedAge              | Median age of the population                            | 2020, 2023           | Tract, ZCTA, County    |
| Percent identifying as 2+ races   | TwoRaceP            | Percent of population identifying as two or more races  | 2020, 2023           | Tract, ZCTA, County    |

| Total population at or over age 65 | AgeOv65 | Total population at or over age 65 | 2010, Latest | Tract, Zip*, County, State |
| Total population at or over age 18 | AgeOv18 | Total population at or over age 18 | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |
| % Population Children | ChildrenP | Percentage of population under age 18 | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |
| % Population between 15-24 years | A15_24P | Percentage of population between ages of 15 & 24 | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |
| % Population under 45  | Und45P | Percentage of population below 45 years of age | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |
| % Population over 65 | Ovr65P | Percentage of population over 65 | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |


### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average.  
*Note that the Zip code scale data is only available for the "latest" file.

### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as -999. 
