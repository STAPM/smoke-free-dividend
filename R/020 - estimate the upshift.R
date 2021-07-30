### The aim of this code is to calculate the upshift factor to match
### Toolkit expenditure info to HMRC duties

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

# (1) Howard Reed parameters compared to the Toolkit estimates

upshift <- smkfreediv::CalcUpshift(data = data)

# (2) Howard Reed parameters compared to LCFS (i.e. reproduce
#     the upshift factor estimated by Howard)

upshift_HR <- smkfreediv::CalcUpshift(data = data,
                                      LCFS = TRUE)

# (3) As (1) but use the price from the ONS time series

price <- as.numeric(smkfreediv::price_cigs[year == 2018 & month == 12,"price"])

upshift_alt_price <- smkfreediv::CalcUpshift(data = data,
                                             price_fm = price)

# gather into a vector, including no upshift, and the PHE upshift

upshift_vec <- c(1, 1.57151042,
                 as.numeric(upshift[["upshift"]]),
                 as.numeric(upshift_alt_price[["upshift"]]),
                 as.numeric(upshift_HR[["upshift"]]) )

param <- 1:length(upshift_vec)

upshift_vec_out <- data.table(param, upshift_vec)

setnames(upshift_vec_out, names(upshift_vec_out), c("id","upshift"))

write.csv(upshift_vec_out,
          paste0(Dir[3],"/upshift_parameters.csv"),
          row.names = FALSE)

write.csv(upshift,
          paste0(Dir[3],"/upshift_calcs_3.csv"),
          row.names = FALSE)

write.csv(upshift_alt_price,
          paste0(Dir[3],"/upshift_calcs_4.csv"),
          row.names = FALSE)

write.csv(upshift_HR,
          paste0(Dir[3],"/upshift_calcs_5.csv"),
          row.names = FALSE)

rm(upshift, upshift_HR, upshift_alt_price, price, upshift_vec_out, param)

