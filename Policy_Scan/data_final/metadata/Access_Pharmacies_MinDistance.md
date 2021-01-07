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
Nearest euclidean distance, in miles, was calculated from the centroid of each tract/ZCTA to the nearest pharmacy location.

### Key Variable and Definitions:

Tracts (Access05_T):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID | Unique GEOID, including state, county, and tract IDs |
| Tract # | TRACTCE | Unique census tract ID |
| Access to Nearest Pharmacy | minDistT_mi | Euclidean distance from tract centroid to closest pharmacy, in miles |

Zip Code (Access05_Z):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique GEOID, same as zip code |
| Zip code tract area | ZCTA5CE10 | Zip code |
| Access to Nearest Pharmacy | minDistZ_mi | Euclidean distance from zip code centroid to closest pharmacy, in miles |

### Data Limitations:
Distance is Euclidean - not driving or walking routes. 

### Comments/Notes:
n/a
