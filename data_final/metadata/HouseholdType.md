**Meta Data Name**: Household Type  
**Last Modified**: November 2021  
**Author**: Susan Paykin  

### Data Location: 
DS05 - 4 spatial scales. Files can be found [here](/data_final).
* DS05_T  
* DS05_Z  
* DS05_C  
* DS05_S  

### Data Source(s) Description:  
Data was sourced from the American Community Survey, 2018 5-year average, Table  B09019: *Household Type (Including Living Alone) by Relationship*, at the state, county, tract and ZIP Code Tabulation Area (ZCTA) scales, available from the [US Census Bureau](https://data.census.gov/cedsci/table?q=B09019&g=0100000US%240400000&tid=ACSDT5Y2018.B09019).  Complete data documentation for this table is available via [Social Explorer](https://www.socialexplorer.com/data/ACS2018_5yr/metadata/?ds=ACS18_5yr&var=B09019001). Data here was accessed through the [tidycensus](https://walker-data.com/tidycensus/index.html) R package, which uses the US Census Bureau's API. 

### Description of Data Source Table:
B09019 : HOUSEHOLD TYPE (INCLUDING LIVING ALONE) BY RELATIONSHIP.

The following variables were selected from Table B09019:
* B09019_001E - Total population 
* B09019_002E - Total population in households
* B09019_003E - Total population in family households
* B09019_018E - Total nonrelatives in family households
* B09019_024E - Total population in non-family households
* B09019_032E - Total nonrelatives in non-family households
* B09019_038E - Total population in group quarters

From Social Explorer's [Table B09019 Data Dictionary](https://www.socialexplorer.com/data/ACS2018_5yr/metadata/?ds=ACS18_5yr&var=B09019001): 

**Household**: A household includes all the people who occupy a housing unit. (People not living in households are classified as living in group quarters.) A housing unit is a house, an apartment, a mobile home, a group of rooms, or a single room that is occupied (or if vacant, is intended for occupancy) as separate living quarters. Separate living quarters are those in which the occupants live separately from any other people in the building and which have direct access from the outside of the building or through a common hall. The occupants may be a single family, one person living alone, two or more families living together, or any other group of related or unrelated people who share living arrangements.

**Family Households vs. Non-family Households**: A family consists of a householder and one or more other people living in the same household who are related to the householder by birth, marriage, or adoption. All people in a household who are related to the householder are regarded as members of his or her family. A family household may contain people not related to the householder, but those people are not included as part of the householder's family in tabulations. Thus, the number of family households is equal to the number of families, but family households may include more members than do families. A household can contain only one family for purposes of tabulations. Not all households contain families since a household may be comprised of a group of unrelated people or of one person living alone - these are called nonfamily households. Families are classified by type as either a "married- couple family" or "other family" according to the sex of the householder and the presence of relatives. The data on family type are based on answers to questions on sex and relationship that were asked of all people.

**[Group Quarters](https://www.census.gov/topics/income-poverty/poverty/guidance/group-quarters.html)**: The Census Bureau classifies all people not living in housing units (house, apartment, mobile home, rented rooms) as living in group quarters. There are two types of group quarters:
* Institutional, such as correctional facilities, nursing homes, or mental hospitals
* Non-Institutional, such as college dormitories, military barracks, group homes, missions, or shelters.

### Description of Data Processing: 
The following rates were calculated from the variables: 

* % Nonrelatives in family households = *Total nonrelatives in family households / Total population in family households*
* % Nonrelatives in non-family households = *Total nonrelatives in non-family households / Total population in non-family households*
* % Group quarters = *Total group quarters population / Total population*


### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
  |:---------|:--------------------|:------------|
  | Total population  | totalP | Total population in the geographic area |
  | Total population in household  | totalP_hh | Total number of people in households |
  | Total population in family households | totalP_fhh | Total number of people living in family households |
  | Total nonrelatives in family households | nonRel_fhh | Total number of people living in family households that are not related to family |
  | Percent of nonrelatives in family households | nonRel_fhhR | Percent of people living in family households that are not related to family |
  | Total population in non-family households | totalP_nfhh | Total number of people living in non-family households |
  | Total nonrelatives in non-family households | nonRel_nfhh | Total number of people living in non-family households that are not related |
  | Percent of nonrelatives in non-family households | nonRel_nfhhR | Percent of people living in non-family households that are not related |
  | Total in group quarters | groupQuar | Total population living in group quarters |
  | Percent in group quarters | groupQuarR | Estimate of people living in group quarters over total population |
  
### Data Limitations:
This data represents estimates as of the ACS 2018 5-year average. Additional variables in this table include householder gender, types of family members represented in households, and types of nonrelatives in household (i.e. roomer/baorder, housemate, foster child, other). 

### Comments/Notes:
For more information about how these data have been used in homelessness and housing stability research, please refer to https://www.census.gov/newsroom/press-releases/2020/special-operations-homelessness.html or https://www.americanprogress.org/issues/poverty/reports/2020/10/05/491122/count-people-where-they-are/.

**Note on missing data:** Missing and/or unavailable data are coded as blank cells or _NA_.
