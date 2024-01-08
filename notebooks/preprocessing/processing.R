
# Reading in data

raw<- readRDS("data/interim/UNGDC.rds")
processed<-raw

#remove numbering
processed$text<-gsub("\\d+\\.\\t", "", raw$text, perl = TRUE)


#This leaves numbering at the beginning of paragraphs that don't end with a dot.
#I've kept those numbers to avoid removing sentences starting with a year.
#For example, a speech might begin with "2023 has been a good year."


#remove tabs
processed$text<-gsub("\\t", " ", processed$text)

processed$word_count <- str_count(processed$text, "\\S+")

# generate word_count variable
processed$word_count <- str_count(processed$text, "\\S+")

# remove stop words
library(tidytext)
library(tm)
light<-processed
light$text_processed<-removeWords(processed$text, stopwords("en"))
light$text_processed<-str_squish(light$text_processed)
