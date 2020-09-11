**Meta Data Name**: 2017 Jail variables, part of the Policy dataset  
**Last Modified**: August 26th, 2020  
**Author**: Qinyun Lin  

### Data Location: 
PS02 - Jail variables at the county level. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* PS02_C  

### Data Source(s) Description:  
Variables were obtained from the Vera Institute of Justice. Raw data and more details can be found at https://github.com/vera-institute/incarceration_trends. Raw data is downloaded in the folder of data_raw, named as "incarceration_trends.xlsx". 


### Description of Data Processing: 
The following variables were included from the source data:
1. Total jail population rate;
2. Female jail population rate;
3. Male jail population rate; 
4. Asian American/Pacific Islander jail population rate;
5. Black jail population rate;
6. Latinx jail population rate; 
7. Native American jail population rate;
8. White jail population rate;
9. Total jail admission rate;
10. Pretrial jail population rate. 
 
These rates were calculated using base rate of county population aged 15-64. They argue that "youth under age 15 and adults over 64 are age groups at very low risk of jail incarceration and because the proportion of these groups varies greatly by county." 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total jail population rate | TtlJlPpr | Total Jail Population Rate, ASJ/COJ Data |
| Female jail population rate | FmlJlPpr | Jail Population Rate, Female |
| Male jail population rate | MlJlPpr | Jail Population Rate, Male |
| Asian American/Pacific Islander jail population rate | AapiJlPpr | Jail Population Rate, Asian American / Pacific Islander |
| Black jail population rate | BlckJlPpr | Jail Population Rate, Black |
| Latinx jail population rate | LtnxJlPpr | Jail Population Rate, Latinx |
| Native American jail population rate | NtvJlPpr | Jail Population Rate, Native American |
| White jail population rate | WhtJlPpr | Jail Population Rate, White |
| Total jail admission rate | TtlJlAdmr | Total Jail Admissions Rate, ASJ/COJ Data |
| Pretrial jail population rate | TtlJlPrtr | Pretrial Jail Population Rate |

### Data Limitations:
There are missing data in many counties. 

### Comments/Notes:
No data for four counties in New York (Queen, King, Bronx, and Richmond). 
