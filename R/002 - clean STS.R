
### This code cleans the raw toolkit data
library(data.table)
library(stringr)

toolkit_raw <- readRDS("data_intermediate/STS_data_raw.rds")

## clean the toolkit data using the CleanToolkit function. Restrict to the variables
## we need and time period needed.

## PHE analysis:
# - 2014-2019 data
# - weekspend as the expenditure variable

# - note LAcode variable only available from month 90 (April 19) so interpret
#   the years as tax years (2014-15 to 2019-20) months 90 - 161

toolkit_clean <- CleanToolkit(data = toolkit_raw,
                              start_month = 90,
                              end_month = 161)

rm(toolkit_raw)
