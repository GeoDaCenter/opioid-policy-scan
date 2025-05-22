**Meta Data Name**: Household Type  
**Date Added**  November 15, 2021  
**Author**: Susan Paykin, Wataru Morioka, Mahjabin Kabir Adrita  
**Date Last Modified**: May 12, 2025  
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita

### Theme: 
Social

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files. 

### Data Source(s) Description:  
Data was sourced from the American Community Survey, 2018 5-year average, Table  B09019: *Household Type (Including Living Alone) by Relationship*, at the state, county, tract and ZIP Code Tabulation Area (ZCTA) scales, available from the [US Census Bureau](https://data.census.gov/cedsci/table?q=B09019&g=0100000US%240400000&tid=ACSDT5Y2018.B09019).  Complete data documentation for this table is available via [Social Explorer](https://www.socialexplorer.com/data/ACS2018_5yr/metadata/?ds=ACS18_5yr&var=B09019001). Data here was accessed through the [tidycensus](https://walker-data.com/tidycensus/index.html) R package, which uses the US Census Bureau's API. 

### Description of Data Source Table:
B09019 : HOUSEHOLD TYPE (INCLUDING LIVING ALONE) BY RELATIONSHIP.

The following variables were selected from Table B09019:
* B09019_001E - Total population 
* B09019_002E - Total population in households
* B09019_003E - Total population in family households
* B09019_018E - Total nonrelatives in family households
* B09019_032E - Total nonrelatives in non-family households

From Social Explorer's [Table B09019 Data Dictionary](https://www.socialexplorer.com/data/ACS2018_5yr/metadata/?ds=ACS18_5yr&var=B09019001): 

**Household**: A household includes all the people who occupy a housing unit. (People not living in households are classified as living in group quarters.) A housing unit is a house, an apartment, a mobile home, a group of rooms, or a single room that is occupied (or if vacant, is intended for occupancy) as separate living quarters. Separate living quarters are those in which the occupants live separately from any other people in the building and which have direct access from the outside of the building or through a common hall. The occupants may be a single family, one person living alone, two or more families living together, or any other group of related or unrelated people who share living arrangements.

**Family Households vs. Non-family Households**: A family consists of a householder and one or more other people living in the same household who are related to the householder by birth, marriage, or adoption. All people in a household who are related to the householder are regarded as members of his or her family. A family household may contain people not related to the householder, but those people are not included as part of the householder's family in tabulations. Thus, the number of family households is equal to the number of families, but family households may include more members than do families. A household can contain only one family for purposes of tabulations. Not all households contain families since a household may be comprised of a group of unrelated people or of one person living alone - these are called nonfamily households. Families are classified by type as either a "married- couple family" or "other family" according to the sex of the householder and the presence of relatives. The data on family type are based on answers to questions on sex and relationship that were asked of all people.

### Description of Data Processing: 
The following rates were calculated from the variables: 

* % Nonrelatives in family households = *Total nonrelatives in family households / Total population in family households*
* % Nonrelatives in non-family households = *Total nonrelatives in non-family households / Total population in non-family households*

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Total population | TotPop | Estimated total population in the geographic area | 1980, 1990, 2000, 2010, 2018, 2023 | Tract, Zip*, County, State |
| Total population in household | TotPopHh | Total number of people in households | 2018 | Tract, Zip, County, State |
| Percent of nonrelatives in family households | NonRelFhhP | Percent of people living in family households that are not related to family | 2018 | Tract, Zip, County, State |
| Percent of nonrelatives in non-family households | NonRelNfhhP | Percent of people living in non-family households that are not related | 2018 | Tract, Zip, County, State |
| Average family size              | FamSize             | Average number of persons per family                       | 2018, 2023           | Tract, ZCTA, County    |
| Average household size           | HHSize              | Average number of persons per household                    | 2018, 2023           | Tract, ZCTA, County    |
| Total households            | HsdTot              | Total households                 | 2020, 2023       | Tract, County, ZCTA   |
| Crowded Housing             | CrowdHsng         | Proportion of occupied housing units that are considered crowded (more than 1 person per room)           | 2018, 2023       | Tract, County, ZCTA   |
| Condominium Housing               | HsdTypCo            | Percent of housing classified as condominium                               | 2018, 2023       | Tract, County, ZCTA   |
| Multifamily Housing               | HsdTypM             | Percent of housing classified as multifamily                               | 2018, 2023       | Tract, County, ZCTA   |
| Mixed-Use Housing                 | HsdTypMC            | Percent of housing classified as mixed-use                                 | 2018, 2023       | Tract, County, ZCTA   |
| Occupied Housing Units            | OccupantP           | Percent occupied housing units | 2023 | Tract, County, ZCTA | 
| Female-headed family households  | HhldFA              | Percent female householder with no spouse/partner living alone             | 2018, 2023           | Tract, ZCTA, County    |
| Female-headed family households with children  | HhldFC              | Percent female householder with no spouse/partner living with children under 18 years             | 2018, 2023           | Tract, ZCTA, County    |
| Single female households  | HhldFS              | Percent female householder 65 years and over living alone                 | 2018, 2023           | Tract, ZCTA, County    |
| Single male-headed adult households     | HhldMA              | Percent male householder with no spouse/partner living alone    | 2018, 2023           | Tract, ZCTA, County    |
| Couple-headed male households    | HhldMC              | Percent married-couple household With children under 18 years              | 2018, 2023           | Tract, ZCTA, County    |
| Single-male households           | HhldMS              | Percent male householder 65 years and over living alone                  | 2018, 2023           | Tract, ZCTA, County    |

 
### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average. Additional variables in this table include householder gender, types of family members represented in households, and types of nonrelatives in household (i.e. roomer/baorder, housemate, foster child, other).  
*Note that the Zip code scale data is only available for the "latest" file.

### Comments/Notes:
For more information about how these data have been used in homelessness and housing stability research, please refer to https://www.census.gov/newsroom/press-releases/2020/special-operations-homelessness.html or https://www.americanprogress.org/issues/poverty/reports/2020/10/05/491122/count-people-where-they-are/.

**Note on missing data:** Missing and/or unavailable data are coded as blank cells or _NA_.
