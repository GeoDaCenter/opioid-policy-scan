**Meta Data Name**: Medicaid Expansion  
**Last Modified**: January 11, 2021  
**Author**: Qinyun Lin  

### Data Location: 
PS07 - at the state level. Files can be found [here](/data_final).
* PS07_S  

### Data Source(s) Description:  
Variables were obtained from Kaiser Family Foundation's [State Health Facts](https://www.kff.org/medicaid/state-indicator/medicaid-expansion-spending/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Total%20Medicaid%20Spending%22,%22sort%22:%22desc%22%7D), accessed January 11, 2021. Raw data is downloaded in the folder of [data_raw](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_raw), named as *raw_data_medi_expan.csv*. Kaiser Family Foundation uses data in its analysis from the Centers for Medicare and Medicaid Services (CMS) [Medicaid Budget and Expenditure System (MBES)](https://www.medicaid.gov/medicaid/financing-and-reimbursement/state-expenditure-reporting/expenditure-reports/index.html).

### Description of Data Processing: 
The following variables were included from the source data:
1. Total medicaid spending;
2. Traditional medicaid federal spending;
3. Traditional medicaid state spending;
4. Expansion federal spending; 
5. Expansion state spending. 

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Total medicaid spending | TtlMedExp | Total medicaid spending |
| Traditional medicaid federal spending | TradFedExp | Traditional medicaid - federal spending |
| Traditional medicaid state spending | TradSttExpN | Traditional medicaid - state spending |
| Expansion federal spending | ExpnFedExp | Expansion Group - Federal Spending |
| Expansion state spending | ExpnSttExp | Expansion Group - State Spending |


### Data Limitations:
N/A

### Comments/Notes:
1. Medicaid is financed by both the federal government and the states using a formula that is based on a state's per capita income. The federal share (FMAP) varies by state from a floor of 50% to a high of 74% with exceptions for certain services or populations. The Affordable Care Act (ACA) expanded Medicaid eligibility for adults under age 65 and provided the states that chose to expand with an Enhanced FMAP of 100% federal funding through 2016 for the newly eligible adults. The federal share for the expansion population phased down to 95% in 2017 and to 90% by 2020 and beyond. 
2. Spending is rounded to the nearest 100. States totals may not sum to national total due to rounding.
3. Traditional medicaid spending refers to medicaid spending that does not include spending on adults enrolled in the ACA expansion group. 
4. Expansion group spending refers to spending for adults who have enrolled in Medicaid through the ACA's expansion of the program. 
5. N/A: Not applicable. State did not expand Medicaid as of September 2018. 
