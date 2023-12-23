**Meta Data Name**: Opioid Indicators: Prescription and Mortality Rates  
**Author**: Susan Paykin  
**Last Modified**: December 22, 2023  
**Last Modified By**: Wataru Morioka  

### Theme: 
Outcome  

### Data Location: 
Latest - Opioid indicators, including opioid prescription rates and drug overdose mortality rates, available at state and county scales. Files can be found [here](../full_tables).
* S_Latest.csv
* T_Latest.csv

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
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Opioid prescription rate | OpRxRt20 | Opioid prescription rate in 2020 |
| Pain reliever misuse percent | PrMsuse20P | Percent of persons who self-report misusing prescription pain relief medication in 2020 |
| Overdose mortality rate | OdMortRt | Death of persons from narcotic overdose per 100,000 persons from individual years 2014-2020 |
| Average overdose mortality rate | OdMortRtAv | Average overdose mortality rates from 2015-2019 |

### Data Limitations:
Note that pain reliever misuse data is only available for State-level data. 

### Comments/Notes:
No additional comments at this time. 
