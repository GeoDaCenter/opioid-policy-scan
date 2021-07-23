**Meta Data Name**: Nearest distance for Substance Use treatment resources.  
**Last Modified**: July 23nd, 2021
**Author**: Rachel Vigil 

### Data Location: 
Access06 - Nearest euclidean distance from Opioid Use Treatment facilities to centroids of ZCTA areas. Files can be found [here]().
* Access07_Z: Access at ZCTA level for contiguous US
* Access07_T: Access at census tract level for contiguous US
* Access07_AK_Z: Access at ZCTA level for state of Alaska
* Access07_AK_T: Access at census tract level for state of Alaska
* Access07_HI_Z: Access at ZCTA level for state of Hawaii
* Access07_HI_T: Access at census tract level for state of Hawaii

### Data Source(s) Description:  
Variables were obtained from the SAMHSA service locator. Raw data and more details can be found [here](https://dpt2.samhsa.gov/treatment/directory.aspx).


### Description of Data Processing: 
The following variable was calculated using minimum distance calculations using ZCTA and census tract centroids and locations of the substance use treatment centers.
 1. The minimum distance from ZCTA or Census Tract centroid to a substance use treatement facility.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Minimum distance to opioid use treatment facility |minDist_OTP|Minimum Distance to Opioid use treatment facility in miles|

### Data Limitations:
It is difficult to verify if all the treatement centers are still operational or offer certified and effective treatment. 
