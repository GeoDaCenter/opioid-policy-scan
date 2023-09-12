**Meta Data Name**: Access to Federal Qualified Health Centers (FQHCs)  
**Added**: January 5, 2021  
**Last Modified**: April 25, 2022  
**Author**: Susan Paykin 

### Data Location: 
Access02 at 4 spatial scales. Files can be found [here](/data_final).
* Access02_T  
* Access02_Z  
* Access02_C
* Access02_S

### Data Source(s) Description:  
Locations of Federal Qualified Health Centers (FQHCs) were sourced from the the [Health Resources and Services Administration](https://bphc.hrsa.gov/datareporting/index.html) which were cleaned and geocoded for the [US COVID Atlas](https://theuscovidatlas.org/). 

ZIP Code Tract Area (ZCTA) and Census Tract boundary files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The raw source FQHC dataset includes the name of the FQHC facility, address, state, phone number, COVID testing status (yes/no), and latitude and logitude variables. 

### Description of Data Processing: 

#### Tract and Zip Code

##### Distance
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance was calculated from the centroid of each tract/ZCTA to the nearest FQHC location. The script is available in [code/access_FQHC.R](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/code/access_FQHC.R).

##### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest FQHC location and count of FQHCs within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for mulitple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20Health%20Resources).

#### County and State 
County and state-level variables include the **count** of Census tracts and the **percent** of Census tracts located within a 30 minute driving threshold of an FQHC, as well as the mean (average) driving time in minutes from Census tracts within the county or state. 

### Key Variable and Definitions:

#### Tract and Zip Code

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Unique 5-digit assigned ZCTA, usually same as ZIP Code  |
| Distance to nearest FQHC | minDisFQHC | Euclidean distance* from tract/zip centroid to nearest FQHC, in miles |
| Driving time to nearest FQHC | driveTime | Driving time from tract/zip origin centroid to the nearest tract/zip FQHC destination centroid, in minutes |
| Count of FQHCs | driveCount | Count of FQHCs within a 30-minute driving threshold |

#### County and State
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| COUNTYFP | ID for counties | Unique 5-digit identifier for counties| 
| STATEFP | ID for states | Unique 2-digit identifier for states| 
| Count of tracts | cntT | Total number of tracts in county/state | 
| Count of tracts within 30-min driving range | cntTimeDrive | Number of tracts with FQHC within a 30-min driving range |
| Percent of tracts within 30-min driving range | pctTimeDrive | Percent of tracts with FQHC within a 30-min driving range |
| Average time drive to nearest FQHC | avTimeDrive | Average driving time (minutes) across tracts in county/state to nearest FQHC |

### Data Limitations:
*Euclidean distance or straight-line distance is a simple approximation of distance or travel time from an origin centroid to the nearest health center. It is not a precise calculation of real travel times or distances. 

### Comments/Notes:
This dataset includes all US states, Washington D.C., and Puerto Rico. It does not include the territories Guam, Northern Mariana Islands, American Samoa, Palau. Zip code and tract centroids are not population-weighted.
