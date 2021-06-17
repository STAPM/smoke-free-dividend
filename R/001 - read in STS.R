
### This code reads in in the raw toolkit data from the X drive and saves to the working repo as an R dataset
### ready for further cleaning

library(foreign)
library(data.table)

### for each stored version of toolkit, record the file name with the month/year of release
### data must be copied into the "data_raw folder in the repository

data_apr21 <- "omni174_39.1_65.2cot_31.3a_25.4s_recodes_60.5sa.sav"

### Run the ReadToolkit function to read in the raw SPSS data and save out an rds copy

ReadToolkit(path = "data_raw/",
            data = data_apr21,
            save = "data_intermediate/")


rm(data_apr21)
