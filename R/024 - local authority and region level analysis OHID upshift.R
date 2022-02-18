### The aim of this code is to use the smkfreediv functions to make the
### smoke free dividend calculations. Loop over different values of upshift
### parameter

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

### The aim of this code is to make the smoke free dividend calculations with my
### data and methodology but using the OHID upshift factor.

## read in toolkit data and upshift factor

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))
upshift <- read.csv(paste0(Dir[2],"/upshift_calcs.csv"))

#### Simulation

n_sim <- 100
up    <- 1.7187398690
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

saveRDS(la_results,paste0(Dir[2],"/results_local_authority_OHID.rds"))

########### REGION LEVEL #############

gor_results <- smkfreediv::CalcDividend_gor_sim(data,
                                                upshift = up,
                                                div = div,
                                                n_sim = n_sim,
                                                seed = seed,
                                                illicit_prop = illicit_prop)

saveRDS(gor_results,paste0(Dir[2],"/results_region_OHID.rds"))
