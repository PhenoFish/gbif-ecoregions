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

This table was produced by the script [`analyses/find_gbif_id.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/analyses/find_gbif_id.R)

To import this dataset, use the following line in R:

```r
species_list <- readRDS(here::here("outputs", "phenofish_species_w_gbif_id.rds"))
```

