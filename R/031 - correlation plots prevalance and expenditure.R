### The aim of this code is to produce results tables and plots from the
### local authority level analysis

library(smkfreediv)
library(ggplot2)

div_la <- readRDS(paste0(Dir[2],"/results_local_authority_",4,".rds"))
con_la <- readRDS(paste0(Dir[2],"/results_consumption.rds"))

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
