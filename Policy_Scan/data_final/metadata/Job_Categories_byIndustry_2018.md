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
S2403 : INDUSTRY BY SEX FOR THE CIVILIAN EMPLOYED POPULATION 16 YEARS AND OVER table 

### Description of Data Processing: 
All variables were included from S2403.

Percentage of population employed in High Risk of Injury Jobs was calculated as : 
	* Sum of the workers employed in (Agriculture, forestry, fishing and hunting,
	* 						 		  Mining, quarrying, and oil and gas extraction,
	* 						 		  Construction,
	* 						 		  Manufacturing,
	* 						 		  Utilities) / (Total Civilian employed population 16 years and over)*

Percentage of population employed in Educations Jobs was calculated as : 
	* Sum of the workers employed in (Educational services) / (Total Civilian employed population 16 years and over)*
	
Percentage of population employed in HealthCare Jobs was calculated as : 
	* Sum of the workers employed in (Health care and social assistance) / (Total Civilian employed population 16 years and over)*

Percentage of population employed in Retail Jobs was calculated as : 
    * Sum of the workers employed in (Retail trade) / (Total Civilian employed population 16 years and over)* 
        
### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % High Risk of Injury Jobs  | hghRskP | Percentage of Population Employed in following Industries : Agriculture, forestry, fishing and hunting, Mining, quarrying, and oil and gas extraction, Construction, Manufacturing, Utilities |
| % Education Jobs  | eduP | Percentage of Population Employed in Educational services Industry |
| % Health Care Jobs | hltCrP | Percentage of Population Employed in Health care and social assistance Industry |
| % Retails Jobs  | retailP | PPercentage of Population Employed in Retail trade Industry|

### Data Limitations:
n/a

### Comments/Notes:
n/a
