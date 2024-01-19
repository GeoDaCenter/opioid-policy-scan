**Meta Data Name**: Drug-Related Death Rate  
**Date Added**: February 5, 2021  
**Author**: Susan Paykin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka

### Theme: 
Outcome

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  

Data on drug-related deaths was sourced from the US CDC's [Underlying Cause of Death, 2009-2019](https://wonder.cdc.gov/ucd-icd10.html) dataset, available through [CDC WONDER](https://wonder.cdc.gov/). This dataset includes national, state, county, and regional mortality data from 1999-2019, including number of deaths, crudge death rates, and age-adjusted death rates. This data can be obtained by place of residence, age group (single-year-of age, 5-year age groups, 10-year age groups and infant age groups), race, Hispanic ethnicity, gender, year, cause-of-death (4-digit ICD-10 code or group of codes), injury intent and injury mechanism, drug/alcohol induced causes and urbanization categories. 

The mortality data are based on information from all death certificates filed in the fifty states and the District of Columbia. Deaths of nonresidents (e.g. nonresident aliens, nationals living abroad, residents of Puerto Rico, Guam, the Virgin Islands, and other territories of the U.S.) and fetal deaths are excluded. Mortality data from the death certificates are coded by the states and provided to NCHS through the Vital Statistics Cooperative Program or coded by NCHS from copies of the original death certificates provided to NCHS by the State registration offices. For more information, see [CDC](https://wonder.cdc.gov/wonder/help/ucd.html#).

### Description of Data Source Tables: 

Data was aggregated to state and county-levels, including total population and total deaths, for all demographics, times, and places for the period 2009-2018. The following **ICD-10 codes** were included:  

#### Drug-induced diseases
D52.1, D59.0, D59.2, D61.1, D64.2, E06.4, E23.1, E24.2, E27.3, G24.0, G25.1, G25.4, G25.6, G72.0, J70, K03.2, K73, K85.3, L10.5, M10.2, M81.4, M87.1

#### Mental/behavioral disorders due to drugs
F10-F19 

#### Drugs in the blood
R78, R82.5, R83.2-R89.2 

#### Poisoning of undetermined intent by exposure to drugs
X40-44, Y10-Y14, Y50.1 

#### Accidental poisoning, intentional self-poisoning
X60-X64 

### Description of Data Processing: 

Data was wrangled, cleaned and filtered for the 48 contiguous US states & Washington, D.C. The adjusted death rate (per 100,000 residents) was calculated by dividing total deaths by total population, multiplied by 100,000 (death / pop * 100,000). 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Deaths | DrgRlDth | Total deaths from drug-related causes, 2009-2018 | Latest | County, State |

### Data Limitations: 

County-level and other subnational data representing fewer than ten persons (0-9) are suppressed for year 1989 and later years, including our years of interest 2009-2018. Furthermore, rates may be considered "unreliable" when the death count is less than 20. For more information, see [CDC](https://wonder.cdc.gov/wonder/help/ucd.html#). 

### Comments/Notes:

This dataset includes data for the 48 contiguous U.S. states and Washington, D.C. It does not include Alaska, Hawaii, or the U.S. territories: Puerto Rico, Guam, American Samoa, Northern Mariana Islands, U.S. Virgin Islands.
