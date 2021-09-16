## explore the consumption patterns by local authority

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

strat_vars <- c("UTLAcode","UTLAname")


means <- data[, .(mean_cigs_fm = weighted.mean(cigs_perday_fm, w = Aweight0 ,na.rm = T),
                  mean_cigs_ryo = weighted.mean(cigs_perday_ryo, w = Aweight0 ,na.rm = T),
                  mean_cigs_tot = weighted.mean(cigs_perday_ryo + cigs_perday_fm, w = Aweight0 ,na.rm = T),
                  mean_ryoperc = weighted.mean(ryoperc, w = Aweight0 ,na.rm = T),
                  prop_fm = weighted.mean(cigs_type_both + cigs_type_fm, w = Aweight0 ,na.rm = T),
                  prop_ryo = weighted.mean(cigs_type_both + cigs_type_ryo, w = Aweight0 ,na.rm = T)),
              by = strat_vars]

means <- means[order(UTLAname),]

saveRDS(means,paste0(Dir[2],"/results_consumption.rds"))
