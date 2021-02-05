**Meta Data Name**: Alcohol Outlet Density  
**Environment**: Physical Factors   
**Last Modified**: January 12, 2021   
**Author**: Susan Paykin    

### Data Location: 
HS03 - Policy Scan Environment Report at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* HS03_S 
* HS03_C
* HS03_T  
* HS03_Z 

### Data Source(s) Description:  
Alcohol outlet locations are from Infogroup's 2018 Business and Consumer Historical Datafile. State, county, census tract, and zip code tract area (ZCTA) geometry files are from the U.S. Census TIGER/Line Shapefiles 2018. 

### Description of Data Source Tables: 

From Infgroup, key variables include point location data and *Primary.NAICS.Code*, which was filtered for the the following NAICS codes for BEER, WINE, & LIQUOR STORES:
* 44531001
* 44531002 
* 44531004 
* 44531005 
* 44531006 
* 44531007

From U.S. Census/TIGER files, key variables include: 
* ALAND - Land area, or an area measurement providing the size, in square meters, of the land portions of geographic entities for which the Census Bureau tabulates and disseminates data.

### Description of Data Processing: 

* Alcohol outlet locations were sourced from the Infogroup Historical Datafile, which was filtered by NAICS code 445310 for BEER, WINE, & LIQUOR STORES. Location data was then cleaned and converted to spatial data.
* Total outlet counts were calculated via point-in-polygon procedure where outlets points were merged with geometries, then counted & summed by state, county, tract, and zip codes.
* Land area in sq meters (ALAND variable) was sourced from geometry files and converted to sq miles (1 sq mi = 2,590,000 sq m).
* Alcohol outlet density was calculated as: 
  * Geographic density: Total outlets / Land area in sq mi
  * Per capita density: Total outlets / Total population

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique identifier with 2 digits for states, 5 digits for counties, 11 digits for census tracts, 5 digits for ZCTAs (more [here](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html)) |
| Alcohol outlet density per land area | alcDens | Number of alcohol outlets per square mile |
| Alcohol outlet density per capita | alcPerCap | Number of alcohol outlets per capita |
| Total alcohol outlets | alcTotal | Total number of alcohol outlets in geography |
| Total area | areaSqMi | Land area of geography in sq miles |
| Total population | totPopE | Total population estimate |

### Data Limitations: 
Land area density is not always the best measurement of the spatial impact of alcohol outlets and liquor stores. We also plan to incorporate population-weighted density, which in some areas, particularly densely-population urban centers and sparsely-populated rural areas, may be a better proxy for access to alcohol outlets.   

The category of 'alcohol outlets' included in this dataset does not include supermarkets and/or drug stores that may carry beer, wine, or liquor. The laws governing these sales varies from state to state, permitting alcohol sales in different kind of sales outlets. Outlets that are permitted to make these sales may not always fall under the same NAICS code for *Beer, Wine, and Liquor Stores*. 

### Comments/Notes:

Includes U.S. states and District of Columbia. Does not include U.S. territories FM, GU, MP, PR, VI.
