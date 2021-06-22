data <- readRDS(paste0(intdatDir,"/toolkit_clean.rds"))

CalcDividend_la_sim <- function(data,
                                upshift = 1.57151042,
                                div = 0.93,
                                n_sim = 100,
                                seed = 2021) {

    set.seed(seed)

    ## Calculate mean weekly expenditure by upper-tier local authority
    cat(crayon::red("Calculating Local Authority Smokefree Dividends\n"))

    mean_spend_la <- smkfreediv::CalcWeekSpend(data = data,
                                               strat_vars = c("UTLAcode","UTLAname"))

    mean_spend_la <- mean_spend_la[order(UTLAname)]

    ## Initialise matrices for probabilistic variables

    m_n_smokers           <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_smk_prev            <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_mean_week_spend     <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_income              <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_total_wk_exp        <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_total_annual_exp    <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_spend_prop          <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_total_wk_exp_up     <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_total_annual_exp_up <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_spend_prop_up       <- matrix(rep(NA,n_sim*151), ncol = n_sim)
    m_dividend            <- matrix(rep(NA,n_sim*151), ncol = n_sim)

    cat(crayon::blue("\tCalculating Probabilistic Variables\n"))

    for (i in 1:n_sim) {

        cat("\t\tSimulating...", round(100*i/n_sim,2),"%", "               \r")
        utils::flush.console()
        if(i == n_sim) { cat("\n") }
    ## Grab the income data

    income <- smkfreediv::GetIncome(mapping_data = smkfreediv::localauthorities,
                                    income_data = smkfreediv::la_inc_pop,
                                    income_var = 3)

    ## Use the income/spending to calculate the smoke free dividend for
    ## each local authority.

    div_la <- CalcDividend_la(profiles = smkfreediv::tobacco_profiles,
                              clean_income = income,
                              clean_expenditure = mean_spend_la,
                              upshift = 1.57151042,
                              div = 0.93)

    ## save out probabilistic results

    m_income[,i]              <- as.vector(as.matrix(div_la[,"prob_income"]))
    m_n_smokers[,i]           <- as.vector(as.matrix(div_la[,"prob_n_smokers"]))
    m_smk_prev[,i]            <- as.vector(as.matrix(div_la[,"prob_smk_prev"]))
    m_mean_week_spend[,i]     <- as.vector(as.matrix(div_la[,"prob_mean_week_spend"]))
    m_total_wk_exp[,i]        <- as.vector(as.matrix(div_la[,"prob_total_wk_exp"]))
    m_total_annual_exp[,i]    <- as.vector(as.matrix(div_la[,"prob_total_annual_exp"]))
    m_spend_prop[,i]          <- as.vector(as.matrix(div_la[,"prob_spend_prop"]))
    m_total_wk_exp_up[,i]     <- as.vector(as.matrix(div_la[,"prob_total_wk_exp_up"]))
    m_total_annual_exp_up[,i] <- as.vector(as.matrix(div_la[,"prob_total_annual_exp_up"]))
    m_spend_prop_up[,i]       <- as.vector(as.matrix(div_la[,"prob_spend_prop_up"]))
    m_dividend[,i]            <- as.vector(as.matrix(div_la[,"prob_dividend"]))
    }

    cat(crayon::blue("\tGenerating Simulation Means and Standard Deviations\n"))

    cat(crayon::red("done\n"))
}


result <- CalcDividend_la_sim(data,
                              upshift = 1.57151042,
                              div = 0.93,
                              n_sim = 10000,
                              seed = 2021)
