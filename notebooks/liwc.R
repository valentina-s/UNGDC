library(readr)library(ggplot2)
library(dplyr)
library(tidyverse)

country <- read_csv("~/Desktop/UNGDC/data/interim/controls.csv")
liwc <- read_csv("~/Desktop/LIWC-22 Results - cleaned - LIWC Analysis.csv")

country <- country %>%
  select(year, ccode, year, bmr_dem) %>%
  mutate(ccode_iso= countrycode(ccode, origin = 'cown',
                                  destination = 'iso3c'))

liwc_regime<-liwc%>%
  left_join(country, by=c("year","ccode_iso"))

liwc_long <- liwc_regime %>%
  select("year", "health", "ethnicity", "conflict", "focusfuture", "ccode_iso") %>%
  pivot_longer(-ccode_iso, -year, names_to="variable", values_to="value")

ggplot(liwc_long, aes(x=year, y=value, color=variable)) + geom_line()+geom_smooth()
