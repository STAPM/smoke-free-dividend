### The aim of this code is to use the smkfreediv functions to make the
### smoke free dividend calculations. Loop over different values of upshift
### parameter

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

upshift_vec <- readRDS(paste0(Dir[2],"/upshift_param_vectors.rds"))

n_sim <- 100

########### LOCAL AUTHORITY LEVEL #############

for (j in 1:length(upshift_vec)) {

  cat(crayon::yellow("Simulation for Upshift Parameter ",j," of ",length(upshift_vec),"\n"))

la_results <- smkfreediv::CalcDividend_la_sim(data,
                                              upshift = upshift_vec[j],
                                              div = 0.93,
                                              n_sim = n_sim,
                                              seed = 2021)

assign(paste0("la_results_",j), la_results)

saveRDS(la_results,paste0(Dir[2],"/results_local_authority_",j,".rds"))

rm(la_results)
}

########### REGION LEVEL #############

for (j in 1:length(upshift_vec)) {

  cat(crayon::yellow("Simulation for Upshift Parameter ",j," of ",length(upshift_vec),"\n"))

  gor_results <- smkfreediv::CalcDividend_gor_sim(data,
                                                  upshift = upshift_vec[j],
                                                  div = 0.93,
                                                  n_sim = n_sim,
                                                  seed = 2021)

  assign(paste0("gor_results_",j), gor_results)

  saveRDS(gor_results,paste0(Dir[2],"/results_region_",j,".rds"))

  rm(gor_results)
}
