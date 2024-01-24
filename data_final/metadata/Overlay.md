**Meta Data Name**: Community Overlay Variables  
**Date Added**: Feburary 23, 2021  
**Author**: Qinyun Lin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka   

### Theme: 
Social

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.  

### Data Source(s) Description:  
Variables were obtained from [The US Covid Atlas Projec](https://theuscovidatlas.org/map)t. Hypersegregated cities refer to American metropolitan areas where black residents experience hypersegregation. See [here](https://www.princeton.edu/news/2015/05/18/hypersegregated-cities-face-tough-road-change) for more information. The Black Belt refers to Southern US counties where at least 30% of the population identified Black or African American in the 2000 Census (see [here](https://en.wikipedia.org/wiki/Black_Belt_in_the_American_South)). Native American or American Indian reservation boundaries come from the [TIGER/Line 2017](https://catalog.data.gov/dataset/tiger-line-shapefile-2017-nation-u-s-current-american-indian-alaska-native-native-hawaiian-area) dataset.

### Description of Data Processing: 
The following variables were included from the source data:

* Hypersegregated City or Metropolitan Area - dummy variable
* Black Belt County - dummy variable
* Native American Reservations - numeric percent of county land area
 
### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Hypersegregated City | DmySgrg | Dummy variable for whether county is part of a hypersegregated city or its metropolitan area | Latest | County |
| Southern Black Belt | DmyBlckBlt | Dummy variable for whether county is in the Southern Black Belt region | Latest | County |
| Native American Reservations | PrctNtvRsrv |  Percentage of county land area that belongs to Native American reservation(s) | Latest | County |

### Data Limitations:
The variable representing Native American reservations was calculated as a percent of each county's total land area in US Albers Equal Area projection. Due to consistency issues of spatial projections, there may be some distortion of the percentage of land area calculation in Alaska.

### Comments/Notes:
In defining counties in the Southern Black Belt, we included southern US counties where at least 30% of the population identified as Black or African American as of the 2000 Census. However, the Southern Black Belt areas have been variously defined in literature. See, for example, Webster, G. R., & Bowman, J. (2008). Quantitatively Delineating the Black Belt Geographic Region. *Southeastern Geographer*, 48(1), 3–18. https://doi.org/10.1353/sgo.0.0007. 
