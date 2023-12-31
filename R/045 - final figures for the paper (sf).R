### The aim of this code is to produce results tables and plots from the
### local authority level analysis

source("R/003 - load packages.R")
source("R/033 - heat map plots setup (sf).R")

######################
### READ IN DATA #####

### figure 1 data
toolkit <- readRDS("input_data/toolkit_clean.rds")
toolkit <- toolkit[!(is.na(gor)),]

### figures 2 and 3 data
div_la <- readRDS("intermediate_data/results_local_authority.rds")
con_la <- readRDS("intermediate_data/results_consumption.rds")

sampsize <- read.csv("intermediate_data/weekly_spend_la.csv")
setDT(sampsize)
sampsize <- sampsize[,c("UTLAname","sample_tkit")]

######################
### FIGURE 1 #########

####### Smokefree dividend per capita by region

gor_results <- readRDS("intermediate_data/results_region.rds")

gor_results[, dividend_pc := dividend*1000000/pop_n]
gor_results[, income := income/1000]

gor_plot <- gor_results[, c("gor","spend_prop","dividend_pc","income")]

gor_plot[, gor := factor(gor,
                         levels = c("North East","Yorkshire and the Humber", "East Midlands", "West Midlands", "North West",
                                    "East of England", "London", "South West", "South East") )]

gor_plot[, incround := round(income*1000)]
gor_plot[, label := format(incround, big.mark = ",", nsmall = 0 )]

ggplot(gor_plot) +
  aes(x = reorder(gor,dividend_pc, FUN = "median", na.rm = TRUE),
      y = dividend_pc,
      fill = income) +
  theme_custom() +
  coord_flip() +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(y = dividend_pc - 10, label = paste0("£",label)  )) +
  theme(legend.position = "bottom") +
  labs(x = "", y = "Annual smoke-free dividend per 18+ population",
       fill = "Average equivalised household income \n after housing costs (£000s)",
       caption = "Bar labels show the regional average equivalised household income") +
  scale_y_continuous(breaks = seq(0,400,50), labels = dollar_format(prefix="£")) +
  scale_fill_gradient(low = "#ade8f4",
                      high = "#d9ed92")
ggsave("output/main results/fig_1.pdf", dpi = 600, units = "mm", width = 180)
ggsave("output/main results/fig_1.png", dpi = 600, units = "mm", width = 180)

############################
##### FIGURE 2 #############


hm1 <- ggplot(data = heat_map_data) +
  geom_sf(aes(geometry = geometry, fill = inc_decile)) +
  theme_void() +
  scale_fill_viridis_c(option = "magma") +
  labs(fill = "Decile")

hm3 <- ggplot(data = heat_map_data) +
  geom_sf(aes(geometry = geometry, fill = dividend_decile)) +
  theme_void() +
  scale_fill_viridis_c(option = "magma") +
  labs(fill = "Decile")

ggarrange(hm1, hm3,labels = c("Average Income", "Dividend per capita"),
          ncol = 2, nrow = 1,  common.legend = TRUE, legend = "bottom")
ggsave("output/main results/fig_2.pdf", dpi = 600, units = "mm", width = 180)
ggsave("output/main results/fig_2.png", dpi = 600, units = "mm", width = 180)

######################
### FIGURE 3 #########

cons_plots <- merge(div_la, con_la, by = c("UTLAcode","UTLAname"))

## read in the sample size from the mean expenditure calculations
sampsize <- read.csv("intermediate_data//weekly_spend_la.csv")
setDT(sampsize)
sampsize <- sampsize[,c("UTLAname","sample_tkit")]

cons_plots <- merge(cons_plots, sampsize, by = "UTLAname")
cons_plots <- cons_plots[sample_tkit >= 10, ]


cons_plots_long <- cons_plots[,c("UTLAcode","UTLAname","mean_cigs_fm","mean_cigs_ryo","mean_cigs_tot","income","smk_prev")]
cons_plots_long <- melt(cons_plots_long,
                        id.vars = c("UTLAcode","UTLAname","income","smk_prev"),
                        variable.name = "product",
                        value.name = "cigarettes")

cons_plots_long[product == "mean_cigs_fm", product := "Factory Made"]
cons_plots_long[product == "mean_cigs_ryo", product := "Hand-Rolled Tobacco"]
cons_plots_long[product == "mean_cigs_tot", product := "All Tobacco"]


ggplot(cons_plots_long) +
  geom_point(aes(x = income/1000, y = cigarettes, alpha = smk_prev), size = 2.5) +
  geom_smooth(aes(x = income/1000, y = cigarettes), method='lm', se = F, linetype = 5) +
  facet_wrap(~product) +
  theme_custom() +
  labs(x = "Average Income (£000s)",
       y = "Average Daily Cigarette Consumption\n by smokers",
       title = "",
       alpha = "Smoking Prevalence (%)",
       caption = "Note: Plot restricted to local authorities with 10 or more smokers in the STS") +
  scale_y_continuous(breaks = seq(0,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  theme(legend.position = "bottom")
ggsave("output/main results/fig_3.pdf", dpi = 600, units = "mm", width = 180)
ggsave("output/main results/fig_3.png", dpi = 600, units = "mm", width = 180)

######################
### FIGURE 4 #########

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
  theme_classic() +
  labs(x = "Average Income (£000s)",
       y = "Average Weekly Spend",
       title = "",
       subtitle = "(a) Correlation between average income and \nweekly spending",
       caption = paste0("Pearson correlation coefficient: ", spend_corr, ". 95% CI: (", spend_corr_ci[1], " , ", spend_corr_ci[2], ")" )) +
  scale_y_continuous(breaks = seq(0,100,10), minor_breaks = NULL, labels=dollar_format(prefix="£")) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)

### Mean weekly spending as a % of household income

prop <- ggplot(exp_plot_data) +
  aes(x = income/1000, y = spend_prop) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_classic() +
  labs(x = "Average Income (£000s)",
       y = "Average Weekly Spend \n(% of Income)",
       title = "",
       subtitle = "(b) Correlation between average income and \nweekly spending as % of income",
       caption = paste0("Pearson correlation coefficient: ", prop_corr, ". 95% CI: (", prop_corr_ci[1], " , ", prop_corr_ci[2], ")" )) +
  scale_y_continuous(breaks = seq(0,1,.02), minor_breaks = NULL, labels = scales::percent) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)

### combine plots


figure <- ggarrange(spend, prop,
                    ncol = 1, nrow = 2)
annotate_figure(figure,
                bottom = text_grob("Note: Plot restricted to local authorities with 10 or more smokers in the STS", color = "black",
                                   hjust = 1, x = 1, size = 9)
)

figure
ggsave("output/main results/fig_4.pdf", dpi = 600, units = "in", width = 5.5, height = 7)
ggsave("output/main results/fig_4.png", dpi = 600, units = "in", width = 5.5, height = 7)


############################
##### FIGURE 5 #############

### plot income

hm1 <- ggplot(data = heat_map_data) +
  geom_sf(aes(geometry = geometry, fill = inc_decile)) +
  theme_void() +
  scale_fill_viridis_c(option = "magma") +
  labs(fill = "Decile")


### plot spend as % of income

hm2 <- ggplot(data = heat_map_data) +
  geom_sf(aes(geometry = geometry, fill = inc_prop_decile)) +
  theme_void() +
  scale_fill_viridis_c(option = "magma") +
  labs(fill = "Decile")


ggarrange(hm1, hm2,labels = c("Average Income", "Spend % of Income"),
          ncol = 2, nrow = 1,  common.legend = TRUE, legend = "bottom")
ggsave("output/main results/fig_5.pdf", dpi = 600, units = "mm", width = 180)
ggsave("output/main results/fig_5.png", dpi = 600, units = "mm", width = 180)




######################################
####### EXTRA FIGURES ################



####### Distribution of spending by region

# manually adjust ordering of gor so the colors in the box plot line up properly
toolkit[, gor := factor(gor,
                     levels = c("North East", "West Midlands", "London",
                                "Yorkshire and the Humber", "East of England",
                                "East Midlands", "North West", "South East", "South West") )]

ggplot(toolkit) +
  aes(x=reorder(gor,weekspend, FUN = "median", na.rm = TRUE),
      y = weekspend,
      fill = gor) +
  theme_custom() +
  coord_flip() +
  geom_boxplot(outlier.alpha = 0.5) +
  scale_fill_viridis_d(option = "mako") +
  theme(legend.position = "none") +
  labs(x = " ", y = "Weekly Tobacco Spending (£)",
       caption = "outliers are points more than 1.5*IQR above the 3rd quartile")
ggsave("output/main results/FIG_EXTRA_spending_distribution_by_region.png", dpi = 600)

######### income / percent of smokers who smoke RYO

ggplot(cons_plots) +
  aes(x = income/1000, y = prop_ryo*100) +
  geom_point(color='black') +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_custom() +
  labs(x = "Average Income (£000s)",
       y = "% of Smokers who Smoke HRT",
       title = "",
       color = "Region",
       caption = "Note: Plot restricted to local authorities with 10 or more smokers in the STS") +
  scale_y_continuous(breaks = seq(0,100,5), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,2))
ggsave("output/main results/FIG_EXTRA_consumption_prop_ryo.png", dpi = 600)


####### Income / Smoke free dividend per capita

div_corr <- round( cor.test(div_la$income, div_la$dividend/div_la$pop_n, method = "pearson")$estimate , 3)
div_corr_ci <- round( cor.test(div_la$income, div_la$dividend/div_la$pop_n, method = "pearson")$conf.int , 3)

ggplot(div_la) +
  aes(x = income/1000, y = dividend*1000000/pop_n) +
  geom_point() +
  geom_smooth(method='lm', se = F, linetype = 5, na.rm = T) +
  theme_custom() +
  labs(x = "Average Income (£000s)",
       y = "Smokefree Dividend per capita (£)",
       title = "",
       caption = paste0("Pearson correlation coefficient: ", div_corr, ". 95% CI: (", div_corr_ci[1], " , ", div_corr_ci[2], ")" )) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  scale_y_continuous(breaks = seq(150,550,50))
ggsave("output/main results/FIG_EXTRA_corr_divpc_income.png", dpi = 600)

