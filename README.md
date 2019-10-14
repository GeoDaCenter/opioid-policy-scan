
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Opioid Work

This repository stores R scripts used to clean, join, and visualize data
for Marynia’s opioid research project. Raw data/output is not stored in
here for confidentiality, but are included in the Google Drive/Box
associated with this
project.

| Input              | Script   | Output             | Purpose                                                                                               |
| ------------------ | -------- | ------------------ | ----------------------------------------------------------------------------------------------------- |
| data/\*            | R/01\_\* | data-output/01\_\* | Clean original data and get each into 3-column format with `name`, `category_service`, and `geometry` |
| data-output/01\_\* | R/02\_\* | data-output/02\_\* | Combine datasets together to get combined point dataset (needed for map overlays)                     |
| data-output/02\_\* | R/03\_\* | data-output/03\_\* | Create various buffers on point dataset                                                               |
| data-output/03\_\* | R/04\_\* | data-output/04\_\* | Get counts by zip code of buffered resources                                                          |
