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
source(here::here("analyses", "compute_species_richness.R"))


## Run plot for phenofish ----
load("~/Documents/CNRS/PHENOFISH/Data_management/git_organisation/betaFish/outputs/test_phenofish.RData")

phenofish_species_w_gbif_id <- readRDS(here::here("outputs/phenofish_species_w_gbif_id.rds"))

prep_map_traits(data = test_phenofish, 
                            ecosystem = "marine",
                            trait_type = "morphological", 
                            trait_name = NULL, 
                            mypalette = viridis::viridis(n=100, option = "turbo"), 
                            title = "Number of species with at least one individual morphological traits", 
                            metric = "trait_richness",
                            taxo_scale = "individual")

prep_map_traits(data = test_phenofish, 
                ecosystem = "marine",
                trait_type = NULL, 
                trait_name = "tmax", 
                mypalette = viridis::viridis(n=100, option = "turbo"), 
                title = "Number of marine sp with Tmax value", 
                metric = "trait_richness",
                taxo_scale = NULL)

prep_map_traits(data = test_phenofish, 
                ecosystem = "freshwater",
                trait_type = NULL, 
                trait_name = "tmax", 
                mypalette = viridis::viridis(n=100, option = "turbo"), 
                title = "Number of freshwater sp with Tmax value", 
                metric = "trait_richness",
                taxo_scale = NULL)


prep_map_traits(data = test_phenofish, 
                ecosystem = "marine",
                trait_type = NULL, 
                trait_name = "tmax", 
                mypalette = viridis::viridis(n=100, option = "turbo"), 
                title = "Percentage of marine sp with Tmax value", 
                metric = "percentage",
                taxo_scale = NULL)

prep_map_traits(data = test_phenofish, 
                ecosystem = "freshwater",
                trait_type = NULL, 
                trait_name = "tmax", 
                mypalette = viridis::viridis(n=100, option = "turbo"), 
                title = "Percentage of freshwater sp with Tmax value", 
                metric = "percentage",
                taxo_scale = NULL)

prep_map_traits(data = test_phenofish, 
                ecosystem = "freshwater",
                trait_type = NULL, 
                trait_name = "excreted_n_p", 
                mypalette = viridis::viridis(n=100, option = "turbo"), 
                title = "Number of freshwater sp with excreted_n_p at individual", 
                metric = "trait_richness",
                taxo_scale = NULL)


prep_map_traits(data = test_phenofish, 
                ecosystem = "marine",
                trait_type = NULL, 
                trait_name = NULL, 
                mypalette = viridis::viridis(n=100, option = "turbo"), 
                title = "number_of_marine_fish_species", 
                metric = "richness",
                taxo_scale = NULL)



  #pal =  
  #data = test_phenofish
  #trait_type = NULL    #trait_type = "physiological"
  #trait_name = NULL    #trait_name = "head_depth"
  #ecosystem = "marine" #ecosystem = "freshwater"
  
