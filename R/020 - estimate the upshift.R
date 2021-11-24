### The aim of this code is to calculate the upshift factor to match
### Toolkit expenditure info to HMRC duties

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

price <- as.numeric(smkfreediv::price_cigs[year == 2018 & month == 12,"price"])

upshift <- smkfreediv::CalcUpshift(data = data,
                                   price_fm = price)


write.csv(upshift,
          paste0(Dir[3],"/upshift_calcs.csv"),
          row.names = FALSE)

