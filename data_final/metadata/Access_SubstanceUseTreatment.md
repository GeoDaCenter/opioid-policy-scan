**Meta Data Name**: Nearest Distance for Substance Use Treatment   
**Last Modified**: July 23, 2021  
**Author**: Rachel Vigil  

### Data Location: 
Access06 - Nearest euclidean distance from Substance Use Treatment facilities to centroids of ZCTA areas. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/data_final).
* Access06_Z: Access at ZCTA level for contiguous US
* Access06_T: Access at census tract level for contiguous US


### Data Source(s) Description:  
Variables were obtained from the SAMHSA service locator. substance use treatment facilities are collected in SAMHSA's annual National Survey of Substance Abuse Treatment Services. The lists and locations of these facilities are based off of certification and data collection for treatment facilities by state abuse agencies for the Behavioral Health Services Information System. Also included in this set are treatment facilities that state substance abuse agencies, for a variety of reasons, do not fund, license, or certify which are found through periodic screening of alternative databases. Raw data can be found [here](https://findtreatment.samhsa.gov/locator), and more details about data collection can be found [here](https://www.samhsa.gov/data/data-we-collect/n-ssats-national-survey-substance-abuse-treatment-services).


### Description of Data Processing: 
The following variable was calculated using minimum distance calculations using ZCTA and census tract centroids and locations of the substance use treatment centers.
 1. The minimum distance from ZCTA or Census Tract centroid to a substance use treatement facility.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Minimum distance to substance use treatment facility |minDist_SUT|Minimum Distance to substance use treatment facility in miles|

### Data Limitations:
It is difficult to verify if all the treatement centers are still operational or offer certified and effective treatment. 
