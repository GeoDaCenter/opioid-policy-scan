
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Opioid Environment Data Warehouse

*Updated April 2021*

## Introduction

The Opioid Environment Policy Scan provides access to data at multiple spatial scales to help characterize the multi-dimensional risk environment impacting opioid use in justice populations across the United States.

This repository stores scripts used to wrangle, clean, join, and visualize data for the Opioid Environment Policy Scan, available to the JCOIN Network through the JCOIN Data Commons. This documentation provides variable metadata and data details for variable constructs included in the Policy Scan. 

The Policy Scan will be further developed as a data visualization product to characterize the multi-dimensional risk environment impacting the opioid crisis in the United States.

For more information, please refer to the full [Data Documentation](https://docs.google.com/document/d/18NPWpuUfFTrKll9_ERHzVDmpNCETTzwjJt_FsIvmSrc/edit?usp=sharing). 

We welcome questions, comments or feedback through our [Request Form](https://docs.google.com/forms/d/e/1FAIpQLSd53yogyubGxepfwQymS_699DIGRpraSNaKb0PEPMl9rCo1Tg/viewform), or contact Susan Paykin at spaykin at uchicago dot edu. 

## Team

This toolkit was developed for the [Justice Community Opioid Innovation Network (JCOIN)](https://heal.nih.gov/research/research-to-practice/jcoin) by [Marynia Kolak](https://github.com/Makosak), [Qinyun Lin](https://github.com/linqinyu), [Susan Paykin](https://github.com/spaykin), Moksha Menghaney, and Angela Li of the [Healthy Regions and Policies Lab](https://voices.uchicago.edu/herop/) and [Center for Spatial Data Science](https://spatial.uchicago.edu/) at the University of Chicago. 

The University of Chicago serves as the JCOIN Methodology and Advanced Analytics Resource Center (MAARC),  providing data infrastructure and statistical and analytic expertise to support individual JCOIN studies and cross-site data synchronization.

JCOIN is part of the NIH HEAL (Helping to End Addiction Long-term<sup>SM</sup>) Initiative. The [NIH HEAL Initiative<sup>SM</sup>](https://heal.nih.gov/) supports a wide range of programs to develop new or improved prevention and treatment strategies for opioid addiction. JCOIN conducts research to address gaps in Opioid Use Disorder (OUD) treatment and related service in a wide range of criminal justice settings, including jails, drug and other problem-solving courts, policing and diversion, re-entry, and probation and parole. 

## Acknowledgements

This research was supported by the National Institute on Drug Abuse, National Institutes of Health, through the NIH HEAL Initiative under award number UG3DA123456. The contents of this publication are solely the responsibility of the authors and do not necessarily represent the official views of the NIH, the Initiative, or the participating sites.

## Data Overview

Variable constructs have been grouped thematically to highlight the multi-dimensional risk environment of opioid use in justice populations.  The variable themes are: **Geographic Boundaries, Policy, Health, Demographic, Economic, Physical Environment,** and **COVID-19**.

For more information about the individual variables, please refer to the data dictionary in the complete [Documentation](https://docs.google.com/document/d/18NPWpuUfFTrKll9_ERHzVDmpNCETTzwjJt_FsIvmSrc/edit?usp=sharing).

### Geographic Boundaries
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | :------------- | :----- | :------- | :------------ | 
| Geographic Boundaries | State, County, Census Tract, Zip Code Tract Area (ZCTA) | US Census, 2018 | [Geographic Boundaries](data_final/metadata/GeographicBoundaries_2018.md) | State, County, Tract, Zip |
| Crosswalk files | County, Census Tract, Zip Code Tract Area (ZCTA) | HUD’s Office of Policy Development and Research (PD&R) | [Crosswalk Files](data_final/metadata/crosswalk.md) | County, Tract, Zip |

### Policy Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | :------------- | :----- | :------- | :------------ | 
| Prison Incarceration Rates | Prison population rate and prison admission rate by gender and ethnicity | Vera Institute of Justice, 2016 | PS01 / [Prison Variables](data_final/metadata/Prison%20variables_2016.md) | County | 
| Jail Incarceration Rates | Jail population rate by gender and ethnicity | Vera Institute of Justice, 2017 | PS02 / [Jail Variables](data_final/metadata/Jail%20variables_2017.md) | County |
| Prescription Drug Monitoring Programs (PDMP) | Any PDMP; Operational PDMP; Must-access PDMP; Electronic PDMP | OPTIC, 2017 | PS03 / [PDMP](data_final/metadata/PDMP_2017.md) | State | 
| Good Samaritan Laws | Any Good Samaritan Law; Good Samaritan Law protecting arrest | OPTIC, 2017 | PS04 / [GSL](data_final/metadata/GSL_2018.md) | State | 
| Naloxone Access Laws |  Any Naloxone law; law allowing distribution through a standing or protocal order; law allowing pharmacists prescriptive authority | OPTIC, 2017 | PS05 / [NAL](data_final/metadata/NAL_2017.md) | State |  
| Medicaid Expenditure | Total Medicaid spending | KFF, 2019 | PS06 / [MedExp](data_final/metadata/MedExp_2019.md) | State | 
| Medicaid Expansion | Spending for adults who have enrolled through Medicaid expansion | KFF, 2018 | PS07 / [MedExpan](data_final/metadata/MedExpan_2018.md) | State | 
| Syringe Services Laws | Laws clarifying legal status for syringe exchange, distribution, and possession programs | LawAtlas, 2019 | PS08 / [Syringe](data_final/metadata/Syringe.md) | State | 
| Medical Marijuana Laws | Law authorizing adults to use medical marijuana | PDAPS, 2017 | PS09 / [MedMarijLaw](data_final/metadata/MedMarijLaw.md) | State |
| State & Local Government Expenditures | Government spending on public health, welfare, public safety, and corrections | US Census, 2018 | PS11 / [Government Expenditures](/data_final/metadata/PublicExpenditures.md) | State, Local |

<br>

### Health Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale |
|:------------------ | :------------- | :----- | :------- | :------------ |
| Drug-related death rate | Death rate from drug-related causes | CDC WONDER, 2009-2019 | Health01 / [Drug-Related Death Rate](data_final/metadata/Health_DrugDeaths.md) | State, County | 
| Hepatitis C infection rate | Hepatitis C infection rate | CDC NNDSS, 2014-2018 | Health02 / [Hepatitis C Rate](data_final/metadata/HepC_rate.md) | State | 
| Physicians | Number of Primary Care and Specialist Physicians | Dartmouth Atlas, 2010 | Health03 / [Physicians](data_final/metadata/Health_PCPs.md) | Tract, County, State | 
| Access to MOUDs | Distance to nearest MOUD | US Census, SAMHSA, Vivitrol, 2020 | Access01 / [Access: MOUDs](/data_final/metadata/Access_MOUDs.md) | Tract, Zip | 
| Access to Health Centers | Distance to nearest FQHC | US Census, US COVID Atlas, HRSA, 2020  | Access02 / [Access: FQHCs](/data_final/metadata/Access_FQHCs_MinDistance.md) | Tract, Zip | 
| Access to Hospitals | Distance to nearest hospital | US Census, CovidCareMap, 2020 |  Access03 / [Access: Hospitals](/data_final/metadata/Acesss_Hospitals_MinDistance.md) | Tract, Zip |
| Access to Mental Health Providers |  Distance to nearest mental health provider | US Census, SAMSHA 2020 |  Access04 / [Access: Mental Health Providers](data_final/metadata/Access_MentalHealth_MinDistance.md) | Tract, Zip |
| Access to Pharmacies | Distance to nearest pharmacy | US Census, InfoGroup 2018 | Access05 / [Access: Pharmacies](/data_final/metadata/Access_Pharmacies_MinDistance.md) | Tract, Zip |

<br>

### Demographic Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Race & Ethnicity | Percentages of population defined by categories of race and ethnicity | ACS, 2014-2018 | DS01/ [Race & Ethnicity Variables](/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip |
| Age | Age group estimates and percentages of population | ACS, 2014-2018 | DS01 / [Age Variables](/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | 
| Population with a Disability | Percentage of population with a disability | ACS, 2014-2018 | DS01 / [Other Demographic Variables](/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | 
| Educational Attainment | Population without a high school degree | ACS, 2014-2018 | DS01 / [Other Demographic Variables](/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | 
| Social Determinants of Health (SDOH) | SDOH Neighborhood Typologies | Kolak et al, 2020 | DS02 / [SDOH Typology](data_final/metadata/SDOH_2014.md) | Tract | 
| Social Vulnerability Index (SVI) | SVI Rankings | CDC, 2018 | DS03 / [SVI](data_final/metadata/SVI_2018.md) | County, Tract | 


<br>

### Economic Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Employment Trends | Percentages of population employed in High Risk of Injury Jobs, Educational Services, Health Care, Retail industries | ACS, 2014-2018 | EC01/ [Jobs by Industry](/data_final/metadata/Job_Categories_byIndustry_2018.md) | State, County, Tract, Zip | 
| Unemployment Rate | Unemployment rate | ACS, 2014-2018 | EC03/ [Economic Variables](/data_final/metadata/Economic_2018.md)| State, County, Tract, Zip | 
| Poverty Rate | Percent classified as below poverty level, based on income | ACS, 2014-2018 | EC03/ [Economic Variables](/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | 
| Per Capita Income | Per capita income in the past 12 months | ACS, 2014-2018 |  EC03/ [Economic Variables](/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | 
| Foreclosure Rate | Mortgage foreclosure and severe delinquency rate | HUD, 2009 | EC04 / [Foreclosure Rate](/data_final/metadata/ForeclosureRate.md) | State, County, Tract | 

<br>

### Physical Environment Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Housing Occupancy Rate | Percent occupied units | ACS, 2014-2018 | HS01 / [Housing Variables](/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Housing Vacancy Rate | Percent vacant units | ACS 2014-2018 | HS01 / [Housing Variables](/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Long Term Occupancy | Percentage of population living in current housing for 20+ years | ACS, 2014-2018 | HS01 / [Housing Variables](/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip |
| Mobile Homes | Percent of housing units classified as mobile homes | ACS, 2014-2018 | HS01 / [Housing Variables](/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Rental Rates | Percent of housing units occupied by renters  | ACS, 2014-2018 | HS01 / [Housing Variables](/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Housing Unit Density | Housing units per square mile | ACS, 2014-2018 | HS01 / [Housing Variables](/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip |
| Urban/Suburban/Rural Classification | Classification of areas as rural, urban or suburban using percent rurality (County) or RUCA Codes (Tract, Zip) | USDA & ACS, 2014-2018 | HS02 / [Rural-Urban Classifications](/data_final/metadata/rural_urban_classifications) | County, Tract, Zip | 
| Alcohol Outlet Density | Alcohol outlets per square mile, alcohol outlets per capita | InfoGroup, 2018 | HS03 / [Alcohol Outlets](/data_final/metadata/AlcoholOutlets_2018.md)  | State, County, Tract, Zip | 
| Hypersegregated Cities | US metropolitan areas where black residents experience hypersegregation | Massey et al, 2015 | HS04 / [Overlay Variables](/data_final/metadata/Overlay.md) | County | 
| Southern Black Belt | US counties where 30% of the population identified as Black or African American | US Census, 2000 | HS04 / [Overlay Variables](/data_final/metadata/Overlay.md) | County | 
| Native American Reservations | Percent area of total land in Native American Reservations | US Census, TIGER, 2018 | HS04 / [Overlay Variables](/data_final/metadata/Overlay.md) | County | 

<br>

### COVID Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Essential Worker Jobs | Percentage of population employed in Essential Jobs as defined during the COVID-19 pandemic | ACS, 2014-2018 | EC02 / [Jobs by Occupation](/data_final/metadata/Job_Categories_byOccupation_2018.md) | State, County, Tract, Zip | 
| Cumulative Case Count | Daily cumulative raw case count (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID01 / [COVID Variables](/data_final/metadata/COVID.md) | State, County | 
| Adjusted Case Count per 100K | Daily cumulative adjusted case count per 100K population (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID02 / [COVID Variables](/data_final/metadata/COVID.md) | State, County |
| 7-day Average Case Count | 7-day average case count (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID03 / [COVID Variables](/data_final/metadata/COVID.md) | State, County | 
| Historical 7-day Average Adjusted Case Count per 100K | 7-day average adjusted case count per 100K population (01/21/20 - 03/03/2021)| The New York Times, 2021 | COVID04 / [COVID Variables](/data_final/metadata/COVID.md) | State, County | 
