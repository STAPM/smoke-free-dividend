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

######################
### FIGURE 2 #########

exp_plot_data <- merge(div_la, sampsize, by = "UTLAname")
exp_plot_data <- exp_plot_data[sample_tkit >= 10, ]

### Calculate correlation coefficients and 95% CIs

spend_corr <- round( cor.test(exp_plot_data$income, exp_plot_data$mean_week_spend, method = "pearson")$estimate , 3)
spend_corr_ci <- round( cor.test(exp_plot_data$income, exp_plot_data$mean_week_spend, method = "pearson")$conf.int , 3)

prop_corr <- round( cor.test(exp_plot_data$income, exp_plot_data$spend_prop, method = "pearson")$estimate , 3)
prop_corr_ci <- round( cor.test(exp_plot_data$income, exp_plot_data$spend_prop, method = "pearson")$conf.int , 3)

### Mean weekly spending

spend <- ggplot(exp_plot_data) +
  aes(x = income/1000, y = mean_week_spend) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Weekly Spend (£)",
       title = "",
       caption = paste0("Pearson correlation coefficient: ", spend_corr, ". 95% CI: (", spend_corr_ci[1], " , ", spend_corr_ci[2], ")" )) +
  scale_y_continuous(breaks = seq(0,140,5), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)

### Mean weekly spending as a % of household income

prop <- ggplot(exp_plot_data) +
  aes(x = income/1000, y = spend_prop*100) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "% of Disposable Income",
       title = "",
       caption = paste0("Pearson correlation coefficient: ", prop_corr, ". 95% CI: (", prop_corr_ci[1], " , ", prop_corr_ci[2], ")" )) +
  scale_y_continuous(breaks = seq(0,100,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)

### combine plots


figure <- ggarrange(spend, prop + font("x.text", size = 10),
                    ncol = 1, nrow = 2)
annotate_figure(figure,
                bottom = text_grob("Note: Plot restricted to local authorities with 10 or more smokers in the STS", color = "black",
                                   hjust = 1, x = 1, face = "italic", size = 10)
)


ggsave("output/corr_spend_income.png")




######################
### FIGURE 3 #########

cons_plots <- merge(div_la, con_la, by = c("UTLAcode","UTLAname"))

## read in the sample size from the mean expenditure calculations
sampsize <- read.csv(paste0(Dir[2],"/weekly_spend_la.csv"))
setDT(sampsize)
sampsize <- sampsize[,c("UTLAname","sample_tkit")]

cons_plots <- merge(cons_plots, sampsize, by = "UTLAname")
cons_plots <- cons_plots[sample_tkit >= 10, ]

## correlation coefficients

fm_corr <- round( cor.test(cons_plots$income, cons_plots$mean_cigs_fm, method = "pearson")$estimate , 3)
fm_corr_ci <- round( cor.test(cons_plots$income, cons_plots$mean_cigs_fm, method = "pearson")$conf.int , 3)

ryo_corr <- round( cor.test(cons_plots$income, cons_plots$mean_cigs_ryo, method = "pearson")$estimate , 3)
ryo_corr_ci <- round( cor.test(cons_plots$income, cons_plots$mean_cigs_ryo, method = "pearson")$conf.int , 3)

tot_corr <- round( cor.test(cons_plots$income, cons_plots$mean_cigs_tot, method = "pearson")$estimate , 3)
tot_corr_ci <- round( cor.test(cons_plots$income, cons_plots$mean_cigs_tot, method = "pearson")$conf.int , 3)

## income / average total tobacco consumption

ggplot(cons_plots) +
  aes(x = income/1000, y = mean_cigs_tot) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Average Daily Cigarette Consumption",
       title = "",
       color = "Region",
       caption = "Note: Plot restricted to local authorities with 10 or more smokers in the STS") +
  scale_y_continuous(breaks = seq(3,26,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,2))
ggsave("output/consumption_avgtot_inc.png")


###
cons_plots_long <- cons_plots[,c("UTLAcode","UTLAname","mean_cigs_fm","mean_cigs_ryo","mean_cigs_tot","income")]
cons_plots_long <- melt(cons_plots_long,
                        id.vars = c("UTLAcode","UTLAname","income"),
                        variable.name = "product",
                        value.name = "cigarettes")

cons_plots_long[product == "mean_cigs_fm", product := "Factory Made"]
cons_plots_long[product == "mean_cigs_ryo", product := "Hand-Rolled Tobacco"]
cons_plots_long[product == "mean_cigs_tot", product := "Total"]


ggplot(cons_plots_long) +
  aes(x = income/1000, y = cigarettes) +
  geom_point() +
  geom_smooth(method='lm', se = F, linetype = 5) +
  facet_wrap(~product) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Average Daily Cigarette Consumption",
       title = "",
       caption = "Note: Plot restricted to local authorities with 10 or more smokers in the STS") +
  scale_y_continuous(breaks = seq(0,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  theme(legend.position = "bottom")
ggsave("output/consumption_avgtot_inc_by_product.png")



######################################
####### EXTRA FIGURES ################

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
ggsave("output/corr_divpc_income.png")

