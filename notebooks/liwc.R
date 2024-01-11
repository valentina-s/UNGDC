library(readr)library(ggplot2)
library(dplyr)
library(tidyverse)

country <- read_csv("~/Desktop/UNGDC/data/interim/controls.csv")
country<-country%>%select(-...1)

liwc <- read_csv("~/Desktop/LIWC-22 Results - cleaned - LIWC Analysis.csv")

country <- country %>%
  select(year, ccode, polyarchy=v2x_polyarchy) %>%
  mutate(ccode_iso= countrycode(ccode, origin = 'cown',
                                  destination = 'iso3c'))

liwc_regime<-liwc%>%
  left_join(country, by=c("year","ccode_iso"))

liwc_regime<-liwc_regime%>%
  dplyr::mutate(democracy=case_when(polyarchy<0.5 ~ 0,
                                 polyarchy>=0.5 ~ 1))


library(tidyr)

liwc_long <- liwc_regime %>%
  select("ccode_iso", "year", "health", "ethnicity", "conflict", "tech", "relig", "illness", "democracy") %>%
  pivot_longer(cols = -c(year, democracy, ccode_iso), names_to = "variable", values_to = "value")


ggplot(liwc_long %>% filter(!is.na(democracy)), aes(x=year, y=value, color=variable)) +
  stat_smooth()+
  facet_wrap(~democracy, labeller=label_both)+
  theme_minimal()+
  labs(title="UNGD Discourse over Time")

ggsave("figs/liwc_timeseries_0111.png", )
