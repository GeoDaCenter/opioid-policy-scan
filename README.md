# OEPS-dashboard
*Updated August 2021*

## About

The Opioid Environment Policy Scan (OEPS) is a database providing access to data at multiple spatial scales to help characterize the multi-dimensional risk environment impacting opioid use in justice populations across the United States. See [here](https://github.com/GeoDaCenter/opioid-policy-scan) for more informaiton regarding the database. 

The goal of the OEPS dashboard is to help researchers explore the OEPS data. This repository stores scripts used to create this dashboard. We rely on [webgeoda scaffolding](http://dhalpern.gitbook.io/webgeoda-templatesBtw) to generate this dashboard. 

For now, the OEPS dashboard lives at https://oeps-dashboard.netlify.app/. 

## Data Overview

Variable constructs have been grouped thematically to highlight the multi-dimensional risk environment of opioid use in justice populations.  The variable themes are: **Geographic Boundaries, Policy, Health, Demographic, Economic, Physical Environment,** and **COVID-19**.

For more information about the individual variables, please refer to the data dictionary in the complete [Documentation](https://docs.google.com/document/d/18NPWpuUfFTrKll9_ERHzVDmpNCETTzwjJt_FsIvmSrc/edit?usp=sharing).

### Geographic Boundaries
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Lead (internal note) |
|:------------------ | :------------- | :----- | :------- | :------------ | :------------ | 
| Geographic Boundaries | State, County, Census Tract, Zip Code Tract Area (ZCTA) | US Census, 2018 | [Geographic Boundaries](data_final/metadata/GeographicBoundaries_2018.md) | State, County, Tract, Zip | |
| Crosswalk files | County, Census Tract, Zip Code Tract Area (ZCTA) | HUD’s Office of Policy Development and Research (PD&R) | [Crosswalk Files](data_final/metadata/crosswalk.md) | County, Tract, Zip | |

### Policy Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Lead (internal note) |
|:------------------ | :------------- | :----- | :------- | :------------ | :------------ |
| Prison Incarceration Rates | Prison population rate and prison admission rate by gender and ethnicity | Vera Institute of Justice, 2016 | PS01 / [Prison Variables](data_final/metadata/Prison%20variables_2016.md) | County |Alexa |
| Jail Incarceration Rates | Jail population rate by gender and ethnicity | Vera Institute of Justice, 2017 | PS02 / [Jail Variables](data_final/metadata/Jail%20variables_2017.md) | County |Alexa |
| Prescription Drug Monitoring Programs (PDMP) | Any PDMP; Operational PDMP; Must-access PDMP; Electronic PDMP | OPTIC, 2017 | PS03 / [PDMP](data_final/metadata/PDMP_2017.md) | State | Margot |
| Good Samaritan Laws | Any Good Samaritan Law; Good Samaritan Law protecting arrest | OPTIC, 2017 | PS04 / [GSL](data_final/metadata/GSL_2018.md) | State | Alexa |
| Naloxone Access Laws |  Any Naloxone law; law allowing distribution through a standing or protocal order; law allowing pharmacists prescriptive authority | OPTIC, 2017 | PS05 / [NAL](data_final/metadata/NAL_2017.md) | State | Alexa |
| Medicaid Expenditure | Total Medicaid spending | KFF, 2019 | PS06 / [MedExp](data_final/metadata/MedExp_2019.md) | State | Alexa |
| Medicaid Expansion | Spending for adults who have enrolled through Medicaid expansion | KFF, 2018 | PS07 / [MedExpan](data_final/metadata/MedExpan_2018.md) | State | Alexa |
| Syringe Services Laws | Laws clarifying legal status for syringe exchange, distribution, and possession programs | LawAtlas, 2019 | PS08 / [Syringe](data_final/metadata/Syringe.md) | State | Margot |
| Medical Marijuana Laws | Law authorizing adults to use medical marijuana | PDAPS, 2017 | PS09 / [MedMarijLaw](data_final/metadata/MedMarijLaw.md) | State | Qinyun |
| State & Local Government Expenditures | Government spending on public health, welfare, public safety, and corrections | US Census, 2018 | PS11 / [Government Expenditures](/data_final/metadata/PublicExpenditures.md) | State, Local | Margot |

### Health Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Lead (internal note) |
|:------------------ | :------------- | :----- | :------- | :------------ | :------------ |
| Drug-related death rate | Death rate from drug-related causes | CDC WONDER, 2009-2019 | Health01 / [Drug-Related Death Rate](data_final/metadata/Health_DrugDeaths.md) | State, County | Alexa Jin
| Hepatitis C infection rate | Hepatitis C infection rate | CDC NNDSS, 2014-2018 | Health02 / [Hepatitis C Rate](data_final/metadata/HepC_rate.md) | State | Alexa Jin
| Physicians | Number of Primary Care and Specialist Physicians | Dartmouth Atlas, 2010 | Health03 / [Physicians](data_final/metadata/Health_PCPs.md) | Tract, County, State | Alexa Jin
| Access to MOUDs | Distance to nearest MOUD | US Census, SAMHSA, Vivitrol, 2020 | Access01 / [Access: MOUDs](/data_final/metadata/Access_MOUDs.md) | County, Tract, Zip | Margot
| Access to Health Centers | Distance to nearest FQHC | US Census, US COVID Atlas, HRSA, 2020  | Access02 / [Access: FQHCs](/data_final/metadata/Access_FQHCs_MinDistance.md) | Tract, Zip | Margot
| Access to Hospitals | Distance to nearest hospital | US Census, CovidCareMap, 2020 |  Access03 / [Access: Hospitals](/data_final/metadata/Acesss_Hospitals_MinDistance.md) | Tract, Zip | Margot
| Access to Pharmacies | Distance to nearest pharmacy | US Census, InfoGroup 2018 | Access04 / [Access: Pharmacies](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_Pharmacies_MinDistance.md) | Tract, Zip | Margot
| Access to Mental Health Providers |  Distance to nearest mental health provider | US Census, SAMSHA 2020 |  Access05 / [Access: Mental Health Providers](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_MentalHealth_MinDistance.md) | Tract, Zip | Margot
|Access to Substance Use Treatment Facilities| Distance to nearest substance use treatment facility| SAMHSA, SSATS 2021| Access06 / [Access: Substance Use Treatment](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_SubstanceUseTreatment.md)|Tract, Zip| Margot
|Access to Opioid Treatment Programs| Distance to nearest Opioid treatment program| SAMHSA, SSATS 2021| Access 07 / [Access: Opioid Treatment Programs](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Access_OpioidUseTreatment.md)|Tract, Zip| Margot


### Demographic Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Lead (internal note) |
|:------------------ | -------------- | ------ | -------- | ------------- | :------------ |
| Race & Ethnicity | Percentages of population defined by categories of race and ethnicity | ACS, 2014-2018 | DS01/ [Race & Ethnicity Variables](/data_final/metadata/Race_Ethnicity_2018.md) | State, County, Tract, Zip | Margot 
| Age | Age group estimates and percentages of population | ACS, 2014-2018 | DS01 / [Age Variables](/data_final/metadata/Age_2018.md) | State, County, Tract, Zip | Margot
| Population with a Disability | Percentage of population with a disability | ACS, 2014-2018 | DS01 / [Other Demographic Variables](/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Margot
| Educational Attainment | Population without a high school degree | ACS, 2014-2018 | DS01 / [Other Demographic Variables](/data_final/metadata/Other_Demographic_2018.md) | State, County, Tract, Zip | Margot
| Social Determinants of Health (SDOH) | SDOH Neighborhood Typologies | Kolak et al, 2020 | DS02 / [SDOH Typology](data_final/metadata/SDOH_2014.md) | Tract | 
| Social Vulnerability Index (SVI) | SVI Rankings | CDC, 2018 | DS03 / [SVI](data_final/metadata/SVI_2018.md) | County, Tract | Margot 
| Veteran Population | Population as defined by veteran status | ACS, 2017 5-year | DS04 / [Veteran Population Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/VetPop.md) | State, County, Tract, Zip | Margot
| Homeless Population | Population as defined by momeless status | ACS, 2019 5-year, Housing and Urban Development, 2020 | DS05 / [Homeless Population Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Homeless_Population.md) | State, County, Tract, Zip | Margot 

### Economic Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Lead (internal note) |
|:------------------ | -------------- | ------ | -------- | ------------- | :------------ |
| Employment Trends | Percentages of population employed in High Risk of Injury Jobs, Educational Services, Health Care, Retail industries | ACS, 2014-2018 | EC01/ [Jobs by Industry](/data_final/metadata/Job_Categories_byIndustry_2018.md) | State, County, Tract, Zip | 
| Unemployment Rate | Unemployment rate | ACS, 2014-2018 | EC03/ [Economic Variables](/data_final/metadata/Economic_2018.md)| State, County, Tract, Zip | 
| Poverty Rate | Percent classified as below poverty level, based on income | ACS, 2014-2018 | EC03/ [Economic Variables](/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | 
| Per Capita Income | Per capita income in the past 12 months | ACS, 2014-2018 |  EC03/ [Economic Variables](/data_final/metadata/Economic_2018.md) | State, County, Tract, Zip | 
| Foreclosure Rate | Mortgage foreclosure and severe delinquency rate | HUD, 2009 | EC04 / [Foreclosure Rate](/data_final/metadata/ForeclosureRate.md) | State, County, Tract | 

### Built Environment Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Lead (internal note) |
|:------------------ | -------------- | ------ | -------- | ------------- | :------------ |
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
| Residential Segregation Indices | Three index measures of segregation: dissimilarity, interaction, isolation | ACS, 2018 5-year | BE05 / [Residential Segregation](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Residential_Seg_Indices.md) | County |

### COVID Variables
| Variable Construct | Variable Proxy | Source | Metadata | Spatial Scale | Lead (internal note) |
|:------------------ | -------------- | ------ | -------- | ------------- | :------------ |
| Essential Worker Jobs | Percentage of population employed in Essential Jobs as defined during the COVID-19 pandemic | ACS, 2014-2018 | EC02 / [Jobs by Occupation](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/Job_Categories_byOccupation_2018.md) | State, County, Tract, Zip | 
| Cumulative Case Count | Daily cumulative raw case count (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID01 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County | 
| Adjusted Case Count per 100K | Daily cumulative adjusted case count per 100K population (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID02 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County |
| 7-day Average Case Count | 7-day average case count (01/21/20 - 03/03/2021) | The New York Times, 2021 | COVID03 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County | 
| Historical 7-day Average Adjusted Case Count per 100K | 7-day average adjusted case count per 100K population (01/21/20 - 03/03/2021)| The New York Times, 2021 | COVID04 / [COVID Variables](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/COVID.md) | State, County | 

<br>

# WebGeoDa Scaffolding

![A map of population density in texas](https://github.com/nofurtherinformation/webgeoda/blob/main/public/cover.png?raw=true)

WebGeoDa Scaffolding is a set of easy-to-use frontend JavaScript toolkits to get started building and exploring client-side geospatial analytics.

⚠️ Heads up! This repository is an _unstable_ work in progress. This means a lot will change in future releases. ⚠️

## About Webgeoda Scaffolding

**What is this thing?**

WebGeoDa is a set of tools, templates, and scaffolding to quickly and easily develop geospatial data dashboards. WebGeoDa builds on the GeoDa suite of geospatial software and extends jsGeoDa through accessible and ready-to-go examples. WebGeoDa uses  [jsGeoDa](https://jsgeoda.libgeoda.org/) (Xun Li & Luc Anselin) as the core of it's geospatial engine, alongside a collection of modern and high-performance libraries for mapping, analysis, data handling, and UI matters.

WebGeoDa capabilities have four areas of complexity. It's easy to learn, but with a high ceiling for customization:

‍💻 Add your geospatial data (GeoJSON), join it to your tabular data (CSV) right in the browser. Specify your variables with a simple JSON specification, and your map is ready to be published!

📑 Customize and add static pages to describe your data and the context of your dashboard. WebGeoDa provides some built-in styling tools using Plain CSS and a reasonably approachable JSX, similar to HTML.

🗺 Add additional map features using Mapbox and Deck.gl, or explore additional data insights through interactive tooltip and sidebar functions.

🦺 Dive directly into the WebGeoDa scaffolding with full control over custom react hooks, the jsGeoDa WebAssembly + WebWorker geospatial engine, a fast Redux-backed state, and extensible and accessible components. 

## What can WebGeoDa do?

WebGeoDa focuses on enabling exploratory data dashboards with complex data, the need for diverse variables, and high performance in-browser analytics. You can make maps with a variety of color-binning techniques and spatial statistical methods, like Hotspot cluster analysis, through a simple JSON based data and variable configuration.

## See the [full docs](https://dhalpern.gitbook.io/webgeoda-templates/) for more and [get started here](https://dhalpern.gitbook.io/webgeoda-templates/getting-started).
