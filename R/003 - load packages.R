
library(smkfreediv)
library(data.table)
library(tidyverse)
library(ggpubr)     # for combining multiple ggplots
#library(rgeos)      # map packages
#library(rgdal)      # map packages
#library(maptools)   # map packages
library(sf)          # NEW map package

library(scales)
library(here)
library(stringr)
#library(flextable)
library(magrittr)
library(readxl)
library(openxlsx)

### custom theme for plots

theme_custom <- function() {
  theme_classic() %+replace%
    theme(plot.title.position="plot", plot.caption.position="plot",
          strip.background=element_blank(), strip.text=element_text(face="bold", size=rel(1)),
          plot.title=element_text(face="bold", size=rel(1.5), hjust=0,
                                  margin=margin(0,0,5.5,0)) )
}
