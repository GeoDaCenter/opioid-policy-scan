
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Opioid Environment Data Warehouse

This repository stores R scripts used to wrangle, clean, join, and visualize data
for the JCOIN Opioid Environment Data Warehouse.

The data included in this analysis will be further developed as a data and visualization product to characterize the multi-dimensional risk environment impacting the opioid crisis in the United States.

Data requests and feedback can be submitted [here](https://docs.google.com/forms/d/e/1FAIpQLSd53yogyubGxepfwQymS_699DIGRpraSNaKb0PEPMl9rCo1Tg/viewform).

## Team

[Marynia Kolak](https://github.com/Makosak), [Qinyun Lin](https://github.com/linqinyu), [Susan Paykin](https://github.com/spaykin), Moksha Menghaney, Angela Li

## Data Overview

### Policy Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Status |
|:------------------ | :------------- | :----- | :------- | :------------ | :------|
| Prison Incarceration Rates | Prison population rate and prison admission rate by gender and ethnicity | Vera Institute of Justice, 2016 | PS01 / [Prison Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/Prison%20variables_2016.md) | County | Complete |
| Jail Incarceration Rates | Jail population rate by gender and ethnicity | Vera Institute of Justice, 2017 | PS02 / [Jail Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/Jail%20variables_2017.md) | County | Complete |
| Prescription Drug Monitoring Programs (PDMP) | Any PDMP; Operational PDMP; Must-access PDMP; Electronic PDMP | OPTIC, 2017 | PS03 / [PDMP](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/PDMP_2017.md) | State | Complete |
| Good Samaritan Laws | Any Good Samaritan Law; Good Samaritan Law protecting arrest | OPTIC, 2017 | PS04 / [GSL](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/GSL_2018.md) | State | Complete | 
| Naloxone Access Laws |  Any Naloxone law; law allowing distribution through a standing or protocal order; law allowing pharmacists prescriptive authority | OPTIC, 2017 | PS05 / [NAL](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/NAL_2017.md) | State | Complete | 
| Medicaid Expenditure | Total Medicaid spending | KFF, 2019 | PS06 / [MedExp](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/MedExp_2019.md) | State | Complete |
| Medicaid Expansion | Spending for adults who have enrolled through Medicaid expansion | KFF, 2018 | PS07 / [MedExpan](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/MedExpan_2018.md) | State | Complete |
| Syringe Services Laws | Laws clarifying legal status for syringe exchange, distribution, and possession programs | LawAtlas, 2019 | PS08 / [Syringe](Policy_Scan/data_final/metadata/Syringe.md) | State | Complete |
| Medical Marijuana Laws | Law authorizing adults to use medical marijuana | PDAPS, 2017 | PS09 / [MedMarijLaw](Policy_Scan/data_final/metadata/MedMarijLaw.md) | State | Complete |
| Social Determinants of Health (SDOH) | SDOH Neighborhood Typologies | Kolak et al, 2020 | PS10 / [SDOH Typology](Policy_Scan/data_final/metadata/SDOH_2014.md) | Tract | Complete |
| State & Local Government Expenditures | Government spending on public health, welfare, public safety, and corrections | US Census, 2018 | PS 11 / [Government Expenditures](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/PublicExpenditures.md) | State, Local | Complete |

<br>

### Health Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Status |
|:------------------ | :------------- | :----- | :------- | :------------ | :------|
| Drug-related death rate | Death rate from drug-related causes | CDC WONDER, 2009-2019 | Health01 / [Drug-Related Death Rate](Policy_Scan/data_final/metadata/Health_DrugDeaths.md) | State, County | Complete |
| Hepatitis C infection rate | Hepatitis C infection rate | CDC NNDSS, 2014-2018 | Health02 / [Hepatitis C Rate](Policy_Scan/data_final/metadata/HepC_rate.md) | State | Complete |
| Primary Care Physicians | Number of PC Physicians| Dartmouth Atlas, 2010 | Health03 / [Physicians](Policy_Scan/data_final/metadata/Health_PCPs.md) | Tract, County, State | Complete |
| Speciality Care Physicians | Number of Specialist Physicians | Darthmouth Atlas, 2010 | Health03 / [Physicians](Policy_Scan/data_final/metadata/Health_PCPs.md) | Tract, County, State | Complete |
| Access to MOUDs | Distance to nearest MOUD | US Census, SAMHSA, Vivitrol, 2020 | Access01 / [Access: MOUDs](Policy_Scan/data_final/metadata/Access_MOUDs.md) | Tract, Zip | Complete |
| Access to Health Centers | Distance to nearest FQHC | US Census, US COVID Atlas, HRSA, 2020  | Access02 / [Access: FQHCs](Policy_Scan/data_final/metadata/Access_FQHCs_MinDistance.md) | Tract, Zip | Complete |
| Access to Hospitals | Distance to nearest hospital | US Census, CovidCareMap, 2020 |  Access03 / [Access: Hospitals](Policy_Scan/data_final/metadata/Acesss_Hospitals_MinDistance.md) | Tract, Zip | Complete |
| Access to Mental Health Providers |  Distance to nearest mental health provider | US Census, SAMSHA 2020 |  Access04 / [Access: Mental Health Providers](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/Policy_Scan/data_final/metadata/Access_MentalHealth_MinDistance.md) | Tract, Zip | Complete |
| Access to Pharmacies | Distance to nearest pharmacy | US Census, InfoGroup 2018 | Access05 / [Access: Pharmacies](Policy_Scan/data_final/metadata/Access_Pharmacies_MinDistance.md) | Tract, Zip | Complete |

<br>

### Demographic Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Status |
|:------------------ | -------------- | ------ | -------- | ------------- | -------|
| Percentage Black, Percentage White | Population with race identified as Black or African American alone, Population with race identified as white alone | ACS, 2014-2018 | DS01/ [Race & Ethnicity Variables](Policy_Scan/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip | Complete |
| Percentage Hispanic | Population with ethnicity identified as Hispanic or Latinx origin | ACS, 2014-2018 | DS01 / [Race & Ethnicity Variables](Policy_Scan/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip | Complete |
| Population with a Disability | Percentage of population with a disability | ACS, 2014-2018 | DS01 / [Other Demographic Variables](Policy_Scan/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Complete |
| Educational Attainment | Population without a high school degree | ACS, 2014-2018 | DS01 / [Other Demographic Variables](Policy_Scan/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Complete |
| Population over 65 | Population over age 65 | ACS, 2014-2018 | DS01 / [Age Variables](Policy_Scan/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | Complete |
| Population under 25 | Young adult population between ages 15-24 | ACS, 2014-2018 | DS01 / [Age Variables](Policy_Scan/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | Complete |

<br>

### Economic Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Status |
|:------------------ | -------------- | ------ | -------- | ------------- | -------|
| High Risk of Injury Jobs | Population employed in agriculture, forestry, fishing and hunting, mining, quarrying, oil and gas extraction, construction, manufacturing, and utilities industries | ACS, 2014-2018 |  EC01/ [Jobs by Industry](Policy_Scan/data_final/metadata/Job_Categories_byIndustry_2018.md)| State, County, Tract, Zip | Complete |
| Essential Worker Jobs | See below, under *COVID Variables* | 
| Unemployment Rate | Unemployment rate | ACS, 2014-2018 | EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md)| State, County, Tract, Zip | Complete |
| Poverty Rate | Percent classified as below poverty level, based on income | ACS, 2014-2018 | EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | Complete |
| Per Capita Income | Per capita income in the past 12 months | ACS, 2014-2018 |  EC03/ [Economic Variables](Policy_Scan/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | Complete |
| Foreclosure Rate | Mortgage foreclosure and severe delinquency rates | HUD, 2009; CFPB, 2014-2018 | EC04 / [Foreclosure Rate](Policy_Scan/data_final/metadata/ForeclosureRate.md) | State, County, Tract | Complete |

<br>

### Physical Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Status |
|:------------------ | -------------- | ------ | -------- | ------------- | -------|
| Housing Occupancy Rate | Percent occupied units | ACS, 2014-2018 | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Vacancy Rate | Percent vacant units | ACS 2014-2018 | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Long Term Occupancy | Percentage of population living in current housing for 20+ years | ACS, 2014-2018 | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Mobile Homes | Percent of housing units classified as mobile homes | ACS, 2014-2018 | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Rental Rates | Percent of housing units occupied by renters  | ACS, 2014-2018 | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Housing Unit Density | Housing units per square mile | ACS, 2014-2018 | HS01 / [Housing Variables](Policy_Scan/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | Complete |
| Urban/Suburban/Rural | Classification of census tracts & ZCTAs as rural, urban and suburban using percent rurality (County) or RUCA Codes (Tract, Zip) | USDA & ACS, 2014-2018 | HS02 / [Rural-Urban Classifications](Policy_Scan/data_final/metadata/rural_urban_classifications) | County, Tract, Zip | Complete |
| Alcohol Outlet Density | Alcohol outlets per square mile and alcohol outlets per capita | InfoGroup, 2018 | HS03 / [Physical Factors](Policy_Scan/data_final/metadata/AlcoholOutlets_2018.md)  | State, County, Tract, Zip | Complete |
| Hypersegregated Cities | American metropolitan areas where black residents experience hypersegregation | Massey et al, 2015 | HS04 / [Overlay Variables](Policy_Scan/data_final/metadata/Overlay.md) | County | Complete |
| Southern Black Belt | Southern US counties where 30% of the population identified as Black or African American | US Census, 2000 | HS04 / [Overlay Variables](Policy_Scan/data_final/metadata/Overlay.md) | County | Complete |
| Native American Reservations | Percent area of total land in Native American Reservations | US Census, TIGER, 2018 | HS04 / [Overlay Variables](Policy_Scan/data_final/metadata/Overlay.md) | County | Complete |

<br>

### COVID Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Status |
|:------------------ | -------------- | ------ | -------- | ------------- | -------|
| Essential Worker Jobs | Percentage of population employed in occupations deemed *essential* during the COVID-19 crisis | ACS, 2014-2018 | EC02 / [Jobs by Occupation](Policy_Scan/data_final/metadata/Job_Categories_byOccupation_2018.md) | State, County, Tract, Zip | Complete |
| Cumulative Case Count | Daily case count, 01/21/20 - 03/03/2021 | The New York Times, 2021 | COVID01 / [COVID Variables](Policy_Scan/data_final/metadata/COVID.md) | State, County | Complete |
| Adjusted Case Count per 100K | Daily case rate, 01/21/20 - 03/03/2021 | The New York Times, 2021 | COVID02 / [COVID Variables](Policy_Scan/data_final/metadata/COVID.md) | State, County | Complete |
| Historical 7-day Average Case Count | 7-day average case count, 01/21/20 - 03/03/2021 | The New York Times, 2021 | COVID03 / [COVID Variables](Policy_Scan/data_final/metadata/COVID.md) | State, County | Complete |
| Historical 7-day Average Adjusted Case Count per 100K | 7-day average case rate, 01/21/20 - 03/03/2021 | The New York Times, 2021 | COVID04 / [COVID Variables](Policy_Scan/data_final/metadata/COVID.md) | State, County | Complete |
