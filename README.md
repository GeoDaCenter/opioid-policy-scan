# Opioid Environment Policy Scan (OEPS) Data Warehouse

## Public Site - OEPS Explorer
Visualize, download, and explore OEPS data on the [OEPS Explorer](https://oeps.healthyregions.org). 

## About

The Opioid Environment Policy Scan (OEPS) is a free, open-source data warehouse to help characterize the multi-dimensional risk environment impacting opioid use and health outcomes across the United States.

The OEPS provides access to data at multiple spatial scales, from U.S. states down to Census tracts. It is designed to support research seeking to study environments impacting and impacted by opioid use and opioid use disorder (OUD), inform public policy, and reduce harm in communities nationwide. 

We developed the OEPS as a free, open-source platform to aggregate and share publicly-available data at the Census tract, zip code, county, and state levels. Geographic boundary shapefiles are provided for ease of merging datasets (csv files) for exploration, spatial analysis, or visualization. Download the entire data repository, or you can filter and download by theme or spatial scale with the [OEPS Explorer](https://oeps.healthyregions.org). All datasets are accompanied by documentation, detailing their source data, year, and more. Learn more about our methods and approaches, including the risk environment framework, on our [Methodology](https://oeps.healthyregions.org/methods) page.

The OEPS is led by the [Healthy Regions and Policies Lab](https://voices.uchicago.edu/herop/team) at the [Center for Spatial Data Science](https://spatial.uchicago.edu/), University of Chicago. It was developed for the NIH's JCOIN Methdology and Advanced Analaytic Resource Center (MAARC). See [Team](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master#team) and [Acknolwedgements](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master#acknowledgements) below for more. 

### Citation
Susan Paykin, Dylan Halpern, Qinyun Lin, Moksha Menghaney, Angela Li, Rachel Vigil, Margot Bolanos Gamez, Alexa Jin, Ally Muszynski, and Marynia Kolak. (2021). GeoDaCenter/opioid-policy-scan: Opioid Environment Policy Scan Data Warehouse (v1.0). Zenodo. https://doi.org/10.5281/zenodo.5842465

### Wiki 
We welcome open source contributions and feedback, including suggesting or contributing relevant data, application development, or sharing applied research. To learn more, visit the [OEPS Wiki](https://github.com/GeoDaCenter/opioid-policy-scan/wiki). 

## Data Overview

Variable constructs are grouped thematically below to highlight the multi-dimensional risk environment of opioid use in justice populations. In the **Metadata** column, linked pages provide more detail about the data source, descriptions of data cleaning or processing, and individual variables included.

### Geographic Boundaries

| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | :------------- | :----- | :------- | :------------ | 
| Geographic Boundaries | State, County, Census Tract, Zip Code Tract Area (ZCTA) | US Census TIGER/Line, 2018 | [Geographic Boundaries](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/GeographicBoundaries_2018.md) | State, County, Tract, Zip |
| Crosswalk files | County, Census Tract, Zip Code Tract Area (ZCTA) | HUD Office of Policy Development and Research | [Crosswalk Files](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/crosswalk.md) | County, Tract, Zip |

### Policy Variables

| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | :------------- | :----- | :------- | :------------ | 
| Prison Incarceration Rates | Prison population rate and prison admission rate by gender and ethnicity | Vera Institute of Justice, 2016 | PS01 / [Prison Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Prison%20variables_2016.md) | County | 
| Jail Incarceration Rates | Jail population rate by gender and ethnicity | Vera Institute of Justice, 2017 | PS02 / [Jail Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Jail%20variables_2017.md) | County |
| Prescription Drug Monitoring Programs (PDMP) | Any PDMP; Operational PDMP; Must-access PDMP; Electronic PDMP | OPTIC, 2017 | PS03 / [PDMP](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/PDMP_2017.md) | State | 
| Good Samaritan Laws | Any Good Samaritan Law; Good Samaritan Law protecting arrest | OPTIC, 2017 | PS04 / [GSL](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/GSL_2018.md) | State | 
| Naloxone Access Laws |  Any Naloxone law; law allowing distribution through a standing or protocal order; law allowing pharmacists prescriptive authority | OPTIC, 2017 | PS05 / [NAL](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/NAL_2017.md) | State |  
| Medicaid Expenditure | Total Medicaid spending | KFF, 2019 | PS06 / [MedExp](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/MedExp_2019.md) | State | 
| Medicaid Expansion | Spending for adults who have enrolled through Medicaid expansion | KFF, 2018 | PS07 / [MedExpan](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/MedExpan_2018.md) | State | 
| Syringe Services Laws | Laws clarifying legal status for syringe exchange, distribution, and possession programs | LawAtlas, 2019 | PS08 / [Syringe](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Syringe.md) | State | 
| Medical Marijuana Laws | Law authorizing adults to use medical marijuana | PDAPS, 2017 | PS09 / [MedMarijLaw](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/MedMarijLaw.md) | State |
| State & Local Government Expenditures | Government spending on public health, welfare, public safety, and corrections | US Census, 2018 | PS11 / [Government Expenditures](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/PublicExpenditures.md) | State, Local |

<br>

### Health Variables

| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale |
|:------------------ | :------------- | :----- | :------- | :------------ |
| Drug-Related Death Rates | Death rate from drug-related causes | CDC WONDER, 2019 10-year | Health01 / [Drug-Related Death Rate](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Health_DrugDeaths.md) | State, County | 
| Hepatitis C Rates | HepC prevalence, mortality | HepVu, 2017 | Health02 / [Hepatitis C](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/HepC_rate.md) | State, County | 
| Physicians | Number of Primary Care and Specialist Physicians | Dartmouth Atlas, 2010 | Health03 / [Physicians](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Health_PCPs.md) | Tract, County, State | 
| Opioid Prescription Rates | Opioid prescription rate | HepVu, CDC 2018-2019 | Health04 / [Opioid Indicators](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/OpioidIndicators.md)| State, County |
| Opioid Mortality Rates | Rates of death from narcotic drug overdoses | HepVu, NVSS, 2014-2019 | Health04 / [Opioid Indicators](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/OpioidIndicators.md) | State, County |
| Access to MOUDs | Travel time (drive, walk, bike) and distance to nearest MOUD | SAMHSA 2019, Vivitrol 2020 | Access01 / [Access: MOUDs](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_MOUDs.md) | Tract, Zip, County, State | 
| Access to FQHCs | Travel time (drive) and distance to nearest Federally Qualified Health Center (FQHC) | US COVID Atlas, HRSA, 2020  | Access02 / [Access: FQHCs](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_FQHCs_MinDistance.md) | Tract, Zip, County, State | 
| Access to Hospitals | Travel time (drive) and distance to nearest hospital | CovidCareMap, 2020 |  Access03 / [Access: Hospitals](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Acesss_Hospitals_MinDistance.md) | Tract, Zip, County, State |
| Access to Pharmacies | Travel time (drive) and distance to nearest pharmacy | InfoGroup, 2018 | Access04 / [Access: Pharmacies](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_Pharmacies_MinDistance.md) | Tract, Zip, County, State |
| Access to Mental Health Providers |  Travel time (drive) and distance to nearest mental health provider | SAMSHA, 2020 |  Access05 / [Access: Mental Health Providers](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_MentalHealth_MinDistance.md) | Tract, Zip, County, State |
| Access to Substance Use Treatment (SUT) Services | Travel time (drive) and distance to nearest substance use treatment (SUT) service | SAMHSA, 2021| Access06 / [Access: Substance Use Treatment](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_SubstanceUseTreatment.md)| Tract, Zip, County, State |
| Access to Opioid Treatment Programs (OTP) | Travel time (drive) and distance to nearest Opioid Treatment Program (OTP) | SAMHSA, 2021| Access 07 / [Access: Opioid Treatment Programs](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_OpioidUseTreatment.md)|Tract, Zip|

<br>

### Demographic Variables

| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Race & Ethnicity | Percentages of population defined by categories of race and ethnicity | ACS, 2018 5-year | DS01/ [Race & Ethnicity Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip |
| Age | Age group estimates and percentages of population | ACS, 2018 5-year | DS01 / [Age Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | 
| Population with a Disability | Percentage of population with a disability | ACS, 2018 5-year | DS01 / [Other Demographic Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | 
| Educational Attainment | Population without a high school degree | ACS, 2018 5-year | DS01 / [Other Demographic Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | 
| Social Determinants of Health (SDOH) | SDOH Neighborhood Typologies | Kolak et al, 2020 | DS02 / [SDOH Typology](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/SDOH_2014.md) | Tract | 
| Social Vulnerability Index (SVI) | SVI Rankings | CDC, 2018 | DS03 / [SVI](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/SVI_2018.md) | County, Tract, Zip | 
| Veteran Population | Population as defined by veteran status | ACS, 2018 5-year | DS04 / [Veteran Population Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/VetPop.md) | State, County, Tract, Zip |
| Household Type | Household Types and Group Quarters Populations | ACS, 2018 5-year | DS05 / [Household Type Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/HouseholdType.md) | State, County, Tract, Zip |
| Homeless Population | Homelessness Census Variables | HUD, 2018  | DS06 / [Homeless Population Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/HomelessPop.md) | State, County, Tract, Zip |

<br>

### Economic Variables

| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Employment Trends | Percentages of population employed across industries | ACS, 2018 5-year | EC01/ [Jobs by Industry](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Job_Categories_byIndustry_2018.md) | State, County, Tract, Zip | 
| Essential Worker Jobs | *See  COVID-19 Variables* | | EC02 / [Jobs by Occupation](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Job_Categories_byOccupation_2018.md) |
| Unemployment Rate | Unemployment rate | ACS, 2018 5-year | EC03/ [Economic Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Economic_2018.md)| State, County, Tract, Zip | 
| Poverty Rate | Percent classified as below poverty level, based on income | ACS, 2018 5-year | EC03/ [Economic Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | 
| Per Capita Income | Per capita income in the past 12 months | ACS, 2018 5-year |  EC03/ [Economic Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | 
| Foreclosure Rate | Mortgage foreclosure and severe delinquency rate | HUD, 2009 | EC04 / [Foreclosure Rate](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/ForeclosureRate.md) | State, County, Tract | 
| Internet Access | Percentage of Households without Internet access  | ACS, 2019 5-year |  EC05/ [Economic Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Internet_2019.md) | State, County, Tract, Zip | 

<br>

### Physical Environment Variables

| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Housing Occupancy Rate | Percent occupied units | ACS, 2018 5-year | BE01 / [Housing](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Housing Vacancy Rate | Percent vacant units | ACS, 2018 5-year | BE01 / [Housing](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Long Term Occupancy | Percentage of population living in current housing for 20+ years | ACS, 2018 5-year | BE01 / [Housing](/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip |
| Mobile Homes | Percent of housing units classified as mobile homes | ACS, 2018 5-year | BE01 / [Housing](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Rental Rates | Percent of housing units occupied by renters  | ACS, 2018 5-year | BE01 / [Housing](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip | 
| Housing Unit Density | Housing units per square mile | ACS, 2018 5-year | BE01 / [Housing](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Housing_2018.md) | State, County, Tract, Zip |
| Urban/Suburban/Rural Classification | County classification | USDA-ERS | BE02 / [Rural-Urban Classifications](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Rural_Urban_Classification_County.md) | County | 
| Urban/Suburban/Rural Classification | Zip code and Census tract classification | USDA-ERS | BE02 / [Rural-Urban Classifications](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Rural_Urban_Classification_T_Z.md) | Tract, Zip | 
| Alcohol Outlet Density | Alcohol outlets per square mile, alcohol outlets per capita | InfoGroup, 2018 | BE03 / [Alcohol Outlets](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/AlcoholOutlets_2018.md)  | State, County, Tract, Zip | 
| Hypersegregated Cities | US metropolitan areas where black residents experience hypersegregation | Massey et al, 2015 | BE04 / [Community Overlays](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Overlay.md) | County | 
| Southern Black Belt | US counties where 30% of the population identified as Black or African American | US Census, 2000 | BE04 / [Community Overlays](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Overlay.md) | County | 
| Native American Reservations | Percent area of total land in Native American Reservations | US Census TIGER/Line, 2018 | BE04 / [Community Overlays](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Overlay.md) | County | 
| Residential Segregation Indices | Three index measures of segregation: dissimilarity, interaction, isolation | ACS, 2018 5-year | BE05 / [Residential Segregation](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Residential_Seg_Indices.md) | County, State, Zip |
| NDVI |  Normalized Difference Vegetation Index (NDVI) average value | Sentinel-2 MSI, 2018 | BE06 / [NDVI](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/NDVI.md) | State, County, Tract, Zip |
| Parks Coverage | Percent of land area covered by parks and green space | OSM, 2022 | BE07 / [Parks](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Park_Cover.md) | State, County |


<br>

### COVID-19 Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | 
|:------------------ | -------------- | ------ | -------- | ------------- | 
| Essential Worker Jobs | Percentage of population employed in Essential Jobs as defined during the COVID-19 pandemic | ACS, 2018 5-year | EC02 / [Jobs by Occupation](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Job_Categories_byOccupation_2018.md) | State, County, Tract, Zip | 
| Cumulative Case Count | Daily cumulative raw case count (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID01 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County | 
| Adjusted Case Count per 100K | Daily cumulative adjusted case count per 100K population (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID02 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County |
| 7-day Average Case Count | 7-day average case count (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID03 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County | 
| Historical 7-day Average Adjusted Case Count per 100K | 7-day average adjusted case count per 100K population (01/21/20 - 03/03/2021)| The New York Times, 2021 | COVID04 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County | 

## Full Documentation
Please refer to the complete [Data Documentation](https://docs.google.com/document/d/18NPWpuUfFTrKll9_ERHzVDmpNCETTzwjJt_FsIvmSrc/edit?usp=sharing) for more information about individual datasets, variables, and data methods.  Contact [Susan Paykin](mailto:spaykin@uchicago.edu) with any questions. 

## Team
The OEPS is led by the [Healthy Regions & Policies Lab](herop.ssd.uchicago.edu) team including [Susan Paykin](https://github.com/spaykin), [Qinyun Lin](https://github.com/linqinyu), [Dylan Halpern](https://github.com/nofurtherinformation), and [Marynia Kolak](https://github.com/Makosak), along with Moksha Menghaney and Angela Li.

## Acknowledgements
The OEPS was developed for the Methodology and Advanced Analytics Resource Center (MAARC), part of the NIH-HEAL Initiative Justice Community Opioid Innovation Network (JCOIN). The Healthy Regions & Policies Lab leads spatial analytics for the MAARC, which provides data infrastructure and statistical and analytic expertise to support individual JCOIN studies and cross-site data synchronization.

*This research was supported by the National Institute on Drug Abuse, National Institutes of Health, through the NIH HEAL Initiative under award number UG3DA123456. The contents of this publication are solely the responsibility of the authors and do not necessarily represent the official views of the NIH, the Initiative, or the participating sites.*
