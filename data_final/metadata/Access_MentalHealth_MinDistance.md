**Meta Data Name**: Access to Mental Health Providers  
**Date Added**: January 9, 2021  
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

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

#### Tract and Zip Code
| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Distance to nearest MH Provider | MhMinDis | Euclidean distance* from tract/zip centroid to nearest mental health provider, in miles | 2019, 2025 | Tract, Zip |
| Driving time to nearest MH Provider | MhTmDr | Driving time from tract/zip origin centroid to the nearest tract/zip mental health provider destination centroid, in minutes | 2019, 2025 | Tract, Zip |
| Count of MH Providers | MhCntDr | Count of MH providers within a 30-minute driving threshold | 2019, 2025 | Tract, Zip |

#### County and State
| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Count of tracts | TotTracts | Total number of tracts in county/state | 2019, 2025 | County, State  
| Count of tracts within 30-min driving range | MhCtTmDr | Number of tracts with an MH provider within a 30-min driving range | 2019, 2025 | County, State |
| Average time drive to nearest MH provider | MhAvTmDr | Average driving time (minutes) across tracts in county/state to nearest MH provider | 2019, 2025 | County, State |
| Percent of tracts within 30-min driving range | MhTmDrP | Percent of tracts with an MH provider within a 30-min driving range | 2019, 2025 | County, State |

### Data Limitations:
*Euclidean or straight-line distance is a simple approximation of access or travel from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances. The travel times are capped at a 90-minute threshold; any data exceeding this limit is left blank. 

### Comments/Notes:
The final dataset includes US states, Washington, D.C., and Puerto Rico, but does not include other territories (Guam, Northern Mariana Islands, American Samoa, Palau). ZCTA and tract centroids are not population-weighted.
