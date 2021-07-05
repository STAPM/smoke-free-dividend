### The aim of this code is to use the smkfreediv functions to make the
### smokefree dividend calculations

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

la_results <- smkfreediv::CalcDividend_la_sim(data,
                                              upshift = 1.57151042,
                                              div = 0.93,
                                              n_sim = 10000,
                                              seed = 2021)

saveRDS(la_results,paste0(Dir[2],"/results_local_authority.rds"))

