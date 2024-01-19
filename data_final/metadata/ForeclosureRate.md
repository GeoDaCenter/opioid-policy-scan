**Meta Data Name**: Foreclosure Rates & Mortgage Delinquencies  
**Date Added**: January 27, 2021  
**Author**: Susan Paykin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka  

### Theme: 
Economic  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  

Foreclosure rate data was sourced from: [Neighborhood Stabilization Program (NSP2)](https://www.huduser.gov/portal/NSP2datadesc.html), U.S. Department of Housing and Urban Development (HUD), Office of Policy Development and Research, 2009. 

The [Neighborhood Stabilization Program (NSP)](https://www.huduser.gov/portal/datasets/NSP.html) was established for the purpose of providing emergency assistance to stabilize communities with high rates of abandoned and foreclosed homes, and to assist households whose annual incomes are up to 120 percent of the area median income (AMI). NSP2 was authorized under the American Recovery and Reinvestment Act of 2009. This data reflects 2007-2008 estimates. 

From [NSP2 Data and Methodology](https://www.huduser.gov/portal/NSP2datadesc.html): The estimated rate of foreclosure problems do not reflect "real" numbers of foreclosures but rather reflect neighborhood characteristics that are estimated to have a high level of risk for foreclosure. HUD has developed these foreclosure estimates and foreclosure risk scores for Census tracts based on: 

* whether or not loans are high cost or highly leveraged in the census tract (see [here](https://www.huduser.gov/periodicals/ushmc/summer08/summary.pdf)),
* change in home values in the metropolitan area (or non-metropolitan portion of the state,
* the unemployment rate for the county in 2008, and
* change in unemployment in the county between 2007 and 2008.

These factors are extremely good predictors of foreclosure problems.

### Description of Data Source Tables:

The NSP2 dataset includes variables used to estimate census tract-level foreclosure risk scores, including estimated number of foreclosures, rate of foreclosures, vacancy rates, number of mortgages, type of mortgages, price changes, average unemployment, and change in unemployment. We selected

### Description of Data Processing: 

Foreclosure and delinquency data was wrangled and cleaned. Tract level estimates were aggregated (mean) up to county-level and state-level, and appropriate geographic boundary labels were selected for inclusion in final datasets. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Foreclosure or delinquency rate | ForDqP | Estimated percent of mortgages to start foreclosure process or be seriously delinquent during the 2008 Recession | Latest | Tract, County, State |
| Foreclosure or delinquency count | ForDqTot | Estimated number of mortgages to start foreclosure process or be seriously delinquent during the 2008 Recession | Latest | Tract, County, State |

### Data Limitations:
The data reflects 2007-2008 estimates. Note again, via [NSP2 Data and Methodology](https://www.huduser.gov/portal/NSP2datadesc.html): The estimated rate of foreclosure problems do not reflect "real" numbers of foreclosures but rather reflect neighborhood characteristics that are estimated to have a high level of risk for foreclosure. 

### Comments/Notes:
For more recent county, state, and metro area data on mortgage delinquencies, see [Mortgage Performance Trends](https://www.consumerfinance.gov/data-research/mortgage-performance-trends/) data from the U.S. Consumer Financial Protection Bureau. 
