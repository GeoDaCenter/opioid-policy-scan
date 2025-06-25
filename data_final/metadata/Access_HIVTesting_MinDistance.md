**Meta Data Name**: Access to HIV Testing  
**Date Added**: June 23, 2025  
**Author**: Mahjabin Kabir Adrita  
**Date Last Modified**: June 23, 2025  
**Last Modified By**: Mahjabin Kabir Adrita  

### Theme:  
Environment  

### Data Location:  
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in `C_2000.csv`.  
*Note: Every variable can be found in the **Latest** files.*

### Data Source(s) Description:  
HIV Testing provider data was sourced from the [Substance Abuse and Mental Health Services Administration (SAMHSA)](https://www.samhsa.gov/) via its [Treatment Services Locator Tool](https://findtreatment.samhsa.gov/locator).  

ZIP Code Tract Area (ZCTA) and Census Tract shapefiles were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html).

### Description of Data Source Tables:  
The SAMHSA HIV Testing dataset includes:  
- Provider name  
- Location (address, city, state, ZIP, county, latitude, longitude)  
- Contact information (website, phone number)  

### Description of Data Processing:  

#### Tract and Zip Code  

##### Distance  
Nearest resource analysis was conducted using minimum Euclidean distance as a proxy for access. This involved:  
- Calculating centroids for all census tracts and ZCTAs  
- Identifying the nearest HIV testing provider to each centroid  
- Calculating the straight-line distance in miles  

##### Travel Time and Count Within Threshold  
Driving-network access metrics were computed, including:  
- Travel time to the nearest HIV testing provider  
- Count of HIV testing providers within a 30-minute driving threshold  

Travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available for multiple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as).  

Analysis was conducted in Python. The script is available in the repository at  
[`code/Access Metrics - Health Resources`](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20Health%20Resources).

#### County and State  
County and state-level variables include:  
- **Count** of Census tracts  
- **Percent** of Census tracts located within a 30-minute driving threshold  
- **Mean driving time** from Census tracts within the county/state  

### Key Variable and Definitions:

- **Variable** – Title of the variable  
- **Variable ID** – Exact name used in the dataset  
- **Description** – Short explanation of what the variable measures  
- **Years Available** – Data availability by year  
- **Spatial Scale** – Level of geography for the variable  

#### Tract and Zip Code

| Variable                          | Variable ID in .csv | Description | Years Available | Spatial Scale |
|----------------------------------|----------------------|-----------------------------------------------------------------------------|------------------|----------------|
| Distance to nearest MH Provider  | HivMinDis | Euclidean distance* from tract/zip centroid to nearest MH provider (miles) | 2025 | Tract, Zip     |
| Driving time to nearest MH Provider | HivTmDr | Driving time from origin to nearest MH provider (minutes)                  | 2025 | Tract, Zip     |
| Count of MH Providers            | HivCntDr | Number of MH providers within a 30-minute drive                             | 2025 | Tract, Zip     |

#### County and State

| Variable                                   | Variable ID in .csv | Description                                                                     | Years Available | Spatial Scale |
|-------------------------------------------|----------------------|----------------------------------------------------------------------------------|------------------|----------------|
| Count of tracts                           | TotTracts | Total number of Census tracts in county/state                                   | 2025 | County, State  |
| Count of tracts within 30-min driving range | HivCtTmDr | Number of tracts with an MH provider within a 30-minute driving range           | 2025 | County, State  |
| Average time drive to nearest MH provider | HivAvTmDr | Mean driving time (minutes) from tracts to nearest MH provider                  | 2025 | County, State  |
| Percent of tracts within 30-min driving range | HivTmDrP | Percent of tracts within 30-minute drive to an MH provider                      | 2025 | County, State  |

### Data Limitations:  
*Euclidean or straight-line distance is a basic proxy for access. It does not account for real-world travel constraints.*  
The travel times are capped at a 90-minute threshold. Any data exceeding this limit is left blank.

### Comments/Notes:  
The final dataset includes U.S. states, Washington D.C., and Puerto Rico, but excludes other U.S. territories (Guam, Northern Mariana Islands, American Samoa, Palau).  
ZCTA and tract centroids are not population-weighted.
