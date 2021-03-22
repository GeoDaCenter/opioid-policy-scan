**Meta Data Name**: Access to Federal Qualified Health Centers (FQHCs)  
**Last Modified**: January 5, 2021  
**Author**: Susan Paykin 

### Data Location: 
Access02 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access02_T  
* Access02_Z  

### Data Source(s) Description:  
Locations of Federal Qualified Health Centers (FQHCs) were sourced from the the [Health Resources and Services Administration](https://bphc.hrsa.gov/datareporting/index.html) which were cleaned and geocoded for the [US COVID Atlas](https://theuscovidatlas.org/). 

ZIP Code Tract Area (ZCTA) and Census Tract boundary files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The raw source FQHC dataset includes the name of the FQHC facility, address, state, phone number, COVID testing status (yes/no), and latitude and logitude variables. 

### Description of Data Processing: 
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance was calculated from the centroid of each tract/ZCTA to the nearest FQHC location.

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Access to FQHC | minDisFQHC | Distance from centroid to nearest FQHC, in miles |
| GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| State | STATEFP | Unique 2-digit ID for states |
| County | COUNTYFP | 3-digit ID for counties |
| Census Tract | TRACTCE | 6-digit ID for census tracts |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Unique 5-digit assigned ZCTA, usually same as ZIP Code  |

### Data Limitations:
Euclidean distance or straight-line distance is a simple approximation of distance or travel time from an origin centroid to the nearest health center. It is not a precise calculation of real travel times or distances. 

### Comments/Notes:
This dataset includes all US states, Washington D.C., and Puerto Rico. It does not include the territories Guam, Northern Mariana Islands, American Samoa, Palau. Zip code and tract centroids are not population-weighted.
