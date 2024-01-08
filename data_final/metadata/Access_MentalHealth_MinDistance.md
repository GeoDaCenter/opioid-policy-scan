**Meta Data Name**: Access to Mental Health Providers  
**Added**: January 9, 2021  
**Author**: Susan Paykin  
**Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment  

### Data Location: 
Latest - the access data is available at 4 spatial scales. Files can be found [here](../full_tables).
* T_Latest.csv  
* Z_Latest.csv  
* C_Latest.csv  
* S_Latest.csv   

### Data Source(s) Description:  
Mental health provider data was sourced from [Substance Abuse and Mental Health Services Administration (SAMSHA)](https://www.samhsa.gov/) through its [Treatment Services Locator Tool](https://findtreatment.samhsa.gov/locator). 

ZIP Code Tract Area (ZCTA) and Census Tract files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The source SAMSHA mental health provider dataset includes provider name, location (address, city, state, zip, county, latitude and longitude), and contact information (website, phone number).

### Description of Data Processing: 
Data was scraped from the SAMSHA Treatment Locator tool, filtered for mental health providers, cleaned, and then converted to spatial data. 

#### Tract and Zip Code

##### Distance
Next, we conducted the nearest resource analysis using minimum Euclidean distance as a proxy variable for access. This analysis included calculating centroids for all census tracts and ZCTAs, identifying the nearest mental health (MH) provider to each centroid, and calculating the distance in miles. 

##### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest mental health (MH) provider location and count of MH providers within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for multiple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20Health%20Resources).

#### County and State 
County and state-level variables include the **count** of Census tracts and the **percent** of Census tracts located within a 30 minute driving threshold of an FQHC, as well as the mean (average) driving time in minutes from Census tracts within the county or state. 

### Key Variable and Definitions:

#### Tract and Zip Code

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Distance to nearest MH Provider | MhMinDis | Euclidean distance* from tract/zip centroid to nearest mental health provider, in miles |
| Driving time to nearest MH Provider | MhTmDr | Driving time from tract/zip origin centroid to the nearest tract/zip mental health provider destination centroid, in minutes |
| Count of MH Providers | MhCntDr | Count of MH providers within a 30-minute driving threshold |

#### County and State
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Count of tracts | TotTracts | Total number of tracts in county/state | 
| Count of tracts within 30-min driving range | MhCtTmDr | Number of tracts with an MH provider within a 30-min driving range |
| Average time drive to nearest MH provider | MhAvTmDr | Average driving time (minutes) across tracts in county/state to nearest MH provider |
| Percent of tracts within 30-min driving range | MhTmDrP | Percent of tracts with an MH provider within a 30-min driving range |

### Data Limitations:
*Euclidean or straight-line distance is a simple approximation of access or travel from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances.  

### Comments/Notes:
The final dataset includes US states, Washington, D.C., and Puerto Rico, but does not include other territories (Guam, Northern Mariana Islands, American Samoa, Palau). ZCTA and tract centroids are not population-weighted.
