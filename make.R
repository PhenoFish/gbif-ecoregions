#' Set up and run the entire project
#' 
#' @description 
#' Retrieve World Fish GBIF Occurrences at Ecoregion/Basin Level.
#' Steps:
#'   - Find GBIF accepted names & keys from Fishbase accepted names
#'   - Download GBIF occurrences
#'   - Clean and check GBIF occurrences
#'   - Intersect occurrences w/ marine ecoregions layer (marine species)
#'   - Intersect occurrences w/ drainage basins layer (terrestrial species)
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@fondationbiodiversite.fr}
#' 
#' @date 2024/02/16



## Install Dependencies (listed in DESCRIPTION) ----

remotes::install_deps(upgrade = "never")


## Load Project Addins (R Functions and Packages) ----

pkgload::load_all(here::here())


## Download data (if required) ----

download_marine_ecoregions()
download_drainage_basins()


## Run Project ----

source(here::here("analyses", "retrieve_species_gbif_id.R"))
source(here::here("analyses", "download_gbif_occurrences.R"))
source(here::here("analyses", "clean_gbif_occurrences.R"))
source(here::here("analyses", "intersect_gbif_occurrences_marine.R"))
