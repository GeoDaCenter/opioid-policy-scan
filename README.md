
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Opioid Environment Program

This repository stores R scripts used to clean, join, and visualize data
for the CSDS opioid environment program. Raw data/output is not stored
in here for confidentiality, but are included in the Google Drive/Box
associated with this
project.

| Input                                     | Script   | Output                                    | Purpose                                                                                                                                          |
| ----------------------------------------- | -------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| data/\*                                   | R/01\_\* | data-output/01\_\*                        | Clean original data and get each into 3-column format with `name`, `category_service`, and `geometry`                                            |
| data-output/01\_\*                        | R/02\_\* | data-output/02\_\*                        | Combine datasets together to get combined point dataset (needed for map overlays), create point maps for each resource (for jurisdictional plan) |
| data-output/02\_\*                        | R/03\_\* | data-output/03\_\*                        | **(unused)** Create various buffers on point dataset, count buffers per zip                                                                      |
| data-output/01\_\*                        | R/04\_\* | data-output/min-dists-to-zip-centroid.csv | Calculate min distance from resources to zip centroids                                                                                           |
| data-output/min-dists-to-zip-centroid.csv | R/05\_\* | data-output/sum\_zscores.gpkg/.shp        | Convert centroid distances to summative z-scores                                                                                                 |
| data/carto….                              | R/99\_\* | data-output/carto…                        | One-off cleaning/joining scripts for manipulating CARTO datasets for collaborators                                                               |

## Relevant Links

  - [Google
    Drive](https://drive.google.com/drive/folders/1WOEZU8e56SiuENpqYbU1-Tf4HFa4aIeD):
    inlcudes raw data, cleaned data, and
    documentation
  - [Trello](https://trello.com/b/r8b41gb0/ethic-opioid-environment-program):
    tasklist and status of project
  - [ETHIC Access Google
    Sheet](https://docs.google.com/spreadsheets/d/1GEZZcFkQd-944-DKvqG6Wh_aJ60FG0Y9GuNS8EtFLY8/edit#gid=0):
    tracks access variables used in calculations
