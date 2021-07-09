### The aim of this code is to calculate the upshift factor to match
### Toolkit expenditure info to HMRC duties

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

# calculate mean weekly expenditure by local authority
upshift <- smkfreediv::CalcUpshift(data = data)

upshift_HR <- smkfreediv::CalcUpshift(data = data,
                                      LCFS = TRUE)

# gather into a vector

upshift_vec <- c(1, 1.57151042, upshift, upshift_HR)

rm(upshift, upshift_HR)
