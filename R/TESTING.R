##### test


data = readRDS(paste0(Dir[1],"/toolkit_clean.rds"))
LCFS = FALSE
price_fm = 8.83
duty_fm = 228.29
avt_fm = 0.165
tot_duty_fm = 7748
price_ryo = 51.60
duty_ryo = 234.65
tot_duty_ryo = 1444
deflate = c(12,2020)

# calculate mean weekly expenditure by local authority
exp <- smkfreediv::CalcWeekSpend(data = data,
                                 strat_vars = c("UTLAcode","UTLAname"),
                                 upshift = 1)
