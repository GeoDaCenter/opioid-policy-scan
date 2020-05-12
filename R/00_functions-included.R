# Functions used in various scripts

## From 07_calc-us-min-dist-metrics.R

#' Get minimum distance from resources to centroids of zips
#'
#' @param centroids_sf sf POINT object representing centroids of unit of interest 
#' (e.g. zip code centroids)
#' @param resources_sf sf POINT object representing locations of resources (e.g methadone clinics)
#'
#' @return
#' @export
#'
#' @examples
get_min_dists <- function(centroids_sf, resources_sf) {
  nearest_resource_indexes <- st_nearest_feature(centroids_sf, resources_sf)
  
  nearest_resource <- resources_sf[nearest_resource_indexes, ]
  
  min_dists <- st_distance(centroids_sf, nearest_resource, by_element = TRUE) # takes 2 minutes to run
  
  min_dists_mi <- set_units(min_dists, "mi")
  
  min_dists_mi
}