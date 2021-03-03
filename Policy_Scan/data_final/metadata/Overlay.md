**Meta Data Name**: Overlay variables, part of the Physical Variables  
**Last Modified**: Feburary 23rd, 2021  
**Author**: Qinyun Lin  

### Data Location: 
HS04 - Overlay variables at the county level. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* HS04_C  

### Data Source(s) Description:  
Variables were obtained from the Covid Atlas Project. Specifically, hypersegregated cities refer to American metropolitan areas where black residents experience hypersegregation, see [here](https://www.princeton.edu/news/2015/05/18/hypersegregated-cities-face-tough-road-change) for more information. The Black Belt counties refer to Southern US counties that were at least 40% Black or African American in the 2000 Census (see [here](https://en.wikipedia.org/wiki/Black_Belt_in_the_American_South)). 


### Description of Data Processing: 
The following variables were included from the source data:
1. Hypersegregated area;
2. Black Belt county;
3. Native American Reservations. 
 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Hypersegregated area | DmySgrg | dummy variable for whether it is a current or historic hypersegregated area |
| Black Belt county | DmyBlckBlt | dummy variable for whether it is a southern black belt county|
| Native American Reservations | PrctNtvRsrv |  percentage of that county that belongs to native american reservations|

### Data Limitations:
The percentage of Native American Reservations is calculated as a percent of total land area in US Albers Equal Area projection. There might be some distortion in Alaska.

### Comments/Notes:
We include southern US counties that were at least 40% Black or African American in the 2000 Census. But the Southern Black Belt areas have been variously defined in literature. See, for example, Webster, G. R., & Bowman, J. (2008). Quantitatively Delineating the Black Belt Geographic Region. *Southeastern Geographer*, 48(1), 3–18. https://doi.org/10.1353/sgo.0.0007. 
