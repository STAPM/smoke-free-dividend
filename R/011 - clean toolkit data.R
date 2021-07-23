## The aim of this code is to read in the raw toolkit data from .sav format, clean, and save
## out a filtered/cleaned dataset in .rds format ready for analysis.


## (1) Read in the data - save an RDS data file to the data input folder so this
##                        part of the code need only be run once.

toolkit_raw <- smkfreediv::ReadToolkit(path = paste0(Dir[1],"/"),
                                       data = data,
                                       save = TRUE)

## (2) Clean the data, retain only needed variables and waves, and save the
##     cleaned data back to the raw inputs folder

toolkit_raw <- readRDS(paste0(Dir[1],"/STS_data_raw.rds"))

toolkit_clean <- smkfreediv::CleanToolkit(data = toolkit_raw,
                                          start_month = 90,
                                          end_month = 160)

## (3) Deflate expenditure to December 2018

toolkit_clean <- smkfreediv::DeflateToolkit(data = toolkit_clean,
                                            index = smkfreediv::cpi_tobacco,
                                            base_month = 12,
                                            base_year = 2018)


saveRDS(toolkit_clean, paste0(Dir[1],"/toolkit_clean.rds"))
rm(toolkit_raw)
