**Meta Data Name**: COVID-19 Variables
**Author**: Qinyun Lin 
**Last Modified**: October 17, 2023
**Last Modified By**: Wataru Morioka
 

### Data Location: 
COVID01-04 - COVID case counts and rates at state and county spatial scales. Files can be found [here](/data_final/).

* COVID01_S: cumulative confirmed cases, state level
* COVID01_C: cumulative confirmed cases, county level
  
* COVID02_S: cumulative confirmed cases, per 100K ppl, state level
* COVID02_C: cumulative confirmed cases, per 100K ppl, county level
  
* COVID03_S: 7 day average confirmed cases, state level
* COVID03_C: 7 day average confirmed cases, county level
  
* COVID04_S: 7 day average confirmed cases, per 100K ppl, state level
* COVID04_C: 7 day average confirmed cases, per 100K ppl, county level

**Note:** Each .csv includes the full time series dataset, January 21, 2020 to March 3, 2021.

### Data Source(s) Description:  

Variables were obtained from [The New York Times](https://github.com/nytimes/covid-19-data). The Times has made data available aggregated from dozens of journalists working to collect and monitor data. Their journalists communicate with public officials to clarify and categorize cases.

Population data used to compute population-adjusted rates were obtained from the [2018 American Community Survey](https://data.census.gov/). 

### Description of Data Processing: 

Data was downloaded for the daily new cases. Then we calcuated cumulative cases and 7-day average cases, and adjusted by local populations. 

### Key Variable and Definitions:

For the example variable table below, note that all variable ID and descriptions are for the example date January 21, 2020. In the final dataset, each variable represents a different date in year-month-day format, i.e. 200121 for January 21, 2020. The data collected is from the first year of the pandemic from January 21, 2020 through March 3, 2021. 

| Variable | Variable ID in .csv | Description |
|:---------|:-------------|:-------------|
| Cumulative Case Count | Cm200121 | Cumulative confirmed case count for date (i.e. January 21, 2020) |
| Adjusted Case Count per 100K | CmAd200121 | Confirmed cases per 100K people for date |
| 7-Day Average Case Count | Wk200121 | 7-Day average confirmed cases for date |
| 7-Day Average Adjusted Case Count per 100K | WkAd200121 | 7-Day average adjusted cases per 100K ppl for date |

### Data Limitations:
As this dataset is sourced from The New York Times COVID-19 databse, estimates may differ slightly than data reported by the U.S. CDC.

### Comments/Notes:
**Note on missing data:** Missing and/or unavailable data are coded as blank/empty cells or _NA_.

Other sources for county and state level COVID-19 data: 

1. [USAFacts](https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/?utm_source=MailChimp&utm_campaign=census-covid2). This dataset is provided by a non-profit organization. The data are aggregated from the CDC, state- and local-level public health agencies. County-level data is confirmed by referencing state and local agencies directly.

2. [1P3A](https://coronavirus.1point3acres.com/en). This was the initial, crowdsourced data project that served as a volunteer project led by 1P3acres.com and Dr. Yu Gao, Head of Machine Learning Platform at Uber. 

3. Visualize this data and more on [The US COVID Atlas](https://theuscovidatlas.org/data), or download other COVID-related variables. 
