### The aim of this code is to use the smkfreediv functions to make the
### smokefree dividend calculations. Loop over different values of upshift

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

upshift <- read.csv("output/upshift_calcs.csv")
up <- as.numeric(upshift[,"upshift"])

#### Estimate mean weekly spending for different stratification

  exp <- smkfreediv::CalcWeekSpend(data,
                                   strat_vars = NULL,
                                   upshift = up)

  exp_age <- smkfreediv::CalcWeekSpend(data,
                                   strat_vars = "Ageband",
                                   upshift = up)
  exp_age <- exp_age[order(Ageband),]


  exp_sex <- smkfreediv::CalcWeekSpend(data,
                                       strat_vars = "Sex",
                                       upshift = up)

  exp_grade <- smkfreediv::CalcWeekSpend(data,
                                         strat_vars = "grade_2cat",
                                         upshift = up)
  exp_grade <- exp_grade[order(grade_2cat),]

  exp_la <- smkfreediv::CalcWeekSpend(data,
                                      strat_vars = "UTLAname",
                                      upshift = up)
  exp_la <- exp_la[order(UTLAname),]

  exp[, upshift := up]
  exp_age[, upshift := up]
  exp_sex[, upshift := up]
  exp_grade[, upshift := up]
  exp_la[, upshift := up]


write.csv(exp,       paste0(Dir[2],"/weekly_spend_all.csv"))
write.csv(exp_age,   paste0(Dir[2],"/weekly_spend_age.csv"))
write.csv(exp_sex,   paste0(Dir[2],"/weekly_spend_sex.csv"))
write.csv(exp_grade, paste0(Dir[2],"/weekly_spend_grade.csv"))
write.csv(exp_la,    paste0(Dir[2],"/weekly_spend_la.csv"))

rm(exp, exp_age, exp_grade, exp_sex, exp_la, data)
