**Meta Data Name**: Prison Incarceration Rates  
**Last Modified**: August 26th, 2020  
**Author**: Qinyun Lin  

### Data Location: 
PS01 - Prison variables at the county level. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* PS01_C  

### Data Source(s) Description:  
Variables were obtained from the Vera Institute of Justice. Raw data and more details can be found at https://github.com/vera-institute/incarceration_trends. Raw data is downloaded in the folder of data_raw, named as "incarceration_trends.xlsx". 


### Description of Data Processing: 
The following variables were included from the source data:
 1. Total prison population rate;
 2. Female prison population rate;
 3. Male prison population rate;
 4. Asian American/Pacific Islander prison population rate;
 5. Black prison population rate;
 6. Latinx prison population rate;
 7. Native American prison population rate;
 8. White prison population rate;
 9. Total prison admission rate;
 10. Female prison admission rate;
 11. Male prison admission rate;
 12. Asian American/Pacific Islander prison admission rate;
 13. Black prison admission rate;
 14. Latinx prison admission rate;
 15. Native American prison admission rate;
 16. White prison admission rate.
 
These rates were calculated using base rate of county population aged 15-64. They argue that "youth under age 15 and adults over 64 are age groups at very low risk of jail incarceration and because the proportion of these groups varies greatly by county." 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total prison population rate | TtlPrPpr | Total Prison Population Rate |
| Female prison population rate | FmlPrPpr | Prison Population Rate, Female |
| Male prison population rate | MlPrPpr | Prison Population Rate, Male |
| Asian American/Pacific Islander prison population rate | AapiPrPpr | Prison Population Rate, Asian American / Pacific Islander |
| Black prison population rate | BlckPrPpr | Prison Population Rate, Black |
| Latinx prison population rate | LtnxPrPpr | Prison Population Rate, Latinx |
| Native American prison population rate | NtvPrPpr | Prison Population Rate, Native American |
| White prison population rate | WhtPrPpr | Prison Population Rate, White |
| Total prison admission rate | TtlPrAPpr | Prison Prison Admissions Rate |
| Female prison admission rate | FmlPrAPpr | Prison Admission Rate, Female |
| Male prison admission rate | MlPrAPpr | Prison Admission Rate, Male |
| Asian American/Pacific Islander prison admission rate | AapiPrAPpr | Prison Admission Rate, Asian American / Pacific Islander |
| Black prison admission rate | BlckPrAPpr | Prison Admission Rate, Black |
| Latinx prison admission rate | LtnxPrAPpr | Prison Admission Rate, Latinx |
| Native American prison admission rate | NtvPrAPpr | Prison Admission Rate, Native American |
| White prison admission rate | WhtPrAPpr | Prison Admission Rate, White |

### Data Limitations:
There are missing data in many counties. 

### Comments/Notes:
No data for four counties in New York (Queen, King, Bronx, and Richmond). 
