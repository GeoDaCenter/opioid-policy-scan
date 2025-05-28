**Meta Data Name**: Good Samaritan Laws  
**Date Added**: January 7, 2021  
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
Variables were obtained from RAND-USC Schaeffer Opioid Policy Tools and Information Center, 2021, [OPTIC-Vetted Good Samaritan Policy Data](https://www.rand.org/health-care/centers/optic/resources/datasets.html).  Raw data is downloaded in the [data_raw](https://github.com/GeoDaCenter/opioid-policy-scan/tree/v1.0/data_raw) folder, named as *WEB_GSL.xlsx*. 

### Description of Data Processing: 
The following variables were included from the source data:
1. Any Good Samaritan Law starting date;
2. Good Samaritan Law protecting arrest starting date;
3. Any Good Samaritan Law fraction;
4. Good Samaritan Law protecting arrest fraction.

Fractions are calculated based on the number of months that a law is effective out of the 12 months in a year. A law is considered effective for a given month if a law becomes effective by the 7th for January, or if it becomes effective by the 3rd for February – December.

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Any Good Samaritan Law start date | AnyGslDt | Date (DMY) any type of Good Samaritan Law is effective | 2018, 2021 | State |
| Good Samaritan Law Protecting Arrest starting date | GslArrDt | Date (DMY) that Good Samaritan Law providing protection from arrest for controlled substance possession laws is effective | 2018, 2021 | State |
| Any Good Samaritan Law fraction | AnyGslFr | Fraction of year any type of Good Samaritan Law is effective | 2018, 2021 | State |
| Good Samaritan Law Protecting Arrest fraction | GslArrFr | Fraction of year that Good Samaritan Law providing protection from arrest for controlled substance possession laws is effective | 2018, 2021 | State |

### Data Limitations:
N/A

### Comments/Notes:
Specific dimensions of Good Samaritan policy data included in this public version of the data are based on a review of relevant protections granted through different variations of these laws as described in:
* Davis, C. S., & Carr, D. (2015). Legal changes to increase access to naloxone for opioid overdose
reversal in the United States. *Drug and alcohol dependence*, *157*, 112-120.
* Davis, C., & Carr, D. (2017). State legal innovations to encourage naloxone dispensing. *Journal of the American Pharmacists Association*, *57*(2), S180-S184. 
