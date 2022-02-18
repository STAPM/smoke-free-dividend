### The aim of this code is to produce results tables and plots from the
### local authority level analysis

library(smkfreediv)
library(ggplot2)

div_la <- readRDS(paste0(Dir[2],"/results_local_authority.rds"))

div_la[, inc_decile := ntile(income,10)]
div_la[, inc_prop_decile := ntile(spend_prop,10)]
div_la[, dividend_decile := ntile(dividend/pop_n,10)]
div_la[, prev_decile := ntile(smk_prev,10)]



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

shape <- readRDS(paste0(Dir[1],"/shapefile_la.rds"))
setDT(shape)
#shape_test <- shape[substring(id, 1, 1) == "E",]
#shape_test <- data.frame(unique(shape[,"id"]))
#setDT(shape_test)
#shape_test <- shape_test[substring(id, 1, 1) == "E",]
#shape_test[, flag := "X"]
#merge <- merge(data_mapping_merge, shape_test, by.x = "LAcode", by.y = "id", all = T)

# merge all to the shapefile


#############################
### Merge to the full shapefile, note all.y = F to remove Scottish/Welsh LAs


heat_map_data <- merge(data_mapping_merge, shape, by.x = "LAcode", by.y = "id", all.y = F)
heat_map_data <- arrange(merge,order)



#### ---------------------------------------------------------------------------------------------------------------------
