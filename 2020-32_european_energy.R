library(tidyverse)
library(tidytuesdayR)

data <- tt_load(2020, week = 32)

energy_types <- data$energy_types
country_totals <- data$country_totals
energy_types$country_name[is.na(energy_types$country_name) & energy_types$country == "UK"] <- "United Kingdom"
country_totals$country_name[is.na(country_totals$country_name) & country_totals$country == "UK"] <- "United Kingdom"

# plot nuclear energy production of each country

nuke_prod <- energy_types %>% filter(type == "Nuclear")

ggplot(data = energy_types, aes(x = country_name, y = `2016`)) + geom_bar(stat = "identity")

# Reorder Nuclear to be the first energy type in the legend.
energy_types$type <- forcats::fct_relevel(energy_types$type, "Nuclear")

# Get list of country names ordered by nuclear's percent of total.
# This list will be used later to order the factor for sorting on the chart.
nuc_ctrys <- energy_types %>%
  group_by(country_name) %>%
  mutate(nuc_pct = `2018`/sum(`2018`)) %>%
  filter(type == "Nuclear") %>%
  arrange(-nuc_pct) %>%
  select(country_name) %>%
  pull()

# Make country_name a factor based on the order we made earlier.
energy_types$country_name <- factor(energy_types$country_name, nuc_ctrys)

ggplot(data = energy_types) +
  geom_bar(aes(x=country_name, y=`2018`, fill=type), stat = "identity", position = "fill") + 
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.25, face = "bold", size = 8),
        axis.title.x = element_blank(),
        plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(face = "italic"),
        plot.caption = element_text(hjust = 1.48)) +
  labs(title = "How do European countries produce their energy?",
       subtitle = "2018 percent of total",
       caption = "Source: Eurostat",
       y = "Percent of Power Generation") + 
  guides(fill = guide_legend(title = "Energy Type")) +
  scale_y_continuous(labels = scales::percent)
