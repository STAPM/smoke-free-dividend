### The aim of this code is to calculate the upshift factor to match
### Toolkit expenditure info to HMRC duties

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

## set prices and duties as they were at december 2018

#price_fm <- as.numeric(smkfreediv::price_cigs[year == 2018 & month == 12,"price"])


### Calculate the December 2018 price from the 2016 WAP for cigarettes obtained from the
### OECD/WHO spreadsheet, upshifting using the tobacco RPI from Dec 2016 - Dec 2018

price_inflator <- as.numeric(smkfreediv::cpi_tobacco[Year == 2018 & month == 12,"cpi"])/as.numeric(smkfreediv::cpi_tobacco[Year == 2016 & month == 12,"cpi"])
price_inflator <- as.numeric(smkfreediv::price_cigs[year == 2018 & month == 12,"price"])/as.numeric(smkfreediv::price_cigs[year == 2016 & month == 12,"price"])

price <- as.numeric(smkfreediv::price_cigs_oecd[country == "United Kingdom","price"]) * price_inflator

### (edit following TL comment on draft - use £8.83 figure used by Howard Reed)

upshift <- smkfreediv::CalcUpshift(data = data,
                                   LCFS = FALSE,
                                   price_fm = price,
                                   duty_fm = 228.29,
                                   avt_fm = 0.165,
                                   duty_ryo = 234.65,
                                   deflate_from = c(12, 2020),
                                   deflate_to = c(12, 2018))


write.csv(upshift,
          paste0(Dir[3],"/upshift_calcs.csv"),
          row.names = FALSE)
