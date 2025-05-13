**Meta Data Name**: Economic Variables  
**Date Added**: October 22, 2020  
**Authors**: Moksha Menghaney, Susan Paykin, Wataru Morika, Mahjabin Kabir Adrita  
**Date Last Modified**: May 12, 2025  
**Last Modified By**: Wataru Morika, Mahjabin Kabir Adrita

### Theme: 
Economic

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  

Variables were obtained from the [2014 - 2018 American Community Survey (ACS)](https://data.census.gov), tables B19301, DP03, and B19301, at the state, county, tract and ZIP Code Tabulation Area (ZCTA) levels.

The ACS is an ongoing survey that provides vital information on a yearly basis about our nation and its people. Learn more about the ACS [here](https://www.census.gov/programs-surveys/acs/about.html). 

### Description of Data Source Tables:

**Table B19301**: Per capita income in the past 12 months (in 2018 inflation-adjusted dollars) <br>

**Table DP03**: Selected Economic Characteristics <br>

**Table S1701:** Poverty status in the past 12 months

### Description of Data Processing: 

The following variables were included from **B19301**.

  * **Estimate; Per capita income in the past 12 months (in 2018 inflation-adjusted dollars)**. Per capita income is the mean income computed for every man, woman, and child in a particular group including those living in group quarters. It is derived by dividing the aggregate income of a particular group by the total population in that group. This measure is rounded to the nearest whole dollar. Note: Employment and unemployment estimates may vary from the official labor force data released by the Bureau of Labor Statistics because of differences in survey design and data collection. 
  
The following variables were included from **DP03**:
  * **Percent estimate; Unemployment Rate**. The unemployment rate represents the number of unemployed individuals as a percentage of the civilian labor force. 
 
The following variables were included from **S1701**:
  * **Percent Estimate; Percent below poverty level**. The total number of people below the poverty level is the sum of people in families and the number of unrelated individuals with incomes in the last 12 months below the poverty threshold. Note: Poverty status was determined for all people except institutionalized people, people in military group quarters, people in college dormitories, and unrelated individuals under 15 years old. These groups were excluded from the numerator and denominator when calculating poverty rates.

For more on variable definitions, see [ACS 2018 Subject Definitions](https://www2.census.gov/programs-surveys/acs/tech_docs/subject_definitions/2018_ACSSubjectDefinitions.pdf). 
  
### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Unemployment Rate | UnempP | The number of unemployed individuals as a percentage of the civilian labor force | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |
| Alt. Unemployment Rate | UnempP2         | Alternative unemployment rate (specific subgroup)               | 2020, 2023       | Tract, County, ZCTA     |
| Poverty Rate | PovP | Number of individuals earning below the poverty income threshold as a percentage of the total population | 1980, 1990, 2000, 2010, Latest | Tract, Zip*, County, State |
| Median Income | MedInc | Median income for individuals in the past 12 months (in 2018 inflation-adjusted dollars) | 2010, Latest | Tract, Zip*, County, State |
| Per Capita Income | PciE | Mean income for individuals in the past 12 months (in 2018 inflation-adjusted dollars) | 2010, Latest | Tract, Zip*, County, State |
| Gini Coefficient | GiniCoeff | Income Inequality (Gini Coefficient) | 2010, Latest | Tract, Zip*, County, State |

### Data Limitations:
The ACS does not gather information in the U.S. territories American Samoa, Guam, Northern Mariana Islands and U.S. Virgin Islands. It does include information for Puerto Rico & Washington, D.C.  
*Note that the Zip code scale data is only available for the "latest" file.

### Comments/Notes:
For complete definitions of ACS variables described above, please refer to the [American Community Survey & Puerto Rico Community Survey 2018 Subject Definitions](https://www2.census.gov/programs-surveys/acs/tech_docs/subject_definitions/2018_ACSSubjectDefinitions.pdf). 
