**Meta Data Name**: Jail Incarceration Variables  
**Date Added**: September 11, 2020  
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
Variables were obtained from the Vera Institute of Justice. Raw data and more details can be found at https://github.com/vera-institute/incarceration_trends. Raw data is downloaded in the folder of data_raw, named "incarceration_trends.xlsx". 


### Description of Data Processing: 
The following variables were included from the source data:
1. Total jail population rate;
2. Total jail admission rate;
3. Pretrial jail population rate;
4. Total jail population count;
5. Total jail admission count;
6. Pretrial jail population count. 
 
These rates were calculated using base rate of county population aged 15-64 and the unit is per 100K people. They argue that "youth under age 15 and adults over 64 are age groups at very low risk of jail incarceration and because the proportion of these groups varies greatly by county." Also, note that these rates are jail population relative to the total county population. For example, the female jail population rate is calculated as the jail female population divided by the female population (aged 15–64) in that county (multiplied by 100,000). 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total jail population rate | TtlJlPpr | Total Jail Population Rate, ASJ/COJ Data | Latest | County |
| Total jail admission rate | TtlJlAdmr | Total Jail Admissions Rate, ASJ/COJ Data | Latest | County |
| Pretrial jail population rate | TtlJlPrtr | Pretrial Jail Population Rate | Latest | County |
| Total jail population count | TtlJlPp | Total Jail Population Count, ASJ/COJ Data | Latest | County |
| Total jail admission count | TtlJlAdm | Total Jail Admissions Count, ASJ/COJ Data | Latest | County |
| Pretrial jail population count | TtlJlPrt | Pretrial Jail Population Count | Latest | County |

### Data Limitations:
There is missing data in many counties. 

### Comments/Notes:
No data for four counties in New York (Queen, King, Bronx, and Richmond). 
