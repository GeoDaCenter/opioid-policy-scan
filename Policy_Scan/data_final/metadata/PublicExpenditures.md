**Meta Data Name**: State & Local Public Expenditures  
**Environment**: Policy Variables   
**Last Modified**: March 10, 2021    
**Author**: Susan Paykin  

### Data Location: 
PS11 - Policy Scan Environment Report. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* PS11_2018_S

### Data Source(s) Description:  

This data was sourced from the 2018 [U.S. Census Bureau Annual Survey of State and Local Government Finances](https://www.census.gov/programs-surveys/gov-finances.html) via Urban Institute & Tax Policy Center's [State and Local Finance Data Finder](https://state-local-finance-data.taxpolicycenter.org/pages.cfm). 

### Description of Data Source Tables: 

To be completed --

Initial variables included: 

### Description of Data Processing: 

Data was downloaded, cleaned and prepared for analysis. The expenditure variables listed above were aggregated by category (corrections, police and fire, health and hospitals, and public welfare) to create summed totals for state-level spending, local-level spending (aggregated at the state level), and total spending for each state. These variables were then merged into the final dataset, including all finance information by state. 

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | geoid | Unique 2-digit identifier for U.S. states |
| State name | state | U.S. state name |
| Police & fire expenditures | plcFireExp_X | Total expenditures on police and fire protection|
| Corrections expenditures | crrctExp_X | Total expenditures on corrections system and operations |
| Public health expenditures | healthExp_X | Total expenditures on public health and hospitals |
| Public welfare expenditures | wlfrExp_X | Total expenditures on public welfare programs |

For the expenditure variables, the last characters *_S, _L,* or *_T* indicate the following levels:  

| Code | Level | Description |
|:-----|:------|:------------|
| S | State | State finance information exclusive of local revenues or spending |
| L | Local | State totals of finance information for all local governments within each state. This includes data for all counties, municipalities, towns, special districts, and school districts |
| T | Total | Aggregated finance information state and local levels of government |

### Data Limitations: 

Local data outside of police and fire expenditures was not available for Washington, D.C. 

### Comments/Notes:

This data does not include U.S. territories FM, GU, MP, PR, or VI.
