**Meta Data Name**: Medicaid Expenditure 2018-2019  
**Date Added**: January 11, 2021  
**Author**: Qinyun Lin, Wataru Morioka, Mahjabin Kabir Adrita   
**Date Last Modified**: May 12, 2025
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita  

### Theme: 
Policy  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.  

### Data Source(s) Description:  
Variables were obtained from Kaiser Family Foundation's [State Health Facts](https://www.kff.org/medicaid/state-indicator/medicaid-expansion-spending/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Total%20Medicaid%20Spending%22,%22sort%22:%22desc%22%7D), first accessed January 11, 2021. Raw data is downloaded in the folder of [data_raw](https://github.com/GeoDaCenter/opioid-policy-scan/tree/v1.0/data_raw), named as *raw_data_medi_expan.csv*. Kaiser Family Foundation uses data in its analysis from the Centers for Medicare and Medicaid Services (CMS) [Medicaid Budget and Expenditure System (MBES)](https://www.medicaid.gov/medicaid/financing-and-reimbursement/state-expenditure-reporting/expenditure-reports/index.html).
The sources are from Urban Institute estimates based on data from CMS (Form 64) from August 2020.

### Description of Data Processing: 
The following variables were included from the source data:
1. Total medicaid spending in 2019, 2018;
2. Traditional medicaid federal spending;
3. Traditional medicaid state spending;
4. Expansion federal spending; 
5. Expansion state spending. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total medicaid spending in FY | MedcdExp | Total medicaid spending in Fiscal Year | 2018, 2019, 2023 | State |
| Traditional medicaid federal spending | TradFedExp | Traditional medicaid - federal spending in Fiscal Year | 2018, 2023 | State |
| Traditional medicaid state spending | TradSttExp | Traditional medicaid - state spending in Fiscal Year | 2018, 2023 | State |
| Expansion federal spending | ExpnFedExp | Expansion Group - Federal Spending in Fiscal Year | 2018, 2023 | State |
| Expansion state spending | ExpnSttExp | Expansion Group - State Spending in Fiscal Year | 2018, 2023 | State |

### Data Limitations:
N/A

### Comments/Notes:
1. Medicaid is financed by both the federal government and the states using a formula that is based on a state's per capita income. The federal share (FMAP) varies by state from a floor of 50% to a high of 74% with exceptions for certain services or populations. The Affordable Care Act (ACA) expanded Medicaid eligibility for adults under age 65 and provided the states that chose to expand with an Enhanced FMAP of 100% federal funding through 2016 for the newly eligible adults. The federal share for the expansion population phased down to 95% in 2017 and to 90% by 2020 and beyond. 
2. Federal Fiscal Year: Unless otherwise noted, years preceded by "FY" refer to the Federal Fiscal Year, which runs from October 1 through September 30. FY 2019 refers to the period from October 1, 2018 through September 30, 2019.
3. New York data may reflect anomalous spending due to adjustments, changes in expenditures, and lags in state claims. 
4. Spending is rounded to the nearest 100. States totals may not sum to national total due to rounding.
5. Traditional medicaid spending refers to medicaid spending that does not include spending on adults enrolled in the ACA expansion group. 
6. Expansion group spending refers to spending for adults who have enrolled in Medicaid through the ACA's expansion of the program. 
7. N/A: Not applicable. State did not expand Medicaid as of September 2018. 
