## Data description

### `phenofish_species_info.rds`

A table containing taxonomic information for 35,035 species with the following columns:

- `fishbase_id`: the species identifier in the [Fishbase](https://www.fishbase.se/search.php) database (used as species identifier in the Phenofish project);
- `fishbase_name`: the binomial name of the species in the Fishbase database (without space, used to merge tables);
- `fishbase_binomial`: the binomial name of the species in the Fishbase database;
- `fishbase_genus`: the genus name of the species in the Fishbase database;
- `fishbase_species`: the species name of the species in the Fishbase database;
- `worms_id`: the species identifier in the [WoRMS](https://www.marinespecies.org/) database.

To import this dataset, use the following line in R:

```r
species_list <- readRDS(here::here("data", "phenofish_species_info.rds"))
```
