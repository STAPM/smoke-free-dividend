### The aim of this code is to produce results tables and plots from the
### local authority level analysis

library(smkfreediv)
library(ggplot2)

div_la <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))

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
