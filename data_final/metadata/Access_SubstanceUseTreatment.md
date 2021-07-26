**Meta Data Name**: Nearest Distance for Substance Use Treatment   
**Last Modified**: July 23, 2021  
**Author**: Rachel Vigil  

### Data Location: 
Access06 - Nearest euclidean distance from Substance Use Treatment facilities to centroids of ZCTA areas. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/data_final).
* Access06_Z: Access at ZCTA level for contiguous US
* Access06_T: Access at census tract level for contiguous US
* Access06_AK_Z: Access at ZCTA level for state of Alaska
* Access06_AK_T: Access at census tract level for state of Alaska
* Access06_HI_Z: Access at ZCTA level for state of Hawaii
* Access06_HI_T: Access at census tract level for state of Hawaii

### Data Source(s) Description:  
Variables were obtained from the SAMHSA service locator. Raw data and more details can be found [here](https://findtreatment.samhsa.gov/locator).


### Description of Data Processing: 
The following variable was calculated using minimum distance calculations using ZCTA and census tract centroids and locations of the substance use treatment centers.
 1. The minimum distance from ZCTA or Census Tract centroid to a substance use treatement facility.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Minimum distance to substance use treatment facility |minDist_SUT|Minimum Distance to substance use treatment facility in miles|

### Data Limitations:
It is difficult to verify if all the treatement centers are still operational or offer certified and effective treatment. 
