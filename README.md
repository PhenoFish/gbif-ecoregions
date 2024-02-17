
<!-- README.md is generated from README.Rmd. Please edit that file -->

# World fish occurrences at ecoregion level <img src="https://raw.githubusercontent.com/FRBCesab/templates/main/logos/compendium-sticker.png" align="right" style="float:right; height:120px;"/>

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://choosealicense.com/licenses/mit/)
<!-- badges: end -->

<p align="left">
• <a href="#overview">Overview</a><br> • <a href="#data-sources">Data
sources</a><br> • <a href="#workflow">Workflow</a><br> •
<a href="#content">Content</a><br> •
<a href="#installation">Installation</a><br> •
<a href="#usage">Usage</a><br> • <a href="#citation">Citation</a><br> •
<a href="#contributing">Contributing</a><br> •
<a href="#acknowledgments">Acknowledgments</a><br> •
<a href="#references">References</a>
</p>

## Overview

This project is dedicated to retrieve and clean GBIF occurrences for all
fish species of the World. Occurrences are aggregated at the ecoregion
level for marine species and at the basin level for freshwater species.

## Data sources

- Fishbase
- GBIF
- MEOW
- Basin data

**{{ DESCRIBE ALL DATA }}**

## Workflow

**{{ DESCRIBE THE MAIN FEATURES }}**

Steps:

- Find GBIF accepted names & keys from Fishbase accepted names
- Get total number of occurrences per species
- Download batch of occurrences
- Clean occurrences
- Intersect occurrences w/ World Marine Ecoregions (marine)
- Intersect occurrences w/ World Freshwater Basins (terrestrial)

## Content

This repository is structured as follow:

- [`DESCRIPTION`](https://github.com/phenofish/gbif-ecoregions/blob/main/DESCRIPTION):
  contains project metadata (authors, description, license,
  dependencies, etc.).

- [`make.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/make.R):
  main R script to set up and run the entire project. Open this file to
  understand the workflow.

- [`R/`](https://github.com/phenofish/gbif-ecoregions/blob/main/R):
  contains R functions developed especially for this project

- [`data/`](https://github.com/phenofish/gbif-ecoregions/blob/main/data):
  contains raw data used in this project. See the
  [`README`](https://github.com/phenofish/gbif-ecoregions/blob/main/data/README.md)
  for further information.

- [`analyses/`](https://github.com/phenofish/gbif-ecoregions/blob/main/analyses):
  contains R scripts to run the workflow. The order to run these scripts
  is explained in the
  [`make.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/make.R)
  and the description of each script is available in the header of each
  file.

- [`outputs/`](https://github.com/phenofish/gbif-ecoregions/blob/main/outputs):
  contains the outputs of the project. See the
  [`README`](https://github.com/phenofish/gbif-ecoregions/blob/main/outputs/README.md)
  for a complete description of the files.

- [`figures/`](https://github.com/phenofish/gbif-ecoregions/blob/main/figures):
  contains the figures used to validate et visualize the outputs. See
  the
  [`README`](https://github.com/phenofish/gbif-ecoregions/blob/main/figures/README.md)
  for a complete description of the figures.

## Installation

To install this compendium:

- [Fork](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)
  this repository using the GitHub interface.
- [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
  your fork using `git clone fork-url` (replace `fork-url` by the URL of
  your fork). Alternatively, open [RStudio
  IDE](https://posit.co/products/open-source/rstudio/) and create a New
  Project from Version Control.

## Usage

Launch the
[`make.R`](https://github.com/phenofish/gbif-ecoregions/blob/main/make.R)
file with:

``` r
source("make.R")
```

**Notes**

- All required packages listed in the `DESCRIPTION` file will be
  installed (if necessary)
- All required packages and R functions will be loaded
- Some analyses listed in the `make.R` might take time

## Citation

Please use the following citation:

> **{{ ADD A CITATION }}**

## Contributing

All types of contributions are encouraged and valued. For more
information, check out our [Contributor
Guidelines](https://github.com/phenofish/gbif-ecoregions/blob/main/CONTRIBUTING.md).

Please note that this project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Acknowledgments

This project has been developed for the
[FRB-CESAB](https://www.fondationbiodiversite.fr/en/about-the-foundation/le-cesab/)
research group
[Phenofish](https://www.fondationbiodiversite.fr/en/the-frb-in-action/programs-and-projects/le-cesab/phenofish/)
that aims to create a global database of fish functional traits
integrating physiology and ecology across World aquatic ecosystems.

## References

**{{ OPTIONAL SECTION }}**
