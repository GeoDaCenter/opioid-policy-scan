**Meta Data Name**: Access to Hospitals  
**Last Modified**: January 6, 2021  
**Author**: Susan Paykin  

### Data Location: 
Access03 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access03_T  
* Access03_Z  

### Data Source(s) Description:  
Hospital locations were sourced from [CovidCareMap Healthcare System Capacity data](https://github.com/covidcaremap/covid19-healthsystemcapacity/tree/master/data), an aggregated dataset which sources data from the [Healthcare Cost Report Information System (HCRIS)](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/Cost-Reports/Hospital-2010-form) and [Definitive Healthcare](https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=125.859%2C-16.820%2C-150.821%2C72.123). 

Zip code tract area (ZCTA) and Census Tract files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
n

### Description of Data Processing: 
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance was calculated from the centroid of each tract/ZCTA to the nearest hospital location.

### Key Variable and Definitions:

Tracts (Access03_T):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| State | STATEFP | Unique 2-digit ID for states |
| County | COUNTYFP | 3-digit ID for counties |
| Census Tract | TRACTCE | 6-digit ID for census tracts |
| Access to Nearest Hospital | minDistT_mi | Euclidean distance from centroid to nearest hospital, in miles |

Zip Code (Access03_Z):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique GEOID, same as zip code |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Assigned ZCTA by the USPS |
| Access to Nearest Hospital | minDistZ_mi | Euclidean distance from centroid to nearest hospital, in miles |

### Data Limitations:
Euclidean distance or straight-line is a simple approximation of distance or travel time from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances. 

### Comments/Notes:
This dataset includes all US states, Washington D.C., and territories, including: Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Palau. Zip code and tract centroids are not population-weighted.
