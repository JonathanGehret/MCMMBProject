# MCMMBProject: Species Distribution Modeling for Birds in Indonesian New Guinea

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R](https://img.shields.io/badge/R-%3E%3D4.0-blue.svg)](https://www.r-project.org/)

## 📋 Project Overview

This repository contains the code and analysis for comparing **IUCN range maps** of bird species with **Species Distribution Models (SDMs)** in Indonesian New Guinea (Papua & Papua Barat). The project addresses two main research questions:

1. **How do IUCN range maps of birds compare to SDMs in Indonesian New Guinea?**
2. **What are the main environmental predictors for bird species distributions in this region?**

### Authors

- **Jonathan Gehret** (GitHub: [@JonathanGehret](https://github.com/JonathanGehret))
- **Paul Leister** (GitHub: [@paulleister](https://github.com/paulleister))

### Academic Context

This project was created as a course project for **"Modern Concepts and Methods in Macroecology and Biogeography" (MCMMB)** during the Master of Science program in **Forest Ecosystem Sciences** (Study Track: Ecosystem Analysis and Modelling) at the **University of Göttingen**, Germany.

**Date:** August 2021

---

## 🔬 Scientific Summary

This project uses R to:

1. **Collect and process biodiversity data:**
   - IUCN range maps from BirdLife International
   - Occurrence data from GBIF (Global Biodiversity Information Facility)

2. **Prepare environmental predictors:**
   - Elevation
   - Temperature
   - Precipitation
   - Land cover
   - Primary forest coverage
   - Human population density

3. **Build Species Distribution Models** using the `biomod2` package with multiple algorithms:
   - Generalized Linear Models (GLM)
   - Generalized Additive Models (GAM)
   - Artificial Neural Networks (ANN)
   - Random Forest (RF)
   - Ensemble models combining the above

4. **Compare model outputs** with IUCN expert range maps to evaluate model performance

### Study Species

The analysis focuses on four species of the *Pachycephala* genus (whistlers):
- *Pachycephala lorentzi* (Lorentz's Whistler)
- *Pachycephala meyeri* (Vogelkop Whistler)
- *Pachycephala schlegelii* (Regent Whistler)
- *Pachycephala soror* (Sclater's Whistler)

---

## 📁 Repository Structure

```
MCMMBProject/
├── MCMMB.Rmd              # Main R Markdown document (reproducible analysis)
├── MCMMB.html             # Rendered HTML report
├── MCMMB_Main.R           # Setup script: libraries, data loading, preprocessing
├── species_loops.R        # Functions for extracting species data (IUCN & GBIF)
├── presence_absence.R     # Pseudo-absence data generation
├── Indicator.R            # Environmental predictor processing
├── sdm_biomod2.R          # SDM modeling functions using biomod2
├── bird_plot_loops.R      # Utility for plotting all species distributions
├── references.bib         # Bibliography for the R Markdown document
├── global-ecology-and-biogeography.csl  # Citation style file
├── data/                  # Data directory (partially gitignored)
│   ├── indicator_stack/   # Processed environmental rasters (.tif)
│   ├── gbif/              # GBIF occurrence data
│   ├── Papua_Birdlife_project/  # IUCN BirdLife shapefiles
│   └── grid/              # Grid shapefiles for the study region
├── images/                # Output images and figures
├── unused_scripts/        # Archive of development/backup scripts
└── old_cache/             # Archived HTML outputs
```

---

## 🚀 Getting Started

### Prerequisites

- **R** (version ≥ 4.0 recommended)
- **RStudio** (recommended for running R Markdown)

### Required R Packages

Install the required packages by running:

```r
install.packages(c(
  "biomod2",    # Species distribution modeling
  "raster",     # Raster data handling
  "rgdal",      # Geospatial data abstraction (Note: being deprecated, see sf)
  "rgeos",      # Geometry operations
  "sf",         # Simple features for R (modern spatial data)
  "spatialEco", # Spatial ecology tools
  "dplyr",      # Data manipulation
  "knitr",      # R Markdown rendering
  "xfun"        # Utilities for knitr
))
```

> ⚠️ **Note (2025):** The `rgdal` and `rgeos` packages have been retired from CRAN as of 2023. For modern workflows, consider migrating to `sf` and `terra` packages. This code was written in 2021 and may require updates for full compatibility with current R versions.

### Data Requirements

The analysis requires the following data (not fully included in the repository due to size):

1. **GBIF Occurrence Data:**
   - Download bird occurrence data for Indonesia from [GBIF](https://www.gbif.org/)
   - Place in `data/gbif/`

2. **IUCN BirdLife Range Maps:**
   - Obtain from [BirdLife International](http://datazone.birdlife.org/)
   - Place shapefiles in `data/Papua_Birdlife_project/`

3. **Environmental Predictors:**
   - **Elevation:** SRTM or similar DEM
   - **Climate data (Temperature, Precipitation):** [CHELSA](https://chelsa-climate.org/)
   - **Land cover:** [ESA CCI Land Cover](https://www.esa-landcover-cci.org/) or similar
   - **Primary forest:** [Intact Forest Landscapes](http://www.intactforests.org/)
   - **Population density:** WorldPop or similar

   Processed `.tif` files should be placed in `data/indicator_stack/`

---

## 📊 Running the Analysis

### Option 1: Knit the R Markdown Document

Open `MCMMB.Rmd` in RStudio and click **Knit** to generate the full HTML report with all analyses and figures.

### Option 2: Run Scripts Individually

1. **Load libraries and data:**
   ```r
   source("MCMMB_Main.R")
   ```

2. **Extract species data:**
   ```r
   source("species_loops.R")
   bird_names <- c("Pachycephala lorentzi", "Pachycephala meyeri", 
                   "Pachycephala schlegelii", "Pachycephala soror")
   iucn_birds <- get_iucn_birds(bird_names, birdlife, regio)
   gbif_birds <- get_gbif_birds(bird_names, gbif_crop, regio)
   ```

3. **Generate pseudo-absence data:**
   ```r
   source("presence_absence.R")
   presence_absence_list <- create_pseudo_absence(regio, gbif_birds)
   ```

4. **Run SDM models:**
   ```r
   source("sdm_biomod2.R")
   tif_predictors <- stack(list.files("data/indicator_stack/", 
                                       full.names = TRUE, pattern = ".tif"))
   gbif_sdms <- calculate_sdm(presence_absence_list, tif_predictors)
   ```

---

## 📖 Key References

- Griffith, D. M. (2017). Species Distribution Modeling in R.
- Araújo, M. B., et al. (2019). Standards for distribution models in biodiversity assessments. *Science Advances*, 5(1), eaat4858.
- Thuiller, W., et al. (2009). BIOMOD – a platform for ensemble forecasting of species distributions. *Ecography*, 32(3), 369-373.

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

This means you are free to use, modify, and distribute this code for any purpose, including commercial use, as long as you include the original copyright notice and license.

---

## 🙏 Acknowledgments

- **University of Göttingen** - Faculty of Forest Sciences and Forest Ecology
- Course instructors for "Modern Concepts and Methods in Macroecology and Biogeography"
- [GBIF](https://www.gbif.org/) for occurrence data
- [BirdLife International](https://www.birdlife.org/) for range map data
- [CHELSA](https://chelsa-climate.org/) for climate data
- The R community and `biomod2` package developers

---

## 📧 Contact

For questions or collaboration inquiries, please open an issue on this repository or contact the authors through GitHub.

---

*Last updated: November 2025*
