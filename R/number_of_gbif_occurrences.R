#' Get the total number of GBIF occurrences
#'
#' @description
#' Given a GBIF usage key, retrieves the total number of GBIF occurrences w/ 
#' geographical coordinates and without any geospatial issue.
#'
#' @param gbif_key a `character` of length 1. The GBIF usage key.
#'
#' @return A `data.frame` with the following two columns:
#' - `gbif_key`: the GBIF usage key (input);
#' - `n_count`: the total number of GBIF occurrences.
#' 
#' @export
#'
#' @examples
#' ## Find accepted name ----
#' info <- find_gbif_id("Abalistes filamentosus")
#' 
#' ## Find total number of occurrences ----
#' number_of_gbif_occurrences(info$"gbif_key")

number_of_gbif_occurrences <- function(gbif_key) {
  
  ## Check argument 'gbif_key' ----
  
  if (missing(gbif_key)) {
    stop("Argument 'gbif_key' is required", call. = FALSE)
  }
  
  if (any(is.na(gbif_key))) {
    stop("Argument 'gbif_key' cannot contain NA", call. = FALSE)
  }
  
  if (!is.integer(gbif_key)) {
    stop("Argument 'gbif_key' must be an integer", call. = FALSE)
  }
  
  if (length(gbif_key) != 1) {
    stop("Argument 'gbif_key' must be of length 1", call. = FALSE)
  }
  
  
  data <- rgbif::occ_search(taxonKey = gbif_key, limit = 0, fields = "minimal", 
                            hasCoordinate = TRUE, hasGeospatialIssue = FALSE)
  
  data.frame("gbif_key" = gbif_key,
             "n_count"  = data$"meta"$"count")
}
