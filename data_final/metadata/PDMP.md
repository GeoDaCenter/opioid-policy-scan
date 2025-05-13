**Meta Data Name**: Prescription Drug Monitoring Program (PDMP) Policy Variables  
**Date Added**: January 7, 2021  
**Author**: Qinyun Lin, Wataru Morioka, Mahjabin Kabir Adrita  
**Date Last Modified**: May 12. 2025   
**Last Modified By**: Wataru Morioka, Mahjabin Kabir Adrita  

### Theme: 
Policy  

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Variables were obtained from RAND-USC Schaeffer Opioid Policy Tools and Information Center, 2021, [OPTIC-Vetted PDMP Policy Data](https://www.rand.org/health-care/centers/optic/resources/datasets.html) on Jan 7th, 2021. Raw data is downloaded in the folder of data_raw, named as *WEB_OPTIC_PDMP.xlsx*. 

### Description of Data Processing: 
The following variables were included from the source data:
1. Any PDMP fraction;
2. Any Horowitz PDMP fraction;
3. Operational PDMP fraction;
4. Must-access PDMP fraction;
5. Electronic PDMP fraction;
6. Any PDMP starting date;
7. Any Horowitz PDMP starting date;
8. Operational PDMP starting date;
9. Must-access PDMP starting date;
10. Electronic PDMP starting date;

Fractions are calculated based on the number of months out of 12 that a law is effective. A law is considered effective for a given month if a law becomes effective by the 7th for January, or if a law becomes effective by the 3rd for February – December.

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
| Any PDMP fraction | AnyPdmpFr | Fraction of year that state has any PDMP operating | 2017, 2023 | State |
| Any Horowitz PDMP fraction | AnyPdmphFr | Fraction of year that state has PDMP enabling legislation for any type of PDMP in effect, including paper-based systems, (as determined by Horowitz et al., 2018) enacted. | 2017, 2023 | State |
| Operational PDMP fraction | OpPdmpFr | Fraction of year that state has a “modern system” operational and users could access (as determined by Horowitz et al., 2018). | 2017, 2023 | State |
| Must-access PDMP fraction | MsAcPdmpFr | Fraction of year that state has any legislation requiring Prescribers to access PDMP before prescribing (as interpreted by PDAPS) enacted. | 2017, 2023 | State |
| Electronic PDMP fraction | ElcPdmpFr | Fraction of year that state has an electronic PDMP system operating. | 2017, 2023 | State |
| Any PDMP starting date | AnyPdmpDt | Date when PDMP enabling legislation was first enacted for any type of PDMP in effect (including paper-based systems). Source:  PDAPS for first PDMP laws passed after January 1, 1998;  Info on laws prior to 1998 came from Brandeis TTAC.| 2017, 2023 | State |
| Any Horowitz PDMP starting date | AnyPdmphDt | Date when PDMP enabling legislation was first enacted for any type of PDMP in effect (including paper-based systems). Source:  Horowitz et al., 2018, Table 2, column 1. | 2017, 2023 | State |
| Operational PDMP starting date | OpPdmpDt | Date when a “modern system” became operational and users could access. Source: Horowitz et al., 2018, Table 2, column 4. This definition includes specific caveats adopted by Horowitz et al., 2018, described further below in Notes. | 2017, 2023 | State |
| Must-access PDMP starting date | MsAcPdmpDt | Date of legislation requiring Prescribers to access PDMP before prescribing as interpreted by PDAPS. | 2017, 2023 | State |
| Electronic PDMP starting date | ElcPdmpDt | Date state began operating an electronic PDMP system. | 2017, 2023 | State |

### Data Limitations:
There currently does not exist a standard definition about what counts as Electronic PDMP. 

### Comments/Notes:
1. According to Horowitz et al (2018), the variable AnyPDMPHdt in this dataset records month and year of when any type of PDMP was enacted (including paper-based systems) according to legislation; the variable OpPDMPdt records month and year of when that PDMP data became accessible to any user (e.g., physician, pharmacist, or member of law enforcement) authorized by state law to receive it.
2. Some caveats regarding operational PDMP: 
* States that required prescribers or dispensers to keep records of prescriptions, but not send them to a central repository, were not considered to have a PDMP.
* If the statute stated a specific date when the PDMP was required to exist, this date was included, not the effective date of the statute. 
* If the authorization of the PDMP was contingent upon receiving sufficient funding, the date of when funding was secured was used.
3. Regarding “must access” provisions, various data sources use the term “mandatory use” to mean different things. Mandatory use (which differs from mandatory registration) may simply mean that prescribers must have an account on the system; that they must input their patient’s information in the system, or that they must check the system before prescribing an opioid under different circumstances (more on this policy [here](https://www.pewtrusts.org/en/research-and-analysis/data-visualizations/2018/when-are-prescribers-required-to-use-prescription-drug-monitoring-programs)). These are ultimately different levels of specificity of the law, and in the spirit of Horowitz et al., 2018, which encourages greater specificity in how these laws are defined, it is appropriate to use the term “physician must access” only when prescribers are mandated to access the database (regardless of the circumstance, which could differ if it is new patient, existing patient, and so on).  The database that best captures this definition is constructed by PDAPS and shows that no state adopted a “prescriber must access” law until 2012. Other papers using data sets showing earlier dates typically have weaker definitions of this policy, such as (a) including state laws that require prescribers to register in the system or use it together – as was done by Patrick et al., 2016 (Health Affairs paper), or (b) indicating that physicians actually have access to the data in the system, but not requiring that they access the data before prescribing – which was done in Horowitz et al., 2018 (NBER working paper).  Neither of these are a pure “must access” requirement and could lead to earlier implementation dates than what actually were required for true “must access” provisions. For example, a lot of papers count Nevada’s 2007 must-access PDMP. PDAPS does not count Nevada because PDAPS only counts policies as must-access if the policy required physicians to access/use the data system based on objective criteria. Nevada’s 2007 law basically said physicians must access “if they suspect abuse” but did not define what “suspected abuse” looked like. In 2015, Nevada put criteria on the conditions requiring PDMP use. As such, the Must Access PDMP captures the need for prescribers to check before prescribing to a patient. Note that this is NOT dispensers to access before dispensing. Also, must-access is interpreted to apply to ANY subset of patients. 

