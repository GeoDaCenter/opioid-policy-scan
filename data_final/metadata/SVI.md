**Meta Data Name**: SVI Variables  
**Date Added**: April 12, 2021  
**Author**: Qinyun Lin, Wataru Morioka, Mahjabin Kabir Adrita  
**Date Last Modified**: May 12, 2025   
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita  

### Theme: 
Composite

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Tract-level variables were obtained from the US Centers for Disease Control and Prevention (CDC) Agency for Toxic Substances and Disease Registry (ATSDR) [Social Vulnerability Index 2018](https://www.atsdr.cdc.gov/placeandhealth/svi/data_documentation_download.html). Data was accessed on April 12, 2021. Raw data is downloaded in the folder of data_raw/SVI. 

The CDC/ATSDR Social Vulnerability Index  uses 15 U.S. census variables to help local officials identify communities that may need support before, during, or after disasters. Each tract is ranked on 15 social factors, including poverty,  lack of vehicle access, and crowded housing, and is grouped into four related themes to identify vulnerable populations. For more on Index, how it can be used, and what it measures, please refer to the complete [CDC SVI documentation, FAQ, and interactive map](https://www.atsdr.cdc.gov/placeandhealth/svi/index.html). 

### Description of Data Processing: 
The following variables were included from the source data:

1. Socioeconomic – RPL_THEME1;
2. Household Composition & Disability – RPL_THEME2
3. Minority Status & Language – RPL_THEME3
4. Housing Type & Transportation – RPL_THEME4
5. Overall summary ranking - RPL_THEMES

For county-level estimates, Census tracts were grouped by counties and their estimates were averaged. 

For ZIP code-level estimates, because Census tracts do not map neatly onto ZCTA boundaries, we used a [HUD USPS ZIP-Tract Crosswalk File](https://www.huduser.gov/portal/datasets/usps_crosswalk.html) to take the weighted mean of the percentage of addresses in each tract that falls into the ZIP code. The ZIP code estimates exclude NAs ( observations coded as -999). Please note that there are some gaps in the ZIP code level databaset, as we identified approximately 200 Census tracts that are included in SVI but NOT the HUD crosswalk; therefore, they were not translated to the ZIP code estimate. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Socioeconomic – RPL_THEME1 | SviTh1 | SVI Ranking, Theme 1: Socioeconomic | 2018, 2022 | Tract, Zip, County |
| Household Composition & Disability – RPL_THEME2 | SviTh2 | SVI Ranking, Theme 2: Household Composition & Disability | 2018, 2022 | Tract, Zip, County |
| Minority Status & Language – RPL_THEME3 | SviTh3 | SVI Ranking, Theme 3: Minority Status & Language | 2018, 2022 | Tract, Zip, County |
| Housing Type & Transportation – RPL_THEME4 | SviTh4 | SVI Ranking, Theme 4: Housing Type & Transportation | 2018, 2022 | Tract, Zip, County |
| Overall summary ranking - RPL_THEMES | SviSmryRnk | Overall summary ranking | 2018, 2022 | Tract, Zip, County |

### Data Limitations:

Please note that the SVI dataset at the ZIP code level is an estimate based on crosswalking the original CDC SVI Census tract measures to ZIP codes; some gaps in this data are to be expected. The ZIP code data does not include Puerto Rico or other US territories. 

### Comments/Notes:

See [here](https://www.atsdr.cdc.gov/placeandhealth/svi/documentation/SVI_documentation_2018.html) for more information on SVI data and methodology.  

**Note on missing data:** Missing and/or unavailable data are represented as blank cells or _NA._
