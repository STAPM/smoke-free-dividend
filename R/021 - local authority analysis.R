### The aim of this code is to use the smkfreediv functions to make the
### smokefree dividend calculations. Loop over different values of upshift

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

n_sim <- 20000

for (j in 1:length(upshift_vec)) {

  cat(crayon::red("Simulation for Upshift Parameter ",j," of ",length(upshift_vec),"\n"))

la_results <- smkfreediv::CalcDividend_la_sim(data,
                                              upshift = upshift_vec[j],
                                              div = 0.93,
                                              n_sim = n_sim,
                                              seed = 2021)

assign(paste0("la_results_",j), la_results)

saveRDS(la_results,paste0(Dir[2],"/results_local_authority_",j,".rds"))

rm(la_results)
}


