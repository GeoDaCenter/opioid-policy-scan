**Meta Data Name**: Prison Incarceration Rates  
**Date Added**: August 26th, 2020  
**Author**: Qinyun Lin  
**Date Last Modified**: Nov 1, 2024  
**Last Modified By**: Adam Cox

### Theme: 
Policy  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Variables were obtained from the Vera Institute of Justice. Raw data and more details can be found at https://github.com/vera-institute/incarceration_trends. Raw data is downloaded in the folder of data_raw, named as "incarceration_trends.xlsx". 


### Description of Data Processing: 
The following variables were included from the source data:
 1. Total prison population rate;
 2. Total prison admission rate;
 3. Total prison population count;
 4. Total prison admission count;

 
These rates were calculated using base rate of county population aged 15-64. They argue that "youth under age 15 and adults over 64 are age groups at very low risk of jail incarceration and because the proportion of these groups varies greatly by county." 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total prison population rate | TtlPrPpr | Total Prison Population Rate | Latest | County |
| Total prison admission rate | TtlPrAPpr | Prison Prison Admissions Rate | Latest | County |
| Total prison population count | TtlPrPp | Total Prison Population Count| Latest | County |
| Total prison admission count | TtlPrAPp | Prison Prison Admissions Count | Latest | County |

### Data Limitations:
There are missing data in many counties. 

### Comments/Notes:
No data for four counties in New York (Queen, King, Bronx, and Richmond). 
