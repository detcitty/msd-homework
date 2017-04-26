library(tm)
library(Matrix)
library(glmnet)
library(ROCR)
library(ggplot2)

# read business and world articles into one data frame

business <- read.table('business.tsv', quote="",header=TRUE, sep="\t")
world <- read.table('world.tsv', quote="", header=TRUE, sep="\t", encoding = "utf-8")

# create a Corpus from the article snippets
source.business <- DataframeSource(business)
source.world <- DataframeSource(world)

business.Corpus <- Corpus(VectorSource(business$snippet))
world.Corpus <- Corpus(VectorSource(world$snippet))

# create a DocumentTermMatrix from the snippet Corpus
# remove punctuation and numbers
dtm.business <- DocumentTermMatrix(business.Corpus, control = list(removePunctuation = TRUE, 
                                                                   stopwords = TRUE))

dtm.world <- DocumentTermMatrix(world.Corpus, control = list(removePunctuation = TRUE,
                                                             stopwords = TRUE))


# convert the DocumentTermMatrix to a sparseMatrix, required by cv.glmnet
# helper function
dtm_to_sparse <- function(dtm) {
 sparseMatrix(i=dtm$i, j=dtm$j, x=dtm$v, dims=c(dtm$nrow, dtm$ncol), dimnames=dtm$dimnames)
}

sparseMatrix.business <- dtm_to_sparse(dtm.business)
sparseMatrix.world. <- dtm_to_sparse(dtm.world)

# create a train / test split

# cross-validate logistic regression with cv.glmnet, measuring auc

# evaluate performance for the best-fit model

# plot ROC curve and output accuracy and AUC

# extract coefficients for words with non-zero weight
# helper function
get_informative_words <- function(crossval) {
  coefs <- coef(crossval, s="lambda.min")
  coefs <- as.data.frame(as.matrix(coefs))
  names(coefs) <- "weight"
  coefs$word <- row.names(coefs)
  row.names(coefs) <- NULL
  subset(coefs, weight != 0)
}

# show weights on words with top 10 weights for business

# show weights on words with top 10 weights for world
