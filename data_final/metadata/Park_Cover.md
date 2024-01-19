**Meta Data Name**: Parks and Green Space Coverage  
**Date Added**: May 30, 2022  
**Author**: Christian Villanueva   
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Land use data were pulled from [OpenStreetMap (OSM)](openstreetmap.org). The following queries were made at the national level:
* natural=wood  
* leisure=nature_reserve  
* landuse=recreation_ground  
* landuse=grass  
* landuse=forest
* landuse=cemetery
* leisure=garden

### Description of Data Processing: 
Data was collected from OpenStreetMap. The queries resulted in a series of polygons representing parks and green spaces. These polygons were dissolved and unioned. The resulting geometries were broken down by county or state to result in the total area of parks and green spaces as well as the percent cover.


### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Park Area | ParkArea | Area (in square meters) of park or green space in a county | Latest |  State |
| Park Cover | Cover | Percent of county covered by park or green space| Latest | State |

### Data Limitations:

Due to differences in geometry between OSM and census tigerlines, there are 2 counties with over 100% parks cover, both of which

### Comments/Notes:

NA
