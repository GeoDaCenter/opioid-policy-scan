**Meta Data Name**: Primary Care Physicians and Specialist Physicians  
**Author**: Susan Paykin  
**Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment  

### Data Location: 
Latest - the data is available at 3 spatial scales: census tract, county, and state. Files can be found [here](../full_tables).
* T_Latest.csv  
* C_Latest.csv  
* S_Latest.csv   

### Data Source(s) Description:  

Data was sourced from [Dartmouth Atlas' Primary Care Service Area (PCSA) Project](https://data.nber.org/data/dartmouth-atlas-primary-care-service-area-pcsa.html). The Dartmouth Atlas Project documents  variations in how medical resources are distributed and used in the United States. It uses Medicare and Medicaid data to provide information and analysis about national, regional, and local markets, as well as hospitals and their affiliated physicians. The full Dartmouth Atlas data is available [here](https://atlasdata.dartmouth.edu/downloads). 

### Description of Data Source Tables: 
The source table was Census Tract layer attributes CSV. The data date is 2010. Source variables selected for inclusion and further processing included state, county, and tract FIPS codes, as well as *TG_DOC* for the number of clinically active primary care physicians in the tract and *TS_DOC* for the number of clinically active specialist physicians in the tract. 

### Description of Data Processing: 
Data was wrangled, cleaned and processed for creation of tract, county and state level datasets. For the tract dataset (T_Latest.csv), we created a *GEOID* variable merging state, county, and tract digits for a unique 11-digit census tract ID. For the county (C_Latest.csv) and state (S_Latest.csv) respectively, we aggregated the tract totals to the appropriate level. 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Primary care physicians | TotPcp | Number of PCPs in area |
| Specialty physicians | TotSp | Number of specialty physicians in area |

### Data Limitations:
Does not include U.S. territories Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Virgin Islands, or Washington, D.C. 

### Comments/Notes:
