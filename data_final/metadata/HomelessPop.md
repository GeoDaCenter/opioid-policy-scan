**Meta Data Name**: Homeless Population  
**Date Added**: September 26, 2021  
**Author**: Ally Muszynski  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka

**Note: These variables have been removed from OEPS prior to the v2.0 release. Retaining this metadata file just for posterity. -AC**

### Theme: 
Social  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Variables were obtained from the 2018 Department of Housing and Urban Development Homeless Census, 2018, table DP03 at State, County, Tract and ZIP Code Tabulation Area (ZCTA) level. Raw data and more details can be found at https://www.huduser.gov.

### Description of Data Source Table:
DP03: Annual homeless census point in time and bed count.fields

### Description of Data Processing: 
The following variables were included from the source data:
1. Homeless shelter bed count
2. Homeless shelter point in time count
3. Homeless shelter yearly bed count

Rates were calculated using group dwelling estimates for homelessness. 

----------
  * Percentage for homeless rate was calculated as: *estimate for the group / total population*, e.g.
-  *% group dwelling  = non-related group dwelling / Total population* \

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Bed Count | BedCnt | Number of beds available to homeless individuals in a continuum of care available at the time of the census | Latest | Tract, Zip, County, State |
| Point In Time Count | PntInTm | Number of housing-insecure individuals at a shelter on the day of the count | Latest | Tract, Zip, County, State |
| Yearly Bed Count | YrlyBedCnt |  Number of beds available to homeless populations in group quarters available year-round | Latest | Tract, Zip, County, State |
  

### Data Limitations:
This data represents estimates as of the ACS 2018 point in time count. This is the taken by a team of individuals in a continuum of care in one day. It is difficult to measure homelessness at a local and Federal level as the population is relatively mobile, homelessness can be cyclical and there are visibility issues for the homeless community, so the annual point in time count was used as a proxy for homelessness in this dataset. Data was geocoded then spatially joined at the tract, ZCTA, state and county level to see where continuums of care are located and the availability of temporary housing solutions.

### Comments/Notes:
Point in time counts were geocoded from addresses provided then spatially joined with different levels of information to give a proxy for homelessness. 
[Here](https://docs.google.com/presentation/d/1rD77sVr92OaUWKWavb6j5cs0XLdReiKXEEG6fOPShYs/edit?usp=sharing) is the methodology for the proxy for homelessness and how data collection is performed.
**Note on missing data:** Missing and/or unavailable data are coded as NA. 


