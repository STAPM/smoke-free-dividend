### This aim of this code is to run the individual R scripts that make up the
### full workflow for the smoke free dividend analysis.
rm(list = ls())

### ----- (0) Setup -------------- ###
data <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav" # data
version <- "1.0.3"            # smkfreediv package version to use
user <- "djmorris1989"        # GitLab user name for package installation

source("R/000 - create directories.R")
#source("R/001 - package installation.R")

library(smkfreediv)
library(data.table)

### ----- (1) Data Cleaning -------- ###
source("R/011 - clean toolkit data.R")
source("R/012 - read and clean shapefiles.R")

### ----- (2) Run the Analysis --------- ###
source("R/020 - estimate the upshift.R")
source("R/021 - local authority analysis.R")

### ----- (3) Results Processing ------- ###
source("R/031 - results plots.R")
source("R/032 - results heat map plots.R")

source("R/035 - results tables local authority.R")

### ----- (4) Markdowns ------- ###
source("R/040 - render markdowns.R")
