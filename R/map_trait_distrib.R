#' Map spatial object at World ecoregions level or bassin for traits
#' 
#' @description
#' Represent a spatial metric on a World map of the traits
#' 
#' @param data a dataset of phenofish 
#' 
#' @ecosystems marine or freshwater
#' 
#' @param metric the column in `file` to map. The name of the column must be 
#'   unquoted (`metric = richness` or `metric = "trait_richness"`or `metric = "percentage"` ).
#'   Default is `richness`.
#' 
#' @param title a `character` of length 1. The title of the map. Default is
#'   `Number of marine fish species`.
#'   
#' @param type_traits if NULL all type traits, or morphological, physiological, ..
#' 
#' @param ecosystems marine or freshwater
#'
#' @return A `ggplot` object.
#' 
#' @export
#' 
#' @examples
#' ## ggmap_marine()



#'@data dataset of phenofish 


#'@traits_names if NULL all traits or names of a specic traits
prep_map_traits <- function(data, ecosystem,trait_type, trait_name, mypalette, title, metric, taxo_scale){
  #mypalette =  viridis::viridis(n=100, option = "turbo")
  #data = test_phenofish
  #trait_type = NULL    #trait_type = "physiological"
  #trait_name = NULL    #trait_name = "max_metabolic_rate"
  #ecosystem = "marine" #ecosystem = "freshwater"
  
  if(!is.null(taxo_scale)){
    data <- data[data$taxo_scale %in% taxo_scale,]
  }
  
  if(!is.null(trait_type)){
    data <- data[data$trait_type %in% trait_type,]
  }
  
  if(!is.null(trait_name)){
    data <- data[data$trait_name %in% trait_name,]
  }
  
  #Choose the ecosystems    
  if(ecosystem == "marine" ){ 
    
    ## Import marine ecoregions layer ----
    
    meow <- sf::st_read(here::here("data", "MEOW", "meow_ecos.shp"))
    
    ## Import species occurrences at ecoregion level ----
    species_ecoregions <- readRDS(here::here("outputs", 
                                             "phenofish_species_marine_ecoregions.rds"))
    ## Compute marine richness ----
    ecoregions_richness <- tapply(species_ecoregions$"gbif_key", 
                                  species_ecoregions$"ECO_CODE", 
                                  function(x) length(unique(x)))
    
    ecoregions_richness <- data.frame("ECO_CODE" = names(ecoregions_richness),
                                      "richness" = ecoregions_richness,
                                      row.names  = NULL)
    
    data$phenofish_name <- gsub(" ","_",data$phenofish_name)
    
    phenofish_species_w_gbif_id$fishbase_name <- tolower(phenofish_species_w_gbif_id$fishbase_name)
    
    data <- unique(data[,c("phenofish_name","worms_id")])
    
    species_ecoregions <- merge(phenofish_species_w_gbif_id,species_ecoregions, by = "gbif_key", all = T)
    
    traits_ecoregions <- merge(species_ecoregions,data,by.x = "fishbase_name", by.y ="phenofish_name", all.y = T)
    
    traits_richness <- tapply(traits_ecoregions$"gbif_key", 
                              traits_ecoregions$"ECO_CODE", 
                              function(x) length(unique(x)))
    
    traits_richness <- data.frame("ECO_CODE" = names(traits_richness),
                                  "trait_richness" = traits_richness,
                                  row.names  = NULL)
    traits_richness <- merge(ecoregions_richness,traits_richness, by= "ECO_CODE", all.x =T)
    
    traits_richness[is.na(traits_richness)] <- 0
    
    traits_richness$percentage <- (traits_richness$trait_richness/traits_richness$richness) * 100
    
    meow   <- merge(meow, traits_richness, by = "ECO_CODE", all = TRUE)
    
    sf::st_write(meow, here::here("outputs", "trait_marine_richness.gpkg"),append=FALSE) 
    }
  
  
  if(ecosystem == "freshwater" ){ 
    
    ## Import species occurrences at ecoregion/basin level ----
    
    species_basins <- readRDS(here::here("outputs", 
                                         "phenofish_species_drainage_basins.rds"))
    ## Import drainage basins layer ----
    basins <- sf::st_read(here::here("data", "basins", "Basin042017_3119.shp"))
    basins <- sf::st_make_valid(basins)
    
    
    ## Compute freshwater richness ----
    
    basins_richness <- tapply(species_basins$"gbif_key", 
                              species_basins$"BasinName", 
                              function(x) length(unique(x)))
    
    basins_richness <- data.frame("BasinName" = names(basins_richness),
                                  "richness"  = basins_richness,
                                  row.names   = NULL)
    
    data$phenofish_name <- gsub(" ","_",data$phenofish_name)
    
    data <- unique(data[,c("phenofish_name","worms_id")])
    
    species_basins <- merge(phenofish_species_w_gbif_id,species_basins, by = "gbif_key")
    
    traits_basins <- merge(species_basins,data,by.x = "fishbase_name", by.y ="phenofish_name",all.y = T)
    
    traits_richness <- tapply(traits_basins$"gbif_key", 
                              traits_basins$"BasinName", 
                              function(x) length(unique(x)))
    
    traits_richness <- data.frame("BasinName" = names(traits_richness),
                                  "trait_richness" = traits_richness,
                                  row.names  = NULL)
    traits_richness <- merge(basins_richness,traits_richness, by= "BasinName", all.x =T)
    
    traits_richness[is.na(traits_richness)] <- 0
    
    traits_richness$percentage <- (traits_richness$trait_richness/traits_richness$richness) * 100
    
    basins   <- merge(basins, traits_richness, by = "BasinName", all = TRUE)
    
    sf::st_write(basins, here::here("outputs", "trait_freshwater_richness.gpkg"),append=FALSE) 
  }
  
  
  ## Map marine richness ----
  if(ecosystem == "marine" ){
    map <- ggmap_marine(file =  here::here("outputs", "trait_marine_richness.gpkg" ), 
                        metric = metric, 
                        title = title,
                        mypalette = mypalette)
 
    ggplot2::ggsave(map, 
                    filename = here::here("figures", paste0(title,".png")),
                    width = 20, height = 13, units = "cm", dpi = 300, bg = "white")
  }
  
  if(ecosystem == "freshwater"){
    map <- ggmap_freshwater(file =  here::here("outputs", "trait_freshwater_richness.gpkg"), 
                            metric = metric, 
                            title = title,
                            mypalette = mypalette)
    ggplot2::ggsave(map, 
                    filename = here::here("figures", paste0(title,".png")),
                    width = 20, height = 13, units = "cm", dpi = 300, bg = "white")
  }
  
} 


