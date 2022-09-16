**Meta Data Name**: Crosswalk files  
**Last Modified**: April 12th, 2021    
**Author**: Qinyun Lin  

### Data Location: 
Four crosswalk files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/main/data_final/geometryFiles/crosswalk).

* ZIP_COUNTY
* ZIP_TRACT
* COUNTY_ZIP
* TRACT_ZIP 

### Data Source(s) Description:  
Crosswalk data are sourced from [the U.S. Department of Housing and Urban Development (HUD) United States Postal Service ZIP Code Crosswalk Files](https://www.huduser.gov/portal/datasets/usps_crosswalk.html#data). All files downloaded here are for 4th Quarter 2020.

### Description of Data Source Tables: 
We include 4 types of crosswalk files here. ZIP_COUNTY and ZIP_TRACT are used to allocate ZIP codes to counties or Census tracts. COUNTY_ZIP and TRACT_ZIP are used to allocate counties or Census tracts to ZIP codes. It is important to note that the relationship between the two types of crosswalk files is not a perfectly inverse one. That is to say, you cannot use the ZIP to Tract crosswalk to allocate Census tract data to the ZIP code level. For that you would have to use the Tract to ZIP crosswalk file. See [here](https://www.huduser.gov/portal/datasets/usps_crosswalk.html#codebook) for more information. 

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| ZIP | ZIP |	2-digit State code |
| TRACT | TRACT |	11 digit unique 2000 or 2010 Census tract GEOID consisting of state FIPS + county FIPS + tract code. The decimal is implied and leading and trailing zeros have been preserved. |
| COUNTY | COUNTY |	5 digit unique 2000 or 2010 Census county GEOID consisting of state FIPS + county FIPS. |
| RES_RATIO | RES_RATIO	| The ratio of residential addresses in the ZIP – Tract or County part to the total number of residential addresses in the entire ZIP, or the vice versa.|
| BUS_RATIO | BUS_RATIO |	The ratio of business addresses in the ZIP – Tract, County, or CBSA part to the total number of business addresses in the entire ZIP, or the vice versa. |
| OTH_RATIO | OTH_RATIO	| The ratio of other addresses in the ZIP – Tract or County part to the total number of other addresses in the entire ZIP, or the vice versa.|
| TOTAL_RATIO | TOTAL_RATIO |	The ratio of total addresses in the ZIP – Tract, County, or CBSA part to the total number of total addresses in the entire ZIP, or the vice versa. |

### Data Limitations: 
N/A


### Comments/Notes:
N/A
