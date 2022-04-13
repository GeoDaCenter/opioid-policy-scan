**Meta Data Name**: Residential Segregation Indices  
**Created**: July 8, 2021  
**Modified**: April 12, 2022  
**Author**: Susan Paykin  

### Data Location: 
BE05 - Residential Segregation Indicies calculated at the county level. File can be found [here](/data_final).
* BE05_C
* BE05_S
* BE05_Z

### Data Source(s) Description:  
All data was sourced from the American Community Survey (ACS) 2018 5-year estimates. Population demographic data was sourced at the tract level for all U.S. states and then aggregated up to the county-level for calculations. 

### Description of Data Processing: 
All calculations were performed in R. We obtained U.S. Census data from the American Community Survey using the `tidycensus` package, pulling from [Table B03002](https://censusreporter.org/tables/B03002/) (Race and Hispanic Origin) at the Census tract level for all states. We then aggregated tract-level population totals to the county level and merged the county population with the tract data for the measures of residential segregation calculations. We used index formulas from the U.S. Census, Housing Patterns, [Appendix B: Measures of Residential Segregation](https://www.census.gov/topics/housing/housing-patterns/guidance/appendix-b.html), developed by Massey and Denton (1998) for these calculations. 

State-level measures are mean values aggregated from county-level index measures by FIPS codes. 

Zip code-level measures were calculated by crosswalking Census tract to zip code populations, using the [HUD USPS ZIP Code Crosswalk File (Tract - Zip)](https://www.huduser.gov/portal/datasets/usps_crosswalk.html). 

The group segregation measures were calculated as follows: 

#### Dissimilarity Index

The most widelu used measure of evenness is the dissimilarity index, which measures the percentage of the minority group's population that would have to change residence for each neighborhood (in this case, tract) to have the same percentage of that group as the county overall. The index ranges from 0.0 (complete integration) to 1.0 (complete segregation). 

To calculate the dissimilarity index for each racial/ethnic minority group, first we calculate the tract-specific contribution to the county dissimilarity index, then we sum the tract-specific contributions within counties. The dissimilarity index formula for minority groups and whites is: $$Dissimilarity=.5∗∑i ∣(xi/X) − (wi/W)∣$$ where xi is the number of minority group residents (Black, Hispanic, Asian) in each tract, X is the number of minority group residents in the county, wi is the number of non-Hispanic white residents in the tract, and W is the number of non-Hispanic white residents in the county.

#### Interaction Index

The interaction index reflect the probabilities that a person in a minority group shares a  area with a majority person. To calculate the interaction index for each racial/ethnic minority group, we used the following formula: $$Interaction= ∑i (xi/X) ∗ (wi/ti)$$ where xi is the number of minority group residents (Black, Hispanic, Asian) in each tract, X is the number of minority group residents in the county, wi is the number of non-Hispanic white residents in the tract, and ti is the total population of the area. 

#### Isolation Index

The isolation index reflects the probabilities that a person in a minority group shares an area with another minority person. To calculate the isolation index for each racial/ethnic minority group, we used the following formula: $$Isolation=∑i (xi/X) ∗ (bi/ti)$$  where xi is the number of minority group residents (Black, Hispanic, Asian) in each tract, X is the number of minority group residents in the county, wi is the number of non-Hispanic white residents in the tract, and ti is the total population of the area. 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| State ID | STATEFP | Unique 2-digit identifier for states |
| County ID | COUNTYFP | Unique 5-digit identifier for counties, w/ first 2 digits state FIPS |
| Dissimilarity index - Black | dissim.b | Dissimilarity index for Black and non-Hispanic White residents |
| Interaction index - Black | inter.bw | Interaction index for Black and non-Hispanic White residents |
| Isolation index - Black | iso.b | Isolation index for Black and non-Hispanic White residents |
| Dissimilarity index - Hispanic | dissim.h | Dissimilarity index for Hispanic and non-Hispanic White residents |
| Interaction index - Hispanic | inter.hw | Interaction index for Hispanic and non-Hispanic White residents |
| Isolation index - Hispanic | iso.h | Isolation index for Hispanic and non-Hispanic White residents |
| Dissimilarity index - Asian | dissim.a | Dissimilarity index for Asian and non-Hispanic White residents |
| Interaction index - Asian | inter.a | Interaction index for Asian and non-Hispanic White residents |
| Isolation index - Asian | iso.a | Isolation index for Asian and non-Hispanic White residents |

### Data Limitations:
The three indices measuring  residential segregation included here represent two categories of measures of residential segregation: measures of evenness (dissimiliarity) and measures of exposure (interaction and isolation). Three additional categories of residential segregation measurements described by Massey and Denton (1998) include measures of concentration, centralization, and clustering. Read more on the indices and their expressions from the [U.S. Census Bureau](https://www.census.gov/topics/housing/housing-patterns/guidance/appendix-b.html). 


### Comments/Notes:
From the [U.S. Census Bureau](https://www.census.gov/topics/housing/housing-patterns/guidance/appendix-b.html), on Measures of Residential Segregation: "Massey and Denton (1988) used an extensive literature search and cluster analysis to identify 20 different indexes of segregation and classify them into five key dimensions of segregation. Basically, evenness involves the differential distribution of the subject population, exposure measures potential contact, concentration refers to the relative amount of physical space occupied, centralization indicates the degree to which a group is located near the center of an urban area, and clustering measures the degree to which minority group members live disproportionately in contiguous areas.""

Note: In all of the calculations, non-Hispanic whites are considered the "majority" (reference) population. 
