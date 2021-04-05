**Meta Data Name**: Access to Hospitals  
**Last Modified**: January 6, 2021  
**Author**: Susan Paykin  

### Data Location: 
Access03 at 2 spatial scales. Files can be found [here](/data_final).
* Access03_T  
* Access03_Z  

### Data Source(s) Description:  
Hospital locations were sourced from [CovidCareMap Healthcare System Capacity data](https://github.com/covidcaremap/covid19-healthsystemcapacity/tree/master/data), an aggregated dataset which sources data from the [Healthcare Cost Report Information System (HCRIS)](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/Cost-Reports/Hospital-2010-form) and [Definitive Healthcare](https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=125.859%2C-16.820%2C-150.821%2C72.123). 

Zip code tract area (ZCTA) and Census Tract files were sourced from the [US Census Bureau, TIGER/Line Shapefiles 2018](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html). 

### Description of Data Source Tables: 
The source datatable from CovidCareMap included the hospital name, address, city, state, county, latitute and longitude, as well as additional variables for hospital bed and ICU bed capacity, current bed occupancy rates, and staffing rates. For this analysis, we used only the hospital name and location variables. 

### Description of Data Processing: 
Data was cleaned and prepared for analysis. Centroids were calculated for ZCTA and Census Tract geometries. For the nearest resource analysis, Euclidean distance was calculated from the centroid of each tract/ZCTA to the nearest hospital location.

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Access to Hospitals | minDisHosp | Euclidean distance from centroid to nearest hospital, in miles |
| Census Tract GEOID | GEOID | Unique 11-digit GEOID for census tracts (state + county + tract) |
| State | STATEFP | Unique 2-digit ID for states |
| County | COUNTYFP | 3-digit ID for counties |
| Census Tract | TRACTCE | 6-digit ID for census tracts |
| ZIP Code Tract Area (ZCTA) | ZCTA5CE10 | Unique 5-digit assigned ZCTA, usually same as ZIP Code |

### Data Limitations:
Euclidean distance or straight-line is a simple approximation of access or travel from an origin centroid to the nearest hospital. It is not a precise calculation of real travel times or distances. 

### Comments/Notes:
This dataset includes all US states, Washington D.C., and Puerto Rico. It does not include the territories Guam, Northern Mariana Islands, American Samoa, Palau. Zip code and tract centroids are not population-weighted.
