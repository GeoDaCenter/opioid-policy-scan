**Meta Data Name**: 2018 Job Category variables, part of the Economic Factors dataset  
**Last Modified**: October 22nd, 2020  
**Author**: Moksha Menghaney  

**Qinyun Lin updated on March 2nd, 2021. Slight changes to what to be included, using definition by [CMAP](https://github.com/CMAP-REPOS/essentialworkers). 

### Data Location: 
EC02 - Policy Scan Environment Report at 4 spatial scales. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).
* EC02_T  
* EC02_Z  
* EC02_C  
* EC02_S  

### Data Source(s) Description:  
Variables were obtained from the 2014 - 2018 American Community Survey (ACS), table S2401, at State, County, Tract and ZIP Code Tabulation Area level. Raw data and more details can be found at https://data.census.gov.

### Description of Data Source Tables:
S2401 : Occupation by sex for the civilian employed population 16 years and over

### Description of Data Processing: 
All variables were included from S2401.

----------
* Percentage of population employed in Essential Jobs was calculated as :
	*Sum of the workers employed in (<br> 
                 - Community and social service occupations, <br>
                 - Health diagnosing and treating practitioners, Health technologists and technicians, and other technical occupations,<br>
                 - Healthcare support occupations,<br>
                 - Protective service occupations,<br>
                 - Food preparation and serving related occupations,<br>
                 - Building and grounds cleaning and maintenance occupations,<br>
                 - Farming, fishing, and forestry occupations,<br>
                 - Construction and extraction occupations,<br>
                 - Installation, maintenance, and repair occupations,<br>
                 - Production, <br>
                 - Transportation and material moving occupations) / (Total Civilian employed population 16 years and over)*

        
### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| % Essential Workers  | essnWrkP | Percentage of Population Employed in occupations outlined above |

### Data Limitations:
Please note this dataset uses occupations as a classifier and doesn't include any information about the industry to which the job belongs. This can lead to an overestimation of essential workers category. 

### Comments/Notes:
Using the API, following variables from table S2401 were identified as essential workers for 2018 - S2401_C01_011, S2401_C01_016, S2401_C01_017, S2401_C01_019, S2401_C01_021, S2401_C01_022, S2401_C01_023, S2401_C01_024, S2401_C01_030, S2401_C01_031, S2401_C01_032, S2401_C01_034, S2401_C01_035, S2401_C01_036.
Also, see [CMAP](https://github.com/CMAP-REPOS/essentialworkers) for more detailed description. 
