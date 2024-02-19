#' Download GBIF occurrences
#' 
#' @description
#' This script uses the function `gbif_download_occ()` stores in the `R/` to
#' download GBIF occurrences (`rgbif::occ_download()`) for 34,903 species.
#' 
#' The ZIP files are exported in the `data/gbif/` folder (untracked by Git). 
#' Metadata of downloads are exported in the same folder as: 
#' `gbif_requests_keys.csv`.
#' 
#' @note
#' A GBIF account must be used to create the ZIP files. Create a GBIF account by
#' visiting this page <https://www.gbif.org/user/profile>.
#' Then, you must store your login information locally in the `~/.Renviron`
#' file. Use the function `usethis::edit_r_environ()` to create/open this file
#' and add the following three lines:
#' 
#' ```
#' GBIF_USER='your_username'
#' GBIF_PWD='your_password'
#' GBIF_EMAIL='your_email'
#' ```
#' 
#' Restart R, and check if everything is ok:
#' 
#' ```r
#' Sys.getenv("GBIF_USER")
#' Sys.getenv("GBIF_PWD")
#' Sys.getenv("GBIF_EMAIL")
#' ```


## Import Phenofish species names ----

species_list <- readRDS(here::here("outputs", "phenofish_species_w_gbif_id.rds"))


## Remove NA and duplicated GBIF ID ----

gbif_ids <- species_list$"gbif_key"

gbif_ids <- gbif_ids[!is.na(gbif_ids)]
gbif_ids <- gbif_ids[!duplicated(gbif_ids)]


## Download occurrences ----

gbif_download_occ(gbif_ids)


## Total number of occurrences ----

download_keys <- read.csv(here::here("data", "gbif", "gbif_requests_keys.csv"))
download_keys <- download_keys$"download_key"

n_occurrences <- rgbif::occ_download_list(limit = length(download_keys))

sum(n_occurrences$"results"$"totalRecords")
