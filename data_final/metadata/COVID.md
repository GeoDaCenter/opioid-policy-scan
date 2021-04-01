**Meta Data Name**: COVID variables
**Last Modified**: March 12th, 2021  
**Author**: Qinyun Lin  

### Data Location: 
COVID01-04 - COVID case counts and rates at state and county levels. Files can be found [here](https://github.com/GeoDaCenter/opioid-policy-scan/tree/master/Policy_Scan/data_final).

* COVID01_S: cumulative confirmed cases, state level
* COVID01_C: cumulative confirmed cases, county level
* COVID02_S: cumulative confirmed cases, per 100K ppl, state level
* COVID02_C: cumulative confirmed cases, per 100K ppl, county level
* COVID03_S: 7 day average confirmed cases, state level
* COVID03_C: 7 day average confirmed cases, county level
* COVID04_S: 7 day average confirmed cases, per 100K ppl, state level
* COVID04_C: 7 day average confirmed cases, per 100K ppl, county level

* **Note:** Each .csv includes a full-time series for one variable.

### Data Source(s) Description:  
Variables were obtained from [The New York Times](https://github.com/nytimes/covid-19-data). The Times has made data available aggregated from dozens of journalists working to collect and monitor data from new conferences. They communicate with public officials to clarify and categorize cases.
Population data used to compute population-adjusted rates are obtained from the [2018 American Comnmunity Survey](https://data.census.gov/). 

### Description of Data Processing: 
Data was downloaded for the daily new cases reported by *The New York Times*. Then we calcuated cumulative cases and 7-day average cases, and adjusted by local populations. 

### Key Variable and Definitions:

For the example variable table below, note that all variable ID and descriptions are for the example date January 21, 2020. In the final dataset, each variable represents a different date in year-month-day format, i.e. 200121 for January 21, 2020. The data collected is from the first year of the pandemic, roughly January 21, 2020 through March 3, 2021. 

| Variable | Variable ID in .csv | Description |
|:---------|:-------------|:-------------|
| Cumulative Case Count | Cm200121 | Cumulative confirmed case count for date (January 21, 2020) |
| Adjusted Case Count per 100K | CmAd200121 | Confirmed cases per 100K people for date |
| 7-Day Average Case Count | Wk200121 | 7-Day average confirmed cases for date |
| 7-Day Average Adjusted Case Count per 100K | WkAd200121 | 7-Day average adjusted cases per 100K ppl for date |

### Data Limitations:
This data may differ slightly than official data reported by the CDC.

### Comments/Notes:
Other soruces for county and state level covid data: 

1. [USAFacts](https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/?utm_source=MailChimp&utm_campaign=census-covid2).This dataset is provided by a non-profit organization. The data are aggregated from the CDC, state- and local-level public health agencies. County-level data is confirmed by referencing state and local agencies directly.

2. [1P3A](https://coronavirus.1point3acres.com/en).This was the initial, crowdsourced data project that served as a volunteer project led by 1P3acres.com and Dr. Yu Gao, Head of Machine Learning Platform at Uber. 

3. Visualize this data and more on the [US COVID Atlas](https://theuscovidatlas.org/data), and download other COVID-related variables. 
