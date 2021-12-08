## compare my results to my results using OHID upshift and to OHID overall results

## NOTE: OHID reports median income, I report the mean

rm(list = ls())
library(readxl)
library(data.table)

##################
# read in OHID ###

ohid <- readxl::read_excel("spreadsheets/Smokefree Dividend 2021 Tidied version.xlsx",
                           sheet = "Regions",
                           range = "A1:H10")

setDT(ohid)

setnames(ohid, names(ohid), c("region","mean_spend","prop_income","tot_annual_exp","dividend","n_smokers","tot_weekly_exp","weekly_income"))

### convert so figures are in the same units as my output

## annual expenditure: 000s -> millions
ohid[, tot_annual_exp := tot_annual_exp/1000]

## total weekly spend: £s to £000s
ohid[, tot_weekly_exp := tot_weekly_exp/1000]

## dividend: 000s -> millions
ohid[, dividend := dividend/1000]

########################
# read in my results ###

myresults <- readxl::read_excel("output/summary_table.xlsx",
                                 sheet = "Region data",
                                 range = "B2:L11")

setDT(myresults)

setnames(myresults, names(myresults), c("region","mean_spend","sample_size","annual_income","prevalence","n_smokers",
                                        "tot_weekly_exp","tot_annual_exp","weekly_income","prop_income","dividend"))

myresults[, c("sample_size","annual_income","prevalence") := NULL]

setnames(myresults,
         names(myresults),
         c("region","mean_spend_my","n_smokers_my",
           "tot_weekly_exp_my","tot_annual_exp_my","weekly_income_my","prop_income_my","dividend_my"))

########################
# read in my results ###

myresults_ohidup <- readxl::read_excel("output/summary_table_OHID_upshift.xlsx",
                                sheet = "Region data",
                                range = "B2:L11")

setDT(myresults_ohidup)

setnames(myresults_ohidup, names(myresults_ohidup), c("region","mean_spend","sample_size","annual_income","prevalence","n_smokers",
                                        "tot_weekly_exp","tot_annual_exp","weekly_income","prop_income","dividend"))

myresults_ohidup[, c("sample_size","annual_income","prevalence") := NULL]

setnames(myresults_ohidup,
         names(myresults_ohidup),
         c("region","mean_spend_my_ohidup","n_smokers_my_ohidup",
           "tot_weekly_exp_my_ohidup","tot_annual_exp_my_ohidup","weekly_income_my_ohidup",
           "prop_income_my_ohidup","dividend_my_ohidup"))



#################################################
## Compare my main results to the OHID results ##

compare1 <- merge(ohid, myresults, by = "region")

compare1[, diff_mean_spend     :=  mean_spend_my - mean_spend]
compare1[, diff_mean_spend_p   :=  round(diff_mean_spend/mean_spend,4)]

compare1[, diff_weekly_income    := weekly_income_my - weekly_income]
compare1[, diff_weekly_income_p  := round(diff_weekly_income/weekly_income,4)]

compare1[, diff_prop_income    := prop_income_my - prop_income]
compare1[, diff_prop_income_p  := round(diff_prop_income/prop_income,4)]

compare1[, diff_n_smokers      := n_smokers_my - n_smokers]
compare1[, diff_n_smokers_p    := round(diff_n_smokers/n_smokers,4)]

compare1[, diff_tot_annual_exp   := tot_annual_exp_my - tot_annual_exp]
compare1[, diff_tot_annual_exp_p := round(diff_tot_annual_exp/tot_annual_exp,4)]

compare1[, diff_dividend       := dividend_my - dividend]
compare1[, diff_dividend_p     := round(diff_dividend/dividend,4)]

compare1[,c("mean_spend_my","n_smokers_my","tot_weekly_exp_my","tot_annual_exp_my","weekly_income_my","prop_income_my","dividend_my",
            "mean_spend","n_smokers", "tot_weekly_exp","tot_annual_exp","weekly_income","prop_income","dividend") := NULL]


##################################################################
## Compare my results with the OHID upshift to the OHID results ##

compare2 <- merge(ohid, myresults_ohidup, by = "region")

compare2[, diff_mean_spend     :=  mean_spend_my_ohidup - mean_spend]
compare2[, diff_mean_spend_p   :=  round(diff_mean_spend/mean_spend,4)]

compare2[, diff_weekly_income    := weekly_income_my_ohidup - weekly_income]
compare2[, diff_weekly_income_p  := round(diff_weekly_income/weekly_income,4)]

compare2[, diff_prop_income    := prop_income_my_ohidup - prop_income]
compare2[, diff_prop_income_p  := round(diff_prop_income/prop_income,4)]

compare2[, diff_n_smokers      := n_smokers_my_ohidup - n_smokers]
compare2[, diff_n_smokers_p    := round(diff_n_smokers/n_smokers,4)]

compare2[, diff_tot_annual_exp   := tot_annual_exp_my_ohidup - tot_annual_exp]
compare2[, diff_tot_annual_exp_p := round(diff_tot_annual_exp/tot_annual_exp,4)]

compare2[, diff_dividend       := dividend_my_ohidup - dividend]
compare2[, diff_dividend_p     := round(diff_dividend/dividend,4)]

compare2[,c("mean_spend_my_ohidup","n_smokers_my_ohidup","tot_weekly_exp_my_ohidup","tot_annual_exp_my_ohidup","weekly_income_my_ohidup","prop_income_my_ohidup","dividend_my_ohidup",
            "mean_spend","n_smokers", "tot_weekly_exp","tot_annual_exp","weekly_income","prop_income","dividend") := NULL]
