
# The aim of this code is to summarise the model data to
# fit into the summary tables

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

for (i in 1:length(upshift_vec)) {

  ############################################
  ## Store results in the workbook template ##

  # load the template workbook
  wb <- openxlsx::loadWorkbook("templates/results_template.xlsx")

  #############################

  results <- readRDS(paste0(Dir[2],"/results_local_authority_",i,".rds"))
  top_la_results <- results[order(-spend_prop)]
  top_la_results <- top_la_results[1:10,]

  rm(results)

  reg <- as.vector(as.matrix(regions[,"UTLAname"]))
  mean <- as.vector(as.matrix(regions[,"mean_week_spend"]))
  prop <- as.vector(as.matrix(regions[,"spend_prop"]))
  tot_exp <- as.vector(as.matrix(regions[,"total_annual_exp"]))
  tot_div <- as.vector(as.matrix(regions[,"dividend"]))


  openxlsx::writeData(wb,
                      sheet = "Expenditure % of Income LA",
                      x = reg,
                      startCol = 1,
                      startRow = 3)

  openxlsx::writeData(wb,
                      sheet = "Expenditure % of Income LA",
                      x = mean,
                      startCol = 2,
                      startRow = 3)

  openxlsx::writeData(wb,
                      sheet = "Expenditure % of Income LA",
                      x = prop,
                      startCol = 3,
                      startRow = 3)

  openxlsx::writeData(wb,
                      sheet = "Expenditure % of Income LA",
                      x = tot_exp,
                      startCol = 4,
                      startRow = 3)

  openxlsx::writeData(wb,
                      sheet = "Expenditure % of Income LA",
                      x = tot_div,
                      startCol = 5,
                      startRow = 3)

  ###########################
  ## save out the workbook ##

  saveWorkbook(wb,paste0("output/summary_table_",i,".xlsx"), overwrite = T)

}
