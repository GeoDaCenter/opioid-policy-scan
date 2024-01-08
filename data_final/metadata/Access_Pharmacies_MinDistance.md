**Meta Data Name**: Access to Pharmacies  
**Added**: January 6, 2021  
**Author**: Susan Paykin  
**Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment  

### Data Location: 
Latest - the access data is available at 4 spatial scales: census tract, zip code, county, and state. Files can be found [here](../full_tables).
* T_Latest.csv  
* Z_Latest.csv  
* C_Latest.csv  
* S_Latest.csv   

### Data Source(s) Description:  
Pharmacy locations were sourced from the InfoGroup (now [Data Axle](https://www.data-axle.com/)) 2019 Business and Consumer Historical Datafile, available through the University of Chicago Library.

Zip code tract area (ZCTA) and Census Tract files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The source InfoGroup dataset includes the business name, location (address, city, state, census tract, latitude, longitude), NAICS Code, and NAICS Code Description variables. 

### Description of Data Processing: 

Data was downloaded and sourced from InfoGroup's historical dataset, filtered for pharmacies via [NAICS class code](https://www.naics.com/naics-code-description/?code=446110) 4461100, cleaned, and then converted to spatial data. 

#### Tract and Zip Code

##### Distance
Next, the nearest resource analysis was conducted using minimum Euclidean distance as a proxy variable for access. This analysis included calculating centroids for all U.S. census tracts and ZCTAs, identifying the nearest pharmact to each tract/ZCTA centroid, then measuring the distance in miles.

##### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest pharmacy location and count of pharmacies within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for mulitple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20Health%20Resources).

#### County and State 
County and state-level variables include the **count** of Census tracts and the **percent** of Census tracts located within a 30 minute driving threshold of an FQHC, as well as the mean (average) driving time in minutes from Census tracts within the county or state. 

### Key Variable and Definitions:

#### Tract and Zip Code

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Distance to nearest pharmacy | RxMinDis | Euclidean distance* from tract/zip centroid to the nearest pharmacy, in miles |
| Driving time to nearest pharmacy | RxTmDr | Driving time from tract/zip origin centroid to the nearest tract/zip pharmacy destination centroid, in minutes |
| Count of pharmacies | RxCntDr | Count of pharmacies within a 30-minute driving threshold |

#### County and State
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Count of tracts | TotTracts | Total number of tracts in county/state | 
| Count of tracts within 30-min driving range | RxCtTmDr | Number of tracts with pharmacy within a 30-min driving range |
| Average time drive to nearest pharmacy | RxAvTmDr | Average driving time (minutes) across tracts in county/state to nearest pharmacy |
| Percent of tracts within 30-min driving range | RxTmDrP | Percent of tracts with pharmacy within a 30-min driving range |

### Data Limitations:
*Euclidean distance or straight-line is a simple approximation of access or travel from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances.

### Comments/Notes:
The final dataset includes US states and Washington, D.C., but does not include territories (Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Palau). ZCTA and tract centroids are not population-weighted.
