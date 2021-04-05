**Meta Data Name**: Hepatitis C Infection Rate  
**Last Modified**: February 8, 2021  
**Author**: Susan Paykin  

### Data Location: 
Health02 at the state-level. Files can be found [here](/data_final).
* Health02_S

### Data Source(s) Description:  

This data was sourced from the U.S. Center for Disease Control (CDC) National Notifiable Diseases Surveillance System (NNDSS), [Viral Hepatitis Surveillance Report 2018 - Hepatitis C](https://www.cdc.gov/hepatitis/statistics/2018surveillance/HepC.htm#Table3.1).  

For case definition, see [Surveillance Case Definitions](https://wwwn.cdc.gov/nndss/conditions/hepatitis-c-acute/).

### Description of Data Source Tables: 

Data was obtained from the 2018 Surveillance Report [Table 3.1 - Number of rate of reported cases of acute hepatitis C, by state or jurisdiction, 2014-2018](https://www.cdc.gov/hepatitis/statistics/2018surveillance/HepC.htm#Table3.1).  

Note: In source table, some data was missing or unreportable by state law (see **Data Limitations** below). These are marked as follows in the annual number and rate columns:  

*N: Not reportable. The disease or condition was not reportable by law, statue, or regulation in the reporting jurisdiction.
*U: Unavailable. The data are unavailable.

### Description of Data Processing: 

Data was wrangled, cleaned and prepared for analysis. To obtain the 5-year mean (2014-2018), averages were taken for total number and rates for each state. Dataset was then merged with state geometry file in order to add the state FIPS codes (GEOID) and abbreviations. 

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique 2-digit identifier for U.S. states |
| State abbreviation | state | Official USPS abbreviation for states |
| Average Number | AveNo | Average number of infections, 2014-2018 |
| Average Rate | AveRt | Average rate of infection per 100,000 population |
| Number of infections | No_20XX | Number of infections in given year |
| Rate of infection | Rt_20XX | Rate of infections per 100,000 population |

### Data Limitations: 

Hepatitis C data was either not available or not reportable by law in the following states: AK, AZ, DE, DC, HI, IA, MS, RI.

### Comments/Notes:

Does not include U.S. territories FM, GU, MP, PR, VI.
