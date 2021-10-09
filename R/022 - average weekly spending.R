### The aim of this code is to use the smkfreediv functions to make the
### smokefree dividend calculations. Loop over different values of upshift

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

for (i in 1:length(upshift_vec)) {

  exp <- smkfreediv::CalcWeekSpend(data,
                                   strat_vars = NULL,
                                   upshift = upshift_vec[i])

  exp_age <- smkfreediv::CalcWeekSpend(data,
                                   strat_vars = "Ageband",
                                   upshift = upshift_vec[i])
  exp_age <- exp_age[order(Ageband),]


  exp_sex <- smkfreediv::CalcWeekSpend(data,
                                       strat_vars = "Sex",
                                       upshift = upshift_vec[i])

  exp_grade <- smkfreediv::CalcWeekSpend(data,
                                       strat_vars = "grade_2cat",
                                       upshift = upshift_vec[i])
  exp_grade <- exp_grade[order(grade_2cat),]

  exp_la <- smkfreediv::CalcWeekSpend(data,
                                         strat_vars = "UTLAname",
                                         upshift = upshift_vec[i])
  exp_la <- exp_la[order(UTLAname),]

  exp[, upshift := i]
  exp_age[, upshift := i]
  exp_sex[, upshift := i]
  exp_grade[, upshift := i]
  exp_la[, upshift := i]

  assign(paste0("exp_",i), exp)
  assign(paste0("exp_age_",i), exp_age)
  assign(paste0("exp_sex_",i), exp_sex)
  assign(paste0("exp_grade_",i), exp_grade)
  assign(paste0("exp_la_",i), exp_la)

}

exp       <- rbindlist(list(exp_1, exp_2, exp_3, exp_4, exp_5))
exp_age   <- rbindlist(list(exp_age_1, exp_age_2, exp_age_3, exp_age_4, exp_age_5))
exp_sex   <- rbindlist(list(exp_sex_1, exp_sex_2, exp_sex_3, exp_sex_4, exp_sex_5))
exp_grade <- rbindlist(list(exp_grade_1, exp_grade_2, exp_grade_3, exp_grade_4, exp_grade_5))
exp_la    <- rbindlist(list(exp_la_1, exp_la_2, exp_la_3, exp_la_4, exp_la_5))

rm(exp_1, exp_2, exp_3, exp_4, exp_5,
   exp_age_1, exp_age_2, exp_age_3, exp_age_4, exp_age_5,
   exp_sex_1, exp_sex_2, exp_sex_3, exp_sex_4, exp_sex_5,
   exp_grade_1, exp_grade_2, exp_grade_3, exp_grade_4, exp_grade_5,
   exp_la_1, exp_la_2, exp_la_3, exp_la_4, exp_la_5)

write.csv(exp,       paste0(Dir[2],"/weekly_spend_all.csv"))
write.csv(exp_age,   paste0(Dir[2],"/weekly_spend_age.csv"))
write.csv(exp_sex,   paste0(Dir[2],"/weekly_spend_sex.csv"))
write.csv(exp_grade, paste0(Dir[2],"/weekly_spend_grade.csv"))
write.csv(exp_la,    paste0(Dir[2],"/weekly_spend_la.csv"))

rm(exp, exp_age, exp_grade, exp_sex, exp_la, data)
