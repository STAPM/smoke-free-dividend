### The aim of this code is to produce correlation plots from the
### local authority level analysis to look at the relationship between income
### and different types of tobacco consumption.

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
