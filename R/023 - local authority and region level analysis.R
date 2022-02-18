
### The aim of this code is to make the smoke free dividend calculations.

## read in toolkit data and upshift factor

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))
upshift <- read.csv(paste0(Dir[2],"/upshift_calcs.csv"))

#### Simulation

n_sim <- 100
up    <- as.numeric(upshift[,"upshift"])
seed  <- 2021
div   <- 0.93
illicit_prop <- as.numeric(upshift[,"illicit_prop"])

########### LOCAL AUTHORITY LEVEL #############

la_results <- smkfreediv::CalcDividend_la_sim(data,
                                              upshift = up,
                                              div = div,
                                              n_sim = n_sim,
                                              seed = seed,
                                              illicit_prop = illicit_prop)

saveRDS(la_results,paste0(Dir[2],"/results_local_authority.rds"))

########### REGION LEVEL #############

gor_results <- smkfreediv::CalcDividend_gor_sim(data,
                                                upshift = up,
                                                div = div,
                                                n_sim = n_sim,
                                                seed = seed,
                                                illicit_prop = illicit_prop)

saveRDS(gor_results,paste0(Dir[2],"/results_region.rds"))

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

saveRDS(gor_results,paste0(Dir[2],"/results_region_OHID_comparison.rds"))

