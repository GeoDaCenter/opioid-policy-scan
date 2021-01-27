**Meta Data Name**: Foreclosure Rates, part of the Economic Factors dataset  
**Last Modified**: January 27, 2021 
**Author**: Susan Paykin  

### Data Location: 
EC04 - Policy Scan Environment Report. Final data can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).  
* EC04_T --> Census tract-level foreclosure rates from 2008 HUD Neighborhood Stabilization Program (NSP2) 
* EC04.1_C --> County-level mortgage delinquency rates, 2014-2018 mean
* EC04.1_S --> State-level mortgage delinquency rates, 2014-2018 mean

### Data Source(s) Description:  

##### Foreclosure: EC04
**Source:** [Neighborhood Stabilization Program (NSP2)](https://www.huduser.gov/portal/NSP2datadesc.html), U.S. Department of Housing and Urban Development, Office of Policy Development and Research.  

##### Delinquency, EC04.1
**Source:** [Mortgage Performance Trends](https://www.consumerfinance.gov/data-research/mortgage-performance-trends/), from the [National Mortgage Database](https://www.consumerfinance.gov/data-research/mortgage-performance-trends/about-the-data/), Consumer Financial Protection Bureau (CFPB).

The **90–day delinquency rate** is a measure of serious delinquencies. It captures borrowers that have missed three or more payments. This rate measures more severe economic distress. 

### Description of Data Source Tables:

##### Foreclosure: EC04
[HUD NSP2](https://www.huduser.gov/portal/NSP2datadesc.html): This file included variables used to estimate census tract -level risk scores, including estimated number of foreclosures, rate of foreclosures, vacancy rates, number of mortgages, type of mortgages, price changes, average unemployment, and change in unemployment. The data used in these estimates was 2007-2008.

##### Delinquency, EC04.1
[CFPB Mortgage Performance Trends](https://www.consumerfinance.gov/data-research/mortgage-performance-trends/):  These files included monthly 90+ day delinquency rate data aggregated by state and county, January 2008 - December 2018. 

### Description of Data Processing: 

##### Foreclosure: EC04
Foreclosure data was cleaned and appropriate variables selected for inclusion. 
  
##### Delinquency, EC04.1
Mean rate over 5-year period was calculated from monthtly rates from 2014-2018. 

### Key Variable and Definitions:

##### Foreclosure: EC04
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| GEOID | GEOID | Unique identifier for census tracts (11 digits)  |
| Foreclosure rate | fordq_rate | Estimated percent of mortgages to start foreclosure process or be seriously delinquent, 2007-2008 |
| Foreclosure risk score | nforeclose | Estimated rate of foreclosure, reflecting neighborhood characteristics determined to have a high level of fisk for foreclosure |


##### Delinquency, EC04.1
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
| FIPS code | FIPSCode | Unique identifier for states (3 digits) and counties (5 digits) |
| Delinquency rate | delinqR | Rate of mortgages 90+ days delinquent |

### Data Limitations:
While the NSP2 foreclosure data is from 2008, the data is correlated with current health and economic outcomes. 

### Comments/Notes:

