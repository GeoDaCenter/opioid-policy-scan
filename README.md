
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Opioid Environment Program

This repository stores R scripts used to clean, join, and visualize data
for the CSDS opioid environment program. 

The data wrangled in this analysis will be further developed as a data and visualization product (Policy Scan) to characterize the multi-dimensional risk environment impacting the opioid crisis in the United States.

## Data Overview

++ to add grid of all datasets and scales included

We plan to source following data variables.

### Policy Variables
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Medicaid Expansion |  |  |  |  |  |
| Medicaid Expenditure |  |  |  |  |  |
| Naloxone Access Laws |  |  |  |  |  |
| Good Samaritan Laws |  |  |  |  |  |
| PDMP | PDMP policy | OPTIC | PS03 / [PDMP](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/PDMP_2017.md) | State | Complete | 
| Syringe Exchange,<br> Distribution, Possession Laws |  |  |  |  |  |
| Controlled Substance Laws |  |  |  |  |  |
| State & Local Govt. |  |  |  |  |  |
| Expenditure on health, public,<br> welfare, police, correction, etc. |  |  |  |  |  |
| Incarceration rates (Prison) | Prison population rate and prison admission rate by gender and ethnicity | the Vera Institute of Justice | PS01 / [Prison Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/Prison%20variables_2016.md) | County | Complete |
| Incarceration rates (Jail) | Jail population rate by gender and ethnicity | the Vera Institute of Justice | PS02 / [Jail Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/Jail%20variables_2017.md) | County | Complete |
| SDOH Typologies |  |  |  |  |  |

<br>

### Health Factors
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Access to MOUDs | Euclidean distaince to nearest MOUD | U.S. Census, SAMHSA and Vivitrol website | Access01/ [Access: MOUD, Min. Distance](Policy_Scan/data_final/metadata/Access_MOUDs_MinDistance.md) | Tract, Zip | Complete |
| Access to FQHC facilities | Euclidean distance to nearest FQHC | U.S. Census, COVID Atlas/HRSA  | Access02/[Access: FQHC, Min. Distance](Policy_Scan/data_final/metadata/Access_FQHCs_MinDistance.md) | Tract, Zip | Complete |
| Access to Hospitals | Euclidean distance to nearest hospital | U.S. Census, CovidCareMap |  Access03/[Access: Hospitals, Min. Distance](Policy_Scan/data_final/metadata/Acesss_Hospitals_MinDistance.md) | Tract, Zip | Complete |
| Access to Mental Health <br> Practitioners |  |  |  |  |  |
| Access to Pharmacies | Euclidean distance to nearest pharmacy | U.S. Census, Infogroup Inc. Business and Consumer Data 2019 | Access05/[Access: Pharmacies, Min. Distance](Policy_Scan/data_final/metadata/Access_Pharmacies_MinDistance.md) | Tract, Zip | Complete |
| Primary Care Providers |  |  |  |  |  |
| Speciality Care Providers |  |  |  |  |  |
| Opioid overdose death rate |  |  |  |  |  |
| Hepatitis C infection rate |  |  |  |  |  |

<br>

### Demographic Factors
| Variable Construct | Variable Proxy | Source(s) | Tables / Metadata | Spatial Scale | Status<br>(internal use)|
|:-------------------|:---------------|:----------|:------------------|:--------------|:------------------------|
| Black, White percentage | Population with Race identified as Black or African American alone (blackP),<br>Population with Race identified as White alone (whiteP) | 2014 - 2018 ACS | DS01/ [Race & Ethnicity Variables](Policy_Scan/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip | Complete |
| Hispanic Percentage | Population with Ethnicity identified as of Hispanic or Latino origin (hispP) | 2014 - 2018 ACS | DS01 / [Race & Ethnicity Variables](Policy_Scan/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip | Complete |
| Population with a Disability | Civilian Non Institutionalized Population with a Disability (disbP) | 2014 - 2018 ACS | DS01 / [Other Demographic Variables](Policy_Scan/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Complete |
| College Aged | Population b/w ages of 15 & 24 (a15_24P) | 2014 - 2018 ACS | DS01 / [Age Variables](Policy_Scan/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | Complete |
| Population over 65 | Population over 65 (ovr65P) | 2014 - 2018 ACS | DS01 / [Age Variables](Policy_Scan/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | Complete |

<br>

### Economic Factors
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| 'High Risk of Injury' jobs | Population employed in Agriculture, forestry, fishing and hunting, Mining, quarrying, and oil and gas extraction, Construction, Manufacturing, and Utilities industries (hghRskP) | 2014 - 2018 ACS |  EC01/ [Jobs by Industry](Policy_Scan/data_final/metadata/Job_Categories_byIndustry_2018.md)| State, County, Tract, Zip | Complete |
| Unemployment Rate | Unemployment Rate (unempP) | 2014 - 2018 ACS | EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md)| State, County, Tract, Zip | Complete |
| Poverty Rate | Percent below poverty level (povP) | 2014 - 2018 ACS | EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | Complete |
| Per Capita Income | Per capita income in the past 12 months (in 2018 inflation-adjusted dollars) (pciE) | 2014 - 2018 ACS |  EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | Complete |
| Educational Attainment | Population without a High School degree (noHSP) | 2014 - 2018 ACS | DS01 / [Other Demographic Variables](Policy_Scan/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Complete |
| Foreclosure Rate |  |  |  |  |  |
| Socioeconomic Disadvantage Index |  |  |  |  |  |
| Urban Core Opportunity |  |  |  |  |  |

<br>

### Physical Factors
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Urban/Suburban/Rural | Classification of census tracts & zipcodes as rural, urban and suburban using RUCA Codes (rurality), <br> For Counties, percent tracts under each classification (rcaUrbP/rcaSubrbP/rcaRuralP) and percent rurality as calculated by the Census(cenRuralP) | USDA & ACS  | HS02/ [Rural-Urban Classifications](Policy_Scan/data_final/metadata/rural_urban_classifications) | County, Tract, Zip | Complete |
| Housing Occupancy Rate | Percent occupied units (occP) | 2014 - 2018 ACS | HS01/ [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Vacancy Rate | Percent vacant units (vacantP) | 2014 - 2018 ACS | HS01/ [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Long Term Occupancy | Population that moved into current housing 20 years or before | 2014 - 2018 ACS | HS01/ [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Mobile Home Structures | Percent mobile housing structures (mobileP)  | 2014 - 2018 ACS | HS01/ [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Rental Rates | Percent occupied housing units on rent (rentalP)  | 2014 - 2018 ACS | HS01/ [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Housing Unit Density | Housing units per square mile | 2014 - 2018 ACS | HS01/ [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Alcohol Outlet Density |  |  |  |  |  |
| Hypersegregated Cities |  |  |  |  |  |
| Southern Black Belt |  |  |  |  |  |
| Native American Reservations |  |  |  |  |  |

<br>

### COVID Factors
| Variable Construct | Variable Proxy | Source(s) | Metadata Document | Spatial Scale | Status<br>(for Internal team use)|
|:------------------ | -------------- | --------- | ----------------- | ------------- | -------------------------------- |
| Historical Confirmed<br>Case Count & Rate |  |  |  |  |  |
| Historical 7-day Average<br>New Case Count & Rate |  |  |  |  |  |
| Statistical Hotspot/Coldspot |  |  |  |  |  |
| Spatiotemporal Profiles |  |  |  |  |  |
|  Non Pharmaceutical<br>Interventions (NPI) |  |  |  |  |  |
| 'Essential worker' jobs| Population employed in Community and social service occupations, Healthcare practitioners and technical occupations, Healthcare support occupations, Protective service occupations, Food preparation and serving related occupations, Building and grounds cleaning and maintenance occupations, Farming, fishing, and forestry occupations, Construction and extraction occupations, Installation, maintenance, and repair occupations,Transportation occupations, Material moving occupations (essnWrkP) | 2014 - 2018 ACS | EC02/ [Jobs by Occupation](Policy_Scan/data_final/metadata/Job_Categories_byOccupation_2018.md) | State, County, Tract, Zip | Complete |


## Data Wrangling

++ to add chart of data wrangling and cleaning scripts for data

## Access Calculations

| Input                                     | Script   | Output                                    | Purpose                                                                                                                                          |
| ----------------------------------------- | -------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| data/\*                                   | R/01\_\* | data-output/01\_\*                        | Clean original data and get each into 3-column format with `name`, `category_service`, and `geometry`                                            |
| data-output/01\_\*                        | R/02\_\* | data-output/02\_\*                        | Combine datasets together to get combined point dataset (needed for map overlays), create point maps for each resource (for jurisdictional plan) |
| data-output/02\_\*                        | R/03\_\* | data-output/03\_\*                        | **(unused)** Create various buffers on point dataset, count buffers per zip                                                                      |
| data-output/01\_\*                        | R/04\_\* | data-output/min-dists-to-zip-centroid.csv | Calculate min distance from resources to zip centroids                                                                                           |
| data-output/min-dists-to-zip-centroid.csv | R/05\_\* | data-output/sum\_zscores.gpkg/.shp        | Convert centroid distances to summative z-scores                                                                                                 |
| data/carto….                              | R/99\_\* | data-output/carto…                        | One-off cleaning/joining scripts for manipulating CARTO datasets for collaborators                                                               |


## Team

Marynia Kolak (Lead), Qinyun Lin (Postdoc), Moksha Menghaney (Analyst), Angela Li (Analyst).
