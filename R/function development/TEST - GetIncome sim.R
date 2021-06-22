

#### test number of sims required to get a decently accurate mean
#### from the GetIncome() function

n_sim <- 5000

m_inc_mean <- matrix(rep(NA, 147*n_sim), ncol = n_sim)


for (i in 1:n_sim) {

  cat("\t\tSimulating the GetIncome() function", round(100*i/n_sim,2),"%", "               \r")
  utils::flush.console()
  if(i == n_sim) { cat("\n") }

  data <- GetIncome(mapping_data = smkfreediv::localauthorities,
                    income_data = smkfreediv::la_inc_pop,
                    income_var = 3)

  m_inc_mean[,i] <- as.vector(as.matrix(data[,"income_sim"]))
}

m_inc_mean     <- data.table(m_inc_mean)

m_inc_mean_m <- transform(m_inc_mean, M=apply(m_inc_mean,1, mean, na.rm = TRUE))
m_inc_mean_s <- transform(m_inc_mean, SD=apply(m_inc_mean,1, sd, na.rm = TRUE))
m_inc_mean   <- cbind(m_inc_mean_m[,"M"] ,m_inc_mean_s[,"SD"])

merge <- cbind(data, m_inc_mean)
