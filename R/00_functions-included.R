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


## From 08_map-us-min-dist-metrics.R

#' Clip geographies to continental US
#'
#' @param sf sf object representing geographical units to clip to continental US
#'
#' @return
#' @export
#'
#' @examples
clip_to_continental_us <- function(sf) {
  
  continental_bbox <- st_as_sfc("POLYGON((-126.3 50.6, -66.0 50.6, -66.0 20.1, -126.3 20.1, -126.3 50.6))") %>% 
    st_as_sf(crs = 4326) %>% 
    st_transform(st_crs(sf))
  
  continental_sf <- st_intersection(continental_bbox, sf)
  
}


#' Calculate hinge breaks (this is right skewed data so only need upfence)
#'
#' @param df 
#' @param variable 
#'
#' @return
#' @export
#'
#' @examples
get_hinge_breaks <- function(df, variable) {
  
  values <- dplyr::pull(df, variable)
  
  qv <- unname(quantile(values))
  iqr <- qv[4] - qv[2]
  upfence <- qv[4] + 1.5 * iqr
  
  breaks <- unname(quantile(values))
  breaks[5] <- upfence
  breaks[6] <- max(values)
  
  breaks
}
