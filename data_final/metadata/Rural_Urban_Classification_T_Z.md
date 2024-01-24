**Meta Data Name**: Rural-Urban Classification for Tracts & ZCTAs  
**Date Added**: October 27, 2020  
**Author**: Moksha Menghaney  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

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

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| RUCA Codes | Ruca1 | Primary RUCA Code | Latest | Tract, Zip |
| RUCA Codes | Ruca2 | Secondary RUCA Code | Latest | Tract, Zip |
| Classification | Rurality | Urban/Suburban/Rural | Latest | Tract, Zip |


### Data Limitations:
n/a

### Comments/Notes:
n/a
