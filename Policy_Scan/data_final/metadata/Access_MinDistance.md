**Meta Data Name**: Access to MOUDs variables, part of the Health Factors dataset  
**Last Modified**: October 30th, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
Access01 - Policy Scan Environment Report at 2 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* Access01_T  
* Access01_Z  

### Data Source(s) Description:  
Locations prescribing Medication for Opioid Overuse Disorder were sourced from SAMHSA database for Naltrexone, Buprenorphine & Methadone. Vivitrol data was scraped from vivitrol.com. **Update this section and Data Source Table section with more details**

Centers of population or population weighted centroids for census tracts were sourced from the NHGIS. Raw data and more information can be found [here](https://www.nhgis.org).

Centers of population or population weighted centroids for zctas were calculated inhouse (check notes or discuss with Vidal).

### Description of Data Source Tables:


### Description of Data Processing: 
Euclidean Distance was calculated from the population weighted centroid of each tract/zcta to the nearest location of Buprenorphine, Methadone and Naltrexone/Vivitrol. Naltrexone and Vivitrol locations were clubbed into one category for this calculation.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Access to Buprenorphine | minDisBup | Euclidean Distance to Nearest Buprenorphine location |
| Access to Methadone | minDisMet | Euclidean Distance to Nearest Methadone location |
| Access to Naltrexone/Vivitrol | minDisNalV | Euclidean Distance to Nearest Naltrexone/Vivitrol location |

### Data Limitations:
n/a

### Comments/Notes:
n/a
