**Meta Data Name**: Access to Hospitals
**Last Modified**: January 6, 2021
**Author**: Susan Paykin 

### Data Location: 
Access03 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access03_T  
* Access03_Z  

### Data Source(s) Description:  
Hospital locations were sourced from [CovidCareMap Healthcare System Capacity data](https://github.com/covidcaremap/covid19-healthsystemcapacity/tree/master/data), an aggregated dataset which sources data from the [Healthcare Cost Report Information System (HCRIS)](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/Cost-Reports/Hospital-2010-form) and [Definitive Healthcare](https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=125.859%2C-16.820%2C-150.821%2C72.123). 

Zip code tract area (ZCTA) and Census Tract files were sourced from the U.S. Census, TIGER/Line Shapefiles 2018. 

### Description of Data Source Tables: 
n/a

### Description of Data Processing: 
Nearest euclidean distance in miles was calculated from the centroid of each tract/ZCTA to the nearest hospital location. 

### Key Variable and Definitions:

Tracts (Access03_T):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID | Unique GEOID, including state, county, and tract IDs |
| Tract # | TRACTCE | Unique census tract ID |
| Access to Nearest Hospital | minDistT_mi | Euclidean distance from tract centroid to nearest hospital, in miles |

Zip Code (Access03_Z):

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Full GEOID | GEOID10 | Unique GEOID, same as zip code |
| Zip code tract area | ZCTA5CE10 | Zip code |
| Access to Nearest Hospital | minDistZ_mi | Euclidean distance from zip code centroid to nearest hospital, in miles |

### Data Limitations:
Distance is Euclidean - not driving or walking routes. 

### Comments/Notes:
Includes US States, Washington D.C., and territories, including: Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Palau
