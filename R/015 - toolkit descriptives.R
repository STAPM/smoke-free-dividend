
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

ggplot(data) +
  aes(x=reorder(gor,-weekspend, FUN = "median", na.rm = TRUE),
      y = weekspend,
      fill = gor) +
  theme_minimal() +
  coord_flip() +
  geom_boxplot() +
  scale_fill_viridis_d(option = "mako") +
  theme(legend.position = "none") +
  labs(x = " ", y = "Weekly Tobacco Spending (£)")
ggsave("output/descriptives/spending distribution by region.png")

