# Read the extracted CSV file and display first few rows of the data set
families <- read.csv("families.csv", header = FALSE, sep = ",", quote = "\"", fill = TRUE) 
colnames(families) <- c("FamilyName", "Description")
head(families)

# Load necessary libraries
library(readr)
library(textstem)
library(tm)
library(stringr)
library(wordcloud)
library(tidytext)
library(tidyverse)

# Create a corpus from the descriptions
corpus <- VCorpus(VectorSource(families$Description))

# Function to perform text pre-processing
preprocess_text <- function(corpus) {
  corpus <- tm_map(corpus, content_transformer(tolower)) # Convert to lowercase
  corpus <- tm_map(corpus, removePunctuation) # Remove Punctuation
  corpus <- tm_map(corpus, removeWords, stopwords("english")) # Remove stop-words
  corpus <- tm_map(corpus, stripWhitespace) # Remove extra white space
  corpus <- tm_map(corpus, content_transformer(lemmatize_strings)) # Lemmatize text
  return(corpus)
}

# This will apply all the cleaning steps above to the text data provided
corpus <- preprocess_text(corpus)

# Create the Document-Term Matrix and TF-IDF
tdm <- TermDocumentMatrix(corpus)
tdm_matrix <- as.matrix(tdm)
dtm_matrix <- t(tdm_matrix)

# Create TF-IDF weighted matrix manually
tf <- dtm_matrix / rowSums(dtm_matrix) # Term Frequency
idf <- log(nrow(dtm_matrix) / colSums(dtm_matrix > 0)) # Inverse Document Frequency
tfidf <- tf %*% diag(idf) # Multiply TF by IDF
tfidf_df <- as.data.frame(tfidf) # Convert to data frame
dim(tfidf_df) # Display dimensions of the TF-IDF data-frame

# Analyze Sparsity (calculate and print output)
total_elements <- nrow(tfidf_df) * ncol(tfidf_df)
non_zero_elements <- sum(tfidf_df != 0)
sparsity <- 1 - (non_zero_elements / total_elements)
cat("Sparsity of the TF-IDF matrix:", round(sparsity * 100, 2), "%\n")

# Install and load cosine similarity library
install.packages("lsa")
library(lsa)

# Get the vector for Apocynaceae
apocynaceae_index <- which(families$FamilyName == "Apocynaceae")
apocynaceae_vector<- as.numeric(tfidf_df[apocynaceae_index, ])

# Compute cosine similarity with all other families and combine with family name
similarities <- apply(tfidf_df, 1, function(x) cosine(apocynaceae_vector, as.numeric(x)))
similarity_df <- data.frame(FamilyName = families$FamilyName, cosinesimilarity = similarities)

# Sort and show top similar families (example: top 5)
similar_families <- similarity_df[order(-similarity_df$cosinesimilarity), ]
head(similar_families, 5)

# Bar plot creation of the top 5 families
top5 <- head(similar_families, 5)
barplot(top5$cosinesimilarity,
        names.arg = top5$FamilyName,
        main = "Top 5 Families similar to Apocynaceae",
        ylab = "Cosine Similarity",
        las = 2,
        col = "skyblue",
        cex.names = 0.8)

# Show top 10 TF-IDF terms for Apocynaceae
terms <- colnames(tfidf_df)
apocynaceae_terms <- tfidf_df[apocynaceae_index, ]
top10_terms <- sort(apocynaceae_terms, decreasing = TRUE)[1:10]
print(top10_terms)

# Compile R Markdown into HTML
install.packages("rmarkdown")
install.packages("knitr")