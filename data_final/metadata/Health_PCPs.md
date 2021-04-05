**Meta Data Name**: Primary Care Physicians and Specialist Physicians  
**Last Modified**: March 3, 2021  
**Author**: Susan Paykin  

### Data Location: 
Health03 at 3 spatial scales. Files can be found [here](/data_final).
* Health03_T  
* Health03_C
* Health03_S

### Data Source(s) Description:  

Data was sourced from [Dartmouth Atlas' Primary Care Service Area (PCSA) Project](https://data.nber.org/data/dartmouth-atlas-primary-care-service-area-pcsa.html). The Dartmouth Atlas Project documents  variations in how medical resources are distributed and used in the United States. It uses Medicare and Medicaid data to provide information and analysis about national, regional, and local markets, as well as hospitals and their affiliated physicians. The full Dartmouth Atlas data is available [here](https://atlasdata.dartmouth.edu/downloads). 

### Description of Data Source Tables: 
The source table was Census Tract layer attributes CSV. The data date is 2010. Source variables selected for inclusion and further processing included state, county, and tract FIPS codes, as well as *TG_DOC* for the number of clinically active primary care physicians in the tract and *TS_DOC* for the number of clinically active specialist physicians in the tract. 

### Description of Data Processing: 
Data was wrangled, cleaned and processed for creation of tract, county and state level datasets. For the tract dataset (Health03_T.csv), we created a *geoid* variable merging state, county, and tract digits for a unique 11-digit census tract ID. For the county (Health03_C.csv) and state (Health03_S.csv) respectively, we aggregated the tract totals to the appropriate level. 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Primary care physicians | pcp_total | Number of PCPs in area |
| Specialty physicians | sp_total | Number of specialty physicians in area |
| GEOID | geoid | Unique 11-digit identifier for census tracts |
| State FIPS | state | Unique 2-digit identifier for states |
| County FIPS | county | Unique 5-digit identifier for counties (state + county) |
| Census tract | tract | 6-digit identifier for census tracts |

### Data Limitations:
Does not include U.S. territories Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Virgin Islands, or Washington, D.C. 

### Comments/Notes:
