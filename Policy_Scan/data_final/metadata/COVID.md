**Meta Data Name**: COVID variables
**Last Modified**: March 12th, 2021  
**Author**: Qinyun Lin  

### Data Location: 
COVID01-04 - COVID cases and rates at state and county levels. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).

* COVID01_S: cumulative confirmed cases, state level
* COVID01_C: cumulative confirmed cases, county level
* COVID02_S: cumulative confirmed cases, per 100K ppl, state level
* COVID02_C: cumulative confirmed cases, per 100K ppl, county level
* COVID03_S: 7 day average confirmed cases, state level
* COVID03_C: 7 day average confirmed cases, county level
* COVID04_S: 7 day average confirmed cases, per 100K ppl, state level
* COVID04_C: 7 day average confirmed cases, per 100K ppl, county level


### Data Source(s) Description:  
Variables were obtained from [New York Times](https://github.com/nytimes/covid-19-data). The New York Times has made data available aggregated from dozens of journalists working to collect and monitor data from new conferences. They communicate with public officials to clarify and categorize cases.
Population data are obtained from ACS 2018. 

### Description of Data Processing: 
We download the daily new cases reported from New York Times. Then we calcuated cumulative cases and 7 day average cases, and adjusted by local population.

### Key Variable and Definitions:
| Variable | Variable ID in .csv (one day as example) | Description (for the example day) |
|:---------|:-------------|:-------------|
| cumulative confirmed cases | Cm200121 | cumulative confirmed case for 2020-01-21 |
| cumulative confirmed cases, per 100K ppl | CmAd200121 | cumulative confirmed cases, per 100K ppl for 2020-01-21 |
| 7 day average confirmed cases | Wk200121 | 7 day average confirmed cases for 2020-01-21 |
| 7 day average confirmed cases, per 100K ppl | WkAd200121 | 7 day average confirmed cases per 100K ppl for 2020-01-21 |
Note that each .csv includes a full-time series for one variable.

### Data Limitations:
The data may be different from what is reported from CDC. 

### Comments/Notes:
Other soruces for county and state level covid data: 

1. [USAFacts](https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/?utm_source=MailChimp&utm_campaign=census-covid2).This dataset is provided by a non-profit organization. The data are aggregated from CDC, state- and local-level public health agencies. County-level data is confirmed by referencing state and local agencies directly.

2. [1P3A](https://coronavirus.1point3acres.com/en).This was the initial, crowdsourced data project that served as a volunteer project led by 1P3acres.com and Dr. Yu Gao, Head of Machine Learning Platform at Uber. 

3. One can also explore [the Data Page of our US COVID Atlas](https://theuscovidatlas.org/data) to download other covid related variables. 