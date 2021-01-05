**Meta Data Name**: Access to FQHCs, part of the Health Factors dataset  
**Last Modified**: January 5, 2021
**Author**: Susan Paykin 

### Data Location: 
Access02 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access02_T  
* Access02_Z  

### Data Source(s) Description:  
Locations of Federal Qualified Health Centers were sourced from the the [Health Resources and Services Administration](https://bphc.hrsa.gov/datareporting/index.html) via the US COVID Atlas. 

Zip code tract area (ZCTA) and Census Tract files were sourced from the US Census, TIGER/Line Shapefiles 2018. 

### Description of Data Source Tables: 
n/a

### Description of Data Processing: 
Euclidean Distance was calculated from the centroid of each tract/ZCTA to the nearest FQHC location.

### Key Variable and Definitions:

Tracts (Access02_T):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID | Unique GEOID, including state, county, and tract IDs |
| Tract # | TRACTCE | Unique census tract ID |
| Access to FQHC | minDistTracts_mi | Euclidean distance from tract centroid to closest FQHC, in miles |

Zip Code (Access02_Z):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique GEOID, same as zip code |
| Zip code tract area | ZCTA5CE10 | Zip code |
| Access to FQHC | minDistZips_mi | Euclidean distance from zip code centroid to closest FQHC, in miles |

### Data Limitations:
Distance is Euclidean - not driving or walking routes. 

### Comments/Notes:
n/a
