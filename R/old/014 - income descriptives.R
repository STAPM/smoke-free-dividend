#### Descriptive statistics about income

# calculate overall average income

income <- smkfreediv::GetIncome()

mean_inc <- weighted.mean(income$income, w = income$population)

mean_weekly_inc <- mean_inc/52
