**Meta Data Name**: Rural-Urban Classification for Counties  
**Date Added**: March 20, 2020  
**Author**: Moksha Menghaney & Susan Paykin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Percentage of rural and urban population is sourced from the Census Bureau. Raw data and more details can be found [here](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural.html).

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

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| % Urban | RcaUrbanP | Percent census tracts in the county classified as Urban using RUCA codes | Latest | County |
| % Suburban | RcaSubrbP | Percent census tracts in the county classified as Suburban using RUCA codes | Latest | County |
| % Rural  | RcaRuralP | Percent census tracts in the county classified as Rural using RUCA codes | Latest | County |
| CeususFlags | CenFlags | Three different values indicating three things: [1] - Revised count, so urban and rural components will not add to total. [2] - Geography name and FIPS code were changed since 2010. Shannon County, Sotuh Dakota name changed to Oglala Lakota County, new FIPS 46102. Wade Hampton Census Area, Alaska, name changed to Kusilvak CEnsus Area, nwe FIPS 02158. [3] - Bedford City, Virginia, was consolidated with Bedford County, Virginia (FIPS 51019) since 2010. | Latest | County |
| Total Population| TotPop10 | 2010 Total Population | Latest | County |
| Urban Population| UrbPop10 | 2010 Population living in urban areas, as defined by Census Bureau | Latest | County |
| Rural Population| RuralPop10 | 2010 Population living in non urban areas, as defined by Census Bureau | Latest | County |
| % Rurality | CenRuralP | % of 2010 Population living in non urban areas, as defined by Census Bureau | Latest | County |

### Data Limitations:
n/a

### Comments/Notes:
The datasets come from two different sources. As a result, there might have some gaps or mismatches in the rurality categorization. Furthermore, for Census rurality, there are additional notes included for certain counties, e.g. changes in FIPS codes. These can be found under the `note` column.
