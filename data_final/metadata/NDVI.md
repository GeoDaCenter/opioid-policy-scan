**Meta Data Name**: Normalized Difference Vegetation Index (NDVI)  
**Last Modified**: Dec 3, 2021  
**Added to OEPS**: April 1, 2022  
**Author**: Michelle Stuhlmacher, DePaul University, Department of Geography  

### Data Location: 
BE05 - Residential Segregation Indicies calculated at the county level. File can be found [here](/data_final).
* BE06_NDVI_T 

### Data Source(s) Description:  
Data was sourced from Sentinel 2 MSI: MultiSpectral Instrument, Level-1 C. It was calculated using imagery from the summer of 2018. Summer is defined as 03/20/2018 to 09/22/2018 (spring to fall solstice).

### Description of Data Processing: 
Sentinel-2 imagery is filtered to the desired date range and then pixels with high cloud and cirrus interference are removed. The remaining pixels are composited using the 50th percentile to produce a single image with minimal cloud interference. The NDVI is calculated using this image, and the mean NDVI values for each census tract is extracted.  

Analysis was completed using [Google Earth Engine](https://earthengine.google.com/). The code is publicly accessible to those with an Earth Engine account here: https://code.earthengine.google.com/4c997cd30d088e97d24171d528e4749b   

The key variable in this dataset is **ndvi**: the average Normalized Difference Vegetation Index (ndvi) value from all pixel values in each census tract. NDVI is a remotely sensed measure of relative vegetation abundance and health using the difference in red (RED) and near-infrared (NIR) measurements. It is calculated: *NDVI = (NIR-RED)/(NIR+RED)*  
The NDVI calculation produces an index from -1 to 1, with values at the higher end of the range corresponding to greater vegetation abundance.  

The original spatial scale was 10m pixels, which was translated to US Census tracts.  

### Key Variable and Definitions:
| Variable | Variable ID in .csv | Description |
|:---------|:--------------------|:------------|
|:Normalized Difference Vegetation Index (NDVI) |: ndvi |: Average NDVI value from all pixel values in each Census tract |

### Data Limitations:
Despite removing identified influences of cloud interferences, there may still be clouds or other atmospheric conditions that alter pixel values used in calculations. See the original source for greater documentation of these effects. Furthermore, summarizing NDVI to the census tract simplifies inter-census tract variability.

### Comments/Notes:
None at this time. 