
## produce summary statistics and descriptive plots of the
## toolkit data

data <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))
data <- data[!(is.na(gor)),]

#### Distribution of weekly spending

exp <- smkfreediv::CalcWeekSpend(data, strat_vars = NULL, upshift = 1)

med <- as.numeric(exp[,"median_week_spend"])
mean   <- as.numeric(exp[,"mean_week_spend"])

ggplot(data) +
  aes(x = weekspend) +
  geom_density(alpha = 0.2) +
  geom_vline(xintercept = mean, color = "navy", linetype = 2) +
  geom_vline(xintercept = med, color = "maroon", linetype = 2) +
  theme_minimal() +
  scale_fill_viridis_d(option = "mako") +
  labs(y = " ", x = "Weekly Tobacco Spending (£)",
       caption = paste0("Median Weekly Spend = £",round(med,2),". Mean Weekly Spend = £",round(mean,2),"."))
ggsave("output/descriptives/spending distribution.png")

#### Distribution of weekly spending by region

# manually adjust ordering of gor so the colors in the box plot line up properly
data[, gor := factor(gor,
                     levels = c("North East", "West Midlands", "London",
                                "Yorkshire and the Humber", "East of England",
                                "East Midlands", "North West", "South East", "South West") )]

ggplot(data) +
  aes(x=reorder(gor,weekspend, FUN = "median", na.rm = TRUE),
      y = weekspend,
      fill = gor) +
  theme_minimal() +
  coord_flip() +
  geom_boxplot(outlier.alpha = 0.5) +
  scale_fill_viridis_d(option = "mako") +
  theme(legend.position = "none") +
  labs(x = " ", y = "Weekly Tobacco Spending (£)",
       caption = "outliers are points more than 1.5*IQR above the 3rd quartile")
ggsave("output/descriptives/spending distribution by region.png")

ggplot(data) +
  aes(x=reorder(gor,weekspend, FUN = "median", na.rm = TRUE),
      y = weekspend,
      fill = gor) +
  theme_minimal() +
  coord_flip() +
  geom_boxplot(outlier.shape = NA) +
  scale_fill_viridis_d(option = "mako") +
  theme(legend.position = "none") +
  labs(x = " ", y = "Weekly Tobacco Spending (£)")
