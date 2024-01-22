# Topic Modeling

library(plyr)
library(dplyr)
library(tm)
library(ggplot2)
library(quanteda)
library(readr)
library(seededlda)
library(slam)
library(jsonlite)

## LDA Trial 6
# This adds more stop words like "will", "must" that showed up as common words in prevous batch. 

light<-readRDS("data/interim/light.RDS")
light<-light %>%
  select(-...1)



#Set up the parameters

duration <- 1945:2022
interval <- 10

light_interval <- light %>%
  dplyr::mutate(span = as.factor(cut(year,
                                     breaks = c(seq(from = 1945, to = 2022, by = 10), 2022)))) %>%
  dplyr::arrange(year)

light_interval <- light_interval[grepl("\\bsovereignty\\b", light_interval$text_processed), ]

country <- light_interval[grepl("countri", light_interval$text_processed),]

mystopwords <- c("will","must")

# Function for generating tf_idf and plots.
lapply(levels(light_interval$span), function(i) {
  subset_i <- light_interval %>% dplyr::filter(span %in% i)
  corpus_subset <- Corpus(VectorSource(subset_i$text_processed))
  tdm <- TermDocumentMatrix(corpus_subset,
                            control = list(weighting = weightTfIdf,
                                           removePunctuation = TRUE,
                                           stemming = TRUE,
                                           removeNumbers = TRUE,
                                           removeWords = mystopwords))
  top_terms <- slam::row_sums(as.matrix(tdm))
  top_terms_df <- data.frame(term = names(top_terms), tfidf = top_terms) %>%
    top_n(20, tfidf)
  figure_i <- ggplot(top_terms_df, aes(x = reorder(term, tfidf), y = tfidf)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    theme_minimal() +
    labs(title = "Top 20 Terms by TF-IDF",
         x = "Terms",
         y = "TF-IDF Score") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  output_file <- file.path("figs/", paste0("plot_", i, ".png"))
  ggsave(output_file, figure_i, width = 8, height = 5, units = "in")
})


#Topic Modeling

lda_generator <- function(corpus, span_levels, num_topics = 10) {
  output_dir <- "output/lda/decade_sov_0118"
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  for (i in span_levels) {
    subset <- corpus[corpus$span == i, ]
    subset_dfm <- dfm(subset$text_processed, 
                      remove_numbers = TRUE,
                      split_hyphens = TRUE,
                      stem = TRUE, 
                      remove_punct = TRUE,
                      tolower = TRUE, 
                      remove = stopwords("english"))
    dfm_idf <- dfm_tfidf(subset_dfm,
                         scheme_tf = "count",
                         scheme_df = "inverse")
    
    timing <- system.time({
      dfm_df <- convert(dfm_idf, to = "data.frame")
      dfm_output_file <- file.path(output_dir, paste0("dfm_", i, ".RDS"))
      saveRDS(dfm_df, dfm_output_file)
      
      tmod_lda <- textmodel_lda(subset_dfm, k = num_topics)
      lda_output_file <- file.path(output_dir, paste0("lda_model_", i, ".RDS"))
      saveRDS(tmod_lda, lda_output_file)
    })
    
    cat(sprintf("Time taken for %s: %s seconds\n", i, timing[3]))
  }
}


span_levels <- levels(light_interval$span)
lda_generator(light_interval, span_levels)


