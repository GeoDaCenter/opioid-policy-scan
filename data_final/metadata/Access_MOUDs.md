**Meta Data Name**: Access to MOUDs  
**Created**: February 1, 2021  
**Last Modified**: April 25, 2022  
**Author**: Susan Paykin  

### Data Location: 
Access01 - Access to MOUDs at 4 spatial scales: Census tract, Zip code, County, State. Files can be found [here](/data_final).
* Access01_T  
* Access01_Z  
* Access01_C
* Access01_S

### Data Source(s) Description:  
Data on providers prescribing Medications for Opioid Overuse Disorder (MOUDs) and their locations were sourced from the [U.S. Substance Abuse and Mental Health Services Administration (SAMHSA) Treatment Locator](https://findtreatment.samhsa.gov/locator) in September 2020. Naltrexone provider data from SAMHSA was supplemented by provider data from *Vivitrol.com*, with duplicates removed. 

### Description of Data Processing: 
Data was identified, wrangled, cleaned, and prepared for analysis. We geocoded locations locations through the [tidygeocoder](https://cran.r-project.org/web/packages/tidygeocoder/vignettes/tidygeocoder.html) package in R, as well as supplemental geocoding through University of Chicago Library GIS services. We calculated population-weighted centroids for each Census tract and ZCTA in the continental US (lower 48 states).

#### Tract and ZIP Code

##### Distance
We conducted a nearest resource analysis from geography centroid to MOUD provider location by type (buprenophine, methadone, naltrexone) to calculate the nearest Euclidean distance (i.e. straight line distance) for each MOUD. This analysis was conducted in R. The scripts are available in [code/access_MOUDs.R](https://github.com/GeoDaCenter/opioid-policy-scan/blob/v1.0/code/access_MOUDs.R).

##### Travel Time and Count Within Threshold

We calculated travel-network access metrics using the [spatial_access Python package](https://github.com/GeoDaCenter/spatial_access) to calculate travel time to nearest provider type and count of providers within a travel threshold (30 minutes and/or 60 minutes) for three modes of transit: driving, walking, and biking. The transit matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for mulitple transit modes [via Box folder](https://uchicago.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The scripts are available in [code/AccessMetrics - MOUDs.](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20MOUD)

#### County and State 
County and state-level variables include the **count** of Census tracts and the **percent** of Census tracts located within a 30 minute driving threshold of an MOUD type, as well as the mean (average) driving time in minutes from Census tracts within the county or state. 

### Key Variable and Definitions:

#### Tract and ZIP Code
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

#### County and State
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| COUNTYFP | ID for counties | Unique 5-digit identifier for counties| 
| STATEFP | ID for states | Unique 2-digit identifier for states| 
| Count of tracts | cntT | Total number of tracts in county/state | 
| Count of tracts within 30-min buprenorphine driving range | cntBupT | Number of tracts with buprenorphine provider within a 30-min driving range |
| Count of tracts within 30-min methadone driving range | cntMetT | Number of tracts with methadone provider within a 30-min driving range |
| Count of tracts within 30-min naltrexone driving range | cntNalT | Number of tracts with naltrexone provider within a 30-min driving range |
| Percent of tracts within 30-min buprenorphine driving range | pctBupT | Percent of tracts with buprenorphine provider within a 30-min driving range |
| Percent of tracts within 30-min methadone driving range | pctMetT | Percent of tracts with methadone provider within a 30-min driving range |
| Percent of tracts within 30-min naltrexone driving range | pctNalT | Percent of tracts with naltrexone provider within a 30-min driving range |
| Average driving time to nearest buprenorphine provider | avBupTime | Average driving time (minutes) across tracts in county/state to nearest buprenorphine provider |
| Average driving time to nearest methadone provider | avMetTime | Average driving time (minutes) across tracts in county/state to nearest methadone provider |
| Average driving time to nearest naltrexone provider | avNalTime | Average driving time (minutes) across tracts in county/state to nearest naltrexone provider |

### Data Limitations:
Access metrics are calculated for continental U.S., and does not include Hawaii, Alaska, or U.S. territories. 

### Comments/Notes:
* All nearest distance calculations are in miles. 
* All nearest travel time calculations are in minutes.
