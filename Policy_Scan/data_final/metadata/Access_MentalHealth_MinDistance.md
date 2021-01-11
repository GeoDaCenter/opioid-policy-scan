**Meta Data Name**: Access to Mental Health Providers
**Last Modified**: January 9, 2021  
**Author**: Susan Paykin  

### Data Location: 
Access04 - Policy Scan at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access04_T  
* Access04_Z  

### Data Source(s) Description:  
Mental health provider data was sourced from [Substance Abuse and Mental Health Services Administration (SAMSHA)](https://findtreatment.samhsa.gov/locator). 

Zip code tract area (ZCTA) and Census Tract files were sourced from the U.S. Census, TIGER/Line Shapefiles 2018. 

### Description of Data Source Tables: 
The original SAMSHA dataset on mental health providers (found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_raw/mentalhealth_clean.csv)) includes provider location (address, city, state, zip, county, latitude and longitude) and contact information (website, phone number).

### Description of Data Processing: 
Data was scraped from the SAMSHA Treatment Locator tool, filtered for mental health providers, cleaned, and then converted to spatial data. Next, we conducted a nearest resource analysis using minimum distance as a proxy variable for access. This analysis included calculating centroids for all U.S. census tracts and ZCTAs, determining the nearest mental health provider to each tract/zip centroid, then converting the distance units from meters to miles.

### Key Variable and Definitions:

Tracts ([Access04_T](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID | Unique GEOID, including state, county, and tract IDs |
| Census Tract | TRACTCE | Unique census tract ID |
| Access to mental health providers | minDistT_mi | Euclidean distance from tract centroid to nearest provider, in miles |

Zip Code ([Access04_Z](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique GEOID, same as zip code |
| Zip code tract area | ZCTA5CE10 | Zip code |
| Access to mental health providers | minDistZ_mi | Euclidean distance from zip code centroid to nearest provider, in miles |

### Data Limitations:
Dataset includes U.S. states and Puerto Rico, but missing D.C. and other territories. 

### Comments/Notes:
