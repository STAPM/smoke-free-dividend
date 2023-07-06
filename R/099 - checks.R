
data <- readRDS("input_data/toolkit_clean.rds")

## ---------- Apply filters --------- ##

data <- data[Smoker == 1 & !is.na(weekspend),]

#########################################

nrow(data[is.na(weekspend)])
nrow(data[is.na(gor)])



upshift <- read.csv("intermediate_data/upshift_calcs.csv")
up <- as.numeric(upshift[,"upshift"])


#########################################
#### Total spending from Upshift calcs

tot_smokers    <- sum(smkfreediv::PHE_tobacco_profiles[, "n_smokers"], na.rm = T)

tot_mean_spend_up <- as.numeric( smkfreediv::CalcWeekSpend(data, strat_vars = NULL, upshift = up)[,"mean_week_spend"] )
total_annual_spend_up <- (tot_mean_spend_up * tot_smokers * 52)/1000000

#################################################
#### Total regional spending grossed up to total

tot_mean_spend_gor <- smkfreediv::CalcWeekSpend(data = data,
                                                strat_vars = c("gor"),
                                                upshift = up)[,c("mean_week_spend","gor")]
tot_mean_spend_gor <- tot_mean_spend_gor[order(gor)]
tot_mean_spend_gor[gor == "Yorkshire and The Humber", gor := "Yorkshire and the Humber"]

smokers_gor <- smkfreediv::PHE_tobacco_profiles[, .(n_smokers = sum(n_smokers, na.rm = TRUE)), by = "gor"]
tot_smokers_gor <- sum(smokers_gor[,"n_smokers"])

#### so the number of smokers is the same. now merge mean spending to n_smokers, calculate total annual spend

tot_mean_spend_gor <- merge(tot_mean_spend_gor, smokers_gor, by = "gor")
tot_mean_spend_gor[, total_annual_spend := (mean_week_spend * n_smokers * 52)/1000000]

total_annual_spend_up_gor <- sum(tot_mean_spend_gor$total_annual_spend)

tot_mean_spend_up_gor <- mean(tot_mean_spend_gor$mean_week_spend)


tot_mean_spend_up <- round(tot_mean_spend_up, 2)
tot_mean_spend_up_gor <- round(tot_mean_spend_up_gor, 2)

#### Discrepancy happens here somewhere, when calculating regional level expenditure,
#### its total does not sum up to the total

nrow(data[is.na(gor)])
nrow(data[is.na(LAname)])

