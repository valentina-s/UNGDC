#LIWC Modeling

library(readr)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(countrycode)
library(lmtest)
liwc_controls<-read.csv("data/interim/liwc_controls.csv")

liwc_controls<-liwc_controls%>%
  select(-X)%>%
  select(-session)%>%
  select(-ccode)%>%
  select(-gwcode)

liwc_controls$year<-as.numeric(liwc_controls$year)

liwc_controls <- pdata.frame(liwc_controls, 
                             index=c("ccode_iso","year"), 
                             drop.index=TRUE, row.names=TRUE)

liwc_sov<-liwc_controls%>%
  filter(grepl("sovereignty", text, ignore.case = TRUE))

model<-lm(risk~ v2x_polyarchy, data = liwc_sov)

model0 <-plm(risk ~ dd_democracy + wdi_gdpcapcon2015 ,
            data = liwc_sov,
            model = "within"
)
summary(model0, vcovBK(model0))

liwc_long <- liwc_regime %>%
  select("ccode_iso", "year", "health",
         "ethnicity", "conflict", "tech", "relig", "illness", "democracy") %>%
  pivot_longer(cols = -c(year, democracy, ccode_iso), names_to = "variable", values_to = "value")

