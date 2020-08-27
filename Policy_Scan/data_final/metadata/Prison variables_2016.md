**Meta Data Name**: 2016 Prison variables, part of the Policy dataset  
**Last Modified**: August 26th, 2020  
**Author**: Qinyun Lin  

### Data Location: 
PS01 - Prison variables at the county level. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* PS01_C  

### Data Source(s) Description:  
Variables were obtained from the Vera Institute of Justice. Raw data and more details can be found at https://github.com/vera-institute/incarceration_trends. Raw data is downloaded in the folder of data_raw, named as "incarceration_trends.xlsx". 


### Description of Data Processing: 
The following variables were included from the source data:
 1. total_prison_pop_rate
 2. female_prison_pop_rate
 3. male_prison_pop_rate
 4. aapi_prison_pop_rate
 5. black_prison_pop_rate
 6. latinx_prison_pop_rate
 7. native_prison_pop_rate
 8. white_prison_pop_rate
 9. total_prison_adm_rate
 10. female_prison_adm_rate
 11. male_prison_adm_rate
 12. aapi_prison_adm_rate
 13. black_prison_adm_rate
 14. latinx_prison_adm_rate
 15. native_prison_adm_rate
 16. white_prison_adm_rate
 
These rates were calculated using base rate of county population aged 15-64. They argue that "youth under age 15 and adults over 64 are age groups at very low risk of jail incarceration and because the proportion of these groups varies greatly by county." 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total prison population rate | total_prison_pop_rate | Total Prison Population Rate |
| Female prison population rate | female_prison_pop_rate | Prison Population Rate, Female |
| Male prison population rate | male_prison_pop_rate | Prison Population Rate, Male |
| Asian American/Pacific Islander prison population rate | aapi_prison_pop_rate | Prison Population Rate, Asian American / Pacific Islander |
| Black prison population rate | black_prison_pop_rate | Prison Population Rate, Black |
| Latinx prison population rate | latinx_prison_pop_rate | Prison Population Rate, Latinx |
| Native American prison population rate | native_prison_pop_rate | Prison Population Rate, Native American |
| White prison population rate | white_prison_pop_rate | Prison Population Rate, White |
| Total prison admission rate | total_prison_adm_rate | Prison Prison Admissions Rate |
| Female prison admission rate | female_prison_adm_rate | Prison Admission Rate, Female |
| Male prison admission rate | male_prison_adm_rate | Prison Admission Rate, Male |
| Asian American/Pacific Islander prison admission rate | aapi_prison_adm_rate | Prison Admission Rate, Asian American / Pacific Islander |
| Black prison admission rate | black_prison_adm_rate | Prison Admission Rate, Black |
| Latinx prison admission rate | latinx_prison_adm_rate | Prison Admission Rate, Latinx |
| Native American prison admission rate | native_prison_adm_rate | Prison Admission Rate, Native American |
| White prison admission rate | white_prison_adm_rate | Prison Admission Rate, White |

### Data Limitations:
There are missing data in many counties. 

### Comments/Notes:
No data for four counties in New York (Queen, King, Bronx, and Richmond). 
