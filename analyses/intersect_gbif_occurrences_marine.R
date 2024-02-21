#' Intersect GBIF occurrences w/ ecoregions and drainage basins layers
#' 
#' @description
#' The final `data.frame` for marine ecoregions (`species_ecoregions`) contain 
#' two columns:
#' - `gbif_key`: the GBIF identifier of the species;
#' - `ECO_CODE`: the identifier of the marine ecoregion in MEOW.
#' 
#' The field `ECO_CODE` can be used to merge this `data.frame` w/ the marine 
#' ecoregions layer (MEOW).
#' 
#' The final `data.frame` for drainage basins (`species_basins`) contain 
#' two columns:
#' - `gbif_key`: the GBIF identifier of the species;
#' - `BasinName`: the name of the drainage basin.
#' 
#' The field `BasinName` can be used to merge this `data.frame` w/ the drainage
#' basins layer.
#' 
#' The `.rds` files are exported in the `outputs/` folder as 
#' `phenofish_species_marine_ecoregions.rds` and
#' `phenofish_species_drainage_basins.rds`.


## Import GBIF downloads metadata ----

downloads_info <- read.csv(here::here("data", "gbif", "gbif_requests_keys.csv"))


## Import marine ecoregions layer ----

meow <- sf::st_read(here::here("data", "MEOW", "meow_ecos.shp"))


## Import drainage basins layer ----

basins <- sf::st_read(here::here("data", "basins", "Basin042017_3119.shp"))
basins <- sf::st_make_valid(basins)


## Intersections ----

species_ecoregions <- data.frame()
species_basins     <- data.frame()


for (i in 1:nrow(downloads_info)) {
  
  cat(paste0("Intersect GBIF file - ", i, "\r"))

  ## Import species occurrences ----
  
  occ <- readRDS(here::here("data", "gbif", 
                            paste0(downloads_info[i, "download_key"], 
                                   "_clean.rds")))
  
  ## Convert to sf POINTS ----
  
  occ <- sf::st_as_sf(occ, coords = c("longitude", "latitude"), 
                      crs = sf::st_crs(4326))
  
  
  ## Intersect w/ marine ecoregions ----
  
  inter <- sf::st_intersects(occ, meow, sparse = TRUE)
  
  pos <- apply(inter, 2, function(x) which(x))
  
  species_list <- lapply(1:length(pos), function(x) {
    
    gbif_key <- unique(occ[pos[[x]], "gbif_key", drop = TRUE])
    
    data.frame(gbif_key,
               "ECO_CODE" = rep(meow[x, "ECO_CODE", drop = TRUE], 
                                length(gbif_key)))
  })
  
  species_list <- do.call(rbind.data.frame, species_list)
  
  species_ecoregions <- rbind(species_ecoregions, species_list)
  
  
  ## Intersect w/ drainage basins ----
  
  inter <- sf::st_intersects(occ, basins, sparse = TRUE)
  
  pos <- apply(inter, 2, function(x) which(x))
  
  species_list <- lapply(1:length(pos), function(x) {
    
    gbif_key <- unique(occ[pos[[x]], "gbif_key", drop = TRUE])
    
    data.frame(gbif_key,
               "BasinName" = rep(basins[x, "BasinName", drop = TRUE], 
                                 length(gbif_key)))
  })
  
  species_list <- do.call(rbind.data.frame, species_list)
  
  species_basins <- rbind(species_basins, species_list)
}


## Export tables ----

saveRDS(species_ecoregions, here::here("outputs", 
                                       "phenofish_species_marine_ecoregions.rds"))

saveRDS(species_basins, here::here("outputs", 
                                   "phenofish_species_drainage_basins.rds"))
