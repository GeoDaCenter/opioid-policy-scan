**Meta Data Name**: State & Local Government Expenditures  
**Date Added**: March 11, 2021  
**Author**: Susan Paykin, Wataru Morioka, Mahjabin Kabir Adrita  
**Date Last Modified**: May 12, 2025
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita  

### Theme: 
Policy  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.
### Data Source(s) Description:  

This data was sourced from the 2018 [U.S. Census Bureau Annual Survey of State and Local Government Finances](https://www.census.gov/programs-surveys/gov-finances.html) and accessed via Urban Institute & Tax Policy Center's [State and Local Finance Data Finder](https://state-local-finance-data.taxpolicycenter.org/pages.cfm). 

This survey is the only source of nationwide, comprehensive local government finance information. It provides statistics on revenue, expenditure, debt, and assets for the 50 states and D.C. The 2018 data was released in September 2020. 

### Description of Data Source Tables: 

The data source table included the following variables for state and local government expenditures.

| Category | Survey Variable |
|:---------|:----------------|
| Police & fire protection | (E019) Police & Fire Protection-Dir Exp |
| Correctional system | (E021) Total Correct-Dir Exp |
| | (E022) Total Correct-Cur Oper |
| | (E023) Total Correct-Cap Out |
| | (E052) Health & Hosp-Dir Exp |
| Public health & hospitals | (E053) Health & Hosp-Cur Oper |
| | (E054) Health & Hosp-Cap Out |
| Public welfare | (E090) Public Welf-Direct Exp |
| | (E091) Public Welf-Cur Oper |
| | (E092) Public Welf-Cash Asst |
| | (E093) Welf-Categ-Cash Assist |
| | (E094) Welf-Cash-Cash Assist |
| | (E095) Public Welf-Cap Outlay |

### Description of Data Processing: 

Data was downloaded, cleaned, and prepared for analysis. The expenditure variables listed above were aggregated by category (police and fire, corrections, public health, and public welfare) to create variables represented category totals for state-level spending, local-level spending, and combined state and local spending for each state. These variables were then merged into the final dataset, which includes all finance variables for state and D.C. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Police & fire expenditures | PlcFyrExp | Total expenditures on police and fire protection| 2022 | State |
| Corrections expenditures | CrrctExp | Total expenditures on corrections system and operations | 2022 | State |
| Public health expenditures | HlthExp | Total expenditures on public health and hospitals | 2022 | State |
| Public welfare expenditures | WlfrExp | Total expenditures on public welfare programs | 2022 | State |

For the expenditure variables, the last characters indicate the following levels:  

| Code | Level | Description |
|:-----|:------|:------------|
| _S | State | State finance information exclusive of local revenues or spending |
| _L | Local | State totals of finance information for all local governments within each state. This includes data for all counties, municipalities, towns, special districts, and school districts |
| _T | Total | Aggregated finance information state and local levels of government |

### Data Limitations: 

Local data outside of police and fire expenditures was not available for Washington, D.C. 

### Comments/Notes:

This data does not include U.S. territories FM, GU, MP, PR, or VI.
