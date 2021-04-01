**Meta Data Name**: Rural Urban Classification for Counties  
**Last Modified**: March 20, 2020  
**Author**: Moksha Menghaney, updates by Susan Paykin

### Data Location: 
HS02 at the County scale. File can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* HS02_C  

### Data Source(s) Description:  
Percentage rural and urban population is sourced from the Census Bureau. Raw data and more details can be found [here](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural.html).

### Description of Data Source Tables:
After each decennial census, the bureau identifies Urban Areas under two categories :
* Urbanized Areas (UAs) of 50,000 or more people;
* Urban Clusters (UCs) of at least 2,500 and less than 50,000 people.

All other areas are classified as Rural. These classifications are done at a census block/tract level and are primarily based on population density and land use. 
Using these classifications, for each county, the bureau calculates a percent rurality measure which is the percentage of population living in non-urban areas. We source this variable. More details on methodology can be found [here](https://www2.census.gov/geo/pdfs/reference/ua/Defining_Rural.pdf).

### Description of Data Processing: 
For each county, from the census data, the percentage of population living in non-urban areas is identified as percentage rurality.

For each county, the percentage of tracts classified as urban/suburban/rural, using the RUCA code definitions were calculated. Details on the classification methodology can be found [here](Policy_Scan/data_final/metadata/Rural_Urban_Classification_T_Z.md).
  
### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % Urban | rcaUrbP | Percent census tracts in the county classified as Urban using RUCA codes |
| % Suburban | rcaSubrbP | Percent census tracts in the county classified as Suburban using RUCA codes |
| % Rural  | rcaRuralP | Percent census tracts in the county classified as Rural using RUCA codes |
| Urban Population| urbPop10 | 2010 Population living in urban areas, as defined by Census Bureau |
| Rural Population| rurlPop10 | 2010 Population living in non urban areas, as defined by Census Bureau |
| % Rurality | cenRuralP | % of 2010 Population living in non urban areas, as defined by Census Bureau |


### Data Limitations:
n/a

### Comments/Notes:
The datasets come from two different source. As a result, there might have some gaps or mismatches in the rurality categorization. Furthermore, for Census rurality, there are additional notes included for certain counties, e.g. changes in FIPS codes. These can be found under the `note` column.
