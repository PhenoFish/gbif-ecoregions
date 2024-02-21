## Output description

### `phenofish_species_w_gbif_id.rds`

A table containing taxonomic information for 35,035 species with the following columns:

- `fishbase_id`: the species identifier in the [Fishbase](https://www.fishbase.se/search.php) database (used as species identifier in the Phenofish project);
- `fishbase_name`: the binomial name of the species in the Fishbase database (without space, used to merge tables);
- `fishbase_binomial`: the binomial name of the species in the Fishbase database;
- `fishbase_genus`: the genus name of the species in the Fishbase database;
- `fishbase_species`: the species name of the species in the Fishbase database;
- `worms_id`: the species identifier in the [WoRMS](https://www.marinespecies.org/) database;
- `gbif_accepted_name`: the species binomial name in the [GBIF](https://www.gbif.org/) database;
- `gbif_key`: the species identifier in the GBIF database;
- `gbif_phylum`: the species phylum in the GBIF database;
- `gbif_order`: the species order in the GBIF database;
- `gbif_family`: the species family in the GBIF database.

**Note:** The `gbif_*` fields can contain `NA` if the species was not found in the GBIF database. Moreover some lines can contain duplicated GBIF information if two or more original species names are considered as synonyms in the GBIF database.

This table was produced by the script [`analyses/retrieve_species_gbif_id.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/analyses/retrieve_species_gbif_id.R)

To import this dataset, use the following line in R:

```r
species_list <- readRDS(here::here("outputs", "phenofish_species_w_gbif_id.rds"))
```


### `phenofish_species_marine_ecoregions.rds`

A table containing the list of marine fish species per marine ecoregions obtained by intersecting GBIF occurrences and the MEOW spatial layer. It contains 17,205 species (column `gbif_key`) and 232 marine ecoregions (column `ECO_CODE`).

This table was produced by the script [`analyses/intersect_gbif_occurrences.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/analyses/intersect_gbif_occurrences.R)

To import this dataset, use the following line in R:

```r
species_ecoregions <- readRDS(here::here("outputs", "phenofish_species_marine_ecoregions.rds"))
```


### `phenofish_species_drainage_basins.rds`

A table containing the list of freshwater fish species per drainage basins obtained by intersecting GBIF occurrences and the Basins spatial layer. It contains 10,493 species (column `gbif_key`) and 2,215 drainage basins (column `BasinName`).

This table was produced by the script [`analyses/intersect_gbif_occurrences.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/analyses/intersect_gbif_occurrences.R)

To import this dataset, use the following line in R:

```r
species_basins <- readRDS(here::here("outputs", "phenofish_species_drainage_basins.rds"))
```


### `phenofish_marine_richness.gpkg`

A spatial layer containing the number of marine fish species (column `richness`) for each marine ecoregion (in rows). This spatial layer is defined in the WGS 84 system (`EPSG = 4326`)

This layer was produced by the script [`analyses/compute_species_richness.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/analyses/compute_species_richness.R)

To import this dataset, use the following line in R:

```r
marine_richness <- sf::st_read(here::here("outputs", "phenofish_marine_richness.gpkg"))
```

### `phenofish_freshwater_richness.gpkg`

A spatial layer containing the number of freshwater fish species (column `richness`) for each drainage basin (in rows). This spatial layer is defined in the WGS 84 system (`EPSG = 4326`)

This layer was produced by the script [`analyses/compute_species_richness.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/analyses/compute_species_richness.R)

To import this dataset, use the following line in R:

```r
freshwater_richness <- sf::st_read(here::here("outputs", "phenofish_freshwater_richness.gpkg"))
```
