
# The aim of this code is to summarise the model data to
# fit into the summary tables

# the intermediate step to this is to write the summary tables
# to an excel workbook that has some pre-formatting to produce
# the right tables

library(here)
library(data.table)
library(stringr)
library(flextable)
library(magrittr)
library(plyr)
library(readxl)
library(openxlsx)
library(dplyr)

############################################
## Read in the local authorities that are in the PHE spreadsheet template
## Read in the results of the analysis
## Merge

results <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))
codes <- readxl::read_excel(path = "templates/template.xlsx",
                            sheet = "Local Authorities",
                            range = "A2:A150")
setDT(codes)
setnames(codes,names(codes),c("UTLAcode"))
codes[UTLAcode == "E10000002", UTLAcode := "E06000060"]

la_results <- merge(codes, results, by = c("UTLAcode"))
la_results <- la_results[order(UTLAname)]

rm(codes, results)

############################################
## Store results in the workbook template ##

# load the template workbook
wb <- openxlsx::loadWorkbook("templates/template.xlsx")

##################################
###  fill in mean weekly spending

la_results[is.nan(mean_week_spend), mean_week_spend := NA]
x <- as.vector(as.matrix( round(la_results[,"mean_week_spend"],2 )))

openxlsx::writeData(wb,
                    sheet = "Local Authorities",
                    x = x,
                    startCol = 3,
                    startRow = 3)

# create confidence intervals

la_results[, lci := round(mean_week_spend - 1.96*mean_week_spend_sd,2)]
la_results[, uci := round(mean_week_spend + 1.96*mean_week_spend_sd,2)]
la_results[, ci := paste0("[",lci," - ",uci,"]")]
la_results[is.na(mean_week_spend), ci := ""]

x <- as.vector(as.matrix( la_results[,"ci"]))

openxlsx::writeData(wb,
                    sheet = "Local Authorities",
                    x = x,
                    startCol = 4,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(mean_week_spend,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "Local Authorities",
                    x = x,
                    startCol = 5,
                    startRow = 3)

###########################
## save out the workbook ##

saveWorkbook(wb,"output/summary_table.xlsx", overwrite = T)
