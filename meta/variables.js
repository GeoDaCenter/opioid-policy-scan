export const variables = {
  'Geographic Boundaries': [
    {
      'Variable Proxy': 'State, County, Census Tract, Zip Code Tract Area (ZCTA)',
      Source: 'US Census, 2018',
      Metadata: '<a href="https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/data_final/metadata/GeographicBoundaries_2018.md">Geographic Boundaries</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: '',
      markdownText: 'Geographic Boundaries',
      markdown: 'GeographicBoundaries_2018',
      'Variable Construct': 'Geographic Boundaries'
    },
    {
      'Variable Proxy': 'County, Census Tract, Zip Code Tract Area (ZCTA)',
      Source: 'HUD’s Office of Policy Development and Research (PD&R)',
      Metadata: '<a href="https://github.com/GeoDaCenter/opioid-policy-scan/master/data_final/metadata/crosswalk.md">Crosswalk Files</a>',
      'Spatial Scale': 'County, Tract, Zip',
      markdownPrefix: '',
      markdownText: 'Crosswalk Files',
      markdown: 'crosswalk',
      'Variable Construct': 'Crosswalk files'
    }
  ],
  'Policy Variables': [
    {
      'Variable Proxy': 'Prison population rate and prison admission rate by gender and ethnicity',
      Source: 'Vera Institute of Justice, 2016',
      Metadata: 'PS01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Prison%20variables_2016.md">Prison Variables</a>',
      'Spatial Scale': 'County',
      markdownPrefix: 'PS01 / ',
      markdownText: 'Prison Variables',
      markdown: 'Prison%20variables_2016',
      'Variable Construct': 'Prison Incarceration Rates'
    },
    {
      'Variable Proxy': 'Jail population rate by gender and ethnicity',
      Source: 'Vera Institute of Justice, 2017',
      Metadata: 'PS02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Jail%20variables_2017.md">Jail Variables</a>',
      'Spatial Scale': 'County',
      markdownPrefix: 'PS02 / ',
      markdownText: 'Jail Variables',
      markdown: 'Jail%20variables_2017',
      'Variable Construct': 'Jail Incarceration Rates'
    },
    {
      'Variable Proxy': 'Any PDMP; Operational PDMP; Must-access PDMP; Electronic PDMP',
      Source: 'OPTIC, 2017',
      Metadata: 'PS03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/PDMP_2017.md">PDMP</a>',
      'Spatial Scale': 'State',
      markdownPrefix: 'PS03 / ',
      markdownText: 'PDMP',
      markdown: 'PDMP_2017',
      'Variable Construct': 'Prescription Drug Monitoring Programs (PDMP)'
    },
    {
      'Variable Proxy': 'Any Good Samaritan Law; Good Samaritan Law protecting arrest',
      Source: 'OPTIC, 2017',
      Metadata: 'PS04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/GSL_2018.md">GSL</a>',
      'Spatial Scale': 'State',
      markdownPrefix: 'PS04 / ',
      markdownText: 'GSL_2018',
      markdown: 'GSL_2018',
      'Variable Construct': 'Good Samaritan Laws'
    },
    {
      'Variable Proxy': 'Any Naloxone law; law allowing distribution through a standing or protocal order; law allowing pharmacists prescriptive authority',
      Source: 'OPTIC, 2017',
      Metadata: 'PS05 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/NAL_2017.md">NAL</a>',
      'Spatial Scale': 'State',
      markdownPrefix: 'PS05 / ',
      markdownText: 'NAL',
      markdown: 'NAL_2017',
      'Variable Construct': 'Naloxone Access Laws'
    },
    {
      'Variable Proxy': 'Total Medicaid spending',
      Source: 'KFF, 2019',
      Metadata: 'PS06 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/MedExp_2019.md">MedExp</a>',
      'Spatial Scale': 'State',
      markdownPrefix: 'PS06 / ',
      markdownText: 'MedExp',
      markdown: 'MedExp_2019',
      'Variable Construct': 'Medicaid Expenditure'
    },
    {
      'Variable Proxy': 'Spending for adults who have enrolled through Medicaid expansion',
      Source: 'KFF, 2018',
      Metadata: 'PS07 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/MedExpan_2018.md">MedExpan</a>',
      'Spatial Scale': 'State',
      markdownPrefix: 'PS07 / ',
      markdownText: 'MedExpan',
      markdown: 'MedExpan_2018',
      'Variable Construct': 'Medicaid Expansion'
    },
    {
      'Variable Proxy': 'Laws clarifying legal status for syringe exchange, distribution, and possession programs',
      Source: 'LawAtlas, 2019',
      Metadata: 'PS08 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Syringe.md">Syringe</a>',
      'Spatial Scale': 'State',
      markdownPrefix: 'PS08 / ',
      markdownText: 'Syringe',
      markdown: 'Syringe',
      'Variable Construct': 'Syringe Services Laws'
    },
    {
      'Variable Proxy': 'Law authorizing adults to use medical marijuana',
      Source: 'PDAPS, 2017',
      Metadata: 'PS09 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan//data_final/metadata/MedMarijLaw.md">MedMarijLaw</a>',
      'Spatial Scale': 'State',
      markdownPrefix: 'PS09 / ',
      markdownText: 'MedMarijLaw',
      markdown: 'MedMarijLaw',
      'Variable Construct': 'Medical Marijuana Laws'
    },
    {
      'Variable Proxy': 'Government spending on public health, welfare, public safety, and corrections',
      Source: 'US Census, 2018',
      Metadata: 'PS11 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan//data_final/metadata/PublicExpenditures.md">Government Expenditures</a>',
      'Spatial Scale': 'State, Local',
      markdownPrefix: 'PS11 / ',
      markdownText: 'Government Expenditures',
      markdown: 'PublicExpenditures',
      'Variable Construct': 'State & Local Government Expenditures'
    }
  ],

  'Health Variables': [
    {
      'Variable Proxy': 'Death rate from drug-related causes',
      Source: 'CDC WONDER, 2009-2019',
      Metadata: 'Health01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Health_DrugDeaths.md">Drug-Related Death Rate</a>',
      'Spatial Scale': 'State, County',
      markdownPrefix: 'Health01 / ',
      markdownText: 'Drug-Related Death Rate',
      markdown: 'Health_DrugDeaths',
      'Variable Construct': 'Drug-related death rate'
    },
    {
      'Variable Proxy': 'HepC prevalence and mortality',
      Source: 'HepVu, 2017',
      Metadata: 'Health02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan//data_final/metadata/HepC_rate.md">Hepatitis C</a>',
      'Spatial Scale': 'State, County',
      markdownPrefix: 'Health02 / ',
      markdownText: 'Hepatitis C',
      markdown: 'HepC_rate',
      'Variable Construct': 'Hepatitis C rates'
    },
    {
      'Variable Proxy': 'Number of Primary Care and Specialist Physicians',
      Source: 'Dartmouth Atlas, 2010',
      Metadata: 'Health03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Health_PCPs.md">Physicians</a>',
      'Spatial Scale': 'Tract, County, State',
      markdownPrefix: 'Health03 / ',
      markdownText: 'Physicians',
      markdown: 'Health_PCPs',
      'Variable Construct': 'Physicians'
    },
    {
      'Variable Proxy': 'Geographic access to MOUDs',
      Source: 'SAMHSA, 2019; Vivitrol, 2020',
      Metadata: 'Access01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan//data_final/metadata/Access_MOUDs.md">Access: MOUDs</a>',
      'Spatial Scale': 'County, Tract, Zip',
      markdownPrefix: 'Access01 / ',
      markdownText: 'Access: MOUDs',
      markdown: 'Access_MOUDs',
      'Variable Construct': 'Access to MOUDs'
    },
    {
      'Variable Proxy': 'Geographic access to FQHCs',
      Source: 'US Covid Atlas via HRSA, 2020',
      Metadata: 'Access02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Access_FQHCs_MinDistance.md">Access: FQHCs</a>',
      'Spatial Scale': 'Tract, Zip',
      markdownPrefix: 'Access02 / ',
      markdownText: 'Access: FQHCs',
      markdown: 'Access_FQHCs_MinDistance',
      'Variable Construct': 'Access to Health Centers'
    },
    {
      'Variable Proxy': 'Geographic access to hospitals',
      Source: 'CovidCareMap, 2020',
      Metadata: 'Access03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Acesss_Hospitals_MinDistance.md">Access: Hospitals</a>',
      'Spatial Scale': 'Tract, Zip',
      markdownPrefix: 'Access03 / ',
      markdownText: 'Access: Hospitals',
      markdown: 'Acesss_Hospitals_MinDistance',
      'Variable Construct': 'Access to Hospitals'
    },
    {
      'Variable Proxy': 'Geographic access to pharmacies',
      Source: 'InfoGroup, 2019',
      Metadata: 'Access04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Access_Pharmacies_MinDistance.md">Access: Pharmacies</a>',
      'Spatial Scale': 'Tract, Zip',
      markdownPrefix: 'Access04 / ',
      markdownText: 'Access: Pharmacies',
      markdown: 'Access_Pharmacies_MinDistance',
      'Variable Construct': 'Access to Pharmacies'
    },
    {
      'Variable Proxy': 'Geographic access to mental health providers',
      Source: 'SAMHSA, 2020',
      Metadata: 'Access05 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Access_MentalHealth_MinDistance.md">Access: Mental Health Providers</a>',
      'Spatial Scale': 'Tract, Zip',
      markdownPrefix: 'Access05 / ',
      markdownText: 'Access: Mental Health Providers',
      markdown: 'Access_MentalHealth_MinDistance',
      'Variable Construct': 'Access to Mental Health Providers'
    },
    {
      'Variable Proxy': 'Geographic access substance use treatment (SUT) programs',
      Source: 'SAMHSA, 2020',
      Metadata: 'Access06 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Access_SubstanceUseTreatment.md">Access: SUT</a>',
      'Spatial Scale': 'Tract, Zip',
      markdownPrefix: 'Access06 / ',
      markdownText: 'Access: Substance Use Treatment Programs',
      markdown: 'Access_SubstanceUseTreatment',
      'Variable Construct': 'Access to Substance Use Treatment Programs'
    },
    {
      'Variable Proxy': 'Geographic access to opioid treatment programs (OTP)',
      Source: 'SAMHSA, 2021',
      Metadata: 'Access07 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Access_OpioidUseTreatment.md">Access: OTP</a>',
      'Spatial Scale': 'Tract, Zip',
      markdownPrefix: 'Access07 / ',
      markdownText: 'Access: Opioid Treatment Programs',
      markdown: 'Access_OpioidUseTreatment',
      'Variable Construct': 'Access to Opioid Treatment Programs'
    }
  ],

  'Demographic Variables': [
    {
      'Variable Proxy': 'Percentages of population defined by categories of race and ethnicity',
      Source: 'ACS, 2018 5-year',
      Metadata: 'DS01/ <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Race_Ethnicity_2018.md">Race & Ethnicity Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: '',
      markdownText: 'Race & Ethnicity Variables',
      markdown: 'Race_Ethnicity_2018',
      'Variable Construct': 'Race & Ethnicity'
    },
    {
      'Variable Proxy': 'Age group estimates and percentages of population',
      Source: 'ACS, 2018 5-year',
      Metadata: 'DS01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Age_2018.md">Age Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'DS01 / ',
      markdownText: 'Age Variables',
      markdown: 'Age_2018',
      'Variable Construct': 'Age'
    },
    {
      'Variable Proxy': 'Percentage of population with a disability',
      Source: 'ACS, 2018 5-year',
      Metadata: 'DS01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Other_Demographic_2018.md">Other Demographic Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'DS01 / ',
      markdownText: 'Other Demographic Variables',
      markdown: 'Other_Demographic_2018',
      'Variable Construct': 'Population with a Disability'
    },
    {
      'Variable Proxy': 'Population without a high school degree',
      Source: 'ACS, 2018 5-year',
      Metadata: 'DS01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Other_Demographic_2018.md">Other Demographic Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'DS01 / ',
      markdownText: 'Other Demographic Variables',
      markdown: 'Other_Demographic_2018',
      'Variable Construct': 'Educational Attainment'
    },
    {
      'Variable Proxy': 'SDOH Neighborhood Typologies',
      Source: 'Kolak et al, 2020',
      Metadata: 'DS02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/SDOH_2014.md">SDOH Typology</a>',
      'Spatial Scale': 'Tract',
      markdownPrefix: 'DS02 / ',
      markdownText: 'SDOH Typology',
      markdown: 'SDOH_2014',
      'Variable Construct': 'Social Determinants of Health (SDOH)'
    },
    {
      'Variable Proxy': 'SVI Rankings',
      Source: 'CDC, 2018',
      Metadata: 'DS03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/SVI_2018.md">SVI</a>',
      'Spatial Scale': 'County, Tract',
      markdownPrefix: 'DS03 / ',
      markdownText: 'SVI',
      markdown: 'SVI_2018',
      'Variable Construct': 'Social Vulnerability Index (SVI)'
    },
    {
      'Variable Proxy': 'Population as defined by veteran status',
      Source: 'ACS, 2017 5-year',
      Metadata: 'DS04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/VetPop.md">Veteran Population Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'DS04 / ',
      markdownText: 'Veteran Population Variables',
      markdown: 'VetPop',
      'Variable Construct': 'Veteran Population'
    },
    {
      'Variable Proxy': 'Household types and group quarter populations',
      Source: 'ACS, 2018 5-year',
      Metadata: 'DS05 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/HouseholdType.md">Housing Type Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'DS05 / ',
      markdownText: 'Household Type',
      markdown: 'HouseholdType',
      'Variable Construct': 'Household Type'
    },
    {
      'Variable Proxy': 'Homelessness as defined by US Homeless Census',
      Source: 'HUD, 2018',
      Metadata: 'DS06 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/HomelessPop.md">Homeless Population Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'DS06 / ',
      markdownText: 'Homeless Population Variables',
      markdown: 'HomelessPop',
      'Variable Construct': 'Homeless Population'
    }

  ],
  'Economic Variables': [
    {
      'Variable Proxy': 'Percentage of population employed in High Risk of Injury Jobs, Educational Services, Health Care, Retail industries',
      Source: 'ACS, 2018 5-year',
      Metadata: 'EC01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Job_Categories_byIndustry_2018.md">Jobs by Industry</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'EC01 / ',
      markdownText: 'Jobs by Industry',
      markdown: 'Job_Categories_byIndustry_2018',
      'Variable Construct': 'Employment Trends'
    },
    {
      'Variable Proxy': 'Percentage of population employed in Essential Jobs as defined during the COVID-19 pandemic (see COVID-19 Variables, below)',
      Source: 'ACS, 2018 5-year',
      Metadata: 'EC02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Job_Categories_byIndustry_2018.md">Jobs by Industry</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'EC02 / ',
      markdownText: 'Jobs by Industry',
      markdown: 'Job_Categories_byIndustry_2018',
      'Variable Construct': 'Essential Workers'
    },
    {
      'Variable Proxy': 'Unemployment rate',
      Source: 'ACS, 2014-2018',
      Metadata: 'EC03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Economic_2018.md">Economic Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'EC03 / ',
      markdownText: 'Economic Variables',
      markdown: 'Economic_2018',
      'Variable Construct': 'Unemployment Rate'
    },
    {
      'Variable Proxy': 'Percent classified as below poverty level, based on income',
      Source: 'ACS, 2018 5-year',
      Metadata: 'EC03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Economic_2018.md">Economic Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'EC03 / ',
      markdownText: 'Economic Variables',
      markdown: 'Economic_2018',
      'Variable Construct': 'Poverty Rate'
    },
    {
      'Variable Proxy': 'Per capita income in the past 12 months',
      Source: 'ACS, 2018 5-year',
      Metadata: 'EC03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Economic_2018.md">Economic Variables</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'EC03 / ',
      markdownText: 'Economic Variables',
      markdown: 'Economic_2018',
      'Variable Construct': 'Per Capita Income'
    },
    {
      'Variable Proxy': 'Mortgage foreclosure and severe delinquency rate',
      Source: 'HUD, 2009',
      Metadata: 'EC04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/ForeclosureRate.md">Foreclosure Rate</a>',
      'Spatial Scale': 'State, County, Tract',
      markdownPrefix: 'EC04 / ',
      markdownText: 'Foreclosure Rate',
      markdown: 'ForeclosureRate',
      'Variable Construct': 'Foreclosure Rate'
    }
  ],
  'Physical Environment Variables': [
    {
      'Variable Proxy': 'Percent occupied units',
      Source: 'ACS, 2018 5-year',
      Metadata: 'BE01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Housing_2018.md">Housing</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'BE01 / ',
      markdownText: 'Housing',
      markdown: 'Housing_2018',
      'Variable Construct': 'Housing Occupancy Rate'
    },
    {
      'Variable Proxy': 'Percent vacant units',
      Source: 'ACS, 2018 5-year',
      Metadata: 'BE01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Housing_2018.md">Housing</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'BE01 / ',
      markdownText: 'Housing',
      markdown: 'Housing_2018',
      'Variable Construct': 'Housing Vacancy Rate'
    },
    {
      'Variable Proxy': 'Percentage of population living in current housing for 20+ years',
      Source: 'ACS, 2018 5-year',
      Metadata: 'BE01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Housing_2018.md">Housing</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'BE01 / ',
      markdownText: 'Housing',
      markdown: 'Housing_2018',
      'Variable Construct': 'Long Term Occupancy'
    },
    {
      'Variable Proxy': 'Percent of housing units classified as mobile homes',
      Source: 'ACS, 2018 5-year',
      Metadata: 'BE01 / <a href="/data_final/metadata/Housing_2018.md">Housing</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'BE01 / ',
      markdownText: 'Housing',
      markdown: 'BE01',
      'Variable Construct': 'Mobile Homes'
    },
    {
      'Variable Proxy': 'Percent of housing units occupied by renters',
      Source: 'ACS, 2018 5-year',
      Metadata: 'BE01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Housing_2018.md">Housing</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'BE01 / ',
      markdownText: 'Housing',
      markdown: 'Housing_2018',
      'Variable Construct': 'Rental Rates'
    },
    {
      'Variable Proxy': 'Housing units per square mile',
      Source: 'ACS, 2018 5-year',
      Metadata: 'BE01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Housing_2018.md">Housing</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'BE01 / ',
      markdownText: 'Housing',
      markdown: 'Housing_2018',
      'Variable Construct': 'Housing Unit Density'
    },
    {
      'Variable Proxy': 'Classification of areas as rural, urban or suburban using percent rurality (County)',
      Source: 'USDA-ERS, 2010 & ACS, 2018 5-year',
      Metadata: 'BE02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Rural_Urban_Classification_County.md">Rural-Urban Classifications (County)</a>',
      'Spatial Scale': 'County',
      markdownPrefix: 'BE02 / ',
      markdownText: 'Rural-Urban Classifications',
      markdown: 'Rural_Urban_Classification_County',
      'Variable Construct': 'Urban/Suburban/Rural Classification (County)'
    },
    {
      'Variable Proxy': 'Classification of areas as rural, urban or suburban using RUCA Codes (Tract, Zip)',
      Source: 'USDA-ERS, 2010',
      Metadata: 'BE02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Rural_Urban_Classification_T_Z.md">Rural-Urban Classifications (Tract, Zip)</a>',
      'Spatial Scale': 'Tract, Zip',
      markdownPrefix: 'BE02 / ',
      markdownText: 'Rural-Urban Classifications',
      markdown: 'Rural_Urban_Classification_T_Z',
      'Variable Construct': 'Urban/Suburban/Rural Classification (Tract, Zip)'
    },
    {
      'Variable Proxy': 'Alcohol outlets per square mile, alcohol outlets per capita',
      Source: 'InfoGroup, 2018',
      Metadata: 'BE03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/AlcoholOutlets_2018.md">Alcohol Outlets</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'BE03 / ',
      markdownText: 'Alcohol Outlets',
      markdown: 'AlcoholOutlets_2018',
      'Variable Construct': 'Alcohol Outlet Density'
    },
    {
      'Variable Proxy': 'US metropolitan areas where black residents experience hypersegregation',
      Source: 'Massey et al, 2015',
      Metadata: 'BE04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Overlay.md">Community Overlays</a>',
      'Spatial Scale': 'County',
      markdownPrefix: 'BE04 / ',
      markdownText: 'Community Overlays',
      markdown: 'Overlay',
      'Variable Construct': 'Hypersegregated Cities'
    },
    {
      'Variable Proxy': 'US counties where 30% of the population identified as Black or African American',
      Source: 'US Census, 2010',
      Metadata: 'BE04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Overlay.md">Community Overlays</a>',
      'Spatial Scale': 'County',
      markdownPrefix: 'BE04 / ',
      markdownText: 'Community Overlays',
      markdown: 'Overlay',
      'Variable Construct': 'Southern Black Belt'
    },
    {
      'Variable Proxy': 'Percent area of total land in Native American Reservations',
      Source: 'US Census, TIGER/Line 2018',
      Metadata: 'BE04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Overlay.md">Community Overlays</a>',
      'Spatial Scale': 'County',
      markdownPrefix: 'BE04 / ',
      markdownText: 'Community Overlays',
      markdown: 'Overlay',
      'Variable Construct': 'Native American Reservations'
    },
    {
      'Variable Proxy': 'Three index measures of segregation: dissimilarity, interaction, isolation',
      Source: 'ACS, 2018 5-year',
      Metadata: 'BE05 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Residential_Seg_Indices.md">Residential Segregation</a>',
      'Spatial Scale': 'County',
      markdownPrefix: 'BE05 / ',
      markdownText: 'Residential Segregation',
      markdown: 'Residential_Seg_Indices',
      'Variable Construct': 'Residential Segregation Indices'
    },
    {
      'Variable Proxy': 'Normalized Difference Vegetation Index (NDVI) average value',
      Source: 'Sentinel-2 MSI, 2018',
      Metadata: 'BE06 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/NDVI.md">NDVI</a>',
      'Spatial Scale': 'Tract',
      markdownPrefix: 'BE06 / ',
      markdownText: 'NDVI',
      markdown: 'NDVI',
      'Variable Construct': 'NDVI'
    }
  ],
  'COVID Variables': [
    {
      'Variable Proxy': 'Percentage of population employed in Essential Jobs as defined during the COVID-19 pandemic',
      Source: 'ACS, 2018 5-year',
      Metadata: 'EC02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/Job_Categories_byOccupation_2018.md">Jobs by Occupation</a>',
      'Spatial Scale': 'State, County, Tract, Zip',
      markdownPrefix: 'EC02 / ',
      markdownText: 'Jobs by Occupation',
      markdown: 'Job_Categories_byOccupation_2018',
      'Variable Construct': 'Essential Worker Jobs'
    },
    {
      'Variable Proxy': 'Daily cumulative raw case count (01/21/20 - 03/03/2021)',
      Source: 'The New York Times, 2021',
      Metadata: 'COVID01 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/COVID.md">COVID Variables</a>',
      'Spatial Scale': 'State, County',
      markdownPrefix: 'COVID01 / ',
      markdownText: 'COVID Variables',
      markdown: 'COVID',
      'Variable Construct': 'Cumulative Case Count'
    },
    {
      'Variable Proxy': 'Daily cumulative adjusted case count per 100K population (01/21/20 - 03/03/2021)',
      Source: 'The New York Times, 2021',
      Metadata: 'COVID02 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/COVID.md">COVID Variables</a>',
      'Spatial Scale': 'State, County',
      markdownPrefix: 'COVID02 / ',
      markdownText: 'COVID Variables',
      markdown: 'COVID',
      'Variable Construct': 'Adjusted Case Count per 100K'
    },
    {
      'Variable Proxy': '7-day average case count (01/21/20 - 03/03/2021)',
      Source: 'The New York Times, 2021',
      Metadata: 'COVID03 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/COVID.md">COVID Variables</a>',
      'Spatial Scale': 'State, County',
      markdownPrefix: 'COVID03 / ',
      markdownText: 'COVID Variables',
      markdown: 'COVID',
      'Variable Construct': '7-day Average Case Count'
    },
    {
      'Variable Proxy': '7-day average adjusted case count per 100K population (01/21/20 - 03/03/2021)',
      Source: 'The New York Times, 2021',
      Metadata: 'COVID04 / <a href="https://github.com/GeoDaCenter/opioid-policy-scan/data_final/metadata/COVID.md">COVID Variables</a>',
      'Spatial Scale': 'State, County',
      markdownPrefix: 'COVID04 / ',
      markdownText: 'COVID Variables',
      markdown: 'COVID',
      'Variable Construct': 'Historical 7-day Average Adjusted Case Count per 100K'
    }
  ]
}