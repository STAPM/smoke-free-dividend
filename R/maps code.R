library(tidyverse)
library(rgeos)
library(rgdal)
library(maptools)

### shape file downloaded from:

## https://geoportal.statistics.gov.uk/datasets/local-authority-districts-december-2019-boundaries-uk-bfc/explore?location=55.172187%2C-3.274222%2C6.00&showTable=true

## on 21/06/2021

shp <- readOGR('data_input/maps/local_authorities_2019/Local_Authority_Districts_(December_2019)_Boundaries_UK_BFC.shp')
shp <- fortify(shp, region = 'lad19cd')

#### code to show that there are 317 local authorities in England
#### in this shapefile data - so these are LTLA
#shp_dat <- data.table(shp)
#shp_dat <- unique(shp_dat[,"id"])
#shp_dat <- shp_dat[substring(id,1,1) == "E",]

### merge the mapping data to the shape file

# merge UTLA level variables to U/L mapping data
data_mapping_merge <- merge(div_la, smkfreediv::localauthorities,
                            by = c("UTLAcode","UTLAname"))

# merge all to the shapefile
merge <- merge(data_mapping_merge, shp,
               by.x = "LAcode", by.y = "id", all.y = F)
merge <- arrange(merge,order)

### plot

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

ggplot(data = merge) +
  aes(x = long,
      y = lat,
      group = group,
      fill = cut(mean_week_spend,
                 breaks = c(0,20,22,25,28,30,35,100),
                 labels = c("Under £20",
                            "£20 - £22",
                            "£22 - £25",
                            "£25 - £28",
                            "£28 - £30",
                            "£30 - £35",
                            "Over £35"))) +
  geom_polygon() + coord_equal() + theme_void() +
  labs(title = 'Weekly Tobacco Expenditure by Local Authority',
       subtitle = 'England, 2014-2019',
       fill = "Mean Weekly Spend") +
  scale_fill_viridis_d()

#+ scale_fill_gradient(low = "white", high = "red", na.value = "white")
