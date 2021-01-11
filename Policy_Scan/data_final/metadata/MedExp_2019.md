**Meta Data Name**: 2019 Medicaid expenditure variables, part of the Policy dataset  
**Last Modified**: Jan 10th, 2021
**Author**: Qinyun Lin  

### Data Location: 
PS06 - Medicaid Expenditure policy variables at the state level. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* PS06_S  

### Data Source(s) Description:  
Variables were obtained from KFF. https://www.kff.org/medicaid/state-indicator/total-medicaid-spending/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D on Jan 10th, 2021. Raw data is downloaded in the folder of data_raw, named as "raw_data_medicaid_exp.csv". The sources are from Urban Institute estimates based on data from CMS (Form 64), as of August 2020.

### Description of Data Processing: 
The following variables were included from the source data:
1. Total medical expenditure (Character);
2. Total medical expenditure (Numeric). 

Fractions are calculated based on the number of months out of 12 that a law is effective. A law is considered effective for a given month if a law becomes effective by the 7th for January, or if a law becomes effective by the 3rd for February – December.

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total medical expenditure (Character) | TtlMedExpC | Total medical expenditure in a character format |
| Total medical expenditure (Numeric) | TtlMedExpN | Total medical expenditure in a numeric format |


### Data Limitations:
N/A.

### Comments/Notes:
1. Medicaid expenditures do not include administrative costs, accounting adjustments, or the U.S. Territories. Total Medicaid spending including these additional items was $626 billion in FY 2019.
2. Federal Fiscal Year: Unless otherwise noted, years preceded by "FY" refer to the Federal Fiscal Year, which runs from October 1 through September 30. FY 2019 refers to the period from October 1, 2018 through September 30, 2019.
3. New York data may reflect anomalous spending due to adjustments, change in expenditures, and lags in state claims. 