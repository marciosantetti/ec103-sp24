library(tidyverse)
library(fpp3)
library(janitor)
library(gapminder)
library(MetBrewer)
library(hrbrthemes)
library(patchwork)
library(scales)

theme_set(theme_ipsum())





#--------------------------------------------------------------------



dat <- read_csv("fredgraph2.csv")


dat <- dat %>% 
  clean_names()

dat <- dat %>% 
  mutate(gdpc1_pc1 = as.double(gdpc1_pc1),
         unrate_ch1 = as.double(unrate_ch1))


dat %>% 
  mutate(period = yearquarter(date)) %>% 
  ggplot() +
  geom_line(aes(x = period, y = gdpc1_pc1), size = 0.7, color = "#5e3c58") +
  geom_hline(yintercept = 0, lty = 1, alpha = 0.6) +
  geom_line(aes(x = period, y = unrate_ch1), size = 0.8, color = "#83adb5") +
  scale_y_continuous(sec.axis = sec_axis(~ ., name = "Unemployment rate")) +
  labs(x = "",
       y = "Real GDP",
       title = "Real GDP and unemployment rate: % change from a year ago (1949Q1–2023Q2)")
