
<!-- README.md is generated from README.Rmd. Please edit that file -->

# The potential smoke-free dividend from quitting for smokers across local areas in England: A cross-sectional analysis - code repository

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

## Introduction

The purpose of this repository is to provide reproducible code and data
inputs to produce the results of the paper “The potential smoke-free
dividend from quitting for smokers across local areas in England: A
cross-sectional analysis”.

## Usage

Fork the project on GitHub to create your own repository. This project
uses [`renv`](https://rstudio.github.io/renv/articles/renv.html) to aid
reproducibility of results by ensuring users make use of the same
environment.

When a new user first launches in this project, `renv` should
automatically bootstrap itself, thereby downloading and installing the
appropriate version of `renv` into the project library. After this has
completed, they can then use `renv::restore()` to restore the project
library locally on their machine.

Once the project library is restored, the repository is ready to be used
to replicate the analysis once the requirements below are met.

The R scripts which reproduce the analysis are stored in the `R/`
directory. The script `run_analyses.R` in the top level of the
repository is a metafile which runs all of the scripts in order. The key
outputs are saved to `outputs/main results/`.

## Requirements

All data inputs required are available in the repository or part of the
R package `smkfreediv` which is open source and available on
[GitHub](https://github.com/STAPM/smkfreediv). The exception to this is
the Smoking Toolkit Study (STS) data which cannot be provided.

### R Package

The analysis requires the use of the `smkfreediv` R package, which
contains functions and data inputs needed to calculate the amount of
upshifting required to account for underreporting of spending data in
the STS and to combine data sources to calculate the smoke free
dividend. The version of `smkfreediv` which produced the analysis in the
paper is **1.6.3**. It is not guaranteed that the code in this
repository will still work with later versions of the package.
`smkfreediv` is part of the `renv` environment and is restored with the
other CRAN packages when using `renv::restore()`

To install the package from GitHub with the version used to produce the
paper, run the follwowing code (also contained in the
`001 - package installation.R` script file).

``` r

devtools::install_git(
  "https://github.com/STAPM/smkfreediv.git",
  ref = "1.6.3",
  build_vignettes = FALSE
)
```

### Smoking Toolkit Study

In order to run the analysis the user must provide their own version of
the STS data. The raw SPSS file for the STS data must be stored in the
`input_data/` directory within the project repository and the name of
the file (including .sav extension) should be updated in the `data_file`
object created in the `run_analyses.R` file located in the root
directory of the repository. e.g. for the April 2021 data the paper was
produced using:

``` r
data_file <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav"
```

## Reproducibility

Note that this repository uses the renv R package to produce a
reproducible environment for this analysis. see the [package
website](https://rstudio.github.io/renv/articles/renv.html) for more
information.

When first launching the project, the function `renv::restore()` will
populate the `renv/library` folder, installing the R packages saved in
the lockfifle.

The lockfile `renv.lock` is in the top level of the repository, and
contains the metadata for all R packages used in the project. The
libraries themselves are ignored by git and not uploaded to GitHub, and
so a new user needs to install the packages themselves using the
metadata.

The .Rprofile file in the top level of the repository is automatically
run when the project is opened and this runs the script file
`renv/activate.R` to set the renv folder as the source R package
library.

The version of R used to produce the analysis is 4.3.1.

## Citation

Please cite this code repository as:

Morris D (2023) The potential smoke-free dividend across local areas in
England: A cross-sectional analysis - code and data repository 2023.
*University of Sheffield*. <doi:10.17605/OSF.IO/VZMP7>.
