ggmap_marine <- function() {
  
  ## Read map data ----
  
  ne_oceans     <- sf::st_read(here::here("data", "basemap", 
                                          "ne_oceans.gpkg"))
  ne_countries  <- sf::st_read(here::here("data", "basemap", 
                                          "ne_countries.gpkg"))
  ne_bbox       <- sf::st_read(here::here("data", "basemap", 
                                          "ne_bbox.gpkg"))
  ne_graticules <- sf::st_read(here::here("data", "basemap", 
                                          "ne_graticules.gpkg"))
  
  ne_poles <- ne_countries[ne_countries$admin %in% c("Greenland", 
                                                     "Antarctica"), ]
  
  
  ## Read richness data ----
  
  data_sf <- sf::st_read(here::here("outputs", 
                                    "phenofish_marine_richness.gpkg"))

  data_sf <- correct_meow(data_sf)
  data_sf <- sf::st_transform(data_sf, crs = sf::st_crs(ne_bbox))
  
  
  ggplot2::ggplot() +
    
    ggplot2::geom_sf(data = ne_bbox, fill = "#cdeafc", col = NA, 
                     linewidth = 0.75) +
    ggplot2::geom_sf(data = ne_graticules, col = "#bae2fb", 
                     linewidth = 0.10) +
    
    ggplot2::geom_sf(data = data_sf, ggplot2::aes(fill = richness)) +
    
    geom_sf(data = ne_countries, fill = "#a6a6a6", col = "#b1b1b1", 
            linewidth = 0.10) +
  
    ggplot2::geom_sf(data = ne_poles, fill = "white", col = "white") +
    ggplot2::geom_sf(data = ne_bbox, fill = NA, col = "#a6a6a6", 
                     linewidth = 0.75) +
    
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "bottom")
}
