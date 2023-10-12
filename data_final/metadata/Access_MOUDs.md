**Meta Data Name**: Access to MOUDs  
**Created**: February 1, 2021
**Author**: Susan Paykin  
**Last Modified**: October 12, 2023  
**Last Modified By**: Wataru Morioka

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
| ID for census tracts | GEOID | Unique 11-digit identifier for census tracts | 
| ID for ZIP Code Tract Areas (ZCTAs) | ZCTA | Unique 5-digit identifier for ZCTAs |
| ID for counties | COUNTYFP | Unique 5-digit identifier for counties |
| Driving time to nearest buprenorphine | BupTmDr | Driving time (minutes) to nearest buprenorphine provider |
| Driving time to nearest methadone | MetTmDr | Driving time (minutes) to nearest methadone provider |
| Driving time to nearest naltrexone |  NalTmDr | Driving time (minutes) to nearest naltrexone provider |
| Count of naltrexone providers (drive) | NalCntDr30 | Count of naltrexone providers in 30 minute drive time threshold |
| Count of buprenorphine providers (drive) | BupCntDr30 | Count of methadone providers in 30 minute drive time threshold |
| Count of methadone providers (drive) | MetCntDr30 | Count of methadone providers in 30 minute drive time threshold |
| Walking time to nearest buprenorphine | BupTmWk | Driving time (minutes) to nearest buprenorphine provider |
| Walking time to nearest methadone | MetTmWk | Driving time (minutes) to nearest methadone provider |
| Walking time to nearest naltrexone |  NalTmWk | Driving time (minutes) to nearest naltrexone provider |
| Count of buprenorphine providers (walk) | BupCntWk30 | Count of buprenorphine providers in 30 minute walking time threshold |
| Count of methadone providers (walk) | MetCntWk30 | Count of methadone providers in 30 minute walking time threshold |
| Count of naltrexone providers (walk) | NalCntWk30 | Count of naltrexone providers in 30 minute walking time threshold |
| Count of buprenorphine providers (walk) | BupCntWk60 | Count of buprenorphine providers in 60 minute walking time threshold |
| Count of methadone providers (walk) | MetCntWk60 | Count of methadone providers in 60 minute walking time threshold |
| Count of naltrexone providers (walk) | NalCntWk60 | Count of naltrexone providers in 60 minute walking time threshold |
| Biking time to nearest buprenorphine | BupTmBk | Biking time (minutes) to nearest buprenorphine provider |
| Biking time to nearest methadone | MetTmBk | Biking time (minutes) to nearest methadone provider |
| Biking time to nearest naltrexone | NalTmBk | Biking time (minutes) to nearest naltrexone provider |
| Count of buprenorphine providers (bike) | BupCntBk30 | Count of buprenorphine providers in 30 minute biking time threshold |
| Count of methadone providers (bike) | MetCntBk30 | Count of methadone providers in 30 minute biking time threshold |
| Count of naltrexone providers (bike) | NalCntBk30 | Count of naltrexone providers in 30 minute biking time threshold |
| Count of buprenorphine providers (bike) | BupCntBk60 | Count of buprenorphine providers in 60 minute biking time threshold |
| Count of methadone providers (bike) | MetCntBk60 | Count of methadone providers in 60 minute biking time threshold |
| Count of naltrexone providers (bike) | NalCntBk60 | Count of naltrexone providers in 60 minute biking time threshold |
| Mininum distance to nearest MOUD (all types) | MoudMinDis | Euclidean distance (miles) to nearest MOUD (all types) |
| Mininum distance to methadone | MetMinDis | Euclidean distance (miles) to nearest methadone provider |
| Mininum distance to buprenorphine | BupMinDis | Euclidean distance (miles) to nearest buprenorphine provider |
| Mininum distance to naltrexone | NalMinDis | Euclidean distance (miles) to nearest naltrexone/Vivitrol provider |

#### County and State
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| ID for counties | COUNTYFP | Unique 5-digit identifier for counties| 
| ID for states | STATEFP | Unique 2-digit identifier for states| 
| Count of tracts | TotTracts | Total number of tracts in county/state | 
| Count of tracts within 30-min buprenorphine driving range | CntBupT | Number of tracts with buprenorphine provider within a 30-min driving range |
| Count of tracts within 30-min methadone driving range | CntMetT | Number of tracts with methadone provider within a 30-min driving range |
| Count of tracts within 30-min naltrexone driving range | CntNalT | Number of tracts with naltrexone provider within a 30-min driving range |
| Percent of tracts within 30-min buprenorphine driving range | PctBupT | Percent of tracts with buprenorphine provider within a 30-min driving range |
| Percent of tracts within 30-min methadone driving range | PctMetT | Percent of tracts with methadone provider within a 30-min driving range |
| Percent of tracts within 30-min naltrexone driving range | PctNalT | Percent of tracts with naltrexone provider within a 30-min driving range |
| Average driving time to nearest buprenorphine provider | AvBupTime | Average driving time (minutes) across tracts in county/state to nearest buprenorphine provider |
| Average driving time to nearest methadone provider | AvMetTime | Average driving time (minutes) across tracts in county/state to nearest methadone provider |
| Average driving time to nearest naltrexone provider | AvNalTime | Average driving time (minutes) across tracts in county/state to nearest naltrexone provider |

### Data Limitations:
Access metrics are calculated for continental U.S., and does not include Hawaii, Alaska, or U.S. territories. 

### Comments/Notes:
* All nearest distance calculations are in miles. 
* All nearest travel time calculations are in minutes.
