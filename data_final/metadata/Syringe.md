**Meta Data Name**: Syringe Services Laws  
**Date Added**: Febrary 23, 2021  
**Author**: Qinyun Lin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Policy

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Variables were obtained from Table 1 (August 1, 2019) in [Fernández-Viña MH, Prood NE, Herpolsheimer A, Waimberg J, Burris S. State Laws Governing Syringe Services Programs and Participant Syringe Possession](https://journals.sagepub.com/doi/full/10.1177/0033354920921817), 2014-2019. Public Health Reports. 2020;135:128S-137S. doi:10.1177/0033354920921817

See **Comments/Notes** section below for where to find more detailed variables regarding syringe related policies. 

### Description of Data Processing: 
The following variables were included from the source data:
1. Law explicitly authorzies SSPs;
2. No state drug paraphernalia law;
3. State law does not prohibit free distribution of syringes;
4. Paraphernalia definition explicitly exludes objects used for injecting drugs;
5. Paraphernalia definition does not refer to objects used for injecting drugs;
6. No state law removing barriers or uncertainty as to SSP legality;

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Law explicitly authorzies SSPs | ExpSsp | Dummy variable indicating whether the state has law that explicitly authorizes Syringe Service Programs (0=no, 1=yes) | Latest | State |
| No state drug paraphernalia law | NoPrphLw | Dummy variable indicating whether the state has no state drug paraphernalia law (0=no, 1=yes) | Latest | State |
| State law does not prohibit free distribution of syringes | NtPrFrDsSy | Dummy variable indicating whether the state law does not prohibit free distribution of syringes (0=no, 1=yes) | Latest | State |
| Paraphernalia definition explicitly exludes objects used for injecting drugs | PrExcInj | Dummy variable indicating whether the paraphernalia definition in the state law explicitly exludes objects used for injecting drugs (0=no, 1=yes) | Latest | State |
| Paraphernalia definition does not refer to objects used for injecting drugs | PrNtRefInj | Dummy variable indicating whether the paraphernalia definition in the state law does not refer to objects used for injecting drugs (0=no, 1=yes) | Latest | State |
|  No state law removing barriers or uncertainty as to SSP legality | NoLwRmUnc | Dummy variable indicating whether the state has no law removing barriers or uncertainty as to SSP legality (0=no, 1=yes) | Latest | State |

### Data Limitations:
N/A

### Comments/Notes:
The variables included here are very high-level and for August 1, 2019. For more detailed and longitudinal data, we recommend the following datasets from LawAtlas: 
1. [Syringe Possesssion Laws from 2012 to 2017](https://lawatlas.org/datasets/paraphernalia-laws )
2. [Syringe Distribution Laws from 2012 to 2017](https://lawatlas.org/datasets/syringe-policies-laws-regulating-non-retail-distribution-of-drug-parapherna )
3. [Syringe Service Program Laws, 2019](https://lawatlas.org/datasets/syringe-services-programs-laws)
