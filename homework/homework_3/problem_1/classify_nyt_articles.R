library(tm)
library(Matrix)
library(glmnet)
library(ROCR)
library(ggplot2)
library(caret)
library(tidyverse)

#setwd("~/columbia/APMA4990/msd-homework/homework/homework_3/problem_1")
setwd("~/Documents/Columbia/msd-apam4990/msd2017/homework/homework_3/problem_1")


# read business and world articles into one data frame

business <- read.table('business.tsv', quote="",header=TRUE, sep="\t", encoding= 'utf-8')
business <- business %>%
  mutate(section = 'business')
world <- read.table('world.tsv', quote="", header=TRUE, sep="\t", encoding = "utf-8")

world <- world %>%
  mutate(section = 'world')

paper_df <- bind_rows(business, world)

paper_df$section <- as.factor(paper_df$section)


# create a Corpus from the article snippets

corpus_paper <- DataframeSource(paper_df)

all_corpus <- Corpus(VectorSource(paper_df$snippet))

# create a DocumentTermMatrix from the snippet Corpus
# remove punctuation and numbers
dtm.paper <- DocumentTermMatrix(all_corpus, control = list(removePunctuation = TRUE, 
                                                                   stopwords = TRUE))


# convert the DocumentTermMatrix to a sparseMatrix, required by cv.glmnet
# helper function
dtm_to_sparse <- function(dtm) {
 sparseMatrix(i=dtm$i, j=dtm$j, x=dtm$v, dims=c(dtm$nrow, dtm$ncol), dimnames=dtm$dimnames)
}

sparseMatrix.paper <- dtm_to_sparse(dtm.paper)

# create a train / test split
set.seed(48)

train_percent <- 0.8

ndx_all <- sample(nrow(paper_df), floor(nrow(paper_df) * train_percent))

train_all <- paper_df[ndx_all,]
test_all <- paper_df[-ndx_all,]


# create a Corpus from the article snippets
#source.train <- DataframeSource(train_all)
#source.test <- DataframeSource(test_all)

traincorpus_all <- Corpus(VectorSource(train_all$snippet))
test_corpus <- Corpus(VectorSource(test_all$snippet))

# create a DocumentTermMatrix from the snippet Corpus
# remove punctuation and numbers
dtm_train <- DocumentTermMatrix(traincorpus_all, control = list(removePunctuation = TRUE, 
                                                                   stopwords = TRUE))
dtm_test <- DocumentTermMatrix(test_corpus, control = list(removePunctuation = TRUE, 
                                                               stopwords = TRUE))

sparseMatrix_train <- dtm_to_sparse(dtm_train)
sparseMatrix_test <- dtm_to_sparse(dtm_test)


# cross-validate logistic regression with cv.glmnet, measuring auc


fit <- cv.glmnet(sparseMatrix_train, train_all$section, family='binomial', type.measure = 'auc')

plot(fit, xvar = "dev", label = TRUE)



#newX <- model.matrix(~.,data=test_all)

#fit_test <- predict(fit, newx=newX)

df <- data.frame(actual = test_all$section,
                 log_odds = predict(fit, test_all, type='class')) %>%
  mutate(pred = ifelse(log_odds > 0, 'business', 'world'))

# evaluate performance for the best-fit model
plot(fit)



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
