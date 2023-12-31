### This aim of this code is to run the individual R scripts that make up the
### full workflow for the smoke free dividend analysis used in the paper

rm(list = ls())

## specify inputs
data_file <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav" # Toolkit data file used for the paper
version <- "1.6.3"            # smkfreediv package version which replicates the paper results (1.6.3 for tobacco control paper)

### ----- (0) Setup -------------- ###

#source("R/001 - package installation.R")
source("R/003 - load packages.R")

### ----- (1) Data Cleaning -------- ###
source("R/011 - clean toolkit data.R")
source("R/017 - consumption patterns.R")

### ----- (2) Run the Analysis --------- ###
source("R/021 - estimate the upshift.R")
source("R/022 - average weekly spending.R")
source("R/023 - local authority and region level analysis.R")

### ----- (4) process results and write out outputs ------- ###
source("R/041 - write results tables.R")
source("R/045 - final figures for the paper (sf).R")
