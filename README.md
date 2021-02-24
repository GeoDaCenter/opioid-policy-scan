
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Opioid Environment Program

This repository stores R scripts used to wrangle, clean, join, and visualize data
for the CSDS opioid environment program. 

The data included in this analysis will be further developed as a Policy Scan data and visualization product to characterize the multi-dimensional risk environment impacting the opioid crisis in the United States.

## Data Overview

### Policy Variables
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Medicaid Expansion | Spending for adults who have enrolled through ACA's expansion | KFF | PS07 / [MedExpan](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/MedExpan_2018.md) | State | Complete |
| Medicaid Expenditure | Total medicaid spending | KFF | PS06 / [MedExp](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/MedExp_2019.md) | State | Complete |
| Naloxone Access Laws |  Any Naloxone law; Naloxone law allowing distribution through a standing or protocal order effective; Naloxone law allowing pharmacists prescriptive authority | OPTIC | PS05 / [NAL](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/NAL_2017.md) | State | Complete | 
| Good Samaritan Laws | Any Good Samaritan Law; Good Samaritan Law protecting arrest | OPTIC | PS04 / [GSL](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/GSL_2018.md) | State | Complete | 
| PDMP | Any PDMP; Operational PDMP; Must-access PDMP; Electronic PDMP | OPTIC | PS03 / [PDMP](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/PDMP_2017.md) | State | Complete | 
| Syringe Exchange,<br> Distribution, Possession Laws | Laws clarifying legal status for syringe services programs | LawAtlas | PS08 / [Syringe](Policy_Scan/data_final/metadata/Syringe.md) | State | Complete |
| Controlled Substance Laws |  |  |  |  |  |
| State & Local Govt. Expenditure on health, public,<br> welfare, police, correction, etc. |  |  |  |  |  |
| Incarceration rates (Prison) | Prison population rate and prison admission rate by gender and ethnicity | Vera Institute of Justice | PS01 / [Prison Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/Prison%20variables_2016.md) | County | Complete |
| Incarceration rates (Jail) | Jail population rate by gender and ethnicity | Vera Institute of Justice | PS02 / [Jail Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/Jail%20variables_2017.md) | County | Complete |
| SDOH Typologies |  |  |  |  |  |

<br>

### Health Variables
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Access to MOUDs | Distance to nearest MOUD | U.S. Census, SAMHSA, Vivitrol | Access01 / [Access: MOUDs](Policy_Scan/data_final/metadata/Access_MOUDs_MinDistance.md) | Tract, Zip | Complete |
| Access to FQHC facilities | Distance to nearest FQHC | U.S. Census, COVID Atlas/HRSA  | Access02 / [Access: FQHCs](Policy_Scan/data_final/metadata/Access_FQHCs_MinDistance.md) | Tract, Zip | Complete |
| Access to Hospitals | Distance to nearest hospital | U.S. Census, CovidCareMap |  Access03 / [Access: Hospitals](Policy_Scan/data_final/metadata/Acesss_Hospitals_MinDistance.md) | Tract, Zip | Complete |
| Access to Mental Health Providers |  Distance to nearest mental health provider | U.S. Census, SAMSHA |  Access04 / [Access: Mental Health Providers](Policy_Scan/data_final/metadata/Acesss_MentalHealth_MinDistance.md) | Tract, Zip | Complete |
| Access to Pharmacies | Distance to nearest pharmacy | U.S. Census, Infogroup | Access05 / [Access: Pharmacies](Policy_Scan/data_final/metadata/Access_Pharmacies_MinDistance.md) | Tract, Zip | Complete |
| Drug-related death rate | Death rate from drug-related causes | CDC WONDER | Health01 / [Drug-Related Death Rate](Policy_Scan/data_final/metadata/Health_DrugDeaths.md) | State, County | Complete |
| Hepatitis C infection rate | Hepatitis C infection rate | CDC NNDSS | Health02 / [Hepatitis C Rate](Policy_Scan/data_final/metadata/HepC_rate.md) | State | Complete |
| Primary Care Providers |  |  |  |  |  |
| Speciality Care Providers |  |  |  |  |  |


<br>

### Demographic Variables
| Variable Construct | Variable Proxy | Source(s) | Tables / Metadata | Spatial Scale | Status<br>(internal use)|
|:-------------------|:---------------|:----------|:------------------|:--------------|:------------------------|
| Black, White percentage | Population with Race identified as Black or African American alone (blackP),<br>Population with Race identified as White alone (whiteP) | 2014 - 2018 ACS | DS01/ [Race & Ethnicity Variables](Policy_Scan/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip | Complete |
| Hispanic Percentage | Population with Ethnicity identified as of Hispanic or Latino origin (hispP) | 2014 - 2018 ACS | DS01 / [Race & Ethnicity Variables](Policy_Scan/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip | Complete |
| Population with a Disability | Civilian Non Institutionalized Population with a Disability (disbP) | 2014 - 2018 ACS | DS01 / [Other Demographic Variables](Policy_Scan/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Complete |
| College Aged | Population b/w ages of 15 & 24 (a15_24P) | 2014 - 2018 ACS | DS01 / [Age Variables](Policy_Scan/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | Complete |
| Population over 65 | Population over 65 (ovr65P) | 2014 - 2018 ACS | DS01 / [Age Variables](Policy_Scan/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | Complete |

<br>

### Economic Variables
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| 'High Risk of Injury' jobs | Population employed in Agriculture, forestry, fishing and hunting, Mining, quarrying, and oil and gas extraction, Construction, Manufacturing, and Utilities industries (hghRskP) | 2014 - 2018 ACS |  EC01/ [Jobs by Industry](Policy_Scan/data_final/metadata/Job_Categories_byIndustry_2018.md)| State, County, Tract, Zip | Complete |
| Unemployment Rate | Unemployment Rate (unempP) | 2014 - 2018 ACS | EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md)| State, County, Tract, Zip | Complete |
| Poverty Rate | Percent below poverty level (povP) | 2014 - 2018 ACS | EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | Complete |
| Per Capita Income | Per capita income in the past 12 months (in 2018 inflation-adjusted dollars) (pciE) | 2014 - 2018 ACS |  EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | Complete |
| Educational Attainment | Population without a High School degree (noHSP) | 2014 - 2018 ACS | DS01 / [Other Demographic Variables](Policy_Scan/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Complete |
| Foreclosure Rate | Mortgage foreclosure and severe delinquency rates | HUD, CFPB | EC04 / [Foreclosure Rate](Policy_Scan/data_final/metadata/ForeclosureRate.md) | State, County, Tract | Complete |
| Socioeconomic Disadvantage Index |  |  |  |  |  |
| Urban Core Opportunity |  |  |  |  |  |

<br>

### Physical Variables
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Urban/Suburban/Rural | Classification of census tracts & zipcodes as rural, urban and suburban using RUCA Codes (rurality), <br> For Counties, percent tracts under each classification (rcaUrbP/rcaSubrbP/rcaRuralP) and percent rurality as calculated by the Census (cenRuralP) | USDA & ACS  | HS02 / [Rural-Urban Classifications](Policy_Scan/data_final/metadata/rural_urban_classifications) | County, Tract, Zip | Complete |
| Housing Occupancy Rate | Percent occupied units (occP) | 2014 - 2018 ACS | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Vacancy Rate | Percent vacant units (vacantP) | 2014 - 2018 ACS | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Long Term Occupancy | Population that moved into current housing 20 years or before | 2014 - 2018 ACS | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Mobile Home Structures | Percent mobile housing structures (mobileP)  | 2014 - 2018 ACS | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Rental Rates | Percent occupied housing units on rent (rentalP)  | 2014 - 2018 ACS | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Housing Unit Density | Housing units per square mile | 2014 - 2018 ACS | HS01/ [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Alcohol Outlet Density | Alcohol outlets per sq mile and per capita | Infogroup  | HS03 / [Physical Factors](Policy_Scan/data_final/metadata/AlcoholOutlets_2018.md)  | State, County, Tract, Zip | Complete |
| Hypersegregated Cities | American metropolitan areas where black residents experience hypersegregation | Massey, D. S., Tannen, J. (2015) | HS04 / [Overlay Variables](Policy_Scan/data_final/metadata/Overlay.md) | County | Complete |
| Southern Black Belt | Southern US counties that were at least 40% Black or African American in the 2000 Census |  | HS04 / [Overlay Variables](Policy_Scan/data_final/metadata/Overlay.md) | County | Complete |
| Native American Reservations | Percent area of total land in Native American Reservations | US Census, TIGER (2010) | HS04 / [Overlay Variables](Policy_Scan/data_final/metadata/Overlay.md) | County | Complete |

<br>

### COVID Factors
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Historical Cumulative <br>Case Count & Rate | Data for first day of month, March 2020 - Jan 2021 |  |  | State, County |  |
| Historical 7-day Average<br>New Case Count & Rate | Data for first day of month, March 2020 - Jan 2021 |  |  | State, County |  |
| 'Essential worker' jobs| Percentage of population employed in occupations deemed essential during COVID-19 crisis | 2014 - 2018 ACS | EC02 / [Jobs by Occupation](Policy_Scan/data_final/metadata/Job_Categories_byOccupation_2018.md) | State, County, Tract, Zip | Complete |


## Team

Marynia Kolak (Lead), Qinyun Lin (Postdoc), Susan Paykin (Analyst), Moksha Menghaney (Former Analyst), Angela Li (Former Analyst).
