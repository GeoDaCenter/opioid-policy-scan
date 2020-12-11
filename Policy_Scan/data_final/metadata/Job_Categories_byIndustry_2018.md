**Meta Data Name**: 2018 Job Category variables, part of the Economic Factors dataset  
**Last Modified**: October 22nd, 2020  
**Author**: Moksha Menghaney  

### Data Location: 
EC01 - Policy Scan Environment Report at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* EC01_T  
* EC01_Z  
* EC01_C  
* EC01_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table S2403, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
S2403 : Industry by sex for the civilian employed population 16 years and over 

### Description of Data Processing: 
All variables were included from S2403.

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
| % High Risk of Injury Jobs  | hghRskP | Percentage of Population Employed in following Industries : Agriculture, forestry, fishing and hunting, Mining, quarrying, and oil and gas extraction, Construction, Manufacturing, Utilities |
| % Education Jobs  | eduP | Percentage of Population Employed in Educational services Industry |
| % Health Care Jobs | hltCrP | Percentage of Population Employed in Health care and social assistance Industry |
| % Retail Jobs  | retailP | PPercentage of Population Employed in Retail trade Industry|

### Data Limitations:
Please note this dataset uses industry as a classifier and doesn't include any information about the specific occupation in that industry. This can lead to an overestimation of High Risk to Injury workers category.

### Comments/Notes:
Using the API, following variables from table S2403 were identified as 

* High Risk of Injury jobs for 2018 - S2403_C01_003, S2403_C01_004, S2403_C01_005, S2403_C01_006, and S2403_C01_011  
* Education jobs for 2018 - S2403_C01_021 
* Health Care jobs for 2018 - S2403_C01_022  
* Retail jobs for 2018 - S2403_C01_008  
