
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
## Read in the results of the analysis

cons <- readRDS(paste0(Dir[2],"/results_consumption.rds"))

### read in local authority results data

results <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))
la_results <- results[order(UTLAname)]

gor_results <- readRDS(paste0(Dir[2],"/results_region.rds"))

rm(results)

### read in weekly spend by demographics data

exp_raw       <- read.csv(paste0(Dir[2],"/weekly_spend_all_no_upshift.csv"))
exp_age_raw   <- read.csv(paste0(Dir[2],"/weekly_spend_age_no_upshift.csv"))
exp_sex_raw   <- read.csv(paste0(Dir[2],"/weekly_spend_sex_no_upshift.csv"))
exp_grade_raw <- read.csv(paste0(Dir[2],"/weekly_spend_grade_no_upshift.csv"))
exp_la_raw    <- read.csv(paste0(Dir[2],"/weekly_spend_la_no_upshift.csv"))
exp_gor_raw   <- read.csv(paste0(Dir[2],"/weekly_spend_gor_no_upshift.csv"))

setDT(exp_raw) ; setDT(exp_age_raw) ; setDT(exp_sex_raw) ; setDT(exp_grade_raw) ; setDT(exp_la_raw) ; setDT(exp_gor_raw)

exp       <- read.csv(paste0(Dir[2],"/weekly_spend_all.csv"))
exp_age   <- read.csv(paste0(Dir[2],"/weekly_spend_age.csv"))
exp_sex   <- read.csv(paste0(Dir[2],"/weekly_spend_sex.csv"))
exp_grade <- read.csv(paste0(Dir[2],"/weekly_spend_grade.csv"))
exp_la    <- read.csv(paste0(Dir[2],"/weekly_spend_la.csv"))
exp_gor   <- read.csv(paste0(Dir[2],"/weekly_spend_gor.csv"))

setDT(exp) ; setDT(exp_age) ; setDT(exp_sex) ; setDT(exp_grade) ; setDT(exp_la) ; setDT(exp_gor)

############################################
## Store results in the workbook template ##

# load the template workbook
wb <- openxlsx::loadWorkbook("templates/results_template.xlsx")

### ---------------- Upshift Calcs Tab ---------- ###

calcs <-  read.csv(paste0(Dir[3],"/upshift_calcs.csv"))
setDT(calcs)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = as.numeric(calcs[,"tot_duty_fm"]),
                    startCol = 4,
                    startRow = 4)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"price_fm"]) , 2),
                    startCol = 4,
                    startRow = 5)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"avt_rate"]) , 3),
                    startCol = 4,
                    startRow = 6)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"avt"]) , 2),
                    startCol = 4,
                    startRow = 7)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"duty_fm"]) , 2),
                    startCol = 4,
                    startRow = 8)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"duty_fm_pp"]) , 2),
                    startCol = 4,
                    startRow = 9)


openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"total_excise_per_pack"]) , 2),
                    startCol = 4,
                    startRow = 10)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"excise_pct_fm"])  , 4),
                    startCol = 4,
                    startRow = 11)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"tot_legal_spend_fm"]) ),
                    startCol = 4,
                    startRow = 12)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"tot_illicit_spend_fm"]) ),
                    startCol = 4,
                    startRow = 13)


openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = as.numeric(calcs[,"tot_duty_ryo"]),
                    startCol = 7,
                    startRow = 4)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"price_ryo"]) , 2),
                    startCol = 7,
                    startRow = 5)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"deflator"]) , 2),
                    startCol = 7,
                    startRow = 6)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"price_ryo_d"]) , 2),
                    startCol = 7,
                    startRow = 7)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"duty_ryo"]) , 2),
                    startCol = 7,
                    startRow = 8)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"duty_ryo_pp"]) , 2),
                    startCol = 7,
                    startRow = 9)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"excise_pct_ryo"]) , 4) ,
                    startCol = 7,
                    startRow = 11)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"tot_legal_spend_ryo"]) ),
                    startCol = 7,
                    startRow = 12)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"tot_illicit_spend_ryo"]) ),
                    startCol = 7,
                    startRow = 13)




openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"total_annual_spend_hmrc"]) ),
                    startCol = 8,
                    startRow = 14)

openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"total_annual_spend_surv"]) ),
                    startCol = 8,
                    startRow = 16)




openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = paste0(calcs[1,"svy_data"]) ,
                    startCol = 3,
                    startRow = 17)





openxlsx::writeData(wb,
                    sheet = "Upshift Calcs",
                    x = round( as.numeric(calcs[,"upshift"]) , 3),
                    startCol = 3,
                    startRow = 19)

### ----------------- LA Data Tab --------------- ###


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

# create smoking toolkit study sample size

x <- as.vector(as.matrix( round(exp_la[,"sample_tkit"],0 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 4,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(mean_week_spend,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 5,
                    startRow = 3)

##################################
###  fill in average income

x <- as.vector(as.matrix( round(la_results[,"income"],2 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 6,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(income,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 7,
                    startRow = 3)

##################################
###  fill in smoking prevalence

x <- as.vector(as.matrix( round(la_results[,"smk_prev"],2 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 8,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(smk_prev,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 9,
                    startRow = 3)

##################################
###  fill in number of smokers

x <- as.vector(as.matrix( round(la_results[,"n_smokers"],0 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 10,
                    startRow = 3)

##################################
###  fill in total weekly expenditure

la_results[is.nan(total_wk_exp), total_wk_exp := NA]
x <- as.vector(as.matrix( la_results[,"total_wk_exp"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 11,
                    startRow = 3)

##################################
###  fill in total annual expenditure

la_results[is.nan(total_annual_exp), total_annual_exp := NA]
x <- as.vector(as.matrix( round(la_results[,"total_annual_exp"],3)))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 12,
                    startRow = 3)

##################################
###  fill in average weekly income

x <- as.vector(as.matrix(la_results[,"income"] ))/52
x <- round(x)

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 13,
                    startRow = 3)

##################################
###  fill in percentage of income spent on tobacco

la_results[is.nan(spend_prop), spend_prop := NA]
x <- as.vector(as.matrix( 100*round(la_results[,"spend_prop"],4 )))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 14,
                    startRow = 3)

# create deciles

la_results[, decile := ntile(spend_prop,10)]
x <- as.vector(as.matrix( la_results[,"decile"]))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 15,
                    startRow = 3)

##################################
###  fill in smoke free dividend

la_results[is.nan(dividend), dividend := NA]
x <- as.vector(as.matrix(la_results[,"dividend"] ))

openxlsx::writeData(wb,
                    sheet = "LA data",
                    x = x,
                    startCol = 16,
                    startRow = 3)

### ----------------- Region Data Tab --------------- ###


#############################
### fill in region names ####

gor <- as.vector(as.matrix(gor_results[,"gor"]))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = gor,
                    startCol = 2,
                    startRow = 3)


##################################
###  fill in mean weekly spending

gor_results[is.nan(mean_week_spend), mean_week_spend := NA]
x <- as.vector(as.matrix( round(gor_results[,"mean_week_spend"],2 )))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 3,
                    startRow = 3)


# create smoking toolkit study sample size

x <- as.vector(as.matrix( round(exp_gor[,"sample_tkit"],0 )))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 4,
                    startRow = 3)

##################################
###  fill in average income

x <- as.vector(as.matrix( round(gor_results[,"income"],2 )))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 5,
                    startRow = 3)

##################################
###  fill in smoking prevalence

x <- as.vector(as.matrix( round(gor_results[,"smk_prev"],2 )))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 6,
                    startRow = 3)

##################################
###  fill in number of smokers

x <- as.vector(as.matrix( round(gor_results[,"n_smokers"],0 )))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 7,
                    startRow = 3)

##################################
###  fill in total weekly expenditure

gor_results[is.nan(total_wk_exp), total_wk_exp := NA]
x <- as.vector(as.matrix( gor_results[,"total_wk_exp"]))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 8,
                    startRow = 3)

##################################
###  fill in total annual expenditure

gor_results[is.nan(total_annual_exp), total_annual_exp := NA]
x <- as.vector(as.matrix( round(gor_results[,"total_annual_exp"],3)))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 9,
                    startRow = 3)

##################################
###  fill in average weekly income

x <- as.vector(as.matrix(gor_results[,"income"] ))/52
x <- round(x)

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 10,
                    startRow = 3)

##################################
###  fill in percentage of income spent on tobacco

gor_results[is.nan(spend_prop), spend_prop := NA]
x <- as.vector(as.matrix( 100*round(gor_results[,"spend_prop"],4 )))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 11,
                    startRow = 3)

##################################
###  fill in smoke free dividend

gor_results[is.nan(dividend), dividend := NA]
x <- as.vector(as.matrix(gor_results[,"dividend"] ))

openxlsx::writeData(wb,
                    sheet = "Region data",
                    x = x,
                    startCol = 12,
                    startRow = 3)

### ----------------- Consumption Tab --------------- ###

### fill in local authorities ####

UTLAname <- as.vector(as.matrix(la_results[,"UTLAname"]))
UTLAcode <- as.vector(as.matrix(la_results[,"UTLAcode"]))

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = UTLAcode,
                    startCol = 1,
                    startRow = 3)

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = UTLAname,
                    startCol = 2,
                    startRow = 3)


## Average Daily FM
x <- as.vector(as.matrix( cons[,"mean_cigs_fm"]))

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = x,
                    startCol = 3,
                    startRow = 3)

## Average Daily RYO
x <- as.vector(as.matrix( cons[,"mean_cigs_ryo"]))

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = x,
                    startCol = 4,
                    startRow = 3)

## Average Daily Total
x <- as.vector(as.matrix( cons[,"mean_cigs_tot"]))

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = x,
                    startCol = 5,
                    startRow = 3)

## Average % of Cigs RYO
x <- as.vector(as.matrix( cons[,"mean_ryoperc"]))

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = x,
                    startCol = 6,
                    startRow = 3)

## % of Smokers who smoke FM
x <- as.vector(as.matrix( cons[,"prop_fm"]))

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = x,
                    startCol = 7,
                    startRow = 3)

## % of Smokers who smoke RYO
x <- as.vector(as.matrix( cons[,"prop_ryo"]))

openxlsx::writeData(wb,
                    sheet = "Consumption",
                    x = x,
                    startCol = 8,
                    startRow = 3)

### ----------------- Average Tobacco Spend Tab --------------- ###

###### NON-UPSHIFTED SPENDING

all_raw   <- as.vector(as.matrix(exp_raw[,"mean_week_spend"]))
grade_raw <- as.vector(as.matrix(exp_grade_raw[,"mean_week_spend"]))
sex_raw   <- as.vector(as.matrix(exp_sex_raw[,"mean_week_spend"]))
age_raw   <- as.vector(as.matrix(exp_age_raw[,"mean_week_spend"]))
gor_raw   <- as.vector(as.matrix(exp_gor_raw[,"mean_week_spend"]))

wk_spend_raw <- c(all_raw, grade_raw, sex_raw, age_raw, gor_raw)
wk_spend_raw <- round(wk_spend_raw, 2)

openxlsx::writeData(wb,
                    sheet = "Average Tobacco Spend",
                    x = wk_spend_raw,
                    startCol = 3,
                    startRow = 3)

###### UPSHIFTED SPENDING

all   <- as.vector(as.matrix(exp[,"mean_week_spend"]))
grade <- as.vector(as.matrix(exp_grade[,"mean_week_spend"]))
sex   <- as.vector(as.matrix(exp_sex[,"mean_week_spend"]))
age   <- as.vector(as.matrix(exp_age[,"mean_week_spend"]))
gor   <- as.vector(as.matrix(exp_gor[,"mean_week_spend"]))

wk_spend <- c(all, grade, sex, age, gor)
wk_spend <- round(wk_spend, 2)

openxlsx::writeData(wb,
                    sheet = "Average Tobacco Spend",
                    x = wk_spend,
                    startCol = 4,
                    startRow = 3)

### --------------- Expenditure % of Income  LAs Tab -------------- ###

results <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))
top_la_results <- results[order(-spend_prop)]
top_la_results <- top_la_results[1:10,]

rm(results)

reg <- as.vector(as.matrix(top_la_results[,"UTLAname"]))
mean <- round(as.vector(as.matrix(top_la_results[,"mean_week_spend"])) , 2)
prop <- round(as.vector(as.matrix(top_la_results[,"spend_prop"])) , 4)*100
tot_exp <- round(as.vector(as.matrix(top_la_results[,"total_annual_exp"])) , 3)
tot_div <- round(as.vector(as.matrix(top_la_results[,"dividend"])) , 3)


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

saveWorkbook(wb,paste0("output/summary_table.xlsx"), overwrite = T)

