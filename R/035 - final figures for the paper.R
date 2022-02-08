### The aim of this code is to produce results tables and plots from the
### local authority level analysis

source("R/000 - create directories.R")
source("R/003 - load packages.R")

######################
### FIGURE 2 #########


div_la <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))

## read in the sample size from the mean expenditure calculations
sampsize <- read.csv(paste0(Dir[2],"/weekly_spend_la.csv"))
setDT(sampsize)
sampsize <- sampsize[,c("UTLAname","sample_tkit")]

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
  labs(x = " ",
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


