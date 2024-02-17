#' Download World drainage basins spatial layer
#'
#' @description
#' Downloads the spatial layer of drainage basins of the World available on the 
#' Figshare website 
#' (<https://figshare.com/collections/A_global_database_on_freshwater_fish_species_occurrences_in_drainage_basins/3739145>).
#'
#' @param path a `character` of length 1. The path/folder to save the layer.
#'   Default is `data/`. Note that a subdirectory `basins/` will be created.
#'
#' @return No return value. Files will be written on the hard drive.
#' 
#' @export
#' 
#' @references
#' Tedesco P _et al._ (2017) A global database on freshwater fish species 
#' occurrence in drainage basins. Scientific Data, 4, 170141.
#' <https://doi.org/10.1038/sdata.2017.141>.
#'
#' @examples
#' ## download_drainage_basins()

download_drainage_basins <- function(path = here::here("data")) {
  
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
  
  if (!("Basin042017_3119.shp" %in% list.files(file.path(path, "basins")))) {
    
    ## URL parameters ----
    
    baseurl <- "https://figshare.com/ndownloader/files/8964583/"
    zipname <- "datatoFigshare.zip"
    
    
    ## Download ZIP file ----
    
    utils::download.file(url      = paste0(baseurl, zipname),
                         destfile = file.path(path, zipname), 
                         mode     = "wb",
                         quiet    = TRUE)
    
    
    ## Extract files in ZIP ----
    
    utils::unzip(zipfile = file.path(path, zipname), 
                 exdir   = file.path(path, "basins"))
    
    
    ## Delete ZIP file ----
    
    invisible(file.remove(file.path(path, zipname)))
    
    
    ## Delete optional files ----
    
    fls_to_del <- list.files(file.path(path, "basins"), pattern = "\\.csv$")
    
    for (fls in fls_to_del) {
      invisible(file.remove(file.path(path, "basins", fls)))
    }
    
    message("Drainage basins spatial layer has been successfully saved in '", 
            file.path(path, "basins"), "/'")
    
  } else {
    
    message("Drainage basins spatial layer is already available in '", 
            file.path(path, "basins"), "/'")
  }
  
  invisible(NULL)
}