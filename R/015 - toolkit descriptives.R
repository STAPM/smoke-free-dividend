# calculate mean weekly expenditure by age/sex
exp <- smkfreediv::CalcWeekSpend(data = data,
                                 strat_vars = c("Sex","Ageband"),
                                 upshift = 1)

# get population weights and merge
pop_n <- smkfreediv::pop_counts

pop_age_sex <- pop_n[, .(pop = sum(population)),
                     by = c("Sex","Ageband")]

merge <- merge(exp, pop_age_sex, by = c("Sex","Ageband"), sort = T)

ggplot(merge) +
  aes(x = Ageband, y = mean_week_spend, fill = Sex) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  labs(y = "Meaan Weekly Expenditure (£)", x = "Age")
