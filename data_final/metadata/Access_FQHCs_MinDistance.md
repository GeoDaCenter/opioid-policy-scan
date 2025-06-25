**Meta Data Name**: Access to Federal Qualified Health Centers (FQHCs)  
**Date Added**: January 5, 2021  
**Author**: Susan Paykin, Wataru Morioka, Mahjabin Kabir Adrita  
**Date Last Modified**: June 23, 2025   
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita  

### Theme: 
Environment

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Locations of Federal Qualified Health Centers (FQHCs) were sourced from the [Health Resources and Services Administration](https://bphc.hrsa.gov/datareporting/index.html) which were cleaned and geocoded for the [US COVID Atlas](https://theuscovidatlas.org/). 

ZIP Code Tract Area (ZCTA) and Census Tract boundary files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The raw source FQHC dataset includes the name of the FQHC facility, address, state, phone number, COVID testing status (yes/no), and latitude and longitude variables. 

### Description of Data Processing: 

#### Tract and Zip Code

##### Distance
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance was calculated from the centroid of each tract/ZCTA to the nearest FQHC location. The script is available in [code/access_FQHC.R](https://github.com/GeoDaCenter/opioid-policy-scan/blob/master/code/access_FQHC.R).

##### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest FQHC location and count of FQHCs within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for multiple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20Health%20Resources).

#### County and State 
County and state-level variables include the **count** of Census tracts and the **percent** of Census tracts located within a 30 minute driving threshold of an FQHC, as well as the mean (average) driving time in minutes from Census tracts within the county or state. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

#### Tract and Zip Code
| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------| 
| Distance to nearest FQHC | FqhcMinDis | Euclidean distance *from tract/zip centroid to nearest FQHC, in miles* | 2021, 2025 | Tract, Zip |
| Driving time to nearest FQHC | FqhcTmDr | Driving time from tract/zip origin centroid to the nearest tract/zip FQHC destination centroid, in minutes | 2021, 2025 | Tract, Zip |
| Count of FQHCs | FqhcCntDr | Count of FQHCs within a 30-minute driving threshold | 2021, 2025 | Tract, Zip |

#### County and State
| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Count of tracts | TotTracts | Total number of tracts in county/state | 2021, 2025 | County, State |
| Count of tracts within 30-min driving range | FqhcCtTmDr | Number of tracts with FQHC within a 30-min driving range | 2021, 2025 | County, State |
| Percent of tracts within 30-min driving range | FqhcTmDrP | Percent of tracts with FQHC within a 30-min driving range | 2021, 2025 | County, State |
| Average time drive to nearest FQHC | FqhcAvTmDr | Average driving time (minutes) across tracts in county/state to nearest FQHC | 2021, 2025 | County, State |

### Data Limitations:
*Euclidean distance or straight-line distance is a simple approximation of distance or travel time from an origin centroid to the nearest health center. It is not a precise calculation of real travel times or distances. The travel times are capped at a 90-minute threshold; any data exceeding this limit is left blank.  

### Comments/Notes:
This dataset includes all US states, Washington D.C., and Puerto Rico. It does not include the territories of Guam, Northern Mariana Islands, American Samoa, and Palau. Zip code and tract centroids are not population-weighted.
