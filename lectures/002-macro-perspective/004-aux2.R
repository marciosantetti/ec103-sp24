library(tidyverse)




real_gdp <- tibble(
  quarter = c("2008q1", "2008q2", "2008q3", "2008q4", "2009q1", "2009q2", "2009q3", "2009q4"),
  nominal_gdp = c(14373.9, 14497.8, 14546.7, 14347.3, 14178.0, 14151.2, 14242.1, 14453.8), 
  real_gdp = c(13366.9, 13415.3, 13324.6, 13141.9, 12925.4, 12901.5, 12973.0, 13149.5)
)

real_gdp <- real_gdp %>% 
  mutate("gdp_deflator" = nominal_gdp / real_gdp)


data <- real_gdp %>% 
  select(-real_gdp)

data %>% 
  write_csv("nominal_gdp.csv")
