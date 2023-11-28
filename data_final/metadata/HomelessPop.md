**Meta Data Name**: Homeless Population  
**Author**: Ally Muszynski  
**Last Modified**: November 27, 2023  
**Last Modified By**: Wataru Morioka  

DS06 - 4 spatial scales. Files can be found [here](/data_final).
* DS06_T  
* DS06_Z  
* DS06_C  
* DS06_S  

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

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Bed Count | BedCnt | Number of beds available to homeless individuals in a continuum of care available at the time of the census |
| Point In Time Count | PntInTm | Number of housing-insecure individuals at a shelter on the day of the count |
| Yearly Bed Count | YrlyBedCnt |  Number of beds available to homeless populations in group quarters available year-round |
  

### Data Limitations:
This data represents estimates as of the ACS 2018 point in time count. This is the taken by a team of individuals in a continuum of care in one day. It is difficult to measure homelessness at a local and Federal level as the population is relatively mobile, homelessness can be cyclical and there are visibility issues for the homeless community, so the annual point in time count was used as a proxy for homelessness in this dataset. Data was geocoded then spatially joined at the tract, ZCTA, state and county level to see where continuums of care are located and the availability of temporary housing solutions.

### Comments/Notes:
Point in time counts were geocoded from addresses provided then spatially joined with different levels of information to give a proxy for homelessness. 
[Here](https://docs.google.com/presentation/d/1rD77sVr92OaUWKWavb6j5cs0XLdReiKXEEG6fOPShYs/edit?usp=sharing) is the methodology for the proxy for homelessness and how data collection is performed.
**Note on missing data:** Missing and/or unavailable data are coded as NA. 


