### This file contains the workflow for using the smkfreediv package in
### calculating the smoke free dividend

library(smkfreediv)
library(data.table)

data <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav"

### ----------- Setup -------------- ###

source("R/000 - create directories.R")
source("R/001 - clean toolkit data.R")

### ----- Run the Analysis --------- ###

source("R/010 - local authority analysis.R")

### ----- Results --------- ###

source("R/020 - results.R")


