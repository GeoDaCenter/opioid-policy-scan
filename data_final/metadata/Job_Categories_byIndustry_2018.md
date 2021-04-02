**Meta Data Name**: Jobs by Industries  
**Last Modified**: October 22, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
EC01 at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* EC01_T  
* EC01_Z  
* EC01_C  
* EC01_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table S2403, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
S2403 : Industry by sex for the civilian employed population 16 years and over 

### Description of Data Processing: 
All variables were included from S2403 (2018):

* High risk of injury jobs - S2403_C01_003, S2403_C01_004, S2403_C01_005, S2403_C01_006, and S2403_C01_011  
* Education jobs - S2403_C01_021 
* Health care jobs - S2403_C01_022  
* Retail jobs - S2403_C01_008  
* 
----------
* Percentage of population employed in High Risk of Injury Jobs was calculated as : 
*Sum of the workers employed in (<br> 
		- Agriculture, forestry, fishing and hunting, <br>
		- Mining, quarrying, and oil and gas extraction,<br>
		- Construction,<br>
		- Manufacturing,<br>
		- Utilities) / (Total Civilian employed population 16 years and over)*

* Percentage of population employed in Educations Jobs was calculated as : <br>
*Sum of the workers employed in Educational services / (Total Civilian employed population 16 years and over)*
	
* Percentage of population employed in HealthCare Jobs was calculated as : <br>
*Sum of the workers employed in Health care and social assistance/ (Total Civilian employed population 16 years and over)*

* Percentage of population employed in Retail Jobs was calculated as : <br>
*Sum of the workers employed in Retail trade / (Total Civilian employed population 16 years and over)* 
        
### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % High Risk of Injury Jobs  | hghRskP | Percentage of population employed in following industries: agriculture, rorestry, fishing and hunting, mining, quarrying,  oil and gas extraction, construction, manufacturing, utilities |
| % Education Jobs  | eduP | Percentage of population employed in educational services industry |
| % Health Care Jobs | hltCrP | Percentage of population employed in health care and social assistance industries |
| % Retail Jobs  | retailP | Percentage of population employed in retail trade industry |

### Data Limitations:
Please note this dataset uses industry as a classifier and does not include any information about the specific occupation in that industry. This could lead to an overestimation of High Risk to Injury workers category.

### Comments/Notes:
n/a
