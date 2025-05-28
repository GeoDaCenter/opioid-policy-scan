**Meta Data Name**: Hepatitis C Mortality & Prevalence  
**Date Added**: February 8, 2021  
**Author**: Susan Paykin, Wataru Morioka, Mahjabin Kabir Adrita  
**Date Last Modified**: May 7, 2025  
**Last Modified By**: Mahjabin Kabir Adrita

### Theme: 
Outcome

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  

Hepatitis C prevalence and mortality data was sourced from [HepVu](https://hepvu.org/), an online platform that collects, visualizes, and disseminates insights on data related to the viral hepatitis epidemic across the US. HepVu is a _Powered by AIDSVu_ project presented by the Rollins School of Public Health at Emory University in partnership with Gilead Sciences, Inc. 

#### Definitions:
**Hepatitis C Prevalence**: The data reflect persons with a positive or indeterminate anti-Hepatitis C virus (HCV) test and positive HCV RNA test.

**Hepatitis C Mortality**: The data reflect deaths among persons with acute viral hepatitis C or chronic viral hepatitis C as an underlying cause of death.

### Description of Data Source Tables: 

Read the complete descriptions of data source tables at HepVu's [Data Methods](https://hepvu.org/data-methods/). 

**Hepatitis C Prevalence Estimates**:

State-level Hepatitis C prevalence estimates (2013-2016 average) from HepVu were published by the Coalition for Applied Modeling for Prevention (CAMP) researchers. These estimates were calculated using four data sources – National Health and Nutrition Examination Survey (NHANES) (1999-2016), National Vital Statistics System (NVSS) (1999-2016), American Community Survey (ACS) Public Use Microdata Samples (PUMS) (2012-2016), and U.S. Census intercensal data (1999-2016). The Hepatitis C prevalence analyses were restricted to people aged 18 years or older, living within the 50 states and D.C. For a complete description, see HepVu's [Data Methods](https://hepvu.org/data-methods/). 

**Hepatitis C Mortality Data**

The state-level Hepatitis C mortality data presented on HepVu (single-year data from 2005-2017) were obtained from the Centers for Disease Control and Prevention (CDC) WONDER Online Database System and compiled by researchers at the Rollins School of Public Health at Emory University. The CDC WONDER data are collected using information from death certificates of all U.S. residents within the 50 states and D.C. Deaths of residents of other U.S. territories and fetal deaths are not included. Demographic, geographic, and cause-of-death information for each individual is recorded. Any records that included the ICD-10 code for acute viral hepatitis C (B17.1) or chronic viral hepatitis C (B18.2) as the underlying or multiple cause of death were used to identify deaths related to hepatitis C. For a complete description, see HepVu's [Data Methods](https://hepvu.org/data-methods/). 

### Description of Data Processing: 

Data was cleaned and prepared for analysis by aggregating multiple single year datasets for mortality data into single multi-year state-level datasets. Stability levels were removed for dataset preparation but are available for reference in the raw datasets. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

#### Prevalence

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total Hepitatis C virus cases | TotHcv | Mean total yearly Hepitatis C cases from 2013-2016 | 2016 | State |
| Male Hepitatis C virus cases | MlHcv | Mean yearly Hepatitis C cases in men from 2013-2016 | 2016 | State |
| Female Hepitatis C virus cases | FmHcv | Mean yearly Hepatitis C cases in women from 2013-2016 | 2016 | State |
| Under 50 Hepitatis C virus cases | Un50Hcv | Mean yearly Hepatatis C cases in people under 50 years of age from 2013-2016 | 2016 | State |
| Ages between 50 to 74 Hepitatis C virus cases | A50_74Hcv | Mean yearly Hepatitis C cases in people between 50 to 74 years of age from 2013-2016 | 2016 | State |
| Over 75 Hepitatis C virus cases | Ov75Hcv | Mean yearly Hepatitis C cases in people over 75 years of age from 2013-2016 | 2016 | State |
| Black Hepitatis C virus cases | BlkHcv | Mean yearly Hepatitis C cases in populations identified as non-hispanic Black alone across 2013-2016 | 2016 | State |
| Non Black Hepitatis C virus cases | NonBlkHcv | Mean yearly Hepatitis C cases in populations non-Black other race/ethnicity populations 2013-2016 | 2016 | State |


#### Mortality

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Hepitatis C virus Deaths | HcvD | Total Hepatitis C deaths | 2017, 2022 | State, County |
| Male Hepitatis C virus Deaths | MlHcvD | Hepatitis C deaths among men | 2017, 2022 | State |
| Female Hepitatis C virus Deaths | FlHcvD | Hepatitis C deaths among women | 2017, 2022 | State |
| American Indian Hepitatis C virus Deaths | AmInHcvD | Hepatitis C deaths among American Indian populations | 2017, 2022 | State |
| Asian and Pacific Islander Hepitatis C virus Deaths  | AsPiHcvD | Hepatitis C deaths among Asian and Pacific Islander populations | 2017 | State |   
| Asian Hepitatis C virus Deaths | AsHcvD | Hepatitis C deaths among Asian populations | 2022 | State |
| Native Hawaiian and Pacific Islander Hepitatis C virus Deaths | NhPiHcvD | Hepatitis C deaths among Native Hawaiian and Pacific Islander populations | 2022 | State | 
| White Hepitatis C virus Deaths  | WhtHcvD | Hepatitis C deaths among White populations | 2022 | State | 
| Black Hepitatis C virus Deaths  | BlkHcvD | Hepatitis C deaths among Black population | 2017, 2022 | State |
| Hispanic Hepitatis C virus Deaths  | HspHcvD | Hepatitis C deaths among Hispanic populations | 2017, 2022 | State |
| Multiple Races Death Cases Hepitatis C virus Deaths | MulHcvD | Hepatitis C deaths among Multiple Race populations | 2022 | State |
| Under 50 Hepitatis C virus Deaths in 20YY | U50HcvD | Hepatitis C deaths in populations under 50 years of age  | 2017, 2022 | State |
| Ages between 50 to 74 Hepitatis C virus Deaths | A50_74HcvD | Hepatitis C deaths among populations between 50 and 74 years of age | 2017, 2022 | State |
| Over 75 Hepitatis C virus Deaths | O75HcvD | Hepatitis C deaths among populations over 75 years of age | 2017, 2022 | State |
| Average Hepitatis C virus Deaths | AvHcvD | Mean total yearly Hepatitis C deaths from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average Male Hepitatis C virus Deaths| AvMlHcvD | Mean yearly Hepatitis C deaths among men from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average Female Hepitatis C virus Deaths | AvFlHcvD | Mean yearly Hepatitis C deaths among women from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average American Indian Hepitatis C virus Deaths | AvAmInHcvD | Mean yearly Hepatitis C deaths among American Indian population from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average Asian and Pacific Islander Hepitatis C virus Deaths | AvAsPiHcvD | Mean yearly Hepatitis C deaths among Asian and Pacific Islanders population from 2013-2017 | 2017 | State |
| Average Asian Hepitatis C virus Deaths | AvAsHcvD | Mean yearly Hepatitis C deaths among Asian population from 2018-2022 | 2022 | State |
| Native Hawaiian and Pacific Islander Hepitatis C virus Deaths | AvNhPiHcvD | Mean yearly Hepatitis C deaths among Native Hawaiian and Pacific Islanders population from 2018-2022 | 2022 | State |
| Average White Hepitatis C virus Deaths | AvWhtHcvD | Mean yearly Hepatitis C deaths among White populations from 2018-2022 | 2022 | State |
| Average Black Hepitatis C virus Deaths | AvBlkHcvD | Mean yearly Hepatitis C deaths among Black populations from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average Hispanic Hepitatis C virus Deaths | AvHspHcvD | Mean yearly Hepatitis C deaths among Hispanic populations from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average Multiple Races Hepitatis C virus Deaths | AvMulHcvD | Mean yearly Hepatitis C deaths among Multiple Race populations from 2018-2022 | 2022 | State |
| Average Under 50 Hepitatis C virus Deaths| AvU50HcvD | Mean yearly Hepatitis C deaths among people under 50 years of age from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average Ages between 50 to 74 Hepitatis C virus Deaths | AvA50_74HcvD | Mean yearly Hepatitis C deaths among people between 50 and 74 years of age from 2013-2017, 2018-2022 | 2017, 2022 | State |
| Average Over 75 Hepitatis C virus Deaths | AvO75HcvD | Mean yearly Hepatitis C deaths among people over 75 years of age from 2013-2017, 2018-2022 | 2017, 2022 | State |

### Data Limitations: 

N/A

### Comments/Notes:

Data included for Hepatitis C State Mortality is for 2013-2017 and 2018-2022, while Hepatitis C State Prevalence data are available for 2013-2016- Only the mortality data have been updated as of 2025. Hepatitis C deaths for county level is available only for 2018-2020.
