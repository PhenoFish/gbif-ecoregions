#' Set up and run the entire project
#' 
#' @description 
#' Retrieve World Fish GBIF Occurrences at Ecoregion/Basin Level.
#' Steps:
#'   - Find GBIF accepted names & keys from Fishbase accepted names
#'   - Get total number of occurrences per species
#'   - Download batch of occurrences
#'   - Clean occurrences
#'   - Intersect occurrences w/ World Marine Ecoregions (marine)
#'   - Intersect occurrences w/ World Freshwater Basins (terrestrial)
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@fondationbiodiversite.fr}
#' 
#' @date 2024/02/16



## Install Dependencies (listed in DESCRIPTION) ----

remotes::install_deps(upgrade = "never")


## Load Project Addins (R Functions and Packages) ----

pkgload::load_all(here::here())


## Download / check data ----

download_marine_ecoregions()
download_drainage_basins()


## Run Project ----

source(here::here("analyses", "find_gbif_id.R"))
