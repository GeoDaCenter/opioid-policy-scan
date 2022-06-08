**Meta Data Name**: Parks and Green Space Coverage  
**Added**: May 30, 2022  
**Last Modified**: June 8, 2022  
**Author**: Christian Villanueva   

### Data Location: 
BE07 at 4 spatial scales. Files can be found [here](/data_final).
* BE07_S 
* BE07_C 

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

#### County

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| COUNTYFP | COUNTYFP | Unique 5-digit GEOID for census tracts |
| Park Area | parkArea | Area (in square meters) of park or green space in a county |
| Park Cover | cover | Percent of county covered by park or green space|

### Data Limitations:

Due to differences in geometry between OSM and census tigerlines, there are 2 counties with over 100% parks cover, both of which

### Comments/Notes:

NA
