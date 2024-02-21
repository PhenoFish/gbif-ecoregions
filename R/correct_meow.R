#' Correct MEOW geometry
#'
#' @description
#' Some MEOW polygons cannot be projected without rendering artifact. This 
#' function slightly changes longitude of polygons at the edge of World.
#'
#' @param meow a `sf MULTIPOLYGON` object. The MEOW spatial layer or the 
#'   richness layer.
#'
#' @return A `sf MULTIPOLYGON`.
#' 
#' @export
#'
#' @examples
#' ## meow <- sf::st_read(here::here("data", "MEOW", "meow_ecos.shp"))
#' ## meow <- correct_meow(meow)

correct_meow <- function(meow) {
  
  wrong_polygons <- c("Fiji Islands", "Gilbert/Ellis Islands")
  
  pos <- which(meow$"ECOREGION" %in% wrong_polygons)
  
  new_lines <- data.frame()
  
  for (i in 1:length(pos)) {
    
    attrs  <- sf::st_drop_geometry(meow[pos[i], ])
    coords <- sf::st_coordinates(meow[pos[i], ])
    
    n <- length(unique(coords[ , 4]))
    
    for (j in 1:n) {
      
      polygon <- coords[which(coords[ , 4] == j), ]
      
      polygon[ , 1] <- as.numeric(gsub("180.0000", "179.9999", polygon[ , 1]))
      
      polygon <- sf::st_polygon(list(polygon[ , 1:2]))
      polygon <- sf::st_sfc(polygon, crs = sf::st_crs(4326))
      new_line <- attrs
      sf::st_geometry(new_line) <- polygon
      
      new_lines <- rbind(new_lines, new_line)
    }
  }
  
  meow <- meow[-pos, ]
  sf::st_geometry(new_lines) <- "geom"
  
  rbind(meow, new_lines)
}
