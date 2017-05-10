library(tidyverse)
library(scales)

########################################
# YOUR SOLUTION BELOW
########################################


setwd("~/columbia/APMA4990/msd-homework/homework/homework_1/problem_3")

ratings <- read.table("ratings.csv", header=FALSE, sep=",")

head(ratings)

tail(ratings)

colnames(ratings) <- c("UserID", "MovieID", "Rating", "Timestamp")

head(ratings)

tail(ratings)

ratings %>% 
  group_by(MovieID) %>%
  summarise((sum(UserID))) %>%
  ungroup()



new <- count(ratings, UserID)

colnames(new) <- c("UserID", "Count")

filter(new, Count > 10 & Count < 30)

movies <- read_table("movies.csv", header=FALSE, sep=",")

