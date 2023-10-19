**Meta Data Name**: Essential Jobs
**Author**: Moksha Menghaney & Qinyun Lin
**Last Modified**: October 18, 2023
**Last Modified By**: Wataru Morioka

### Data Location: 
EC02 at 4 spatial scales. Files can be found [here](/data_final).
* EC02_T  
* EC02_Z  
* EC02_C  
* EC02_S  

### Data Source(s) Description:  
Variables were obtained from the [2014 - 2018 American Community Survey (ACS)](https://data.census.gov), table S2401, at State, County, Tract and ZIP Code Tabulation Area (ZCTA) levels.  

The definition of "essential jobs" included in this dataset comes from [Chicago Metropolitan Agency for Planning (CMAP)](https://github.com/CMAP-REPOS/essentialworkers). 

### Description of Data Source Tables:
S2401 : Occupation by sex for the civilian employed population 16 years and over

### Description of Data Processing: 
All variables were included from S2401. The following variables were identified as essential workers for 2018:  

S2401_C01_011, S2401_C01_016, S2401_C01_017, S2401_C01_019, S2401_C01_021, S2401_C01_022, S2401_C01_023, S2401_C01_024, S2401_C01_030, S2401_C01_031, S2401_C01_032, S2401_C01_034, S2401_C01_035, S2401_C01_036

See [CMAP](https://github.com/CMAP-REPOS/essentialworkers) for a more detailed description of essential jobs. 

----------

* Percentage of population employed in Essential Jobs was calculated as:  

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
| % Essential Workers  | EssnWrkP | Percentage of Population Employed in Essential Occupations (outlined above) |

### Data Limitations:
Please note this dataset uses occupations as a classifier and doesn't include any information about the industry to which the job belongs. This can lead to an overestimation of essential workers category. 

### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as blank/empty cells or _NA_.
