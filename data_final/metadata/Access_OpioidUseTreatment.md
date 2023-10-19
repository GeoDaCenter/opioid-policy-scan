**Meta Data Name**: Access to Opioid Treatment Programs (OTP)  
**Added**: July 23, 2021  
**Author**: Rachel Vigil  
**Last Modified**: October 12, 2023
**Last Modified By**: Wataru Morioka

### Data Location: 
Access07 - Access to Opioid Treatment Programs (OTP) at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/v1.0/data_final).
* Access07_Z
* Access07_T


### Data Source(s) Description:  
Variables were obtained from the U.S. Substance Abuse and Mental Health Services Administration (SAMHSA) [Opioid Treatment Program (OTP) Directory](https://dpt2.samhsa.gov/treatment/directory.aspx). The OTPs represented in this set are those certified, either fully or provisionally by SAMHSA. Cetification is required for MOUD, but these programs can offer other types of treatment, including counseling and other behavioral therapies. Raw data can be found [here](https://dpt2.samhsa.gov/treatment/directory.aspx) and more information can be found [here](https://www.samhsa.gov/medication-assisted-treatment/become-accredited-opioid-treatment-program).

### Description of Data Processing: 

#### Distance
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance* was calculated from the centroid of each tract/ZCTA to the nearest OTP location. 

#### Travel Time and Count Within Threshold
We calculated travel-network access metrics for the driving travel time to the nearest OTP location and count of OTPs within a 30 minute driving threshold. The driving travel cost matrices were sourced from [Project OSRM](http://project-osrm.org/) and are available at the Tract or ZCTA scales for mulitple transit modes via [this Box folder](https://uchicago.app.box.com/s/ae2mtsw7f5tb4rhciczufdxd0owc23as). This analysis was conducted in Python. The script is available in [code/Access Metrics - Health Resources](https://github.com/GeoDaCenter/opioid-policy-scan/tree/fc3d94053dd1941a96a5945d73cc6f4845453484/code/Access%20Metrics%20-%20Health%20Resources).

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Unique 5-digit assigned ZCTA, usually same as ZIP Code  |
| Distance to nearest OTP | OtpMinDis | Euclidean distance* from tract/zip centroid to nearest OTP service location, in miles |
| Driving time to nearest OTP | OtpTmDr | Driving time from tract/zip origin centroid to the nearest tract/zip OTP destination centroid, in minutes |
| Count of OTPs | OtpCntDr | Count of OTPs within a 30-minute driving threshold |

### Data Limitations:
*Euclidean distance or straight-line distance is a simple approximation of distance or travel time from an origin centroid to the nearest health center. It is not a precise calculation of real travel times or distances. 

### Comments/Notes:
This dataset includes all US states, Washington D.C., and Puerto Rico. It does not include the territories Guam, Northern Mariana Islands, American Samoa, Palau. Zip code and tract centroids are not population-weighted.

