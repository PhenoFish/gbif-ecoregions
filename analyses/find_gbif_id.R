#' Find GBIF identifier of the Phenofish species
#' 
#' @description
#' This script uses the function `find_gbif_id()` stores in the `R/` folder.
#' For 35,035 species, it takes ~ 60 mins.
#' 
#' Among the 35,035 species,
#' -  17 Phenofish species are not found in the GBIF system;
#' - 115 GBIF accepted names are duplicated (2 or more Phenofish species have 
#'   the same GBIF identifier);
#' - 616 Phenofish accepted names are synonyms in the GBIF system.
#' 
#' The final table is exported in the `outputs/` folder as 
#' `phenofish_species_w_gbif_id.rds`.


## Import Phenofish species names ----

species_list <- readRDS(here::here("data", "phenofish_species_info.rds"))

n <- nrow(species_list)


## Find GBIF ids ----

gbif_ids <- list()

for (i in 1:n) {
  
  cat(paste0("Find GBIF ID - ", round(100 * i / n, 1), "%   \r"))
  
  info <- find_gbif_id(species_list[i, "fishbase_binomial"])
  
  gbif_ids[[length(gbif_ids) + 1]] <- info
}

gbif_ids <- do.call(rbind, gbif_ids)


## Number of not found species ----

nrow(species_list) - nrow(gbif_ids)


## Number of duplicated accepted names ----

sum(duplicated(gbif_ids$"gbif_accepted_name"))


## Number of GBIF accepted names != Fishbase name ----

sum(gbif_ids$"search_terms" != gbif_ids$"gbif_accepted_name")


## Merge tables ----

species_list <- merge(species_list, gbif_ids, by.x = "fishbase_binomial",
                      by.y = "search_terms", all = TRUE)


## Export table ----

saveRDS(species_list, here::here("outputs", "phenofish_species_w_gbif_id.rds"))
