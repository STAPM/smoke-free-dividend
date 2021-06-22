### This aim of this code is to run the individual R scripts that make up the
### full workflow for the smoke free dividend analysis.

library(smkfreediv)
library(data.table)
library(tidyverse)

### ----------- Setup -------------- ###

data <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav"

source("R/000 - create directories.R")

### --------- Data Cleaning -------- ###
source("R/001 - clean toolkit data.R")
source("R/002 - read and clean shapefiles.R")

### ----- Run the Analysis --------- ###
source("R/010 - local authority analysis.R")

### ----- Results Processing ------- ###
source("R/020 - results.R")


