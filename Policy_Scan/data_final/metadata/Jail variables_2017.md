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
 1. total_jail_pop_rate
 2. female_jail_pop_rate
 3. male_jail_pop_rate
 4. aapi_jail_pop_rate
 5. black_jail_pop_rate
 6. latinx_jail_pop_rate
 7. native_jail_pop_rate
 8. white_jail_pop_rate
 9. total_jail_adm_rate
 10. total_jail_pretrial_rate
 
These rates were calculated using base rate of county population aged 15-64. They argue that "youth under age 15 and adults over 64 are age groups at very low risk of jail incarceration and because the proportion of these groups varies greatly by county." 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total jail population rate | total_jail_pop_rate | Total Jail Population Rate, ASJ/COJ Data |
| Female jail population rate | female_jail_pop_rate | Jail Population Rate, Female |
| Male jail population rate | male_jail_pop_rate | Jail Population Rate, Male |
| Asian American/Pacific Islander jail population rate | aapi_jail_pop_rate | Jail Population Rate, Asian American / Pacific Islander |
| Black jail population rate | black_jail_pop_rate | Jail Population Rate, Black |
| Latinx jail population rate | latinx_jail_pop_rate | Jail Population Rate, Latinx |
| Native American jail population rate | native_jail_pop_rate | Jail Population Rate, Native American |
| White jail population rate | white_jail_pop_rate | Jail Population Rate, White |
| Total jail admission rate | total_jail_adm_rate | Total Jail Admissions Rate, ASJ/COJ Data |
| Pretrial jail population rate | total_jail_pretrial_rate | Pretrial Jail Population Rate |

### Data Limitations:
There are missing data in many counties. 

### Comments/Notes:
No data for four counties in New York (Queen, King, Bronx, and Richmond). 
