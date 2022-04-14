**Meta Data Name**: Opioid Indicators: Prescription and Mortality Rates  
**Last Modified**: April 13, 2022  
**Author**: Susan Paykin  


### Data Location: 
Health04 - Opioid indicators, including prescription and mortality rates, available at state and county scales. Files can be found [here](/data_final).
* Health04_S
* Health04_C

### Data Source(s) Description:  

Opioid indicators -- opioid prescription rates and overdose rates --  were sourced from [HepVu](https://hepvu.org/data-methods/). 

For the **county** dataset, the two indicators are overdose mortality rate during 2014-2018 and opioid prescription rate in 2018.

*From HepVu:* County-level data on drug overdose mortality were obtained from [“Describing the changing relationship between opioid prescribing rates and overdose mortality: A novel county-level metric”](https://www.sciencedirect.com/science/article/pii/S0376871621002568)  and National Vital Statistics System (NVSS). Data from NVSS classified drug overdose death using International Classification of Diseases, Tenth Revision codes: X40-X44, X60-X64, X85, and Y10-Y14.

The opioid prescriptions rate data from 2014 to 2018 for all U.S. counties were obtained from the [CDC’s National Center for Injury Prevention and Control](https://www.cdc.gov/drugoverdose/rxrate-maps/index.html). CDC derived the data from the IQVIA Transactional Data Warehouse to obtain the number of opioid prescriptions dispensed in the U.S. via retail. Please see the full CDC report for more details.

For the **state** dataset, the three indicators are overdose mortality rate during 2014-2019, opioid prescription rate in 2019, and pain reliever misuse prevalence during 2018-2019.

*From HepVu:* State-specific data for overdose mortality rates were obtained from the CDC injury center and the NVSS. Deaths were classified using the International Classification of Diseases, Tenth Revision. Drug overdose deaths were identified using underlying cause-of-death codes X40–X44, X60–X64, X85, and Y10–Y14. Rates are age-adjusted using the 2000 U.S. standard population, except for age-specific crude rates. All rates are per 100,000 population.

The opioid prescription rate data were obtained from the CDC report, “[2019 Annual Surveillance Report of Drug-Related Risks and Outcomes](https://www.cdc.gov/drugoverdose/pdf/pubs/2019-cdc-drug-surveillance-report.pdf).” Data were collected from Table 1C reporting “Rates of opioid prescription dispensed per 100 persons by dosage, type, and state – United States, 2018.” CDC derived the data from the IQVIA Transactional Data Warehouse to obtain the number of opioid prescriptions dispensed in the U.S. via retail. Please see the full CDC report for more details.

Pain reliever misuse data were obtained from a report produced by the Substance Abuse and Mental Health Service Administration (SAMHSA). The data come from Table 11, “Pain Reliever Misuse in the Past Year,” in the report, “[2018-2019 National Survey on Drug Use and Health: Model-Based Prevalence Estimates (50 States and the District of Columbia)](https://www.samhsa.gov/data/sites/default/files/reports/rpt32805/2019NSDUHsaeExcelPercents/2019NSDUHsaeExcelPercents/2019NSDUHsaePercents.pdf).” The data are a yearly average of the 2018 and 2019 data collected in the National Survey on Drug Use and Health. Misuse was described as anyone 12 and older using a prescription psychotherapeutic drug in any way not directed by a doctor and does not include over-the-counter drugs. Please see the full SAMHSA report for more details.

For more information, see [HepVu's Data Methods](https://hepvu.org/data-methods/). 

### Description of Data Processing: 

Data was cleaned and variables were renamed to shorter, abbreviated labels. The average overdose mortality rate variable (*odMortRtAv*) was calculated by taking the average of all available years of overdose death rates (2014-2018 for County; 2014-2019 for State).

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Opioid prescription rate | opPrscRt | Opioid prescription rate 2018 (County) and 2019 (State)  |
| Overdose mortality rate | odMortRt | Annual overdose mortality rates from individual years 2014-2018 (County) and 2014-2019 (State) |
| Average opioid mortality rate  | odMortRtAv | Average overdose mortality rates from 2014-2018 (County) and 2014-2019 (State)  |
| County FIPS  | COUNTYFP | 5-digit unique county geoidentifier FIPS code |
| County name | cnty_name | Count name |
| State FIPS | STATEFP | 2-digit unique state geoidentifier FIPS code |
| State abbreviation | st_abb | State abbreviation |

### Data Limitations:
Note that 2019 overdose mortality rates were only available for State-level data. 

### Comments/Notes:
No additional comments at this time. 