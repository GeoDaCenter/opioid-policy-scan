**Meta Data Name**: Internet Variables  
**Author**: Qinyun Lin  
**Last Modified**: November 27, 2023  
**Last Modified By**: Wataru Morioka  

### Data Location: 
EC05 at 4 spatial scales. Files can be found [here](/data_final).

* EC05_2019_T  
* EC05_2019_Z  
* EC05_2019_C  
* EC05_2019_S  

### Data Source(s) Description:  
Variables were obtained from the 2015 - 2019 American Community Survey (ACS), table B28002, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
PRESENCE AND TYPES OF INTERNET SUBSCRIPTIONS IN HOUSEHOLD

### Description of Data Processing: 
The following variables were included from **B28002**:

* B28002_001: Estimate!!Total
* B28002_002: Estimate!!Total:!!With an Internet subscription
* B28002_012: Estimate!!Total:!!Internet access without a subscription
* B28002_013: Estimate!!Total:!!No Internet access

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Households with an Internet subscription  | IntSub | Households with an Internet subscription |
| Households with Internet but without subscription | IntNoSub | Households with Internet but without subscription |
| Households without Internet access | noInt | Households without Internet access |
| % Households with an Internet subscription  | IntSubPct | Percentage of Households with an Internet subscription |
| % Households with Internet but without subscription | IntNoSubPct | Percentage of Households with Internet but without subscription |
| % Households without Internet access | NoIntP | Percentage of Households without Internet access |

### Data Limitations:
This data represents estimates as of the ACS 2019 5-year average.
