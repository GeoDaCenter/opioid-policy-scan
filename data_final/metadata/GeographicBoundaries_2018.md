**Meta Data Name**: Geographic Boundaries  
**Last Modified**: March 20, 2021    
**Author**: Susan Paykin  

### Data Location: 
Four geographic boundary files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final/geometryFiles).
* State 
* County
* Tract
* ZIP Code (ZCTA) 

### Data Source(s) Description:  
Geographic boundary data are sourced from the U.S. Census [2018 TIGER/Line Shapefiles](https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.2018.html). All legal boundaries and names are as of January 1, 2018. The files were originally released September 18, 2018.

### Description of Data Source Tables: 
The source state, county, tract, and ZCTA shapefiles include variables for the the area's geographic ID code, ID code of other relevant areas (i.e. state ID for each county ID), total land area, total water area, and geometry variables. The Census Bureau provides [full technical documentation](https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.2018.html) for these files, including information on how to use shapefiles for GIS and spatial analysis, as well as information about the use of [geographic identifiers](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html).

### Description of Data Processing: 
Geographic boundary files were merged with descriptive data included in the Opioid Environment Data Warehouse for use in geocomputational research, GIS activities, and spatial data analysis and visualization. 


### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| State | STATEFP |	2-digit State code |
| County | COUNTYFP |	5-digit County code (state + county) |
| ZIP Code Tract Area (ZCTA) | ZCTA |	5-digit assigned ZCTA |
| Census Tract | TRACTCE	| 6-digit Census Tract designation |
| GEOID for Census Tract | GEOID |	Unique 11-digit ID for Census Tracts (state + county + tract) |


### Data Limitations: 
N/A


### Comments/Notes:
N/A
