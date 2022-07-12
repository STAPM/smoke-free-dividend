### The aim of this code is to produce results tables and plots from the
### local authority level analysis

source("R/000 - create directories.R")
source("R/003 - load packages.R")

div_la <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))
con_la <- readRDS(paste0(Dir[2],"/results_consumption.rds"))


## read in the sample size from the mean expenditure calculations
sampsize <- read.csv(paste0(Dir[2],"/weekly_spend_la.csv"))
setDT(sampsize)
sampsize <- sampsize[,c("UTLAname","sample_tkit")]

exp_plot_data <- merge(div_la, sampsize, by = "UTLAname")
exp_plot_data <- exp_plot_data[sample_tkit >= 10, ]

###############################################
## SMOKE FREE DIVIDEND PER CAPITA AND INCOME ##

div_corr <- round( cor.test(div_la$income, div_la$dividend/div_la$pop_n, method = "pearson")$estimate , 3)
div_corr_ci <- round( cor.test(div_la$income, div_la$dividend/div_la$pop_n, method = "pearson")$conf.int , 3)

ggplot(div_la) +
  aes(x = income/1000, y = dividend*1000000/pop_n) +
  geom_point() +
  geom_smooth(method='lm', se = F, linetype = 5, na.rm = T) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Smokefree Dividend per capita",
       title = "",
       caption = paste0("Pearson correlation coefficient: ", div_corr, ". 95% CI: (", div_corr_ci[1], " , ", div_corr_ci[2], ")" )) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)

##########################################
## CORRELATION PLOTS - PREVALENCE/INCOME

###### plot prevalence against income

ggplot(div_la) +
  aes(x = income/1000, y = smk_prev) +
  geom_point(color='black') +
  geom_smooth(method='loess', se = F, linetype = 5, na.rm = T) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Smoking Prevalence (%)",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(6,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)
#ggsave("output/corr_smkprev_income.png")

######### plot prevalence against income, colour by region

ggplot(div_la) +
  aes(x = income/1000, y = smk_prev , color = gor) +
  geom_point() +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Smoking Prevalence (%)",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(6,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  scale_colour_viridis_d()
#ggsave("output/corr_smkprev_income_byregion.png")

## as above, but allow for a regression line in each region

ggplot(div_la) +
  aes(x = income/1000, y = smk_prev , color = gor, linetype = gor) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='black') +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Smoking Prevalence (%)",
       title = "",
       color = "Region",
       linetype = "Region") +
  scale_y_continuous(breaks = seq(6,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  scale_colour_viridis_d()
#ggsave("output/corr_smkprev_income_byregion_regs.png")


##########################################
## CORRELATION PLOTS - SPENDING/INCOME

ggplot(exp_plot_data) +
  aes(x = income/1000, y = mean_week_spend) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Weekly Spend (£)",
       title = "",
       color = "Region",
       caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
  scale_y_continuous(breaks = seq(0,140,5), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)
#ggsave("output/corr_meanspend_income.png")

## plot spend % of income (upshifted) against income

ggplot(exp_plot_data) +
  aes(x = income/1000, y = spend_prop*100) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Spend as % of Disposable Income",
       title = "",
       color = "Region",
       caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
  scale_y_continuous(breaks = seq(0,100,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)
#ggsave("output/corr_propspend_income.png")




# manually adjust ordering of gor by mean income
exp_plot_data[, gor := factor(gor,
                     levels = c("North East", "North West", "West Midlands",
                                "Yorkshire and the Humber", "South West",
                                "East Midlands", "East of England", "South East", "London") )]



ggplot(exp_plot_data) +
  aes(x = income/1000, y = spend_prop*100, colour = gor) +
  geom_point() +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Spend as % of Disposable Income",
       title = "",
       color = "Region",
       caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
  scale_y_continuous(breaks = seq(0,100,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  scale_color_viridis_d(option = "magma")
