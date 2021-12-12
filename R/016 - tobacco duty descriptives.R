
## produce summary statistics and descriptive plots of the
## tobacco duties data

duties <- smkfreediv::tobacco_duty_receipts[year %in% 2000:2020,]

# CPI is monthly, use a mid-year figure (June)
cpi <- smkfreediv::cpi_tobacco[Year %in% 2000:2020 & month == 6, "cpi"]

duties <- cbind(duties,cpi)

############################
## plot duties over time ###

duties_plot <- melt(duties[,c("year","cpi","FM_cigs","RYO_tob","Total")],
                    id.vars = c("year","cpi"),
                    value.name = "duty",
                    variable.name = "Product")

duties_plot[, duty := duty*smkfreediv::prop_smokers_ENG]
duties_plot[, Product := factor(Product,
                                levels = c("FM_cigs","RYO_tob","Total"),
                                labels = c("Cigarettes","HRT","Total"))]

duties_plot[, duty_real := duty*(100/cpi)]

ggplot(duties_plot) +
  geom_line( aes(x = year, y = duty,      color = Product), linetype = 1 ) +
  geom_point(aes(x = year, y = duty,      color = Product, shape = Product)) +
  geom_line( aes(x = year, y = duty_real, color = Product), linetype = 2 ) +
  geom_point(aes(x = year, y = duty_real, color = Product, shape = Product)) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  labs(y = "Duty receipts (£m)", x = " ",
       caption = "dashed lines represent real terms duties in December 2018 prices (CPI All Tobacco)")

## look at 2018 only

duties_all_2018 <- as.numeric(duties_plot[year == 2018 & Product == "Total", "duty"])

############################################################
## compare Toolkit implies total spend with duty receipts ##

tkit <- readRDS(paste0(Dir[1],"/toolkit_clean.rds"))

tot_smokers    <- round( sum(smkfreediv::PHE_tobacco_profiles[, "n_smokers"], na.rm = T) )
tot_mean_spend <- round( as.numeric( smkfreediv::CalcWeekSpend(tkit, strat_vars = NULL, upshift = 1)[,"mean_week_spend"] ), 2)

tot_exp <- (tot_mean_spend * tot_smokers * 52)/1000000

