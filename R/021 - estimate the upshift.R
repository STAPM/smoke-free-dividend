### The aim of this code is to calculate the upshift factor to match
### Toolkit expenditure info to HMRC duties

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

## set prices and duties as they were at december 2018

price_fm <- as.numeric(smkfreediv::price_cigs[year == 2018 & month == 12,"price"])

upshift <- smkfreediv::CalcUpshift(data = data,
                                   LCFS = FALSE,
                                   price_fm = price_fm,
                                   duty_fm = 228.29,
                                   avt_fm = 0.165,
                                   duty_ryo = 234.65,
                                   deflate_from = c(12, 2020),
                                   deflate_to = c(12, 2018))


write.csv(upshift,
          paste0(Dir[3],"/upshift_calcs.csv"),
          row.names = FALSE)
