
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

results <- readRDS(paste0(Dir[2],"/results_local_authority_1.rds"))
la_results <- results[order(UTLAname)]

rm(results)

############################################
## Store results in the workbook template ##

# load the template workbook
wb <- openxlsx::loadWorkbook("templates/results_template.xlsx")

##################################
### fill in local authorities ####

UTLAname <- as.vector(as.matrix(la_results[,"UTLAname"]))
UTLAcode <- as.vector(as.matrix(la_results[,"UTLAcode"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = UTLAcode,
                    startCol = 1,
                    startRow = 3)

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = UTLAname,
                    startCol = 2,
                    startRow = 3)


##################################
###  fill in mean weekly spending

la_results[is.nan(mean_week_spend), mean_week_spend := NA]
x <- as.vector(as.matrix( round(la_results[,"mean_week_spend"],2 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 3,
                    startRow = 3)

# create confidence intervals

#la_results[, lci := round(mean_week_spend - 1.96*mean_week_spend_sd,2)]
#la_results[, uci := round(mean_week_spend + 1.96*mean_week_spend_sd,2)]
#la_results[, ci := paste0("[",lci," - ",uci,"]")]
#la_results[is.na(mean_week_spend), ci := ""]

#x <- as.vector(as.matrix( la_results[,"ci"]))

#openxlsx::writeData(wb,
#                    sheet = "Local Authorities",
#                    x = x,
#                    startCol = 4,
#                    startRow = 3)

# create deciles

la_results[, decile := ntile(mean_week_spend,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 4,
                    startRow = 3)

##################################
###  fill in average income

x <- as.vector(as.matrix( round(la_results[,"income"],2 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 5,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(income,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 6,
                    startRow = 3)

##################################
###  fill in smoking prevalence

x <- as.vector(as.matrix( round(la_results[,"smk_prev"],2 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 7,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(smk_prev,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 8,
                    startRow = 3)

##################################
###  fill in number of smokers

x <- as.vector(as.matrix( round(la_results[,"n_smokers"],2 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 9,
                    startRow = 3)

##################################
###  fill in total weekly expenditure

la_results[is.nan(total_wk_exp), total_wk_exp := NA]
x <- as.vector(as.matrix( la_results[,"total_wk_exp"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 10,
                    startRow = 3)

##################################
###  fill in total annual expenditure

la_results[is.nan(total_annual_exp), total_annual_exp := NA]
x <- as.vector(as.matrix( round(la_results[,"total_annual_exp"],3)))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 11,
                    startRow = 3)

##################################
###  fill in average weekly income

x <- as.vector(as.matrix(la_results[,"income"] ))/52
x <- round(x)

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 12,
                    startRow = 3)

##################################
###  fill in percentage of income spent on tobacco

la_results[is.nan(spend_prop), spend_prop := NA]
x <- as.vector(as.matrix( 100*round(la_results[,"spend_prop"],4 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 13,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(spend_prop,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 14,
                    startRow = 3)


###########################
## save out the workbook ##

saveWorkbook(wb,"output/summary_table.xlsx", overwrite = T)
