# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-02-16')
tuesdata <- tidytuesdayR::tt_load(2021, week = 8)

georgia_pop <- tuesdata$georgia_pop

# Or read in the data manually

georgia_pop <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/georgia_pop.csv')
census <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/census.csv')
furniture <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/furniture.csv')
city_rural <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/city_rural.csv')
income <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/income.csv')
freed_slaves <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/freed_slaves.csv')
occupation <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/occupation.csv')
conjugal <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/conjugal.csv')

# Data wrangling and Plot
library(tidyverse)
library(plotly)

censusplot <- census %>% filter(region == "USA Total") %>% arrange(year) %>% select(year, black_free, black_slaves) %>% pivot_longer(!year, names_to = "vars", values_to = "pct") %>% ggplot(aes(x = year)) + geom_bar(aes(y = pct, fill = vars), stat = "identity", position = "dodge")

incomeplot <- income %>% pivot_longer(c("Rent", "Food", "Clothes", "Tax", "Other")) %>% ggplot(aes(x = Class)) + geom_bar(aes(y = value, fill = factor(name, levels = c("Other", "Tax", "Clothes", "Food", "Rent"))), stat = "identity", position = "stack")
