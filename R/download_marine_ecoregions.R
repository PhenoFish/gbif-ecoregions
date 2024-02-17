#' Download marine ecoregions of the World (MEOW) spatial layer
#'
#' @description
#' Downloads the spatial layer of marine ecoregions of the World (MEOW) 
#' available on the WWF website 
#' (<https://www.worldwildlife.org/publications/marine-ecoregions-of-the-world-a-bioregionalization-of-coastal-and-shelf-areas>).
#'
#' @param path a `character` of length 1. The path/folder to save the layer.
#'   Default is `data/`. Note that a subdirectory `MEOW/` will be created.
#'
#' @return No return value. Files will be written on the hard drive.
#' 
#' @export
#' 
#' @references
#' Spalding MD _et al._ (2007) Marine Ecoregions of the World: A 
#' Bioregionalization of Coastal and Shelf Areas. BioScience, 57(7), 573-583.
#' <https://doi.org/10.1641/B570707>.
#'
#' @examples
#' ## download_marine_ecoregions()

download_marine_ecoregions <- function(path = here::here("data")) {
  
  ## Check path to save files ----
  
  if (is.null(path)) {
    path <- here::here()  
  }
  
  if (!is.character(path)) {
    stop("Argument 'path' must be a character", call. = FALSE)
  }
  
  if (length(path) != 1) {
    stop("Argument 'path' must be a character of length 1", call. = FALSE)
  }
  
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
  
  ## Check if layer is already locally available ----
  
  if (!("meow_ecos.shp" %in% list.files(file.path(path, "MEOW")))) {
    
    ## URL parameters ----
    
    baseurl <- "https://files.worldwildlife.org/wwfcmsprod/files/Publication/file/"
    zipname <- "7gger8mmke_MEOW_FINAL.zip"
    
    
    ## Download ZIP file ----
    
    utils::download.file(url      = paste0(baseurl, zipname),
                         destfile = file.path(path, zipname), 
                         mode     = "wb",
                         quiet    = TRUE)
    
    
    ## Extract files in ZIP ----
    
    utils::unzip(zipfile = file.path(path, zipname), exdir = path)
    
    
    ## Delete ZIP file ----
    
    invisible(file.remove(file.path(path, zipname)))
    
    message("MEOW spatial layer has been successfully saved in '", 
            file.path(path, "MEOW"), "/'")
    
  } else {
    
    message("MEOW spatial layer is already available in '", 
            file.path(path, "MEOW"), "/'")
  }
    
  invisible(NULL)
}
