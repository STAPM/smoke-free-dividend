
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
paper is 1.6.2. It is not guaranteed that the code in this repository
will still work with later versions of the package.

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

Note that this repository uses the `renv` R package to produce a
reproducible environment for this analysis. see [the package
website](https://rstudio.github.io/renv/articles/renv.html) for more
information.

If any packages are updated

## Citation

Please cite as:

## Computational environment

This repository was last updated on 2023-12-13 14:13:38 and used the
following computational environment and dependencies:

``` r
# which R packages and versions?
if ("devtools" %in% installed.packages()) devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.2.3 (2023-03-15 ucrt)
#>  os       Windows 10 x64 (build 19044)
#>  system   x86_64, mingw32
#>  ui       RTerm
#>  language (EN)
#>  collate  English_United Kingdom.utf8
#>  ctype    English_United Kingdom.utf8
#>  tz       Europe/London
#>  date     2023-12-13
#>  pandoc   2.19.2 @ C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools/ (via rmarkdown)
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date (UTC) lib source
#>  abind         1.4-5   2016-07-21 [1] CRAN (R 4.2.0)
#>  backports     1.4.1   2021-12-13 [1] CRAN (R 4.2.0)
#>  broom         1.0.5   2023-06-09 [1] CRAN (R 4.2.3)
#>  cachem        1.0.8   2023-05-01 [1] CRAN (R 4.2.3)
#>  callr         3.7.3   2022-11-02 [1] CRAN (R 4.2.3)
#>  car           3.1-2   2023-03-30 [1] CRAN (R 4.2.3)
#>  carData       3.0-5   2022-01-06 [1] CRAN (R 4.2.3)
#>  cellranger    1.1.0   2016-07-27 [1] CRAN (R 4.2.3)
#>  cli           3.6.1   2023-03-23 [1] CRAN (R 4.2.3)
#>  colorspace    2.1-0   2023-01-23 [1] CRAN (R 4.2.3)
#>  crayon        1.5.2   2022-09-29 [1] CRAN (R 4.2.3)
#>  data.table  * 1.14.8  2023-02-17 [1] CRAN (R 4.2.3)
#>  devtools      2.4.5   2022-10-11 [1] CRAN (R 4.2.3)
#>  digest        0.6.32  2023-06-26 [1] CRAN (R 4.2.3)
#>  dplyr       * 1.1.2   2023-04-20 [1] CRAN (R 4.2.3)
#>  ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.2.3)
#>  evaluate      0.21    2023-05-05 [1] CRAN (R 4.2.3)
#>  fansi         1.0.4   2023-01-22 [1] CRAN (R 4.2.3)
#>  fastmap       1.1.1   2023-02-24 [1] CRAN (R 4.2.3)
#>  forcats     * 1.0.0   2023-01-29 [1] CRAN (R 4.2.3)
#>  foreign       0.8-84  2022-12-06 [1] CRAN (R 4.2.3)
#>  fs            1.6.2   2023-04-25 [1] CRAN (R 4.2.3)
#>  generics      0.1.3   2022-07-05 [1] CRAN (R 4.2.3)
#>  ggplot2     * 3.4.2   2023-04-03 [1] CRAN (R 4.2.3)
#>  ggpubr      * 0.6.0   2023-02-10 [1] CRAN (R 4.2.3)
#>  ggsignif      0.6.4   2022-10-13 [1] CRAN (R 4.2.3)
#>  glue          1.6.2   2022-02-24 [1] CRAN (R 4.2.3)
#>  gtable        0.3.3   2023-03-21 [1] CRAN (R 4.2.3)
#>  here        * 1.0.1   2020-12-13 [1] CRAN (R 4.2.3)
#>  hms           1.1.3   2023-03-21 [1] CRAN (R 4.2.3)
#>  htmltools     0.5.5   2023-03-23 [1] CRAN (R 4.2.3)
#>  htmlwidgets   1.6.2   2023-03-17 [1] CRAN (R 4.2.3)
#>  httpuv        1.6.11  2023-05-11 [1] CRAN (R 4.2.3)
#>  knitr         1.43    2023-05-25 [1] CRAN (R 4.2.3)
#>  later         1.3.1   2023-05-02 [1] CRAN (R 4.2.3)
#>  lattice       0.20-45 2021-09-22 [1] CRAN (R 4.2.3)
#>  lifecycle     1.0.3   2022-10-07 [1] CRAN (R 4.2.3)
#>  lubridate   * 1.9.2   2023-02-10 [1] CRAN (R 4.2.3)
#>  magrittr    * 2.0.3   2022-03-30 [1] CRAN (R 4.2.3)
#>  maptools    * 1.1-7   2023-05-29 [1] CRAN (R 4.2.3)
#>  memoise       2.0.1   2021-11-26 [1] CRAN (R 4.2.3)
#>  mime          0.12    2021-09-28 [1] CRAN (R 4.2.0)
#>  miniUI        0.1.1.1 2018-05-18 [1] CRAN (R 4.2.3)
#>  munsell       0.5.0   2018-06-12 [1] CRAN (R 4.2.3)
#>  openxlsx    * 4.2.5.2 2023-02-06 [1] CRAN (R 4.2.3)
#>  pillar        1.9.0   2023-03-22 [1] CRAN (R 4.2.3)
#>  pkgbuild      1.4.2   2023-06-26 [1] CRAN (R 4.2.3)
#>  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.2.3)
#>  pkgload       1.3.2   2022-11-16 [1] CRAN (R 4.2.3)
#>  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.2.3)
#>  processx      3.8.2   2023-06-30 [1] CRAN (R 4.2.3)
#>  profvis       0.3.8   2023-05-02 [1] CRAN (R 4.2.3)
#>  promises      1.2.0.1 2021-02-11 [1] CRAN (R 4.2.3)
#>  ps            1.7.5   2023-04-18 [1] CRAN (R 4.2.3)
#>  purrr       * 1.0.1   2023-01-10 [1] CRAN (R 4.2.3)
#>  R6            2.5.1   2021-08-19 [1] CRAN (R 4.2.3)
#>  Rcpp          1.0.10  2023-01-22 [1] CRAN (R 4.2.3)
#>  readr       * 2.1.4   2023-02-10 [1] CRAN (R 4.2.3)
#>  readxl      * 1.4.2   2023-02-09 [1] CRAN (R 4.2.3)
#>  remotes       2.4.2   2021-11-30 [1] CRAN (R 4.2.3)
#>  renv          1.0.3   2023-09-19 [1] CRAN (R 4.2.3)
#>  rgdal       * 1.6-7   2023-05-31 [1] CRAN (R 4.2.3)
#>  rgeos       * 0.6-3   2023-05-24 [1] CRAN (R 4.2.3)
#>  rlang         1.1.1   2023-04-28 [1] CRAN (R 4.2.3)
#>  rmarkdown     2.23    2023-07-01 [1] CRAN (R 4.2.3)
#>  rprojroot     2.0.3   2022-04-02 [1] CRAN (R 4.2.3)
#>  rstatix       0.7.2   2023-02-01 [1] CRAN (R 4.2.3)
#>  rstudioapi    0.14    2022-08-22 [1] CRAN (R 4.2.3)
#>  scales      * 1.2.1   2022-08-20 [1] CRAN (R 4.2.3)
#>  sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.2.3)
#>  shiny         1.7.4   2022-12-15 [1] CRAN (R 4.2.3)
#>  smkfreediv  * 1.6.3   2023-12-13 [1] git2r (https://github.com/STAPM/smkfreediv.git@195c21e)
#>  sp          * 2.0-0   2023-06-22 [1] CRAN (R 4.2.3)
#>  stringi       1.7.12  2023-01-11 [1] CRAN (R 4.2.2)
#>  stringr     * 1.5.0   2022-12-02 [1] CRAN (R 4.2.3)
#>  tibble      * 3.2.1   2023-03-20 [1] CRAN (R 4.2.3)
#>  tidyr       * 1.3.0   2023-01-24 [1] CRAN (R 4.2.3)
#>  tidyselect    1.2.0   2022-10-10 [1] CRAN (R 4.2.3)
#>  tidyverse   * 2.0.0   2023-02-22 [1] CRAN (R 4.2.3)
#>  timechange    0.2.0   2023-01-11 [1] CRAN (R 4.2.3)
#>  tzdb          0.4.0   2023-05-12 [1] CRAN (R 4.2.3)
#>  urlchecker    1.0.1   2021-11-30 [1] CRAN (R 4.2.3)
#>  usethis       2.2.1   2023-06-23 [1] CRAN (R 4.2.3)
#>  utf8          1.2.3   2023-01-31 [1] CRAN (R 4.2.3)
#>  vctrs         0.6.3   2023-06-14 [1] CRAN (R 4.2.3)
#>  withr         2.5.0   2022-03-03 [1] CRAN (R 4.2.3)
#>  xfun          0.39    2023-04-20 [1] CRAN (R 4.2.3)
#>  xtable        1.8-4   2019-04-21 [1] CRAN (R 4.2.3)
#>  yaml          2.3.7   2023-01-23 [1] CRAN (R 4.2.3)
#>  zip           2.3.0   2023-04-17 [1] CRAN (R 4.2.3)
#> 
#>  [1] X:/ScHARR/PR_SPECTRUM/Workpackages/WP6 Evaluation Langley/Smokefree Dividend/R/smoke-free-dividend/renv/library/R-4.2/x86_64-w64-mingw32
#>  [2] C:/Users/cm1djm/AppData/Local/R/cache/R/renv/sandbox/R-4.2/x86_64-w64-mingw32/19d6eec0
#> 
#> ──────────────────────────────────────────────────────────────────────────────
```

The current Git commit details are (currently a private repository):

``` r
# what commit is this file at? 
if ("git2r" %in% installed.packages() & git2r::in_repository(path = ".")) git2r::repository(here::here())  
```
