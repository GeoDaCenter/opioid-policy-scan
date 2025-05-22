Metadata Name: Marital Status Variables  
Date Added: May 14, 2025  
Date Last Modified: May 14, 2025  
Author: Mahjabin Kabir Adrita  
Last Modified By: Mahjabin Kabir Adrita   
Last Modified Date: May 14, 2025  

### Theme  
Marital Status  

### Data Location  
You can find the variables described in this document in the CSV files. CSV files are organized by year and spatial scale. For example, county-level variables from 2020 will be found in `C_2020.csv`.  
**Note**: Every variable can be found in the **Latest** files.

### Data Source(s) Description  
American Community Survey (ACS) 5-Year Estimates from the U.S. Census Bureau. These estimates provide aggregated demographic, housing, and socioeconomic information for various geographic scales across the U.S.

### Description of Data Source Tables  
The data tables used to construct these variables are drawn from detailed ACS summary tables, particularly those related to marital status (e.g., Table B12001: Marital Status by Sex by Age for the Population 15 Years and Over).

### Description of Data Processing  
- Data extracted using Census API or downloaded from the U.S. Census Bureau website.  
- Variables were renamed and standardized to ensure consistency across datasets.  
- Spatial joins performed to attach geospatial identifiers at tract, county, and ZCTA levels.  
- All values normalized to percentages where applicable.


### Key Variables and Definitions  

| Variable                 | Variable ID   | Description                                       | Years Available | Spatial Scale          |
|--------------------------|----------------|---------------------------------------------------|------------------|-------------------------|
| Divorced Individuals     | DivrcdP        | Percent Males 15 years and over  Who are Divorced                   | 2020, 2023       | Tract, County, ZCTA     |
| Married Individuals      | MrrdP          | Percent males aged 15 or older who are married and living with their spouse                    | 2020, 2023       | Tract, County, ZCTA     |
| Never Married Individuals| NvMrrdP        | Percent males aged 15 or older who never got married                             | 2020, 2023       | Tract, County, ZCTA     |
| Separated Individuals    | SepartedP      | Percent males aged 15 years and over who are separated from their spouse                  | 2020, 2023       | Tract, County, ZCTA     |
| Widowed Individuals      | WidwdP         | Percent male population aged 15 and over who are widowed                                   | 2020, 2023       | Tract, County, ZCTA     |

### Data Limitations  
- ACS estimates are subject to sampling error; margins of error should be considered when interpreting values, especially at smaller spatial scales such as tracts.  
- ZCTA-level data may not align exactly with USPS ZIP code boundaries.  
- Some geographic areas may have suppressed data due to confidentiality thresholds.

### Comments/Notes  
- Variables are suitable for longitudinal comparison across 2020 and 2023.  
- Useful for studying marital trends, household composition, and family structure in demographic research or health equity studies.

