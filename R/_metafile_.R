### This aim of this code is to run the individual R scripts that make up the
### full workflow for the smoke free dividend analysis.
rm(list = ls())

### ----- (0) Setup -------------- ###
data <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav" # data
version <- "1.0.0"            # smkfreediv package version to use
user <- "djmorris1989"        # GitLab user name for package installation

source("R/001 - package installation.R")
source("R/002 - create directories.R")

library(smkfreediv)
library(data.table)

### ----- (1) Data Cleaning -------- ###
source("R/011 - clean toolkit data.R")
source("R/012 - read and clean shapefiles.R")

### ----- (2) Run the Analysis --------- ###
source("R/021 - local authority analysis.R")

### ----- (3) Results Processing ------- ###
source("R/031 - local authority results.R")

source("R/035 - local authority results tables.R")

### ----- (4) Markdowns ------- ###

source("R/040 - render markdowns.R")
