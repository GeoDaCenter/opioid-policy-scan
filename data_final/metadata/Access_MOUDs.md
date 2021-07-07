**Meta Data Name**: Access to MOUDs  
**Last Modified**: July 6, 2021  
**Author**: Susan Paykin  

### Data Location: 
Access01 - Access to MOUDs at 3 spatial scales. Files can be found [here](/data_final).
* Access01_C  
* Access01_T  
* Access01_Z  

### Data Source(s) Description:  
Data on providers prescribing Medications for Opioid Overuse Disorder (MOUDs) and their locations were sourced from the [U.S. Substance Abuse and Mental Health Services Administration (SAMHSA) Treatment Locator](https://findtreatment.samhsa.gov/locator) in September 2020. Naltrexone provider data from SAMHSA was supplemented by provider data from *Vivitrol.com*, with duplicates removed. 

### Description of Data Processing: 
Data was identified, wrangled, cleaned, and prepared for analysis. We geocoded locations locations through the [tidygeocoder](https://cran.r-project.org/web/packages/tidygeocoder/vignettes/tidygeocoder.html) package in R, as well as supplemental geocoding through University of Chicago Library GIS services. We calculated population-weighted centroids for each County, Census tract and ZCTA and conducted a nearest resource analysis from centroid to provider location to determine the nearest Euclidean (straight-line) distance for each of the three MOUDs. We then calculated additional spatial access metrics using the [spatial_access Python package](https://github.com/GeoDaCenter/spatial_access): driving time to nearest provider and count of providers within 30 minunites driving range.  

*Note: Currently, additional spatial access metrics (driving time, count) are  calculated for ZCTAs only. Tract-level calculations will be updated and added in July 2021.*

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | ID for ZCTA or tract | Unique 5-digit identifier for ZCTAs, unique 11-digit identifier for census tracts | 
| COUNTYFP | ID for counties | Unique 5-digit identifier for counties, w/ first 2 digits being state FIPS |
| Mininum distance to nearest MOUD (all types) | minDisMOUD | Euclidean distance (miles) to nearest MOUD (all types) |
| Mininum distance to methadone | minDisMet | Euclidean distance (miles) to nearest methadone provider |
| Driving time to nearest methadone | time_to_nearest_methadone | Driving time (minutes) to nearest methadone provider |
| Count of methadone providers | count_in_range_methadone | Count of methadone providers in 30 minute driving time range |
| Mininum distance to buprenorphine | minDisBup | Euclidean distance (miles) to nearest buprenorphine provider |
| Driving time to nearest buprenorphine | time_to_nearest_buprenorphine | Driving time (minutes) to nearest buprenorphine provider |
| Count of buprenorphine providers | count_in_range_buprenorphine | Count of methadone providers in 30 minute driving time range |
| Mininum distance to naltrexone | minDisNalV | Euclidean distance (miles) to nearest naltrexone/Vivitrol provider |
| Driving time to nearest naltrexone |  time_to_nearest_naltrexone.vivitrol | Driving time (minutes) to nearest naltrexone provider |
| Count of naltrexone providers | count_in_range_naltrexone.vivitrol | Count of naltrexone providers in 30 minute driving time range |

### Data Limitations:
Access metrics are calculated for continental U.S., and does not include Hawaii, Alaska, or U.S. territories. 

### Comments/Notes:
* All access calculations were calculated using population-weighted centroids. 
* Minimum distance calculations are in miles. 
* Driving time calculations are in minutes.

