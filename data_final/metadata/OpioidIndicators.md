**Meta Data Name**: Opioid Indicators: Prescription and Mortality Rates  
**Date Added**: February 1, 2021  
**Author**: Susan Paykin, Wataru Morioka. Mahjabin Kabir Adrita   
**Date Last Modified**: May 12, 2025  
**Last Modified By**: Wataru Morioka. Mahjabin Kabir Adrita  

### Theme: 
Outcome

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  

Opioid indicators -- opioid prescription rates and drug overdose mortality rates --  were sourced from [HepVu](https://hepvu.org/data-methods/). 

For the **county** dataset, the two indicators are overdose mortality rate during 2014-2020 and opioid prescription rate in 2020.

*From HepVu:* County-level data on drug overdose mortality were obtained from the “[CDC’s National Center for Health Statistics](https://www.cdc.gov/nchs/data-visualization/drug-poisoning-mortality/)” and National Vital Statistics System (NVSS). Data from NVSS classified drug overdose death using International Classification of Diseases, Tenth Revision codes: X40–X44 (unintentional), X60–X64 (suicide), X85 (homicide), or Y10–Y14 (undetermined intent).

The opioid prescriptions rate data for 2020 for all U.S. counties were obtained from the “[CDC’s National Center for Injury Prevention and Control](https://www.cdc.gov/drugoverdose/rxrate-maps/index.html)”. CDC derived the data from the IQVIA Transactional Data Warehouse to obtain the number of opioid prescriptions dispensed in the U.S. via retail. Please see the full CDC report for more details.

For the **state** dataset, the three indicators are overdose mortality rate during 2014-2020, opioid prescription rate in 2020, and pain reliever misuse prevalence during 2019-2020.

*From HepVu:* State-specific data for overdose mortality rates were obtained from the CDC injury center and the NVSS. Deaths were classified using the International Classification of Diseases, Tenth Revision. Drug overdose deaths were identified using underlying cause-of-death codes X40–X44, X60–X64, X85, or Y10–Y14. Rates are age-adjusted using the 2000 U.S. standard population, except for age-specific crude rates. All rates are per 100,000 population.

The opioid prescription rate data were obtained from the CDC injury center. The rates of opioid prescription dispensed per 100 persons by dosage, type, and state data were collected from U.S. Opioid Dispensing Rate Maps, 2020. CDC derived the data from the IQVIA Transactional Data Warehouse to obtain the number of opioid prescriptions dispensed in the U.S. via retail. Please see the full CDC “[injury center drug overdose website](https://www.cdc.gov/drugoverdose/).” for more details.

Pain reliever misuse data were obtained from a report produced by the Substance Abuse and Mental Health Service Administration (SAMHSA). The data come from Table 12, “Prescription Pain Reliever Misuse in the Past Year,” in the report, “2019-2020 National Survey on Drug Use and Health: Model-Based Prevalence Estimates (50 States and the District of Columbia).” The data are a yearly average of the 2019 and 2020 data collected in the National Survey on Drug Use and Health. Misuse was described as anyone 12 and older using a prescription psychotherapeutic drug in any way not directed by a doctor and does not include over-the-counter drugs. Please see the full SAMHSA report for more details.

For more information, see [HepVu's Data Methods](https://hepvu.org/data-methods/). 

### Description of Data Processing: 

Data was cleaned and variables were renamed to shorter, abbreviated labels. The average drug overdose mortality rate variable (*OdMortRtAv*) was calculated by taking the 5-year average from 2015 to 2019).

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Opioid prescription rate | OpRxRt | Opioid prescription rate in a specific year | 2020, 2022 | County, State |
| Overdose mortality rate | OdMortRt | Death of persons from narcotic overdose per 100,000 persons from individual years 2014-2022 | 2020, 2022 | County, State |
| Average overdose mortality rate | OdMortRtAv | Average narcotic overdose mortality rates from 2015-2019 | 2015-2019 | County, State |
| Pain reliever misuse percent | PrMsuseP | Percent of persons who self-report misusing prescription pain relief medication in a specific year | 2020, 2022 | State |

### Data Limitations:
Note that pain reliever misuse data is only available for State-level data. Overdose mortality data for county level is vailable for 2021.

### Comments/Notes:
No additional comments at this time. 
