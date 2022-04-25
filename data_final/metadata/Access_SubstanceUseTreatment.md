**Meta Data Name**: Nearest Distance for Substance Use Treatment   
**Added**: July 23, 2021  
**Author**: Rachel Vigil  
**Last Modified:** April 25, 2022, Susan Paykin

### Data Location: 
Access06 - Access to Substance Use Treatment (SUT) Services at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/data_final).
* Access06_Z
* Access06_T

### Data Source(s) Description:  
Variables were obtained from the SAMHSA service locator. substance use treatment facilities are collected in SAMHSA's annual National Survey of Substance Abuse Treatment Services. The lists and locations of these facilities are based off of certification and data collection for treatment facilities by state abuse agencies for the Behavioral Health Services Information System. Also included in this set are treatment facilities that state substance abuse agencies, for a variety of reasons, do not fund, license, or certify which are found through periodic screening of alternative databases. Raw data can be found [here](https://findtreatment.samhsa.gov/locator), and more details about data collection can be found [here](https://www.samhsa.gov/data/data-we-collect/n-ssats-national-survey-substance-abuse-treatment-services).

### Description of Data Processing: 

#### Distance
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance* was calculated from the centroid of each tract/ZCTA to the nearest SUT location. 

#### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest SUT service location and count of SUT services within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for mulitple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/code/Access%20Metrics%20-%20Health%20Resources).

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Unique 5-digit assigned ZCTA, usually same as ZIP Code  |
| Distance to nearest SUT | minDisSUT | Euclidean distance* from tract/zip centroid to nearest SUT service location, in miles |
| Driving time to nearest SUT | driveTime | Driving time from tract/zip origin centroid to the nearest tract/zip SUT destination centroid, in minutes |
| Count of SUTs | driveCount | Count of SUT services within a 30-minute driving threshold |

### Data Limitations:
*Euclidean distance or straight-line distance is a simple approximation of distance or travel time from an origin centroid to the nearest health center. It is not a precise calculation of real travel times or distances. 

### Comments/Notes:
This dataset includes all US states, Washington D.C., and Puerto Rico. It does not include the territories Guam, Northern Mariana Islands, American Samoa, Palau. Zip code and tract centroids are not population-weighted.
