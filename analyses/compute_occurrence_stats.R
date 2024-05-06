## get descriptive info about species occurrences 
library(tidyverse)

## Import GBIF downloads metadata ----

downloads_info <- read.csv(here::here("data", "gbif", "gbif_requests_keys.csv"))

stats <- c()
for (i in 1:nrow(downloads_info)) {
  
  ## Import species occurrences ----
  
  occ <- readRDS(here::here("data", "gbif", 
                            paste0(downloads_info[i, "download_key"], 
                                   "_clean.rds")))
  
  ## Calculate max, min, mean, 95th and 5th percentile ----
  stats <- occ %>%
    group_by(gbif_key) %>%
    summarize(occ_mean_latitude = mean(latitude),
              occ_max_latitude = max(latitude),
              occ_min_latitude = min(latitude),
              occ_95th_latitude = quantile(latitude, probs = 0.95),
              occ_5th_latitude = quantile(latitude, probs = 0.05), 
              num_occ = length(unique(latitude))) %>%
    rbind(., stats)
  
  
  i = i + 1
}

length(unique(stats$gbif_key)) ## 18939



## get gbif keys for phenofish species: 
phenofish_species_w_gbif_id <- readRDS(here::here("outputs/phenofish_species_w_gbif_id.rds"))
length(unique(phenofish_species_w_gbif_id$gbif_key))

## bind them: 
pf_occstats <- left_join(phenofish_species_w_gbif_id, stats)
length(unique(pf_occstats$gbif_key)) # 34904
length(which(is.na(pf_occstats$occ_mean_latitude))) # 15993 are missing gbif occurrence data

pf_occstats = filter(pf_occstats, !is.na(occ_mean_latitude))
nrow(pf_occstats)

any(duplicated(pf_occstats$gbif_key)) ## note: some gbif keys duplicated 


## write it out:
occurrence_stats = plot_data
saveRDS(occurrence_stats, here::here("outputs", "occurrence_stats.RData"))






