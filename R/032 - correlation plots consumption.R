### The aim of this code is to produce correlation plots from the
### local authority level analysis to look at the relationship between income
### and different types of tobacco consumption.

library(smkfreediv)
library(ggplot2)

div_la <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))
con_la <- readRDS(paste0(Dir[2],"/results_consumption.rds"))

##########################################
## CORRELATION PLOTS - CONSUMPTION/INCOME

cons_plots <- merge(div_la, con_la, by = c("UTLAcode","UTLAname"))

## read in the sample size from the mean expenditure calculations
sampsize <- read.csv(paste0(Dir[2],"/weekly_spend_la.csv"))
setDT(sampsize)
sampsize <- sampsize[,c("UTLAname","sample_tkit")]

cons_plots <- merge(cons_plots, sampsize, by = "UTLAname")
cons_plots <- cons_plots[sample_tkit >= 10, ]

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
       caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
  scale_y_continuous(breaks = seq(3,26,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,2))
ggsave("output/consumption_avgtot_inc.png")

## income / average FM tobacco consumption

ggplot(cons_plots) +
  aes(x = income/1000, y = mean_cigs_fm) +
  geom_point(color='black') +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Average Daily Cigarette Consumption (FM only)",
       title = "",
       color = "Region",
       caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
  scale_y_continuous(breaks = seq(0,26,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,2))

ggplot(cons_plots) +
  aes(x = income/1000, y = mean_cigs_ryo) +
  geom_point(color='black') +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Average Daily Cigarette Consumption (HRT only)",
       title = "",
       color = "Region",
       caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
  scale_y_continuous(breaks = seq(0,26,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,2))

## income / RYO percentage of total consumption

  ggplot(cons_plots) +
    aes(x = income/1000, y = mean_ryoperc*100) +
    geom_point(color='black') +
    geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "Average % of Cigs Consumed that are HRT",
         title = "",
         color = "Region",
         caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
    scale_y_continuous(breaks = seq(0,100,5) , minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2))

## income / percent of smokers who smoke RYO

  ggplot(cons_plots) +
    aes(x = income/1000, y = prop_ryo*100) +
    geom_point(color='black') +
    geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "% of Smokers who Smoke HRT",
         title = "",
         color = "Region",
         caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
    scale_y_continuous(breaks = seq(0,100,5), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2))
  ggsave("output/consumption_prop_ryo.png")

## income / percent of smokers who smoke FM

    ggplot(cons_plots) +
    aes(x = income/1000, y = prop_fm*100) +
    geom_point(color='navy') +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "% of Smokers who Smoke FM",
         title = "",
         color = "Region",
         caption = "Note: Plot restricted to local authorities with 10 or more observations (smokers) in the toolkit data") +
    scale_y_continuous(breaks = seq(0,100,5), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2))

