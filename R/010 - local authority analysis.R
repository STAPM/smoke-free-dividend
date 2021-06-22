

## (3) Calculate mean weekly expenditure by upper-tier local authority

toolkit_clean <- readRDS(paste0(intdatDir,"/toolkit_clean"))

mean_spend_la <- smkfreediv::CalcWeekSpend(data = toolkit_clean,
                                           strat_vars = c("UTLAcode","UTLAname"))

mean_spend_la <- mean_spend_la[order(UTLAname)]

## (4) Grab the income data

income <- smkfreediv::GetIncome(income_var = 3)

## (5) Use the output of (3) and (4) to calculate the smoke free dividend for
##     each local authority.

div_la <- CalcDividend_la(profiles = smkfreediv::tobacco_profiles,
                          clean_income = income,
                          clean_expenditure = mean_spend_la,
                          upshift = 1.57151042,
                          div = 0.93,
                          reps = 200,
                          seed = 2021)
