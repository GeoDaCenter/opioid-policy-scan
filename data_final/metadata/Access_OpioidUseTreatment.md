**Meta Data Name**: Access to Opioid Treatment Programs (OTP)  
**Date Added**: July 23, 2021  
**Author**: Rachel Vigil  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka

### Theme: 
Environment  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files. 

### Data Source(s) Description:  
Variables were obtained from the U.S. Substance Abuse and Mental Health Services Administration (SAMHSA) [Opioid Treatment Program (OTP) Directory](https://dpt2.samhsa.gov/treatment/directory.aspx). The OTPs represented in this set are those certified, either fully or provisionally by SAMHSA. Certification is required for MOUD, but these programs can offer other types of treatment, including counseling and other behavioral therapies. Raw data can be found [here](https://dpt2.samhsa.gov/treatment/directory.aspx) and more information can be found [here](https://www.samhsa.gov/medication-assisted-treatment/become-accredited-opioid-treatment-program).

### Description of Data Processing: 

#### Distance
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance* was calculated from the centroid of each tract/ZCTA to the nearest OTP location. 

#### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest OTP location and count of OTPs within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for multiple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20Health%20Resources).

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

#### Tract, ZIP Code
| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Distance to nearest OTP | OtpMinDis | Euclidean distance* from tract/zip centroid to nearest OTP service location, in miles | 2025 | Tract, Zip |
| Driving time to nearest OTP | OtpTmDr | Driving time from tract/zip origin centroid to the nearest tract/zip OTP destination centroid, in minutes | 2025 | Tract, Zip |
| Count of OTPs | OtpCntDr | Count of OTPs within a 30-minute driving threshold | 2025 | Tract, Zip |

#### County and State
| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Count of tracts | TotTracts | Total number of tracts in county/state | 2025 | County, State |
| Count of tracts within 30-min OTP driving range | OtpCtTmDr | Number of tracts with OTP within a 30-min driving range | 2025 | County, State |
| Average driving time to nearest OTP | OtpAvTmDr | Average driving time (minutes) across tracts in county to nearest OTP | 2025 | County, State |
| Percent of tracts within 30-min OTP driving range | OtpTmDrP | Percent of tracts with an OTP within a 30-min driving range | 2025 | County, State |

### Data Limitations:
*Euclidean distance or straight-line distance is a simple approximation of distance or travel time from an origin centroid to the nearest health center. It is not a precise calculation of real travel times or distances. 

### Comments/Notes:
This dataset includes all US states, Washington D.C., and Puerto Rico. It does not include the territories of Guam, Northern Mariana Islands, American Samoa, and Palau. Zip code and tract centroids are not population-weighted. The access metrics for 2025 have been calculated using vintage travel metrics and geographic data.

