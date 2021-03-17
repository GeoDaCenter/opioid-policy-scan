**Meta Data Name**: Access to Pharmacies  
**Last Modified**: January 6, 2021   
**Author**: Susan Paykin    

### Data Location: 
Access05 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access05_T  
* Access05_Z  

### Data Source(s) Description:  
Pharmacy locations were sourced from the InfoGroup (now [Data Axle](https://www.data-axle.com/) 2019 Business and Consumer Historical Datafile.

Zip code tract area (ZCTA) and Census Tract files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The source InfoGroup dataset includes the business name, location (address, city, state, census tract, latitude, longitude), NAICS Code, and NAICS Code Description variables. 

### Description of Data Processing: 
Data was downloaded and sourced from InfoGroup's historical dataset, filtered for pharmacies via [NAICS class code](https://www.naics.com/naics-code-description/?code=446110) *4461100*, cleaned, and then converted to spatial data. Next, the nearest resource analysis was conducted using minimum Euclidean distance as a proxy variable for access. This analysis included calculating centroids for all U.S. census tracts and ZCTAs, identifying the nearest pharmact to each tract/zip centroid, then measuring the distance in miles.

### Key Variable and Definitions:

Tracts ([Access05_T](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique GEOID, including state, county, and tract IDs |
| State | STATEFP | Unique 2-digit ID for states |
| County | COUNTYFP | 3-digit ID for counties |
| Census Tract | TRACTCE | 6-digit ID for census tracts |
| Access to pharmacies | minDistT_mi | Euclidean distance from centroid to closest pharmacy, in miles |

Zip Code ([Access05_Z](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique GEOID, same as zip code |
| Zip code tract area | ZCTA5CE10 | Zip code |
| Access to pharmacies | minDistZ_mi | Euclidean distance from centroid to closest pharmacy, in miles |

### Data Limitations:
Euclidean distance or straight-line is a simple approximation of access or travel from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances.

### Comments/Notes:
The final dataset includes US states and Washington, D.C., but does not include territories (Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Palau). ZCTA and tract centroids are not population-weighted.
