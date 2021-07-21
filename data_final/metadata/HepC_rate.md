**Meta Data Name**: Hepatitis C Mortality & Prevalence
**Last Modified**: July 20, 2021  
**Author**: Susan Paykin  

### Data Location: 
Datasets labeled Health02, available at the state- and county-levels. Files can be found [here](/data_final).
* Health02_S_Prevalence.csv
* Health02_S_Mortality.csv
* Health02_C_Mortality.csv

### Data Source(s) Description:  

Hepatitis C prevalence and mortality data was sourced from [HepVu](https://hepvu.org/), an online platform that collects, visualizes, and disseminates insights on data related to the viral hepatitis epidemic across the US. HepVu is a _Powered by AIDSVu_ project presented by the Rollins School of Public Health at Emory University in partnership with Gilead Sciences, Inc. 

#### Definitions:
**Hepatitis C Prevalence**: The data reflect persons with a positive or indeterminate anti-Hepatitis C virus (HCV) test and positive HCV RNA test.

**Hepatitis C Mortality**: The data reflect deaths among persons with acute viral hepatitis C or chronic viral hepatitis C as an underlying cause of death. The map title “Deaths related to Hepatitis C” has been used to encompass deaths of persons diagnosed with acute or chronic Hepatitis C.

### Description of Data Source Tables: 

Read the complete descriptions of data source tables at HepVu's [Data Methods](https://hepvu.org/data-methods/). 

**Hepatitis C Prevalence Estimates**:

State-level Hepatitis C prevalence estimates (2013-2016 average) from HepVu were published by the Coalition for Applied Modeling for Prevention (CAMP) researchers. These estimates were calculated using four data sources – National Health and Nutrition Examination Survey (NHANES) (1999-2016), National Vital Statistics System (NVSS) (1999-2016), American Community Survey (ACS) Public Use Microdata Samples (PUMS) (2012-2016), and U.S. Census intercensal data (1999-2016). The Hepatitis C prevalence analyses were restricted to people aged 18 years or older, living within the 50 states and D.C. Rates are expressed as the number of estimated cases per 100,000 people in the population, rounded to the nearest 10 persons. It is an expression of the relative concentration of people with current Hepatitis C infection in an area (state). Estimated cases are rounded to the nearest hundred persons. For a complete description, see HepVu's [Data Methods](https://hepvu.org/data-methods/). 

**Hepatitis C State Mortality Data**

The state-level Hepatitis C mortality data presented on HepVu (single-year data from 2005-2017) were obtained from the Centers for Disease Control and Prevention (CDC) WONDER Online Database System and compiled by researchers at the Rollins School of Public Health at Emory University. The CDC WONDER data are collected using information from death certificates of all U.S. residents within the 50 states and D.C. Deaths of residents of other U.S. territories and fetal deaths are not included. Demographic, geographic, and cause-of-death information for each individual is recorded. Any records that included the ICD-10 code for acute viral hepatitis C (B17.1) or chronic viral hepatitis C (B18.2) as the underlying or multiple cause of death were used to identify deaths related to hepatitis C. For a complete description, see HepVu's [Data Methods](https://hepvu.org/data-methods/). 

**Hepatitis C County Mortality Data**

The county-level hepatitis C mortality data presented on HepVu (single-year data from 2000-2017) were published by Eric Hall, et. al., in a paper titled “County-Level Variation in Hepatitis C Virus Mortality and Trends in the United States, 2005-2017.” These estimates were calculated using data from the National Center for Health Statistics Detailed Multiple Cause of Death (1999-2017) using deaths that listed ICD-10 codes for acute viral hepatitis C (B17.1) and chronic viral hepatitis C (B18.2) as a multiple cause of death. For a complete description, see HepVu's [Data Methods](https://hepvu.org/data-methods/). 

### Description of Data Processing: 

Data was wrangled, cleaned and prepared for analysis. To obtain the 5-year mean (2014-2018), averages were taken for total number and rates for each state. Dataset was then merged with state geometry file in order to add the state FIPS codes (GEOID) and abbreviations. 

### Key Variable and Definitions:


#### State Prevalence

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| State FIPS code | STATEFP | Unique 2-digit identifier for U.S. states |
| State abbreviation | state.abb | Official USPS abbreviation for states |
| State Cases | State Cases | Average, 2013-2016 |
| State Rate  | State Rate  | |
| Male Cases | Male Cases | |
| Male Rate | Male Rate | |
| Female Cases | Female Cases | |  
| Female Rate  | Female Rate ||
| Age Less than 50 Cases | Age Less than 50 Cases | |
| Age Less than 50 Rate | Age Less than 50 Rate
| Age 50-74 Cases | Age 50-74 Cases 
| Age 50-74 Rate  | Age 50-74 Rate  
| Age 75 Plus Cases | Age 75 Plus Cases   
| Age 75 Plus Rate  | Age 75 Plus Rate     
| Black Non-Hispanic Cases | Black Non-Hispanic Cases
| Black Non-Hispanic Rate | Black Non-Hispanic Rate
| Non-Black Other Cases | Non-Black Other Cases 
| Non-Black Other Rate | Non-Black Other Rate 

#### State Mortality

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| State FIPS code | STATEFP | Unique 2-digit identifier for U.S. states |
| State abbreviation | state.abb | Official USPS abbreviation for states |
| State Death Rate |  State Death Rate_20XX | Individual years, 2014-2017 |                      
| Male Death Cases | Male Death Cases_20XX | 
| Male Death Rate | Male Death Rate_20XX |     
| Female Death Cases | Female Death Cases_20XX | 
| Female Death Rate | Female Death Rate_20XX |           
| American Indian/Alaska Native Death Cases | American Indian/Alaska Native Death Cases_20XX |
| American Indian/Alaska Native Death Rate | American Indian/Alaska Native Death Rate_20XX |
| Asian or Pacific Islander Death Cases | Asian or Pacific Islander Death Cases_20XX |
| Asian or Pacific Islander Death Rate | Asian or Pacific Islander Death Rate_20XX |
| Black Death Cases |  Black Death Cases_20XX |          
| Black Death Rate | Black Death Rate_20XX |      
| Hispanic Death Cases | Hispanic Death Cases_20XX |      
| Hispanic Death Rate  | Hispanic Death Rate_20XX |    
| White Death Cases | White Death Cases_20XX |    
| White Death Rate  | White Death Rate_20XX
| Age Less than 50 Death Cases | Age Less than 50 Death Cases_20XX           
| Age Less than 50 Death Rate | Age Less than 50 Death Rate_20XX          
| Age 50-74 Death Cases  | Age 50-74 Death Cases_20XX       
| Age 50-74 Death Rate  | Age 50-74 Death Rate_20XX         
| Age 75 Plus Death Cases | Age 75 Plus Death Cases_20XX
| Age 75 Plus Death Rate | Age 75 Plus Death Rate_20XX 

#### County Mortality

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| County FIPS code | COUNTYP | Unique 5-digit identifier for U.S. counties |
| County name | county | County name |
$ County HCV Death Rate_2014          : num [1:3220] 2.47 4.39 3.94 4.06 3.08 4.57 2.79 3.38 4.01 4.4 ...
 $ Age Less than 40 HCV Death Rate_2014: num [1:3220] 0.15 0.21 0.18 0.25 0.23 0.16 0.16 0.19 0.15 0.2 ...
 $ Age 40+ HCV Death Rate_2014         : num [1:3220] 5.55 9.93 8.93 9.09 6.85 10.4 6.29 7.61 9.13 9.97 ...
 $ County HCV Death Rate_2015          : num [1:3220] 2.23 3.93 3.46 3.61 2.69 3.98 2.56 2.96 3.48 4.03 ...
 $ Age Less than 40 HCV Death Rate_2015: num [1:3220] 0.16 -1 0.18 0.29 0.26 0.15 0.17 0.21 0.15 0.23 ...
 $ Age 40+ HCV Death Rate_2015         : num [1:3220] 4.98 -1 7.79 7.98 5.9 9.05 5.73 6.59 7.89 9.05 ...
 $ County HCV Death Rate_2016          : num [1:3220] 2.35 3.99 3.42 3.47 2.54 3.77 2.64 2.73 3.44 3.99 ...
 $ Age Less than 40 HCV Death Rate_2016: num [1:3220] 0.16 -1 0.19 0.27 0.23 0.17 0.18 0.2 0.16 0.22 ...
 $ Age 40+ HCV Death Rate_2016         : num [1:3220] 5.24 -1 7.69 7.72 5.6 8.57 5.9 6.06 7.76 8.96 ...
 $ County HCV Death Rate_2017          : num [1:3220] 2.29 3.86 3.27 3.36 2.55 3.58 2.63 2.73 3.29 3.78 ...
 $ Age Less than 40 HCV Death Rate_2017: num [1:3220] 0.18 -1 0.17 0.27 0.27 0.14 0.18 0.22 0.16 0.25 ...
 $ Age 40+ HCV Death Rate_2017        

| Average Number | AveNo | Average number of infections, 2014-2018 ave. |
| Average Rate | AveRt | Average rate of infection per 100,000 population |
| Number of infections | No_20XX | Number of infections in given year (2014-2018) |
| Rate of infection | Rt_20XX | Rate of infections per 100,000 population in given year (2014-2018)  |

### Data Limitations: 

Regarding Hepatitus C County Mortality Data, HepVu notes the following [caveat](https://hepvu.org/data-methods/): 

From 2000 to 2017, several county definitions changed (counties were created and consolidated), so a common set of 3115 counties were included in the analysis. For counties that were created out of another county during the time period, HepVu took the death rate from the original county and applied it to the new county. Several counties that were created could not be associated to a singular county and were therefore suppressed. The analysis grouped the New York counties Bronx, Kings, New York, Queens, and Richmond together for the analysis, and therefore the rates listed for each of those counties is the combined death rate of all five counties. Below is a list of counties which were created during the time period paired with the old counties from which their data was pulled:

* La Paz County, AZ (GEO ID 4012) – created from Yuma County, AZ (GEO ID 4027)
* Cibola County, NM (GEO ID 35006) – created from Valencia County, NM (GEO ID 35061)

### Comments/Notes:

Data included for Hepatitis C State and County Mortality is for 2014-2017, while Hepatitis C State Prevalence data are available for 2013-2016
