library(tm)
library(Matrix)
library(glmnet)
library(ROCR)
library(ggplot2)
library(caret)
library(tidyverse)
library(scales)

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

train_all <- paper_df[ndx_all, ]
test_all <- paper_df[-ndx_all,]

train_sparseMatrix <- sparseMatrix.paper[ndx_all, , drop=FALSE]
test_sparseMatrix <- sparseMatrix.paper[-ndx_all, , drop=FALSE]

fit <- cv.glmnet(train_sparseMatrix, train_all$section, family='binomial', type.measure = 'auc')

plot(fit, xvar = "dev", label = TRUE)


df <- data.frame(actual = test_all$section,
                 log_odds = predict(fit, test_sparseMatrix)) %>%
  
  mutate(pred = if_else(X1 > 0, 'world', 'business'))

# evaluate performance for the best-fit model
plot(fit)
head(df)

table(actual = df$actual, predicted = df$pred)
# accuracy: fraction of correct classifications
df %>%
  summarize(acc = mean(pred == actual))

# precision: fraction of positive predictions that are actually true
df %>%
  filter(pred == 'business') %>%
  summarize(prec = mean(actual == 'business'))

# recall: fraction of true examples that we predicted to be positive
# aka true positive rate, sensitivity
df %>%
  filter(actual == 'business') %>%
  summarize(recall = mean(pred == 'business'))

# false positive rate: fraction of false examples that we predicted to be positive
df %>%
  filter(actual == 'world') %>%
  summarize(fpr = mean(pred == 'business'))


# plot ROC curve and output accuracy and AUC
plot_data = test_all
plot_data$probs <- predict(fit, test_sparseMatrix, type="response")
ggplot(plot_data, aes(x = probs)) +
  geom_histogram(binwidth = 0.01) +
  xlab('Predicted probability of world') +
  ylab('Number of examples')



# plot calibration
data.frame(predicted=plot_data$probs, actual=test_all$section) %>%
  group_by(X1=round(X1*10)/10) %>%
  summarize(num=n(), actual=mean(actual == "world")) %>%
  ggplot(data=., aes(x=X1, y=actual, size=num)) +
  geom_point() +
  geom_abline(linetype=2) +
  scale_x_continuous(labels=percent, lim=c(0,1)) +
  scale_y_continuous(labels=percent, lim=c(0,1)) +
  xlab('Predicted probability of world') +
  ylab('Percent that are actually world')


pred <- prediction(plot_data$probs, test_all$section)
perf_lr <- performance(pred, measure='tpr', x.measure='fpr')
plot(perf_lr)
performance(pred, 'auc')



predicted <- plot_data$probs
actual <- test_all$section == "world"
ndx_pos <- sample(which(actual == 1), size=100, replace=T)
ndx_neg <- sample(which(actual == 0), size=100, replace=T)
mean(predicted[ndx_pos] > predicted[ndx_neg])


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



business_weights <- get_informative_words(fit)
head(business_weights)
# show weights on words with top 10 weights for world

world_weights <- get_informative_words(fit)
head(world_weights)
