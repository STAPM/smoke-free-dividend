## produce figures for the % of expenditure that is tax (on products)
## at the economy level

library(readxl)
library(data.table)
library(ggplot2)

### loop over years - read in data and grow a time series dataset

for (y in 1997:2019) {

data <- readxl::read_excel("spreadsheets/bb21a10summarytables.xlsx",
                           sheet = as.character(y),
                           range = "H33:I33",
                           col_names = FALSE)

data <- data.table(y, data)

setDT(data)
setnames(data, names(data), c("year","tax","output"))

if (y == 1997) {
  final_data <- copy(data)
} else {

  final_data <- rbindlist(list(final_data,data))
}

}

### calculate tax as a proportion of total output

final_data[, tax_prop := tax/output]


ggplot(final_data) +
  aes(x = year, y = tax_prop*100) +
  geom_point() +
  geom_line() +
  theme_minimal() +
  labs(y = "Tax % of total output",
       x = " ",
       title = "Tax less subsidies on products - % of output")
