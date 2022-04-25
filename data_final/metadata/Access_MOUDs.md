**Meta Data Name**: Access to MOUDs  
**Created**: February 1, 2021  
**Last Modified**: April 20, 2022  
**Author**: Susan Paykin  

### Data Location: 
Access01 - Access to MOUDs at 2 spatial scales: census tract and zip code. Files can be found [here](/data_final).
* Access01_T  
* Access01_Z  

### Data Source(s) Description:  
Data on providers prescribing Medications for Opioid Overuse Disorder (MOUDs) and their locations were sourced from the [U.S. Substance Abuse and Mental Health Services Administration (SAMHSA) Treatment Locator](https://findtreatment.samhsa.gov/locator) in September 2020. Naltrexone provider data from SAMHSA was supplemented by provider data from *Vivitrol.com*, with duplicates removed. 

### Description of Data Processing: 
Data was identified, wrangled, cleaned, and prepared for analysis. We geocoded locations locations through the [tidygeocoder](https://cran.r-project.org/web/packages/tidygeocoder/vignettes/tidygeocoder.html) package in R, as well as supplemental geocoding through University of Chicago Library GIS services. We calculated population-weighted centroids for each Census tract and ZCTA in the continental US (lower 48 states).

#### Distance
We conducted a nearest resource analysis from geography centroid to MOUD provider location by type (buprenophine, methadone, naltrexone) to calculate the nearest Euclidean distance (i.e. straight line distance) for each MOUD. This analysis was conducted in R. The scripts are available in [code/access_MOUDs.R](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/code/access_MOUDs.R).

#### Travel Time and Count Within Threshold

We calculated travel-network access metrics using the [spatial_access Python package](https://github.com/GeoDaCenter/spatial_access) to calculate travel time to nearest provider type and count of providers within a travel threshold (30 minutes and/or 60 minutes) for three modes of transit: driving, walking, and biking. The transit matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for mulitple transit modes [via Box folder](https://uchicago.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The scripts are available in [code/AccessMetrics - MOUDs.](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/code/Access%20Metrics%20-%20MOUD)

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | ID for census tracts | Unique 11-digit identifier for census tracts | 
| ZCTA | ID for ZIP Code Tract Areas (ZCTAs) | Unique 5-digit identifier for ZCTAs |
| COUNTYFP | ID for counties | Unique 5-digit identifier for counties |
| Driving time to nearest buprenorphine | bupTimeDrive | Driving time (minutes) to nearest buprenorphine provider |
| Driving time to nearest methadone | metTimeDrive | Driving time (minutes) to nearest methadone provider |
| Driving time to nearest naltrexone |  nalTimeDrive | Driving time (minutes) to nearest naltrexone provider |
| Count of naltrexone providers (drive) | nalCountDrive30 | Count of naltrexone providers in 30 minute drive time threshold |
| Count of buprenorphine providers (drive) | bupCountDrive30 | Count of methadone providers in 30 minute drive time threshold |
| Count of methadone providers (drive) | metCountDrive30 | Count of methadone providers in 30 minute drive time threshold |
| Walking time to nearest buprenorphine | bupTimeWalk | Driving time (minutes) to nearest buprenorphine provider |
| Walking time to nearest methadone | metTimeWalk | Driving time (minutes) to nearest methadone provider |
| Walking time to nearest naltrexone |  nalTimeWalk | Driving time (minutes) to nearest naltrexone provider |
| Count of buprenorphine providers (walk) | bupCountWalk30 | Count of buprenorphine providers in 30 minute walking time threshold |
| Count of methadone providers (walk) | metCountWalk30 | Count of methadone providers in 30 minute walking time threshold |
| Count of naltrexone providers (walk) | nalCountWalk30 | Count of naltrexone providers in 30 minute walking time threshold |
| Count of buprenorphine providers (walk) | bupCountWalk60 | Count of buprenorphine providers in 60 minute walking time threshold |
| Count of methadone providers (walk) | metCountWalk60 | Count of methadone providers in 60 minute walking time threshold |
| Count of naltrexone providers (walk) | nalCountWalk60 | Count of naltrexone providers in 60 minute walking time threshold |
| Biking time to nearest buprenorphine | bupTimeBike | Biking time (minutes) to nearest buprenorphine provider |
| Biking time to nearest methadone | metTimeBike | Biking time (minutes) to nearest methadone provider |
| Biking time to nearest naltrexone |  nalTimeBike | Biking time (minutes) to nearest naltrexone provider |
| Count of buprenorphine providers (bike) | bupCountBike30 | Count of buprenorphine providers in 30 minute biking time threshold |
| Count of methadone providers (bike) | metCountBike30 | Count of methadone providers in 30 minute biking time threshold |
| Count of naltrexone providers (bike) | nalCountBike30 | Count of naltrexone providers in 30 minute biking time threshold |
| Count of buprenorphine providers (bike) | bupCountBike60 | Count of buprenorphine providers in 60 minute biking time threshold |
| Count of methadone providers (bike) | metCountBike60 | Count of methadone providers in 60 minute biking time threshold |
| Count of naltrexone providers (bike) | nalCountBike60 | Count of naltrexone providers in 60 minute biking time threshold |
| Mininum distance to nearest MOUD (all types) | minDisMOUD | Euclidean distance (miles) to nearest MOUD (all types) |
| Mininum distance to methadone | metMinDis | Euclidean distance (miles) to nearest methadone provider |
| Mininum distance to buprenorphine | bupMinDis | Euclidean distance (miles) to nearest buprenorphine provider |
| Mininum distance to naltrexone | nalMinDis | Euclidean distance (miles) to nearest naltrexone/Vivitrol provider |

### Data Limitations:
Access metrics are calculated for continental U.S., and does not include Hawaii, Alaska, or U.S. territories. 

### Comments/Notes:
* All nearest distance calculations are in miles. 
* All nearest travel time calculations are in minutes.
