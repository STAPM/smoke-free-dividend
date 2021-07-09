### The aim of this code is to calculate the upshift factor to match
### Toolkit expenditure info to HMRC duties

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

# calculate mean weekly expenditure by local authority
upshift <- smkfreediv::CalcUpshift(data = data)

upshift_HR <- smkfreediv::CalcUpshift(data = data,
                                      LCFS = TRUE)

