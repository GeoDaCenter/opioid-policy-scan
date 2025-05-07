Meta Data Name: Educational Attainment Variables  
Date Added: May 5, 2025  
Authors: Mahjabin Kabir Adrita 
Date Last Modified: May 5, 2025  
Last Modified By: Mahjabin Kabir Adrita

---

### Theme:  
Education – Levels of Educational Attainment

---

### Data Location:  
You can find the variables described in this document in the CSV files here.

CSV files are organized by year and spatial scale. For example, county-level variables from 2020 will be found in `C_2020.csv`.  
**Note:** Every variable can be found in the **Latest** files.

---

### Data Source(s) Description:  
Variables were obtained from the *American Community Survey (ACS)* 5-Year Estimates, using table B15003 and related education summary tables for the years 2020 and 2023.

The ACS provides detailed information about educational attainment at multiple geographic scales including tract, county, and ZIP Code Tabulation Area (ZCTA).

---

### Description of Data Source Tables:  
**Table B15003:** Educational Attainment for the Population 25 Years and Over

This table includes the number and percent of people aged 25 years and older who have completed various levels of education, from no formal education to graduate or professional degrees.

---

### Description of Data Processing:  
- Percentages represent the proportion of the population 25 years and over with a specified level of education.  
- Some variables are reported as counts (e.g., total with high school or higher).  
- Estimates are rounded to two decimal places where applicable.  
- Calculations are based on total educational attainment population, excluding those under 25.

---

### Key Variable and Definitions:

| Variable                           | Variable ID in .csv | Description                                                       | Years Available | Spatial Scale        |
|------------------------------------|---------------------|-------------------------------------------------------------------|------------------|-----------------------|
| Bachelor's degree or higher        | BachelorsP          | Percent of population with a Bachelor’s degree                    | 2020, 2023       | Tract, County, ZCTA   |
| High school graduate               | EduHsP              | Percent with high school diploma or equivalent                    | 2020, 2023       | Tract, County, ZCTA   |
| Less than 9th grade               | Eduless9P           | Percent with less than a 9th grade education                      | 2020, 2023       | County only           |
| No high school diploma             | EduNoHsP            | Percent without a high school diploma                            | 2020, 2023       | Tract, County, ZCTA   |
| Graduate or professional degree    | GradSclP            | Percent with graduate or professional degree                      | 2020, 2023       | Tract, County, ZCTA   |
| Total with HS or higher            | HsdTot              | Total number with high school or higher education                 | 2020, 2023       | Tract, County, ZCTA   |
| Some college, no degree            | SomeCollegeP        | Percent with some college education but no degree                 | 2020, 2023       | Tract, County, ZCTA   |

---

### Data Limitations:  
- Only individuals aged 25 years or older are included in these statistics.  
- Percentages may not sum to 100% due to rounding or individuals falling into excluded categories (e.g., GED vs diploma).  
- ZCTA data may be unavailable or unstable for very small populations.  
- County-level data for some variables (e.g., Eduless9P) may not exist at tract or ZCTA scales.

---

### Comments/Notes:  
See the [ACS Subject Definitions](https://www.census.gov/programs-surveys/acs/technical-documentation/code-lists.html) for more information on education variable definitions and data processing methodology.
