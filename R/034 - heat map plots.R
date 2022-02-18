
#######################
### plot income #######

hm1 <- ggplot(heat_map_data) +
  aes(x = long,
      y = lat,
      group = group,
      fill = inc_decile) +
  geom_polygon() + coord_equal() + theme_void() +
  labs(title = '  ',
       subtitle = ' ',
       fill = "Decile") +
  scale_fill_viridis_c(option = "magma") +
  theme(legend.position = "none")

#####################################
### plot spend as % of income #######

hm2 <- ggplot(heat_map_data) +
  aes(x = long,
      y = lat,
      group = group,
      fill = inc_prop_decile) +
  geom_polygon() + coord_equal() + theme_void() +
  labs(title = ' ',
       subtitle = ' ',
       fill = "Decile") +
  scale_fill_viridis_c(option = "magma") +
  theme(legend.position = "none")


#########################
### plot dividend #######

hm3 <- ggplot(heat_map_data) +
  aes(x = long,
      y = lat,
      group = group,
      fill = dividend_decile) +
  geom_polygon() + coord_equal() + theme_void() +
  labs(title = ' ',
       subtitle = ' ',
       fill = "Decile") +
  scale_fill_viridis_c(option = "magma") +
  theme(legend.position = "none")

###########################
### plot prevalence #######

hm4 <- ggplot(heat_map_data) +
  aes(x = long,
      y = lat,
      group = group,
      fill = prev_decile) +
  geom_polygon() + coord_equal() + theme_void() +
  labs(title = ' ',
       subtitle = ' ',
       fill = "Decile") +
  scale_fill_viridis_c(option = "magma") +
  theme(legend.position = "none")



##### make the plots


ggarrange(hm1, hm2,labels = c("Average Income", "Spend % of Income"), ncol = 2, nrow = 1,  common.legend = TRUE, legend = "bottom")
ggsave("output/map_income.png")

ggarrange(hm1, hm3,labels = c("Average Income", "Dividend per capita"), ncol = 2, nrow = 1,  common.legend = TRUE, legend = "bottom")
ggsave("output/map_dividend.png")

ggarrange(hm1, hm4,labels = c("Average Income", "Smoking prevalence"), ncol = 2, nrow = 1)
ggsave("output/map_prev.png")

