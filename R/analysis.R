### This file contains the workflow for using the smkfreediv package in
### calculating the smoke free dividend

library(smkfreediv)
library(data.table)

### ----------- Setup -------------- ###

# Create a directory in the current R project to save raw data. Copy
# the raw toolkit data SPSS file to the directory "data_input"

data <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav"

rawdatDir <- "data_input"
if(!dir.exists(here::here(rawdatDir))) {dir.create(here::here(rawdatDir))}

intdatDir <- "data_input"
if(!dir.exists(here::here(intdatDir))) {dir.create(here::here(intdatDir))}

### -------------------------------- ###

## (1) Read in the data - save an RDS data file to the data input folder so this
##                        part of the code need only be run once.

toolkit_raw <- smkfreediv::ReadToolkit(path = paste0(rawdatDir,"/"),
                                       data = data,
                                       save = TRUE)

## (2) Clean the data, retain only needed variables and waves

toolkit_raw <- readRDS(paste0(rawdatDir,"/STS_data_raw.rds"))

toolkit_clean <- smkfreediv::CleanToolkit(data = toolkit_raw,
                                          start_month = 90,
                                          end_month = 160)
saveRDS(toolkit_clean, paste0(intdatDir,"/toolkit_clean"))
rm(toolkit_raw)

## (3) Calculate mean weekly expenditure by upper-tier local authority

toolkit_clean <- readRDS(paste0(intdatDir,"/toolkit_clean"))

mean_spend_la <- smkfreediv::CalcWeekSpend(data = toolkit_clean,
                                           strat_vars = c("UTLAcode","UTLAname"))

mean_spend_la <- mean_spend_la[order(UTLAname)]

## (4) Grab the income data

income <- smkfreediv::GetIncome(income_var = 3)
