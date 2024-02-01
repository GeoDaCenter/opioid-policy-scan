**Meta Data Name**: Geographic Boundaries - 2010
**Last Added**: February 1, 2024  
**Author**: Adam Cox

### Data Location: 

* State: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/state-2010.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/state-2010-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/state-2010.pmtiles)
* County: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/county-2010.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/county-2010-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/county-2010.pmtiles)
* Tract: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/tract-2010.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/tract-2010-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/tract-2010.pmtiles)
* ZIP Code (ZCTA): [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/zcta-2010.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/zcta-2010-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/zcta-2010.pmtiles)

### Data Source(s) Description:

These geographic boundary files have been generated from the U.S. Census Bureau [Cartographic Boundary Files](https://www.census.gov/programs-surveys/geography/technical-documentation/naming-convention/cartographic-boundary-file.html), using the 500k scale variants for all geographies. All legal boundaries and names are as of January 1, 2010.

### Description of Data Source Tables: 

_section in progress_

The source state, county, tract, and ZCTA shapefiles include variables for the the area's geographic ID code, ID code of other relevant areas (i.e. state ID for each county ID), total land area, total water area, and geometry variables. The Census Bureau provides [full technical documentation](https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.2018.html) for these files, including information on how to use shapefiles for GIS and spatial analysis, as well as information about the use of [geographic identifiers](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html).

### Description of Data Processing: 

_section in progress_

Geographic boundary files were merged with descriptive data included in the Opioid Environment Data Warehouse for use in geocomputational research, GIS activities, and spatial data analysis and visualization. 


### Key Variable and Definitions:

_section in progress_

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
