
## The aim of this code is to read in the raw toolkit data
## from .sav format, clean, and save out a filtered/cleaned dataset
## in .rds format ready for analysis.

## (1) Read in the data from where the raw toolkit data is stored

tkit_path <- "X:/ScHARR/PR_SPECTRUM/Workpackages/WP6 Evaluation Langley/Smokefree Dividend/Toolkit Data/STS and ATS files Apr 21/Latest omnibus SPSS data file/"

toolkit_raw <- smkfreediv::ReadToolkit(path = tkit_path,
                                       data = data_file,
                                       save = TRUE,
                                       name = "STS_data_raw")

## (2) Clean the data and save the cleaned data back to the raw inputs folder. Use period April 2014 - February 2020

toolkit_raw <- readRDS(paste0(tkit_path, "STS_data_raw.rds"))

toolkit_clean <- smkfreediv::CleanToolkit(data = toolkit_raw,
                                          start_month = 90,
                                          end_month = 160)

## (3) Deflate expenditure to December 2018 for the upshift calculations

toolkit_clean_2018 <- smkfreediv::DeflateToolkit(data = toolkit_clean,
                                                 index = smkfreediv::cpi_tobacco,
                                                 base_month = 12,
                                                 base_year = 2018)

toolkit_clean_2018 <- toolkit_clean_2018[Age >= 18,]

saveRDS(toolkit_clean_2018, "input_data/toolkit_clean.rds")


rm(toolkit_raw)
