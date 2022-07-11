### The aim of this code is to use the smkfreediv functions to make the
### smokefree dividend calculations. Loop over different values of upshift



#### --------------- USE MY CALCULATED UPSHIFT -------------------------###

data <- readRDS(paste0(Dir[1],"/toolkit_clean_2022.rds"))

upshift <- read.csv(paste0(Dir[2],"/upshift_calcs.csv"))
up <- as.numeric(upshift[,"upshift"])

## overall
exp <- smkfreediv::CalcWeekSpend(data,
                                 strat_vars = NULL,
                                 upshift = up)

## by age
exp_age <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "Ageband",
                                     upshift = up)
exp_age <- exp_age[order(Ageband),]

## by sex
exp_sex <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "Sex",
                                     upshift = up)

## by social grade
exp_grade <- smkfreediv::CalcWeekSpend(data,
                                       strat_vars = "grade_2cat",
                                       upshift = up)
exp_grade <- exp_grade[order(grade_2cat),]

## by local authority
exp_la <- smkfreediv::CalcWeekSpend(data,
                                    strat_vars = "UTLAname",
                                    upshift = up)
exp_la <- exp_la[order(UTLAname),]

## by government office region
exp_gor <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "gor",
                                     upshift = up)
exp_gor <- exp_gor[order(gor),]

## add value of upshift factor to the calculations

exp[, upshift := up]
exp_age[, upshift := up]
exp_sex[, upshift := up]
exp_grade[, upshift := up]
exp_la[, upshift := up]
exp_gor[, upshift := up]

## save out results

write.csv(exp,       paste0(Dir[2],"/weekly_spend_all.csv"))
write.csv(exp_age,   paste0(Dir[2],"/weekly_spend_age.csv"))
write.csv(exp_sex,   paste0(Dir[2],"/weekly_spend_sex.csv"))
write.csv(exp_grade, paste0(Dir[2],"/weekly_spend_grade.csv"))
write.csv(exp_la,    paste0(Dir[2],"/weekly_spend_la.csv"))
write.csv(exp_gor,   paste0(Dir[2],"/weekly_spend_gor.csv"))

rm(exp, exp_age, exp_grade, exp_sex, exp_la, exp_gor, data)

#############################################################################
#### --------------- USE OHID CALCULATED UPSHIFT -------------------------###


data <- readRDS(paste0(Dir[1],"/toolkit_clean_2022.rds"))

up <- 1.7187398690

#### Estimate mean weekly spending for different stratification

## overall
exp <- smkfreediv::CalcWeekSpend(data,
                                 strat_vars = NULL,
                                 upshift = up)

## by age
exp_age <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "Ageband",
                                     upshift = up)
exp_age <- exp_age[order(Ageband),]

## by sex
exp_sex <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "Sex",
                                     upshift = up)

## by social grade
exp_grade <- smkfreediv::CalcWeekSpend(data,
                                       strat_vars = "grade_2cat",
                                       upshift = up)
exp_grade <- exp_grade[order(grade_2cat),]

## by local authority
exp_la <- smkfreediv::CalcWeekSpend(data,
                                    strat_vars = "UTLAname",
                                    upshift = up)
exp_la <- exp_la[order(UTLAname),]

## by government office region
exp_gor <- smkfreediv::CalcWeekSpend(data,
                                    strat_vars = "gor",
                                    upshift = up)
exp_gor <- exp_gor[order(gor),]

## add value of upshift factor to the calculations

exp[, upshift := up]
exp_age[, upshift := up]
exp_sex[, upshift := up]
exp_grade[, upshift := up]
exp_la[, upshift := up]
exp_gor[, upshift := up]

## save out results

write.csv(exp,       paste0(Dir[2],"/weekly_spend_all_OHID.csv"))
write.csv(exp_age,   paste0(Dir[2],"/weekly_spend_age_OHID.csv"))
write.csv(exp_sex,   paste0(Dir[2],"/weekly_spend_sex_OHID.csv"))
write.csv(exp_grade, paste0(Dir[2],"/weekly_spend_grade_OHID.csv"))
write.csv(exp_la,    paste0(Dir[2],"/weekly_spend_la_OHID.csv"))
write.csv(exp_gor,   paste0(Dir[2],"/weekly_spend_gor_OHID.csv"))

rm(exp, exp_age, exp_grade, exp_sex, exp_la, exp_gor, data)



#### --------------- BASELINE CALCS WITH NO UPSHIFT -------------------------###


data <- readRDS(paste0(Dir[1],"/toolkit_clean_2022.rds"))

up <- 1

#### Estimate mean weekly spending for different stratification

## overall
exp <- smkfreediv::CalcWeekSpend(data,
                                 strat_vars = NULL,
                                 upshift = up)

## by age
exp_age <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "Ageband",
                                     upshift = up)
exp_age <- exp_age[order(Ageband),]

## by sex
exp_sex <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "Sex",
                                     upshift = up)

## by social grade
exp_grade <- smkfreediv::CalcWeekSpend(data,
                                       strat_vars = "grade_2cat",
                                       upshift = up)
exp_grade <- exp_grade[order(grade_2cat),]

## by local authority
exp_la <- smkfreediv::CalcWeekSpend(data,
                                    strat_vars = "UTLAname",
                                    upshift = up)
exp_la <- exp_la[order(UTLAname),]

## by government office region
exp_gor <- smkfreediv::CalcWeekSpend(data,
                                     strat_vars = "gor",
                                     upshift = up)
exp_gor <- exp_gor[order(gor),]

## add value of upshift factor to the calculations

exp[, upshift := up]
exp_age[, upshift := up]
exp_sex[, upshift := up]
exp_grade[, upshift := up]
exp_la[, upshift := up]
exp_gor[, upshift := up]

## save out results

write.csv(exp,       paste0(Dir[2],"/weekly_spend_all_no_upshift.csv"))
write.csv(exp_age,   paste0(Dir[2],"/weekly_spend_age_no_upshift.csv"))
write.csv(exp_sex,   paste0(Dir[2],"/weekly_spend_sex_no_upshift.csv"))
write.csv(exp_grade, paste0(Dir[2],"/weekly_spend_grade_no_upshift.csv"))
write.csv(exp_la,    paste0(Dir[2],"/weekly_spend_la_no_upshift.csv"))
write.csv(exp_gor,   paste0(Dir[2],"/weekly_spend_gor_no_upshift.csv"))

rm(exp, exp_age, exp_grade, exp_sex, exp_la, exp_gor, data)
