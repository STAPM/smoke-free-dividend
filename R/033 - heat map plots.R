### The aim of this code is to produce results tables and plots from the
### local authority level analysis

library(smkfreediv)
library(ggplot2)

div_la <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))

############
## HEAT MAPS

# merge UTLA level variables to U/L mapping data

data_mapping_merge <- merge(smkfreediv::income[,c("UTLAcode","LAcode","LAname")],
                            div_la,
                            by = c("UTLAcode"))

### ---------update lower tier local authorities so they match to the 2019 changes

# Somerset
data_mapping_merge[LAcode %in% c("E07000190","E07000191"), LAname := "Somerset West and Taunton"]
data_mapping_merge[LAcode %in% c("E07000190","E07000191"), LAcode := "E07000246"]

# Gateshead
data_mapping_merge[LAcode %in% c("E08000020"), LAname := "Gateshead"]
data_mapping_merge[LAcode %in% c("E08000020"), LAcode := "E08000037"]

# Northumberland
data_mapping_merge[LAcode %in% c("E06000048"), LAname := "Northumberland"]
data_mapping_merge[LAcode %in% c("E06000048"), LAcode := "E06000057"]

# Bournemouth, Christchurch and Poole
data_mapping_merge[LAcode %in% c("E06000028","E06000029","E07000048"), LAname := "Bournemouth, Christchurch and Poole"]
data_mapping_merge[LAcode %in% c("E06000028","E06000029","E07000048"), LAcode := "E06000058"]

# Dorset
data_mapping_merge[LAcode %in% c("E07000048","E07000049","E07000050",
                                 "E07000051","E07000052","E07000053"), LAname := "Dorset"]
data_mapping_merge[LAcode %in% c("E07000048","E07000049","E07000050",
                                 "E07000051","E07000052","E07000053"), LAcode := "E06000059"]


# East Hertfordshire
data_mapping_merge[LAcode %in% c("E07000097"), LAname := "East Hertfordshire"]
data_mapping_merge[LAcode %in% c("E07000097"), LAcode := "E07000242"]

# Stevenage
data_mapping_merge[LAcode %in% c("E07000101"), LAname := "Stevenage"]
data_mapping_merge[LAcode %in% c("E07000101"), LAcode := "E07000243"]

# West Suffolk
data_mapping_merge[LAcode %in% c("E07000205","E07000206"), LAname := "East Suffolk"]
data_mapping_merge[LAcode %in% c("E07000205","E07000206"), LAcode := "E07000244"]

# West Suffolk
data_mapping_merge[LAcode %in% c("E07000201","E07000204"), LAname := "West Suffolk"]
data_mapping_merge[LAcode %in% c("E07000201","E07000204"), LAcode := "E07000245"]

###### LA mergers should reduce number of unique English LAs from 326 to 317
data_mapping_merge <- unique(data_mapping_merge)

## check shapefile and results file local authorities match properly 1:1 for 317 LAs

#shape <- readRDS(paste0(Dir[1],"/shapefile_la.rds"))
#setDT(shape)
#shape_test <- shape[substring(id, 1, 1) == "E",]
#shape_test <- data.frame(unique(shape[,"id"]))
#setDT(shape_test)
#shape_test <- shape_test[substring(id, 1, 1) == "E",]
#shape_test[, flag := "X"]
#merge <- merge(data_mapping_merge, shape_test, by.x = "LAcode", by.y = "id", all = T)

# merge all to the shapefile

#### ---------------------------------------------------------------------------------------------------------------------

#############################
### Merge to the full shapefile, note all.y = F to remove Scottish/Welsh LAs


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

### plot by income

ggplot(data = merge) +
  aes(x = long,
      y = lat,
      group = group,
      fill = cut(income,
                 breaks = c(0,20,25,30,35,40,100),
                 labels = c("Under £20,000",
                            "£20,000 - £25,000",
                            "£25,000 - £30,000",
                            "£30,000 - £35,000",
                            "£35,000 - £40,000",
                            "Over £40,000"))) +
  geom_polygon() + coord_equal() + theme_void() +
  labs(title = ' ',
       subtitle = ' ',
       fill = "Annual Income") +
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
