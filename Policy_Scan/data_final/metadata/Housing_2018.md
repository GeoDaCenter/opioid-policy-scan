**Meta Data Name**: Housing Variables
**Last Modified**: March 20, 2021 
**Author**: Moksha Menghaney, updates by Susan Paykin   

### Data Location: 
HS01 at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* HS01_T  
* HS01_Z  
* HS01_C  
* HS01_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), tables B25002, B25024, B25003, and B25026, each at the State, County, Tract and ZIP Code Tabulation Area (ZCTA) levels. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
B25002 : Occupancy status <br>
B25024 : Units in structure <br>
B25003 : Tenure <br>
B25026 : Total population in occupied housing units by tenure by year householder moved into unit

### Description of Data Processing: 
The following variables were included from **B25002**:
  1. Estimate; Total Units
  2. Estimate; Occupied Units
  3. Estimate; Vacant Units
  
The following variables were included from **B25024**:
  1. Estimate; Mobile homes
 
The following variables were included from **B25003**:
  1. Estimate; Total Occupied Units
  2. Estimate; Owner Occupied Units
  3. Estimate; Renter Occupied Units
 
The following variables were included from **B25026**:
  1. Estimate; Total Population in owner occupied units
  2. Estimate; Total Population in owner occupied units moved in before 1989
  3. Estimate; Total Population in owner occupied units moved in between 1990 and 1999
  4. Estimate; Total Population in renter occupied units
  5. Estimate; Total Population in renter occupied units moved in before 1989
  6. Estimate; Total Population in renter occupied units moved in between 1990 and 1999

----------
* **Occupancy rate** was calculated as : *Occupied units / Total units*  

* **Vacancy rate** was calculated as : *Vacant units / Total units*  

* **Rental rate** was calculated as : *Renter occupied units / Total occupied units*  

* **Percentange of mobile housing structures** was calculated as : *Mobile units / Total units*   

* **Long-term occupancy rate** was calculated as : *(Owner & renter populations moved in before 1989 + Owner & renter population moved in between 1990 & 1999) / (Total population in owner & renter occupied units)*  

* **Housing Unit Density** was calculated as : *Total Housing Units / Land area in square miles*  
Note: Total land area for each spatial scale was sourced from geometry files and converted to square miles.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Housing Occupancy Rate | occP | Percentage of housing units occupied |
| Housing Vacancy Rate | vacantP | Percentage of housing units vacant |
| Long-Term Occupancy | lngTermP | Percentage of population who moved into their current housing more than 20 years ago |
| Rental Rate | rentalP | Percentage of occupied housing units that are rented |
| Mobile Homes Rate | mobileP | Percentage of total housing units categorized as mobile housing structures |
| Housing Unit Density | unitDens | Number of housing units per square mile of land area |

### Data Limitations:
n/a

### Comments/Notes:
n/a
