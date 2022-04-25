**Meta Data Name**: Access to Pharmacies  
**Added**: January 6, 2021  
**Last Modified**: April 25, 2022  
**Author**: Susan Paykin    

### Data Location: 
Access04 at 2 spatial scales. Files can be found [here](/data_final).
* Access04_T  
* Access04_Z  

### Data Source(s) Description:  
Pharmacy locations were sourced from the InfoGroup (now [Data Axle](https://www.data-axle.com/)) 2019 Business and Consumer Historical Datafile, available through the University of Chicago Library.

Zip code tract area (ZCTA) and Census Tract files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The source InfoGroup dataset includes the business name, location (address, city, state, census tract, latitude, longitude), NAICS Code, and NAICS Code Description variables. 

### Description of Data Processing: 

Data was downloaded and sourced from InfoGroup's historical dataset, filtered for pharmacies via [NAICS class code](https://www.naics.com/naics-code-description/?code=446110) 4461100, cleaned, and then converted to spatial data. 

#### Distance
Next, the nearest resource analysis was conducted using minimum Euclidean distance as a proxy variable for access. This analysis included calculating centroids for all U.S. census tracts and ZCTAs, identifying the nearest pharmact to each tract/ZCTA centroid, then measuring the distance in miles.

#### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest pharmacy location and count of pharmacies within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for mulitple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/code/Access%20Metrics%20-%20Health%20Resources).


### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Unique 5-digit assigned ZCTA, usually same as ZIP Code  |
| Distance to nearest pharmacy | minDisRx | Euclidean distance* from tract/zip centroid to nearest pharmacy, in miles |
| Driving time to nearest pharmacy | driveTime | Driving time from tract/zip origin centroid to the nearest tract/zip pharmacy destination centroid, in minutes |
| Count of pharmacies | driveCount | Count of pharmacies within a 30-minute driving threshold |

### Data Limitations:
*Euclidean distance or straight-line is a simple approximation of access or travel from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances.

### Comments/Notes:
The final dataset includes US states and Washington, D.C., but does not include territories (Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Palau). ZCTA and tract centroids are not population-weighted.
