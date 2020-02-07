# Functions used in various scripts

## From 04_calc-nearest-zip-centroid.R

#' Get minimum distance from resources to centroids of zips
#'
#' @param resource_pts sf POINT object representing locations of resources (e.g 
#' methadone clinimcs)
#' @param centroid_pts sf POINT object representing centroids of unit of interest 
#' (e.g. zip code centroids)
#' @param convert if FALSE, will return distance in meters (default is TRUE, 
#' will return distance in miles)
#'
#' @return
#' @export
#'
#' @examples
get_min_dist <- function(resource_pts, centroid_pts = zips_centroids, convert = TRUE) {
  distance_matrix <- st_distance(resource_pts, centroid_pts)
  if (convert) {
    distance_matrix <- set_units(distance_matrix, mi)
  }
  
  min_dists <- round(apply(distance_matrix, 2, min), digits = 4)
  
  min_dists
}