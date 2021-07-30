**Meta Data Name**: Nearest Distance for Opioid Use Treatment Providers  
**Last Modified**: July 23, 2021  
**Author**: Rachel Vigil  

### Data Location: 
Access07 - Nearest euclidean distance from Opioid Use Treatment facilities to centroids of ZCTA areas. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/data_final).
* Access07_Z: Access at ZCTA level for contiguous US
* Access07_T: Access at census tract level for contiguous US


### Data Source(s) Description:  
Variables were obtained from the SAMHSA service locator. The Opioid Treatment Programs (OTPs) represented in this set are those certified, either fully or provisionally by SAMHSA. Cetification is required for MOUD, but these programs can offer other types of treatment, including counseling and other behavioral therapies. Raw data can be found [here](https://dpt2.samhsa.gov/treatment/directory.aspx) and more information can be found [here](https://www.samhsa.gov/medication-assisted-treatment/become-accredited-opioid-treatment-program).


### Description of Data Processing: 
The following variable was calculated using minimum distance calculations using ZCTA and census tract centroids and locations of the substance use treatment centers.
* Minimum distance from ZCTA or Census Tract centroid to a substance use treatement facility.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Minimum distance to opioid use treatment facility |minDist_OTP|Minimum Distance to Opioid use treatment facility in miles|

### Data Limitations:
It is difficult to verify if all the treatement centers are still operational or offer certified and effective treatment. 
