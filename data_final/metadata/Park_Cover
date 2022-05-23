**Meta Data Name**: Access to Pharmacies  
**Added**: January 6, 2021  
**Last Modified**: April 25, 2022  
**Author**: Susan Paykin    

### Data Location: 
BE07 at 4 spatial scales. Files can be found [here](/data_final).
* BE07_S 
* BE07_C 

### Data Source(s) Description:  
Land use data were pulled from [OpenStreetMap (OSM)](openstreetmap.org). The following queries were made at the national level:
*natural=wood
*leisure=nature_reserve
*landuse=recreation_ground
*landuse=grass
*landuse=forest
*landuse=cemetery
*leisure=garden

### Description of Data Processing: 
Data was collected from OpenStreetMap. The queries resulted in a series of polygons representing parks and green spaces. These polygons were dissolved and unioned. The resulting geometries were broken down by county or state to result in the total area of parks and green spaces as well as the percent cover.


### Key Variable and Definitions:

#### County

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| COUNTYFP | COUNTYFP | Unique 5-digit GEOID for census tracts |
| Park Area | parkArea | Area (in square meters) of park or green space in a county |
| Park Cover | cover | Percent of county covered by park or green space|

#### State
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| COUNTYFP | ID for counties | Unique 5-digit identifier for counties| 
| STATEFP | ID for states | Unique 2-digit identifier for states| 
| Count of tracts | cntT | Total number of tracts in county/state | 
| Count of tracts within 30-min driving range | cntTimeDrive | Number of tracts with pharmacy within a 30-min driving range |
| Percent of tracts within 30-min driving range | pctTimeDrive | Percent of tracts with pharmacy within a 30-min driving range |
| Average time drive to nearest pharmacy | avTimeDrive | Average driving time (minutes) across tracts in county/state to nearest pharmacy |

### Data Limitations:
*Due to differences in geometry between OSM and census tigerlines, there are 2 counties with over 100% parks cover, both of which
### Comments/Notes:
