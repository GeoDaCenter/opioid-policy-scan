**Meta Data Name**: Geographic Boundaries
**Date Added**: February 1, 2024
**Date Last Modified**: December 9, 2024
**Author**: Adam Cox

### Data Location

#### 2010 Geographic Boundaries

Use for all OEPS data from 1980 to 2010.

* State: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/state-2010-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/state-2010-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/state-2010-500k.pmtiles)
* County: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/county-2010-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/county-2010-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/county-2010-500k.pmtiles)
* Tract: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/tract-2010-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/tract-2010-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/tract-2010-500k.pmtiles)
* Block Group: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/bg-2010-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/bg-2010-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/bg-2010-500k.pmtiles)

#### 2018 Geographic Boundaries

Use for latest OEPS data (2018).

* State: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/state-2018-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/state-2018-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/state-2018-500k.pmtiles)
* County: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/county-2018-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/county-2018-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/county-2018-500k.pmtiles)
* Tract: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/tract-2018-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/tract-2018-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/tract-2018-500k.pmtiles)
* ZIP Code (ZCTA): [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/zcta-2018-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/zcta-2018-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/zcta-2018-500k.pmtiles)
* Block Group: [GeoJSON](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/bg-2018-500k.geojson) | [Shapefile](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/bg-2018-500k-shp.zip) | [PMTiles](https://herop-geodata.s3.us-east-2.amazonaws.com/oeps/bg-2018-500k.pmtiles)

### Data Source(s) Description:

These geographic boundary files have been generated from the U.S. Census Bureau [Cartographic Boundary Files](https://www.census.gov/programs-surveys/geography/technical-documentation/naming-convention/cartographic-boundary-file.html), using the 500k scale variants for all geographies.

### Description of Data Source Tables: 

_section in progress_

The source state, county, tract, and ZCTA shapefiles include variables for the the area's geographic ID code, ID code of other relevant areas (i.e. state ID for each county ID), total land area, total water area, and geometry variables. The Census Bureau provides [full technical documentation](https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.2018.html) for these files, including information on how to use shapefiles for GIS and spatial analysis, as well as information about the use of [geographic identifiers](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html).

### Description of Data Processing: 

We have a backend ETL pipeline set up to create these files. The following steps are performed for any geography and year:

- Download all 500k Cartographic Boundary files for a given geography and year from the US Census Bureau's FTP, [www2.census.gov/geo/tiger](https://www2.census.gov/geo/tiger/)
- Merge all downloaded files with GeoPandas
    - For smaller geographies, like ZCTA and tracts, these is one file per state, while larger geographies are distributed in a single file for the whole US
- Calculate new fields `HEROP_ID`, `minx`, `miny`, `maxx`, `maxy`, `BBOX`, and `LABEL`
- Drop extra fields as needed
- Export to GeoJSON, SHP, and PMTiles derivatives.
- Upload exports to AWS S3 for storage


### Key Variable and Definitions:

_note, some fields below may not be present across all geographies._

| Variable | Type | Description |
|:---------|:------------|:---|
| HEROP_ID | string | Unique identifier across all census geographies (see below for details) |
| GEOID fo r Census Tract | GEOID |	Unique id within a given geography level |
| minx | float | Min X coordinate |
| miny | float | Min Y coordinate |
| maxx | float | Max X coordinate |
| maxy | float | Max Y coordinate |
| BBOX | string | Concatenation of {minx},{miny},{maxx},{maxy} |
| LABEL | Display label for this geography |
| COUNTYFP | integer | 5-digit County code (state + county) |
| ZCTA | ZCTA |	5-digit assigned ZCTA |
| TRACTCE | 	| 6-digit Census Tract designation |

#### HEROP_ID

The <strong>HEROP_ID</strong> is a slight variation on the commonly used standard <strong>GEOID</strong>. Our format is similar to what the American FactFinder used (now data.census.gov). 

  A HEROP_ID consists of three parts:

  1. The 3-digit [Summary Level Code](https://www.census.gov/programs-surveys/geography/technical-documentation/naming-convention/cartographic-boundary-file/carto-boundary-summary-level.html) for this geography. Common summary level codes are:
      - `040` -- **State**
      - `050` -- **County**
      - `140` -- **Census Tract**
      - `150` -- **Census Block Group**
      - `860` -- **Zip Code Tabulation Area (ZCTA)**
  2. The 2-letter string `US`
  3. The standard [GEOID](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html) for the given unit (length depends on unit summary)
      - GEOIDs are, in turn, hierarchical aggregations of FIPS codes

  Expanding out the FIPS codes for the five summary levels shown above, the full IDs would look like:

  | summary level | format | length | example |
  |---|---|---|---|
  |State|`040US` + `STATE (2)`|7|`040US17` (Illinois)|
  |County|`050US` + `STATE (2)` + `COUNTY (3)`|10|`050US17019` (Champaign County)|
  |Tract|`140US` + `STATE (2)` + `COUNTY (3)` + `TRACT (6)`|16|`140US17019005900`|
  |Block Group|`150US` + `STATE (2)` + `COUNTY (3)` + `TRACT (6)` + `BLOCK GROUP (1)`|17|`150US170190059002`|
  |ZCTA|`860US` + `ZIP CODE (5)`|10|`860US61801`|

  The advantages of this composite ID are:
  
  1. Unique across all geographic areas in the US
  2. Will always be forced to string formatting
  3. Easy to programmatically change back into the more standard GEOIDs

  **Convert to GEOID (integers)**

  The `HEROP_ID` can be converted back to standard GEOIDs by removing the first 5 characters, or by taking everything after the substring "US". Here are some examples of what this looks like in different software:
  
  - Excel: `REPLACE(A1, 1, 5, "")`
  - R: `geoid <- str_split_i(HEROP_ID, "US", -1)`
  - Python: `geoid = HEROP_ID.split("US")[1]`
  - JavaScript: `const geoid = HEROP_ID.split("US")[1]`


### Data Limitations: 
N/A


### Comments/Notes:
N/A
