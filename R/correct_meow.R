correct_meow <- function(meow) {
  
  wrong_polygons <- c("Fiji Islands", "Gilbert/Ellis Islands")
  
  pos <- which(meow$"ECOREGION" %in% wrong_polygons)
  
  new_lines <- data.frame()
  
  for (i in 1:length(pos)) {
    
    attrs  <- sf::st_drop_geometry(meow[pos[i], ])
    coords <- sf::st_coordinates(meow[pos[i], ])
    
    j <- 1
    
    polygon <- coords[which(coords[ , 4] == j), ]
    polygon <- sf::st_polygon(list(polygon[ , 1:2]))
    polygon <- sf::st_sfc(polygon, crs = sf::st_crs(4326))
    new_line <- attrs
    sf::st_geometry(new_line) <- polygon
    
    new_lines <- rbind(new_lines, new_line)
    
  }
  
  meow <- meow[-pos, ]
  sf::st_geometry(new_lines) <- "geom"
  
  rbind(meow, new_lines)
}
