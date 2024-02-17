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

### `MEOW/`

A folder containing the spatial layer of the 232 marine ecoregions of the World (MEOW) defined by Spalding _et al._ (2007) and downloaded from the [WWF](https://www.worldwildlife.org/publications/marine-ecoregions-of-the-world-a-bioregionalization-of-coastal-and-shelf-areas) website. It contains the following main fields:

- `ECO_CODE`: the code of the marine ecoregion;
- `ECOREGION`: the name of the marine ecoregion;
- `PROV_CODE`: the code of the marine province;
- `PROVINCE`: the name of the marine province;
- `RLM_CODE`: the code of the marine realm;
- `REALM`: the name of the marine realm.

This spatial layer is defined in the WGS 84 system (`EPSG = 4326`) and has been downloaded with the R function [`download_marine_ecoregions()`](https://github.com/phenofish/gbif-ecoregions/blob/main/R/download_marine_ecoregions.R).

To import this dataset, use the following line in R:

```r
meow <- sf::st_read(here::here("data", "MEOW", "meow_ecos.shp"))
```


### References

Spalding MD _et al._ (2007) Marine Ecoregions of the World: A Bioregionalization of Coastal and Shelf Areas. BioScience, 57(7), 573-583. DOI: <https://doi.org/10.1641/B570707>.
