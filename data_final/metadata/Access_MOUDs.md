**Meta Data Name**: Access to MOUDs
**Last Modified**: March 15, 2021  
**Author**: Susan Paykin  

### Data Location: 
Access01 at 2 spatial scales. Files can be found [here](/data_final).
* Access01_T  
* Access01_Z  

### Data Source(s) Description:  
Provider locations prescribing Medications for Opioid Overuse Disorder (MOUDs) were sourced from SAMHSA database for Buprenorphine & Methadone. Provider locations for those prescribing Vivitrol/Naltrexone data was scraped from *vivitrol.com*. 

### Description of Data Processing: 
Data was identified, wrangled, cleaned, and prepared for analysis. We geocoded locations locations through the [tidygeocoder](https://cran.r-project.org/web/packages/tidygeocoder/vignettes/tidygeocoder.html) package in R, as well as supplemental geocoding through University of Chicago Library GIS services. We calculated centroids for each census tract and ZCTA, and then conducted a nearest resource analysis to determine the Euclidean distance from each centroid to the nearest MOUD provider location. This produced minimum distance access variables for each of the three medications.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | ID for zip or tract | Unique 5-digit ID for ZCTA, unique 11-digit ID for census tracts | 
| Access to nearest MOUD | minDisMOUD | Euclidean distance to nearest MOUD (all types) |
| Access to Buprenorphine | minDisBup | Euclidean distance to nearest buprenorphine provider |
| Access to Methadone | minDisMet | Euclidean distance to nearest methadone provider |
| Access to Naltrexone/Vivitrol | minDisNalV | Euclidean distance to nearest naltrexone/Vivitrol provider |

### Data Limitations:
Centroids are not population weighted.

### Comments/Notes:
This dataset does not include U.S. territories.
