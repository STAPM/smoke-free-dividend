### the aim of this code is to read in and clean the shapefiles needed to produce
### heatmaps in ggplot

library(tidyverse)
library(rgeos)
library(rgdal)
library(maptools)

##################################################
#### LOCAL AUTHORITY DISTRICT (DEC 2019) FILE ####

### shape file downloaded on 21/06/2021 from:
## https://geoportal.statistics.gov.uk/datasets/local-authority-districts-december-2019-boundaries-uk-bfc/explore?location=55.172187%2C-3.274222%2C6.00&showTable=true

shp <- readOGR('input_data/maps/local_authorities_2019/Local_Authority_Districts_(December_2019)_Boundaries_UK_BFC.shp')
shp <- fortify(shp, region = 'lad19cd')

#### code to show that there are 317 local authorities in England
#### in this shapefile data - so these are LTLA
#shp_dat <- data.table(shp)
#shp_dat <- unique(shp_dat[,"id"])
#shp_dat <- shp_dat[substring(id,1,1) == "E",]

saveRDS(shp, "input_data/shapefile_la.rds")
