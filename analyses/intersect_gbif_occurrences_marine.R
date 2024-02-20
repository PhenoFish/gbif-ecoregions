
## Import GBIF downloads metadata ----

downloads_info <- read.csv(here::here("data", "gbif", "gbif_requests_keys.csv"))


## Import marine ecoregions layer ----

meow <- sf::st_read(here::here("data", "MEOW", "meow_ecos.shp"))



## Import drainage basins layer ----

basins <- sf::st_read(here::here("data", "basins", "Basin042017_3119.shp"))
basins <- sf::st_make_valid(basins)

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


## Compute species richness ----

ecoregions_richness <- tapply(species_ecoregions$"gbif_key", 
                              species_ecoregions$"ECO_CODE", 
                              function(x) length(unique(x)))

ecoregions_richness <- data.frame("ECO_CODE" = names(ecoregions_richness),
                                  "richness" = ecoregions_richness,
                                  row.names  = NULL)

basins_richness <- tapply(species_basins$"gbif_key", 
                          species_basins$"BasinName", 
                          function(x) length(unique(x)))

basins_richness <- data.frame("BasinName" = names(basins_richness),
                              "richness"  = basins_richness,
                              row.names   = NULL)



## Add data to spatial layers ----

meow   <- merge(meow, ecoregions_richness, by = "ECO_CODE", all = TRUE)
basins <- merge(basins, basins_richness, by = "BasinName", all = TRUE)

meow$"richness"   <- ifelse(is.na(meow$"richness"), 0, meow$"richness")
basins$"richness" <- ifelse(is.na(basins$"richness"), 0, basins$"richness")


## Select fields ----

meow   <- meow[ , c("ECO_CODE", "ECOREGION", "richness")]
basins <- basins[ , c("BasinName", "richness")]


## Export richness layers ----

sf::st_write(meow, here::here("outputs", "phenofish_marine_richness.gpkg"))
sf::st_write(basins, here::here("outputs", "phenofish_freshwater_richness.gpkg"))

