
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

###############################################################################################
### further processing of gor results to compare to OHID results (sent in Dec 2021 by Tessa)

gor_results[, gor := factor(gor,
                            levels = c("North East","West Midlands",
                                       "Yorkshire and the Humber","East Midlands",
                                       "North West","East of England",
                                       "South West", "South East", "London")) ]

gor_results <- gor_results[order(gor),]

gor_results <- gor_results[, c("gor","spend_prop","n_smokers","dividend")]

gor_results[, dividend := dividend * 1000]
gor_results[, spend_prop := round(spend_prop * 100, 2)]

saveRDS(gor_results, "intermediate_data/results_region_OHID_comparison.rds")

