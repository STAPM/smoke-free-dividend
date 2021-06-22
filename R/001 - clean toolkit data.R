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
saveRDS(toolkit_clean, paste0(intdatDir,"/toolkit_clean.rds"))
rm(toolkit_raw)
