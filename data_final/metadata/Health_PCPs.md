**Meta Data Name**: Primary Care Physicians and Specialist Physicians  
**Date Added**: March 3, 2021  
**Author**: Susan Paykin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Environment  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  

Data was sourced from [Dartmouth Atlas' Primary Care Service Area (PCSA) Project](https://data.nber.org/data/dartmouth-atlas-primary-care-service-area-pcsa.html). The Dartmouth Atlas Project documents  variations in how medical resources are distributed and used in the United States. It uses Medicare and Medicaid data to provide information and analysis about national, regional, and local markets, as well as hospitals and their affiliated physicians. The full Dartmouth Atlas data is available [here](https://atlasdata.dartmouth.edu/downloads). 

### Description of Data Source Tables: 
The source table was Census Tract layer attributes CSV. The data date is 2010. Source variables selected for inclusion and further processing included state, county, and tract FIPS codes, as well as *TG_DOC* for the number of clinically active primary care physicians in the tract and *TS_DOC* for the number of clinically active specialist physicians in the tract. 

### Description of Data Processing: 
Data was wrangled, cleaned and processed for creation of tract, county and state level datasets. For the tract dataset (T_Latest.csv), we created a *GEOID* variable merging state, county, and tract digits for a unique 11-digit census tract ID. For the county (C_Latest.csv) and state (S_Latest.csv) respectively, we aggregated the tract totals to the appropriate level. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Primary care physicians | TotPcp | Number of PCPs in area | Latest | Tract, County, State |
| Specialty physicians | TotSp | Number of specialty physicians in area | Latest | Tract, County, State |
| PCPs per 100,000 | PcpPer100k | PCPs per total Population X 100,000 | Latest | Tract, County, State |
| SPs per 100,000 | SpPer100k | Specialty Physicians per total Population X 100,000 | Latest | Tract, County, State |

### Data Limitations:
Does not include U.S. territories Puerto Rico, Guam, Northern Mariana Islands, American Samoa, Virgin Islands, or Washington, D.C. 

### Comments/Notes:
