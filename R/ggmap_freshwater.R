#' Map spatial object at World drainage basins level
#' 
#' @description
#' Represent a spatial metric on a World map at the drainage basins scale. By 
#' default, the number of freshwater fish species per World drainage basin is 
#' mapped.
#'
#' @param file a `character` of length 1. The relative path to the spatial 
#'   object to read. Default is `outputs/phenofish_freshwater_richness.gpkg`.
#' 
#' @param metric the column in `file` to map. The name of the column must be 
#'   unquoted (`metric = richness` and not `metric = "richness"`).
#'   Default is `richness`.
#' 
#' @param title a `character` of length 1. The title of the map. Default is
#'   `Number of freshwater fish species`.
#' 
#' @return A `ggplot` object.
#' 
#' @export
#' 
#' @examples
#' ## ggmap_freshwater()

ggmap_freshwater <- function(
    file, 
    metric, 
    title,
    mypalette) {
  
  
  ## Check args ----
  
  if (!is.character(file) && length(file) != 1) {
    stop("Argument 'file' must a character of length 1", call. = FALSE)
  }
  
  if (!is.character(metric) && length(metric) != 1) {
    stop("Argument 'metric' must a character of length 1", call. = FALSE)
  }
  
  if (!file.exists(file)) {
    stop("The file '", file, "' does not exist", call. = FALSE)
  }
  
  # if (!is.character(metric) && length(metric) != 1) {
  #   stop("Argument 'metric' must a character of length 1", call. = FALSE)
  # }
  
  if (!is.character(title) && length(title) != 1) {
    stop("Argument 'title' must a character of length 1", call. = FALSE)
  }
  
  
  ## Read base map layers ----
  
  ne_oceans     <- sf::st_read(here::here("data", "basemap", 
                                          "ne_oceans.gpkg"), quiet = TRUE)
  ne_countries  <- sf::st_read(here::here("data", "basemap", 
                                          "ne_countries.gpkg"), quiet = TRUE)
  ne_bbox       <- sf::st_read(here::here("data", "basemap", 
                                          "ne_bbox.gpkg"), quiet = TRUE)
  ne_graticules <- sf::st_read(here::here("data", "basemap", 
                                          "ne_graticules.gpkg"), quiet = TRUE)
  
  ne_poles <- ne_countries[ne_countries$admin %in% c("Greenland", 
                                                     "Antarctica"), ]
  
  
  ## Read richness data ----
  
  data_sf <- sf::st_read(file, quiet = TRUE)
  
  # if (!(metric %in% colnames(data_sf))) {
  #   stop("The column '", metric, "'is not found in '", file, "'", call. = FALSE)
  # }
  
  
  ## Make map ----
  
  ggplot2::ggplot() +
    
    ggplot2::geom_sf(data = ne_bbox, fill = "#cdeafc", col = NA, 
                     linewidth = 0.75) +
    ggplot2::geom_sf(data = ne_graticules, col = "#bae2fb", 
                     linewidth = 0.10) +
    
    ggplot2::geom_sf(data = ne_countries, fill = "#c0c0c0", col = "#c9c9c9", 
                     linewidth = 0.10) +
    
    ggplot2::geom_sf(data = ne_poles, fill = "white", col = "white") +
    ggplot2::geom_sf(data = ne_bbox, fill = NA, col = "#a6a6a6", 
                     linewidth = 0.10) +
    
    ggplot2::geom_sf(data = data_sf, ggplot2::aes_string(fill =  metric ))+
    ggplot2::scale_fill_gradientn(colours=mypalette,
                                  na.value = "grey100") +
    
    ggplot2::theme_void() +
    ggplot2::theme(legend.position  = "bottom",
                   legend.key.width = ggplot2::unit(1.5, "cm"),
                   legend.title = ggplot2::element_text(face = "bold")) +
    ggplot2::labs(fill = title) + 
    ggplot2::guides(fill = ggplot2::guide_colorbar(title.position = "top", 
                                                  title.hjust = 0.5))
}
