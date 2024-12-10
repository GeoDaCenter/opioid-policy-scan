# Opioid Environment Policy Scan (OEPS) Data Warehouse

## Repo Changes at v2 Release

*In December 2024 we published v2 of OEPS, and this release brought a few significant structural changes to how the repositories and content are managed.*

*In brief, this repository still holds the v2 CSV files, metadata Markdown files, and R scripts, while a new repo, [healthyregions/oeps](https://github.com/healthyregions/oeps), now holds the OEPS Explorer front-end code, and a new Flask-based backend application that manages all data ETL operations.*

*We expect future releases to continue moving content from this repository to the new one. Here is a link to this repository at the [v1 release](https://github.com/GeoDaCenter/opioid-policy-scan/tree/115989bd1f6706e2b225da9a88c27c5e34e42692).*

## Links

- OEPS Explorer: The main public website for OEPS, where you can find data download, documentation, and methodology
  - Website: [oeps.healthyregions.org](https://oeps.healthyregions.org)
  - Repo: [healthyregions/oeps](https://github.com/healthyregions/oeps) (in the `explorer` directory)
- OEPS Backend: A Flask app that handles all ETL processes for OEPS data
  - Repo: [healthyregions/oeps](https://github.com/healthyregions/oeps) (in the `backend` directory)
- `oepsData`: An R package that provides very easy access to all OEPS data for R users
  - Documentation: [oepsdata.healthyregions.org](https://oepsdata.healthyregions.org)
  - Repo: [healthyregions/oepsdata](https://github.com/healthyregions/oepsdata)

## About OEPS

The Opioid Environment Policy Scan (OEPS) is a free, open-source data warehouse to help characterize the multi-dimensional risk environment impacting opioid use and health outcomes across the United States.

The OEPS provides access to data at multiple spatial scales, from U.S. states down to Census tracts. It is designed to support research seeking to study environments impacting and impacted by opioid use and opioid use disorder (OUD), inform public policy, and reduce harm in communities nationwide. 

We developed the OEPS as a free, open-source platform to aggregate and share publicly-available data at the Census tract, zip code, county, and state levels. Geographic boundary shapefiles are provided for ease of merging datasets (csv files) for exploration, spatial analysis, or visualization. Download the entire data repository, or you can filter and download by theme or spatial scale with the [OEPS Explorer](https://oeps.healthyregions.org). All datasets are accompanied by documentation, detailing their source data, year, and more. Learn more about our methods and approaches, including the risk environment framework, on our [Methodology](https://oeps.healthyregions.org/methods) page.

### Citation

**v2**

Adam Cox, Ashlynn Wimer, Sara Lambert, Susan Paykin, Dylan Halpern, Qinyun Lin, Moksha Menghaney, Angela Li, Rachel Vigil, Margot Bolanos Gamez, Alexa Jin, Ally Muszynski, and Marynia Kolak. (2024). healthyregions/oeps: Opioid Environment Policy Scan (OEPS) Data Warehouse (v2.0). Zenodo. https://doi.org/10.5281/zenodo.5842465

**v1**

Susan Paykin, Dylan Halpern, Qinyun Lin, Moksha Menghaney, Angela Li, Rachel Vigil, Margot Bolanos Gamez, Alexa Jin, Ally Muszynski, and Marynia Kolak. (2021). GeoDaCenter/opioid-policy-scan: Opioid Environment Policy Scan Data Warehouse (v1.0). Zenodo. https://doi.org/10.5281/zenodo.5842465

## Team

The OEPS is led by the [Healthy Regions & Policies Lab](https://healthyregions.org) team including [Adam Cox](https://github.com/mradamcox), [Ashlynn Wimer](https://github.com/bucketteOfIvy), [Sara Lambert](https://github.com/bodom0015) and [Marynia Kolak](https://github.com/makosak).

OEPS was originally created by [Susan Paykin](https://github.com/spaykin), [Qinyun Lin](https://github.com/linqinyu), [Dylan Halpern](https://github.com/nofurtherinformation), and [Marynia Kolak](https://github.com/makosak) along with Moksha Menghaney and Angela Li.

## Acknowledgements
The OEPS was developed for the Methodology and Advanced Analytics Resource Center (MAARC), part of the NIH-HEAL Initiative Justice Community Opioid Innovation Network (JCOIN). The Healthy Regions & Policies Lab leads spatial analytics for the MAARC, which provides data infrastructure and statistical and analytic expertise to support individual JCOIN studies and cross-site data synchronization.

*This research was supported by the National Institute on Drug Abuse, National Institutes of Health, through the NIH HEAL Initiative under award number UG3DA123456. The contents of this publication are solely the responsibility of the authors and do not necessarily represent the official views of the NIH, the Initiative, or the participating sites.*
