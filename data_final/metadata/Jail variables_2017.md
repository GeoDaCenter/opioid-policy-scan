**Meta Data Name**: Jail Incarceration Variables  
**Last Modified**: August 26th, 2020  
**Author**: Qinyun Lin  

### Data Location: 
PS02 - Jail variables at the county level. Files can be found [here](/data_final).
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
10. Pretrial jail population rate;
11. Total jail population count;
12. Female jail population count;
13. Male jail population count; 
14. Asian American/Pacific Islander jail population count;
15. Black jail population count;
16. Latinx jail population count; 
17. Native American jail population count;
18. White jail population count;
19. Total jail admission count;
20. Pretrial jail population count. 
 
These rates were calculated using base rate of county population aged 15-64 and the unit is per 100K people. They argue that "youth under age 15 and adults over 64 are age groups at very low risk of jail incarceration and because the proportion of these groups varies greatly by county." Also note that these rates are jail population relative to the total county population. For example, the female jail population rate is calcualted as the jail female population divided by the female population (aged 15–64) in that county (multiply by 100,000). 

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
| Total jail population count | TtlJlPp | Total Jail Population Count, ASJ/COJ Data |
| Female jail population count | FmlJlPp | Jail Population Count, Female |
| Male jail population count | MlJlPp | Jail Population Count, Male |
| Asian American/Pacific Islander jail population count | AapiJlPp | Jail Population Count, Asian American / Pacific Islander |
| Black jail population count | BlckJlPp | Jail Population Count, Black |
| Latinx jail population count | LtnxJlPp | Jail Population Count, Latinx |
| Native American jail population count | NtvJlPp | Jail Population Count, Native American |
| White jail population count | WhtJlPp | Jail Population Count, White |
| Total jail admission count | TtlJlAdm | Total Jail Admissions Count, ASJ/COJ Data |
| Pretrial jail population count | TtlJlPrt | Pretrial Jail Population Count |

### Data Limitations:
There are missing data in many counties. 

### Comments/Notes:
No data for four counties in New York (Queen, King, Bronx, and Richmond). 
