
### The aim of this code is to make the smoke free dividend calculations.

## read in toolkit data (011) and upshift factor (021)

data <- readRDS("input_data/toolkit_clean.rds")
data <- data[Smoker == 1 & !is.na(weekspend),]

upshift <- read.csv("intermediate_data/upshift_calcs.csv")

#### Simulation (draw from distributions of income, prevalence etc based on
#### standard errors)

n_sim <- 100                              ## number of simulation reps
up    <- as.numeric(upshift[,"upshift"])  ## upshift factor on spending data
seed  <- 2021                             ## random number seed
div   <- 0.93                             ## proportion of legal spending allocated to dividend
illicit_prop <- as.numeric(upshift[,"illicit_prop"]) ## illict spending as % of total (LA level)

###############################################
########### LOCAL AUTHORITY LEVEL #############

la_results <- smkfreediv::CalcDividend_la_sim(data,
                                              upshift = up,
                                              div = div,
                                              n_sim = n_sim,
                                              seed = seed,
                                              illicit_prop = illicit_prop)

saveRDS(la_results, "intermediate_data/results_local_authority.rds")

######################################
########### REGION LEVEL #############

gor_results <- smkfreediv::CalcDividend_gor_sim(data,
                                                upshift = up,
                                                div = div,
                                                n_sim = n_sim,
                                                seed = seed,
                                                illicit_prop = illicit_prop)

saveRDS(gor_results, "intermediate_data/results_region.rds")


