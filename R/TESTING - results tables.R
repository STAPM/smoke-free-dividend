
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

  all   <- as.vector(as.matrix(exp[,"mean_week_spend"]))
  grade <- as.vector(as.matrix(exp_grade[,"mean_week_spend"]))
  sex   <- as.vector(as.matrix(exp_sex[,"mean_week_spend"]))
  age   <- as.vector(as.matrix(exp_age[,"mean_week_spend"]))

  wk_spend <- c(all, grade, sex, age)
  wk_spend <- round(wk_spend, 2)

  openxlsx::writeData(wb,
                      sheet = "Average Tobacco Spend",
                      x = wk_spend,
                      startCol = 3,
                      startRow = 3)

  ###########################
  ## save out the workbook ##

  saveWorkbook(wb,paste0("output/summary_table_",i,".xlsx"), overwrite = T)

}
