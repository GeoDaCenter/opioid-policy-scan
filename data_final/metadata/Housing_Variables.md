**Meta Data Name**: Housing Variables  
**Date Added**: April 1, 2021  
**Author**: Susan Paykin, Moksha Menghaney, Wataru Morioka, Mahjabin Kabir Adrita  
**Date Last Modified**: May 12, 2025 
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita

### Theme: 
Environment

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  
CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files. 

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

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total Occupied Units | TotUnits | Count of total occupied housing units | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| Housing Vacancy Rate | VacantP | Percentage of vacant housing units | 1980, 1990, 2000, 2010, Latest | Tract, Zip, County, State |
| Mobile Homes Rate | MobileP | Percentage of total housing units categorized as mobile housing structures | Latest | Tract, Zip, County, State |
| Long-Term Occupancy | LngTermP | Percentage of population who moved into their current housing more than 20 years ago | Latest | Tract, Zip, County, State |
| Rental Rate | RentalP | Percentage of occupied housing units that are rented | Latest | Tract, Zip, County, State |
| Housing Unit Density | UnitDens | Number of housing units per square mile of land area | Latest | Tract, Zip, County, State |
| Crowded Housing (18+)             | crowdHsng18         | Percent of households with crowding (1.01+ persons/room, age 18+)           | 2020, 2023       | Tract, County, ZCTA   |
| Condominium Housing               | HsdTypCo            | Percent of housing classified as condominium                               | 2020, 2023       | Tract, County, ZCTA   |
| Multifamily Housing               | HsdTypM             | Percent of housing classified as multifamily                               | 2020, 2023       | Tract, County, ZCTA   |
| Mixed-Use Housing                 | HsdTypMC            | Percent of housing classified as mixed-use                                 | 2020, 2023       | Tract, County, ZCTA   |
| Occupied Housing Units            | occupantP           | Percent of housing units that are occupied | 2023 | Tract, County, ZCTA |   


### Data Limitations:
None at this time.  

### Comments/Notes:
Note: Data is as of the 2018 5-year average (ACS). 
