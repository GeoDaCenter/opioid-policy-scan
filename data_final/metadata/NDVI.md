**Meta Data Name**: Normalized Difference Vegetation Index (NDVI)  
**Date Added**: April 1, 2022  
**Author**: Michelle Stuhlmacher & Susan Paykin  
**Date Last Modified**: January 3, 2024  
**Last Modified By**: Wataru Morioka

### Theme: 
Environment

### Data Location: 
You can find the variables described in this document in the CSV files [here](../full_tables).  

CSV files are organized by **year** and **spatial scale**. For example, county-level variables from 2000 will be found in C_2000.csv.  
Note: Every variable can be found in the **Latest** files.

### Data Source(s) Description:  
Tract-level data was sourced from Sentinel 2 MSI: MultiSpectral Instrument, Level-1 C. It was calculated using imagery from the summer of 2018. Summer is defined as 03/20/2018 to 09/22/2018 (spring to fall solstice). The tract-level dataset was provided by Dr. Michelle Stuhmacher, Assistant Professor, DePaul University Department of Geography. 

### Description of Data Processing: 
The tract-level data processing was done by the Depaul University team. Sentinel-2 imagery is filtered to the desired date range and then pixels with high cloud and cirrus interference are removed. The remaining pixels are composited using the 50th percentile to produce a single image with minimal cloud interference. The NDVI is calculated using this image, and the mean NDVI values for each census tract is extracted.  

Analysis was completed using [Google Earth Engine](https://earthengine.google.com/). The code is publicly accessible to those with an Earth Engine account here: https://code.earthengine.google.com/4c997cd30d088e97d24171d528e4749b   

The key variable in this dataset is **Ndvi**: the average Normalized Difference Vegetation Index (ndvi) value from all pixel values in each census tract. NDVI is a remotely sensed measure of relative vegetation abundance and health using the difference in red (RED) and near-infrared (NIR) measurements. It is calculated: *NDVI = (NIR-RED)/(NIR+RED)*  
The NDVI calculation produces an index from -1 to 1, with values at the higher end of the range corresponding to greater vegetation abundance.  

The original spatial scale was 10m pixels, which was translated to US Census tracts. 

Tract-level estimates were then aggregated to the county-level average and state-level average using their FIPS Codes. Zip code-level estimates were calculated using the [HUD USPS ZIP Code Crosswalk File](https://www.huduser.gov/portal/datasets/usps_crosswalk.html) (Tract-Zip), also provided in the OEPS under [geometryFiles/crosswalk](https://github.com/GeoDaCenter/opioid-policy-scan/tree/v1.0/data_final/geometryFiles/crosswalk). Data processing was done by the CSDS team. 

### Key Variable and Definitions:

- **Variable** -- title of variable
- **Variable ID** -- exact name of variable in datasets
- **Description** -- Short description of variable
- **Years Available** -- years for which data exists for this variable
- **Spatial Scale** -- the variable exists for these levels of spatial scale

| Variable | Variable ID in .csv | Description | Years Available | Spatial Scale |
|:---------|:--------------------|:------------|:----------------|:--------------|
|Normalized Difference Vegetation Index (NDVI) | Ndvi | Average NDVI value from all pixel values in each Census tract | Latest | Tract, Zip, County, State |

### Data Limitations:
Despite removing identified influences of cloud interferences, there may still be clouds or other atmospheric conditions that alter pixel values used in calculations. See the original source for greater documentation of these effects. Furthermore, summarizing NDVI to the census tract simplifies inter-census tract variability.

### Comments/Notes:
No additional comments at this time. 
