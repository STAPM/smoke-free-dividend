### The aim of this code is to produce results tables and plots from the
### local authority level analysis

library(smkfreediv)
library(ggplot2)

div_la <- readRDS(paste0(Dir[2],"/results_local_authority_",4,".rds"))
con_la <- readRDS(paste0(Dir[2],"/results_consumption.rds"))

##########################################
## CORRELATION PLOTS - CONSUMPTION/INCOME

cons_plots <- merge(div_la, con_la, by = c("UTLAcode","UTLAname"))

cons_plots$text <- with(cons_plots,
                       paste0("Local Authority: ", UTLAname,
                              "<br>Average Income: £", round(income),
                              "<br>Cigarettes: ",round(mean_cigs_tot,2)) )

## income / average total tobacco consumption

  ggplot(cons_plots) +
    aes(x = income/1000, y = mean_cigs_tot) +
    geom_point(color='navy') +
    geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "Average Daily Cigarette Consumption (FM + RYO)",
         title = "",
         color = "Region") +
    scale_y_continuous(breaks = seq(3,26,1), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2))
  ggsave("output/consumption_avgtot_inc.png")

## income / average FM tobacco consumption

  ggplot(cons_plots) +
    aes(x = income/1000, y = mean_cigs_fm, text = text) +
    geom_point(color='navy') +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "Average Daily Cigarette Consumption (FM only)",
         title = "",
         color = "Region") +
    scale_y_continuous(breaks = seq(3,26,1), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2))

## income / average RYO tobacco consumption


plotly::ggplotly(

  ggplot(cons_plots) +
    aes(x = income/1000, y = mean_cigs_ryo, text = text) +
    geom_point(color='navy') +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "Average Daily Cigarette Consumption (RYO only)",
         title = "",
         color = "Region") +
    scale_y_continuous(breaks = seq(0,26,1), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2)) , tooltip = c("text")

)

## income / RYO percentage of total consumption


plotly::ggplotly(

  ggplot(cons_plots) +
    aes(x = income/1000, y = mean_ryoperc*100, text = text) +
    geom_point(color='navy') +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "Average % of Cigs Consumed that are RYO",
         title = "",
         color = "Region") +
    scale_y_continuous(breaks = seq(0,100,5) , minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2)) , tooltip = c("text")

)

## income / percent of smokers who smoke RYO


plotly::ggplotly(

  ggplot(cons_plots) +
    aes(x = income/1000, y = prop_ryo*100, text = text) +
    geom_point(color='navy') +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "% of Smokers who Smoke RYO",
         title = "",
         color = "Region") +
    scale_y_continuous(breaks = seq(0,100,5), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2)) , tooltip = c("text")

)

## income / percent of smokers who smoke FM


plotly::ggplotly(

  ggplot(cons_plots) +
    aes(x = income/1000, y = prop_fm*100, text = text) +
    geom_point(color='navy') +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "% of Smokers who Smoke FM",
         title = "",
         color = "Region") +
    scale_y_continuous(breaks = seq(0,100,5), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2)) , tooltip = c("text")

)

## income / percent of smokers who smoke both


plotly::ggplotly(

  ggplot(cons_plots) +
    aes(x = income/1000, y = prop_fm*100, text = text) +
    geom_point(color='navy') +
    theme_minimal() +
    labs(x = "Average Income (£000s)",
         y = "% of Smokers who Smoke FM",
         title = "",
         color = "Region") +
    scale_y_continuous(breaks = seq(0,100,5), minor_breaks = NULL) +
    scale_x_continuous(breaks = seq(5,45,2)) , tooltip = c("text")

)

##########################################
## CORRELATION PLOTS - PREVALENCE/INCOME

plot_data <- merge(div_la, smkfreediv::utla_gor_lookup, by = "UTLAname")


###### plot prevalence against income


plot_data$text <- with(plot_data,
                       paste0("Local Authority: ", UTLAname,
                              "<br>Average Income: £", round(income),
                              "<br>Smoking Prevalence: ",round(smk_prev,2),"%") )

## plotly
plotly::ggplotly(

ggplot(plot_data) +
  aes(x = income/1000, y = smk_prev, text = text) +
  geom_point(color='navy') +
  geom_smooth(method='lm', se = F, linetype = 5, na.rm = T) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Smoking Prevalence (%)",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(6,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) , tooltip = c("text")

)

## regular plot

ggplot(plot_data) +
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
ggsave("output/corr_smkprev_income.png")

######### plot prevalence against income, colour by region

ggplot(plot_data) +
  aes(x = income/1000, y = smk_prev , color = region) +
  geom_point() +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Smoking Prevalence (%)",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(6,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  scale_colour_viridis_d()
ggsave("output/corr_smkprev_income_byregion.png")

## as above, but allow for a regression line in each region

ggplot(plot_data) +
  aes(x = income/1000, y = smk_prev , color = region, linetype = region) +
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
ggsave("output/corr_smkprev_income_byregion_regs.png")


##########################################
## CORRELATION PLOTS - SPENDING/INCOME

ggplot(plot_data) +
  aes(x = income/1000, y = mean_week_spend) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Weekly Spend (£)",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(20,140,5), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)
ggsave("output/corr_meanspend_income.png")

## plot spend % of income (upshifted) against income

ggplot(plot_data) +
  aes(x = income/1000, y = spend_prop*100) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Spend as % of Disposable Income",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(0,100,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)
ggsave("output/corr_propspend_income.png")
