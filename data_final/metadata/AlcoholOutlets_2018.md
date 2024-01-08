**Meta Data Name**: Alcohol Outlet Density  
**Author**: Susan Paykin  
**Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment  

### Data Location: 
Latest - the data is available at 4 spatial scales: census tract, zip code, county, and state. Files can be found [here](../full_tables).
* T_Latest.csv  
* Z_Latest.csv  
* C_Latest.csv  
* S_Latest.csv   

### Data Source(s) Description:  
Alcohol outlet locations are from Infogroup's 2018 Business and Consumer Historical Datafile. State, county, census tract, and ZIP Code Tract Area (ZCTA) geometry files are from the U.S. Census TIGER/Line Shapefiles 2018. 

### Description of Data Source Tables: 

From Infgroup, key variables include point location data and *Primary.NAICS.Code*, which was filtered for the following NAICS codes for BEER, WINE, & LIQUOR STORES:
* 44531001
* 44531002 
* 44531004 
* 44531005 
* 44531006 
* 44531007

From U.S. Census/TIGER files, key variables include: 
* ALAND - Land area, or an area measurement providing the size, in square meters, of the land portions of geographic entities for which the Census Bureau tabulates and disseminates data.

### Description of Data Processing: 

Alcohol outlet locations were sourced from the Infogroup Historical Datafile, which was filtered by NAICS code 445310 (*BEER, WINE, & LIQUOR STORES*). Location data was then cleaned and converted to spatial data. Total outlet counts were calculated via point-in-polygon procedure where outlets points were merged with geometries, then counted & summed by state, county, tract, and zip codes.

Land area in sq meters was sourced from geometry files and converted to sq miles (1 sq mi = 2,590,000 sq m).

Alcohol outlet density was then calculated as: 
  * Geographic density: Total outlets / Land area in sq mi
  * Per capita density: Total outlets / Total population

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total alcohol outlets | AlcTot | Total number of alcohol outlets |
| Alcohol outlet density per land area | AlcDens | Number of alcohol outlets per square mile |
| Alcohol outlet density per capita | AlcPerCap | Number of alcohol outlets per capita |
| Total area | AreaSqMi | Land area of geography in sq miles |
| Total population | TotPop | Estimated total population |

### Data Limitations: 
Alcohol outlet density is one approximation for accessibility or demand, though a limited one for describing or understanding the complex relationship between alcohol consumption and the surrounding area or community. 

The category of 'alcohol outlets' included in this dataset does not include supermarkets and/or drug stores that may carry beer, wine, or liquor. The laws governing these sales vary from state to state, permitting alcohol sales in different kinds of sales outlets. Outlets that are permitted to make these sales may not always fall under the same NAICS code for *Beer, Wine, and Liquor Stores*. 

### Comments/Notes:

This dataset includes U.S. states and Washington, D.C. It does not include U.S. territories FM, GU, MP, PR, or VI.
