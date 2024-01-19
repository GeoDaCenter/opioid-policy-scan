**Meta Data Name**: Medicaid Expenditure 2019  
**Author**: Qinyun Lin  
**Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Policy  

### Data Location: 
Latest - the access data is available at state scale. The file can be found [here](../full_tables).
* S_Latest.csv   

### Data Source(s) Description:  
Variables were obtained from Kaiser Family Foundation's [State Health Facts](https://www.kff.org/medicaid/state-indicator/total-medicaid-spending/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D), accessed January 10, 2021. Raw data is downloaded in the folder of [data_raw](https://github.com/GeoDaCenter/opioid-policy-scan/tree/v1.0/data_raw), named as *raw_data_medicaid_exp.csv*. The sources are from Urban Institute estimates based on data from CMS (Form 64) from August 2020.

### Description of Data Processing: 
The following variables were included from the source data:
* Total medicaid spending  (Character)
* Total medicaid spending (Numeric) 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total medicaid spending (Character) | TtlMedExpC | Total medicaid spending in character format |
| Total medicaid spendinge (Numeric) | MedcdExp19 | Total medicaid spending in numeric format |


### Data Limitations:
N/A

### Comments/Notes:
1. Medicaid expenditures do not include administrative costs, accounting adjustments, or the U.S. Territories. Total Medicaid spending including these additional items was $626 billion in FY 2019.
2. Federal Fiscal Year: Unless otherwise noted, years preceded by "FY" refer to the Federal Fiscal Year, which runs from October 1 through September 30. FY 2019 refers to the period from October 1, 2018 through September 30, 2019.
3. New York data may reflect anomalous spending due to adjustments, changes in expenditures, and lags in state claims. 
