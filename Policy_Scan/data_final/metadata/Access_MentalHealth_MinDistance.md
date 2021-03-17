**Meta Data Name**: Access to Mental Health Providers  
**Last Modified**: January 9, 2021  
**Author**: Susan Paykin  

### Data Location: 
Access04 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access04_T  
* Access04_Z  

### Data Source(s) Description:  
Mental health provider data was sourced from [Substance Abuse and Mental Health Services Administration (SAMSHA)](https://www.samhsa.gov/) through its [Treatment Services Locator Tool](https://findtreatment.samhsa.gov/locator). 

ZIP Code Tract Area (ZCTA) and Census Tract files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The source SAMSHA mental health provider dataset includes provider name, location (address, city, state, zip, county, latitude and longitude), and contact information (website, phone number).

### Description of Data Processing: 
Data was scraped from the SAMSHA Treatment Locator tool, filtered for mental health providers, cleaned, and then converted to spatial data. Next, we conducted a nearest resource analysis using minimum Euclidean distance as a proxy variable for access. This analysis included calculating centroids for all census tracts and ZCTAs, identifying the nearest mental health provider to each centroid, and calculating the distance in miles. 

### Key Variable and Definitions:

Tracts ([Access04_T](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| State | STATEFP | Unique 2-digit ID for states |
| County | COUNTYFP | 3-digit ID for counties |
| Census Tract | TRACTCE | 6-digit ID for census tracts |
| Access to mental health providers | minDistT_mi | Euclidean distance from centroid to nearest provider, in miles |

Zip Code ([Access04_Z](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final)):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique 5-digit GEOID, same as ZCTA |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Assigned ZCTA by the USPS |
| Access to mental health providers | minDistZ_mi | Euclidean distance from centroid to nearest provider, in miles |

### Data Limitations:
Euclidean or straight-line distance is a simple approximation of access or travel from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances.  

### Comments/Notes:
This final data includes US states and Puerto Rico, but missing other territories (Guam, Northern Mariana Islands, American Samoa, Palau). ZCTA and tract centroids are not population-weighted.
