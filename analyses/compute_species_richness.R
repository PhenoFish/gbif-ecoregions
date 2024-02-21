#' Compute species richness per ecoregions and drainage basins
#' 
#' @description
#' The `.gpkg` files are exported in the `outputs/` folder as 
#' `phenofish_marine_richness.gpkg` and
#' `phenofish_freshwater_richness.gpkg`.


## Import species occurrences at ecoregion/basin level ----

species_ecoregions <- readRDS(here::here("outputs", 
                                         "phenofish_species_marine_ecoregions.rds"))

species_basins <- readRDS(here::here("outputs", 
                                     "phenofish_species_drainage_basins.rds"))


## Compute marine richness ----

ecoregions_richness <- tapply(species_ecoregions$"gbif_key", 
                              species_ecoregions$"ECO_CODE", 
                              function(x) length(unique(x)))

ecoregions_richness <- data.frame("ECO_CODE" = names(ecoregions_richness),
                                  "richness" = ecoregions_richness,
                                  row.names  = NULL)


## Compute freshwater richness ----

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


## Map marine richness ----

map <- ggmap_marine()
ggplot2::ggsave(map, 
                filename = here::here("figures", 
                                      "number_of_marine_fish_species.png"),
                width = 20, height = 13, units = "cm", dpi = 300, bg = "white")


## Map freshwater richness ----

map <- ggmap_freshwater()
ggplot2::ggsave(map, 
                filename = here::here("figures", 
                                      "number_of_freshwater_fish_species.png"),
                width = 20, height = 13, units = "cm", dpi = 300, bg = "white")
