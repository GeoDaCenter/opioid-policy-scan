**Meta Data Name**: Foreclosure Rates & Mortgage Delinquencies  
**Last Modified**: January 27, 2021  
**Author**: Susan Paykin  

### Data Location: 
EC04 at 3 spatial scales. Final data can be found [here](/data_final).  
* EC04_T
* EC04_C
* EC04_S

### Data Source(s) Description:  

Foreclosure rate data was sourced from: [Neighborhood Stabilization Program (NSP2)](https://www.huduser.gov/portal/NSP2datadesc.html), U.S. Department of Housing and Urban Development (HUD), Office of Policy Development and Research, 2009. 

The [Neighborhood Stabilization Program (NSP)](https://www.huduser.gov/portal/datasets/NSP.html) was established for the purpose of providing emergency assistance to stabilize communities with high rates of abandoned and foreclosed homes, and to assist households whose annual incomes are up to 120 percent of the area median income (AMI). NSP2 was authorized under the American Recovery and Reinvestment Act of 2009. This data reflects 2007-2008 estimates. 

[NSP2 Data & Methodology](https://www.huduser.gov/portal/NSP2datadesc.html): The estimated rate of foreclosure problems do not reflect "real" numbers of foreclosures but rather reflect neighborhood characteristics that are estimated to have a high level of risk for foreclosure. HUD has developed these foreclosure estimates and foreclosure risk scores for Census tracts based on: 

* whether or not loans are high cost or highly leveraged in the census tract (see https://www.huduser.gov/periodicals/ushmc/summer08/summary.pdf),
* change in home values in the metropolitan area (or non-metropolitan portion of the state),
* the unemployment rate for the county in 2008, and
* change in unemployment in the county between 2007 and 2008.

These factors are extremely good predictors of foreclosure problems.

### Description of Data Source Tables:

The NSP2 dataset includes variables used to estimate census tract-level foreclosure risk scores, including estimated number of foreclosures, rate of foreclosures, vacancy rates, number of mortgages, type of mortgages, price changes, average unemployment, and change in unemployment. We selected

### Description of Data Processing: 

Foreclosure and delinquency data was wrangled and cleaned. Tract level estimates were aggregated (mean) up to county-level and state-level, and appropriate gegraphic boundary labels were selected for inclusion in final datasets. 

### Key Variable and Definitions:

| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| Foreclosure rate | fordq_rate | Estimated percent of mortgages to start foreclosure process or be seriously delinquent |

### Data Limitations:
The data reflects 2007-2008 estimates, before the Great Recession, but the data is correlated with 2018 trends. 

### Comments/Notes:
N/A
