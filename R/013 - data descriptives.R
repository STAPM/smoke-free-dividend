### Basic data descriptives

data <- readRDS("input_data/toolkit_clean.rds")

### observations in the data

dim(data)[1]

### observations in the data who are smokers

dim(data[Smoker == 1,] )[1]

### observations in the data who are smokers and have a valid expenditure value
### and check that non-smokers do not report expenditures

dim(data[Smoker == 1 & !(is.na(weekspend)),] )[1]
dim(data[Smoker == 0 & !(is.na(weekspend)),] )[1]

### smokers with missing expenditures

dim(data[Smoker == 1 & is.na(weekspend),] )[1]


### Proportion of smokers with a valid expenditure value

dim(data[Smoker == 1 & !(is.na(weekspend)),] )[1] / dim(data[Smoker == 1,] )[1]
