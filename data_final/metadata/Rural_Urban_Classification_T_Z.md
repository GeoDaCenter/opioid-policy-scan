**Meta Data Name**: Rural-Urban Classification for Tracts & ZCTAs  
**Author**: Moksha Menghaney  
**Last Modified**: December 5, 2023  
**Last Modified By**: Wataru Morioka  

### Data Location: 
BE02 at 2 spatial scales. Files can be found [here](/data_final).
* BE02_RUCA_T  
* BE02_RUCA_Z  

### Data Source(s) Description:  
Tract and ZCTA level classifications were calculated using the [Rural-Urban Commuting Area Codes (RUCA codes)](https://www.ers.usda.gov/data-products/rural-urban-commuting-area-codes.aspx). These codes classify U.S. census tracts using measures of population density, urbanization, and daily commuting. A second dataset then applies the 2010 RUCA classifications to ZIP code areas by transferring RUCA values from the census tracts that comprise them.


### Description of Data Source Tables:
For each census tract, the USDA calculates 10 primary and 21 secondary codes. Tract-to-tract commuting patterns are utilized for calculation of these codes. Primary codes use the largest share commuting flow to classify tracts. 

* Codes 1, 4 and 7 are Core Codes, i.e., these identify the tract equivalents for cores of Metropolitan, Micropolitan and Small Towns respectively. 

* Codes 2, 5 and 8 are High Commuting Codes, i.e., these identify the tract equivalents for communities with primary flows to Metropolitan, Mitropolitan and Small Towns cores respectively. The primary flow accounts for more than 30% of the communities total commuting flow.

* Codes 3, 6 and 9 are Low Commuting Codes, i.e., these identify the tract equivalents for communities with primary flows to Metropolitan, Mitropolitan and Small Towns respectively, but these flows account for less than 30% of the communities total commute. Please note, this flow is still the largest commuting flow, but it is less than 30%. 

Secondary codes utilize the second largest share of commuting patterns to further classify census tracts. Exact definitons can be found [here](https://www.ers.usda.gov/data-products/rural-urban-commuting-area-codes/documentation/).


### Description of Data Processing: 

Census Tracts & Zipcodes were classified as :
* Urban, if their RUCA2 codes were 1.0 and 1.1 
* Suburban, if their RUCA2 codes were 2.0, 2.1, 4.0, and 4.1 
* All other RUCA2 codes were classified as Rural.

  
### Key Variable and Definitions:
tractFIPS and ZIP_CODE are the respective identifiers for census tract and zipcode level files.

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| RUCA Codes | Ruca1 | Primary RUCA Code |
| RUCA Codes | Ruca2 | Secondary RUCA Code |
| Classification | Rurality | Urban/Suburban/Rural |


### Data Limitations:
n/a

### Comments/Notes:
n/a
