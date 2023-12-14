library(tidyverse)

gapminder_data <- read.csv("gapminder_data.csv")

summarize(gapminder_data, averageLifeExp = mean(lifeExp))

gapminder_data %>% summarize(averageLifeExp = mean(lifeExp))

gapminder_data %>%
  summarise( averageLifeExp = mean(lifeExp))

###this is a brief comment on data piping.
# %>% 
  # shift+command+m

gapminder_data_summarized <- gapminder_data %>% summarise(averageLifeExp = mean(lifeExp))

#dangegr bcareful not to load an object that is already into your holding data. 
gapminder_data <- gapminder_data %>% summarise(averageLifeExp = mean(lifeExp))

gapminder_data <- read.csv("gapminder_data.csv")

gapminder_data %>% 
  summarise(recent_year = max(year))
#recent_year is the label made up and max is a base r function and the year in max function is from the data set. 

#the year below is important we use it from the column in the data set. The two equal signs are required instead of one. I forget why.
gapminder_data %>% 
  filter(year == 2007) %>% 
  summarize(average = mean(lifeExp))

gapminder_data %>% 
  summarize(recent_year = min(year))

gapminder_data %>% 
  filter(year == 1952) %>% 
  summarize(average = mean(gdpPercap))
  
gapminder_data %>% 
  filter(year == min(year)) %>% 
  summarize(average = mean(gdpPercap)

gapminder_data
  filter(year == pull(my_object)) %>% 
  summarize(average=mean(gdpPercap))
  
my_objext <- gapminder_data %>% 
  summarize(first_year=min(year)

#group_by command 

gapminder_data %>% 
  group_by(year) %>% 
  summarize(average=mean(lifeExp))

gapminder_data %>% 
  group_by(continent) %>% 
  summarize(average=mean(lifeExp))

gapminder_data %>% 
  group_by(continent, year) %>% 
  summarize(average=mean(lifeExp))
n = ...

gapminder_data %>% 
  group_by(continent) %>%
  summarize(average=mean(lifeExp), min=min(lifeExp))

gapminder_data %>% 
  group_by(continent) %>%
  summarize(average=mean(lifeExp), min=min(lifeExp), max=max(lifeExp))

#mutate() 

gapminder_data %>% 
  mutate(gdp = pop * gdpPercap)

gapminder_data %>% 
  mutate(gdp = pop * gdpPercap, popInMillions = pop/1000000)

#select() way to pull out specific part of data we are interested in 

gapminder_data %>% 
  select(pop,year)

gapminder_data %>% 
  select(-continent)

# get a data frame that has only the columns country, conditent, year, and life expectancy 
gapminder_data %>% 
  select(-pop,-gdpPercap)

#additonal things you can do with Select() these are called helper functions 
gapminder_data %>% 
  select(year,starts_with('c'))

gapminder_data %>% 
  select(ends_with('p'))
?select

gapminder_data %>% 
  select(year,starts_with('con'))




gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

#newdataset

gapminder_data_2007 <- read.csv("gapminder_data.csv") %>% 
  filter(year == 2007 & continent == "Americas") %>% 
  select(-year, -continent)




read_csv(CO2)

read_csv("co2-un-data.csv")
temp <- read_csv("co2-un-data.csv")


read_csv('co2-un-data.csv', skip = 1)
co2_emissions_dirty <- read_csv("co2-un-data.csv", skip = 2,
                                col_names = c("region", "country", "year",
                                              "series", "value", "footnotes", "source"))
co2_emissions_dirty


read_csv("co2-un-data.csv", skip = 1) %>% 
  rename(country=X2)

read_csv("co2-un-data.csv", skip = 1) %>% 
  rename(country = X2)

read_csv("co2-un-data.csv", skip = 1) %>% 
  rename(country=...2)


co2_emissions_dirty %>% 
  select(country, year, series, value)

co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
        "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions"))


co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value)


co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions",
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  count(year)


co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions",
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year==2005) %>% 
  select(-year)

co2_emissions <- co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions",
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year==2005) %>% 
  select(-year)


inner_join(gapminder_data, co2_emissions)

inner_join(gapminder_data, co2_emissions, by="country")


gapminder_co2 <- inner_join(gapminder_data_2007, co2_emissions)



ggplot(gapminder_co2, aes(x=gdpPercap, y=per_capita_emissions)) +
  geom_point() +
  labs(x = "GDP (per capita)", y = "CO2 emitted (per capita)", 
       title ="Strong association between a nation's GDP and CO2 production")
  



