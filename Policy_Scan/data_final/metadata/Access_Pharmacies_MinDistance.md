**Meta Data Name**: Access to Pharmacies  
**Last Modified**: January 6, 2021   
**Author**: Susan Paykin    

### Data Location: 
Access05 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access05_T  
* Access05_Z  

### Data Source(s) Description:  
Pharmacy locations were sourced from Infogroup's 2019 Business and Consumer Historical Datafile.

Zip code tract area (ZCTA) and Census Tract files were sourced from the U.S. Census, TIGER/Line Shapefiles 2018. 

### Description of Data Source Tables: 
n/a

### Description of Data Processing: 
Data was sourced from Infogroup's historical dataset, filtered for pharmacies via NAICS code, cleaned, and then converted to spatial data. Next, we conducted a nearest resource analysis using minimum distance as a proxy variable for access. This analysis included calculating centroids for all U.S. census tracts and ZCTAs, determining the nearest pharmact to each tract/zip centroid, then converting the distance units from meters to miles.

### Key Variable and Definitions:

Tracts ([Access05_T](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID | Unique GEOID, including state, county, and tract IDs |
| Census tract| TRACTCE | Unique census tract ID |
| Access to pharmacies | minDistT_mi | Euclidean distance from tract centroid to closest pharmacy, in miles |

Zip Code ([Access05_Z](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique GEOID, same as zip code |
| Zip code tract area | ZCTA5CE10 | Zip code |
| Access to pharmacies | minDistZ_mi | Euclidean distance from zip code centroid to closest pharmacy, in miles |

### Data Limitations:
Distance is Euclidean - not driving or walking routes. 

### Comments/Notes:
n/a
