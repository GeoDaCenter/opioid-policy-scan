# Historical ZCTA Data

*9/12/2023 -- Adam Cox*

While preparing the 2.0 release, we decided to omit the historical Zip Code Tabulation Area (ZCTA) data based on further inspection of the interpolation and join methods we had used to create it. Initially, we had hoped that HUD crosswalks (which can be found in this repo) between historical census tracts and USPS Zip Codes would be sufficient to interpolate historical tract-level data into ZCTAs. However, this did not work as well as we'd hoped, as we found a ~6k row discrepancy between the number of USPS Zip Codes (which the crosswalk produced) and the 2010 ZTCA geometries which we were planning to join to.

A potential path forward would involve the Zip Code to ZCTA crosswalks [published by UDS Mapper](https://udsmapper.org/zip-code-to-zcta-crosswalk/). This crosswalk links all USPS zip codes with a corresponding ZCTA (which can be a many-to-one relationship), and it indicates whether a USPS zip code is a "Post Office or large volume customer", as well as whether it matches exactly with a ZCTA or is one of many that match a ZCTA. My hunch is that many of the Zip Codes in our HUD crosswalk output may be these "Post Office or large volume customer" zips, and not have any meaningful demographic data anyway. So, it may be possible to incorporate the UDS file within the tract to zip code interpolation step to learn more about how to handle the zips that don't directly match ZCTAs. However, this will not be pursued for the 2.0 release.

Included in this directory is also the data dictionary that included the 1990-2000 ZCTA variables, just for future reference.
