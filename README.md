
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Opioid Environment Program

This repository stores R scripts used to clean, join, and visualize data
for the CSDS opioid environment program. 

The data wrangled in this analysis will be further developed as a data and visualization product (Policy Scan) to characterize the multi-dimensional risk environment impacting the opioid crisis in the United States.

## Data Overview

++ to add grid of all datasets and scales included

## Data Wrangling

++ to add chart of data wrangling and cleaning scripts for data

## Access Calculations

| Input                                     | Script   | Output                                    | Purpose                                                                                                                                          |
| ----------------------------------------- | -------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| data/\*                                   | R/01\_\* | data-output/01\_\*                        | Clean original data and get each into 3-column format with `name`, `category_service`, and `geometry`                                            |
| data-output/01\_\*                        | R/02\_\* | data-output/02\_\*                        | Combine datasets together to get combined point dataset (needed for map overlays), create point maps for each resource (for jurisdictional plan) |
| data-output/02\_\*                        | R/03\_\* | data-output/03\_\*                        | **(unused)** Create various buffers on point dataset, count buffers per zip                                                                      |
| data-output/01\_\*                        | R/04\_\* | data-output/min-dists-to-zip-centroid.csv | Calculate min distance from resources to zip centroids                                                                                           |
| data-output/min-dists-to-zip-centroid.csv | R/05\_\* | data-output/sum\_zscores.gpkg/.shp        | Convert centroid distances to summative z-scores                                                                                                 |
| data/carto….                              | R/99\_\* | data-output/carto…                        | One-off cleaning/joining scripts for manipulating CARTO datasets for collaborators                                                               |


## Team

Marynia Kolak (Lead), Angela Li (Analyst), Qinyun Lin (Postdoc), Moksha Menghaney (Analyst)
