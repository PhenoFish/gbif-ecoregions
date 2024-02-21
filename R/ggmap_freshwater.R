#' Map number of freshwater fish species per World drainage basin
#'
#' @return A `ggplot` object.
#' 
#' @export
#'
#' @examples
#' ## ggmap_freshwater()

ggmap_freshwater <- function() {
  
  ## Read map data ----
  
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
  
  data_sf <- sf::st_read(here::here("outputs", 
                                    "phenofish_freshwater_richness.gpkg"),
                         quiet = TRUE)
  
  
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
    
    ggplot2::geom_sf(data = data_sf, ggplot2::aes(fill = richness)) +
    
    ggplot2::theme_void() +
    ggplot2::theme(legend.position  = "bottom",
                   legend.key.width = ggplot2::unit(1.5, 'cm'),
                   legend.title = ggplot2::element_text(face = "bold")) +
    ggplot2::labs(fill = "Number of freshwater fish species") + 
    ggplot2::guides(fill = ggplot2::guide_colorbar(title.position = "top", 
                                                   title.hjust = 0.5))
}
