### The aim of this code is to produce results tables and plots from the
### local authority level analysis

library(smkfreediv)
library(ggplot2)

div_la <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))

############
## CORRELATION plots


plot_data <- copy(div_la)

## plot prevalence against income


plot_data$text <- with(plot_data,
                       paste0("Local Authority: ", UTLAname,
                              "<br>Average Income: £", round(income),
                              "<br>Smoking Prevalence: ",round(smk_prev,2),"%") )

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
ggsave("output/local authority/corr_smkprev_income.pdf")

## plot prevalence against income, colour by region

ggplot(plot_data) +
  aes(x = income/1000, y = smk_prev , color = GORname) +
  geom_point() +
  geom_smooth(method='loess', se = F, color='black', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Smoking Prevalence (%)",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(6,26,2), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL) +
  scale_colour_viridis_d()
ggsave("output/local authority/corr_smkprev_income_byregion.pdf")

## as above, but allow for a regression line in each region

ggplot(plot_data) +
  aes(x = income/1000, y = smk_prev , color = GORname, linetype = GORname) +
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
ggsave("output/local authority/corr_smkprev_income_byregion_regs.pdf")

## plot mean weekly spend (upshifted) against income

ggplot(plot_data) +
  aes(x = income/1000, y = mean_week_spend_up) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Weekly Spend (£)",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(20,70,5), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)
ggsave("output/local authority/corr_meanspend_income.pdf")

## plot spend % of income (upshifted) against income

ggplot(plot_data) +
  aes(x = income/1000, y = spend_prop_up*100) +
  geom_point() +
  geom_smooth(method='lm', se = F, color='turquoise4', linetype = 5) +
  theme_minimal() +
  labs(x = "Average Income (£000s)",
       y = "Mean Spend as % of Disposable Income",
       title = "",
       color = "Region") +
  scale_y_continuous(breaks = seq(0,100,1), minor_breaks = NULL) +
  scale_x_continuous(breaks = seq(5,45,5), minor_breaks = NULL)
ggsave("output/local authority/corr_propspend_income.pdf")

############
## HEAT MAPS

# merge UTLA level variables to U/L mapping data

data_mapping_merge <- merge(div_la, smkfreediv::localauthorities, by = c("UTLAcode","UTLAname"))

# merge all to the shapefile

shape <- readRDS(paste0(Dir[1],"/shapefile_la.rds"))

merge <- merge(data_mapping_merge, shape, by.x = "LAcode", by.y = "id", all.y = F)
merge <- arrange(merge,order)

### plot by smoking prevalence

ggplot(data = merge) +
  aes(x = long,
      y = lat,
      group = group,
      fill = cut(smk_prev,
                 breaks = c(0,10,12,14,16,18,20,100),
                 labels = c("Under 10%",
                            "10-12%",
                            "12-14%",
                            "14-16%",
                            "16-18%",
                            "18-20%",
                            "Over 20%"))) +
  geom_polygon() + coord_equal() + theme_void() +
  labs(title = ' ',
       subtitle = ' ',
       fill = "Prevalence") +
  scale_fill_viridis_d()

## plot by expenditure

choropleth <- merge
choropleth$text <- with(choropleth, paste0(UTLAname,": £", round(mean_week_spend_up,2) ))

p <- ggplot(data = choropleth) +
  aes(x = long, y = lat, group = group, text = text,
      fill = cut(mean_week_spend,
                 breaks = c(0,20,22,25,28,30,35,100),
                 labels = c("Under £20",
                            "£20 - £22",
                            "£22 - £25",
                            "£25 - £28",
                            "£28 - £30",
                            "£30 - £35",
                            "Over £35")) ) +
  geom_polygon() +
  coord_equal() +
  theme_void() +
  labs(title = 'Weekly Tobacco Expenditure by Local Authority',
       subtitle = 'England, 2014-2019',
       fill = "Mean Weekly Spend") +
  scale_fill_viridis_d()


plotly::ggplotly(p, tooltip = "text")
