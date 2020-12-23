library(tidytuesdayR)
library(tidyverse)

tidytuesday <- tt_load(2020, week = 52)
data <- tidytuesday$`big-mac`
df_asean <- data %>% filter(name %in% c("Indonesia", "Myanmar", "Malaysia", "Singapore", "Thailand", "Vietnam", "Philippines"))
df_idn <- data %>% filter(name == "Indonesia") %>% na.omit()

df_asean %>% pivot_longer(cols = )

ggplot(data = df_idn, aes(x = date)) + geom_line(aes(y = local_price)) + geom_line((aes(y = gdp_dollar)))