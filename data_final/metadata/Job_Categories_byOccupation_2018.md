**Meta Data Name**: Essential Jobs  
**Date Added**: October 22, 2020  
**Author**: Moksha Menghaney & Qinyun Lin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Economic  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

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

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Count of Essential Workers | EssnWrkE | Estimated count of Population Employed in Essential Occupations (outlined above) | Latest | Tract, Zip, County, State |
| % Essential Workers  | EssnWrkP | Percentage of Population Employed in Essential Occupations (outlined above) | Latest | Tract, Zip, County, State |

### Data Limitations:
Please note this dataset uses occupations as a classifier and doesn't include any information about the industry to which the job belongs. This can lead to an overestimation of essential workers category. 

### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as blank/empty cells or _NA_.
