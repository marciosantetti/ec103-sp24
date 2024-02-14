library(tidyverse)
library(tidyquant)
library(scales)
library(lubridate)

gdp <- tq_get("GDPC1", get = "economic.data", from = "1949-01-01")

gdp <- gdp %>% 
  select(date, price) %>% 
  rename(real_gdp = price)


gdp %>% 
  ggplot(aes(x = date, y = real_gdp)) +
  geom_line() +
  scale_x_date(breaks = breaks_width("10 years"),
               labels = label_date("%Y")) +
  scale_y_continuous(labels = dollar_format())


gdp %>% 
  mutate( gdp_growth = ( ( real_gdp - lag(real_gdp, n = 1) ) / lag(real_gdp, n = 1) ) * 100 )  %>% 
  ggplot(aes(x = date, y = gdp_growth)) +
  geom_line(size = 0.6)


annual_gdp <- gdp %>% 
  mutate(year = floor_date(date, unit = "year")) %>% 
  group_by(year) %>% 
  summarize(real_gdp = mean(real_gdp)) %>% 
  mutate(year = year(year))


annual_gdp %>% 
  write_csv("annual_gdp.csv")
