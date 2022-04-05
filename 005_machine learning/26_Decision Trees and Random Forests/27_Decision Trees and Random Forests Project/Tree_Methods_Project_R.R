### Decision Trees and Random Forests Project in R

library(ISLR)
library(ggplot2)
library(dplyr)
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)

head(College)
data("College")
df <- data.frame(College)
head(df)

# EDA

grad.v.board <- df %>% 
  ggplot(aes(x = Room.Board, y = Grad.Rate)) +
  geom_point(aes(color = factor(Private)))
grad.v.board

ft.grads <- df %>% 
  ggplot(aes(x = F.Undergrad)) +
  geom_histogram(binwidth = 50, aes(color = factor(Private)))
ft.grads
# or:
ft.grads <- df %>% 
  ggplot(aes(x = F.Undergrad)) +
  geom_histogram(aes(fill = factor(Private)), color = "black", bins = 50)
ft.grads

graduate.rate <- df %>% 
  ggplot(aes(x = Grad.Rate)) +
  geom_histogram(aes(fill = factor(Private)), color = "black", bins = 50)
graduate.rate

# Correction

subset(df,Grad.Rate > 100) # Cazenovia College
df["Cazenovia College", "Grad.Rate"] <- 100
df["Cazenovia College",]

# Decision Tree

# Testing and Training

set.seed(101)
sampling <- sample.split(df$Private, SplitRatio = .70)
training.data <- subset(df, sampling == T)
testing.data <- subset(df, sampling == F)

tree <- rpart(Private ~ ., data = training.data, method = "class") # model

help("predict")
predicted.testing <- predict(tree, testing.data)
head(predicted.testing)

tree.prediction <- as.data.frame(predicted.testing)
combining <- function(x){
  if(x >= 0.5){
    return("Yes")
  }else{
    return("No")
  }
}
tree.prediction$Private <- sapply(tree.prediction$Yes, combining)
head(tree.prediction)

table(tree.prediction$Private, testing.data$Private)

prp(tree)

# Random Forest

help("randomForest")
model <- randomForest(Private ~ ., data = training.data, importance = T)

model$confusion # confusion matrix for the random forests model

model$importance

# Predictions

pred <- predict(model, testing.data)
table(pred, testing.data$Private)