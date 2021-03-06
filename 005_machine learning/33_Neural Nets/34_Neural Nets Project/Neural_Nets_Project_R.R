### Neural Nets Project in R

library(caTools)
library(ggplot2)
library(dplyr)
library(neuralnet)
library(randomForest)

banks <- read.csv("bank_note_data.csv")
head(banks)
str(banks)
summary(banks)

set.seed(101)
split <- sample.split(banks$Class, SplitRatio = 0.7)
training.data <- subset(banks, split == T)
testing.data <- subset(banks, split == F)

str(training.data)

help("neuralnet")

nn <- neuralnet(Class ~ Image.Var + Image.Skew + Image.Curt + Entropy, 
                data = training.data, hidden = 10, linear.output = FALSE)
nn
predicted.nn.values <- compute(nn, testing.data[1:4])
head(predicted.nn.values$net.result)

rounded.results <- round(predicted.nn.values$net.result)
head(rounded.results)
tail(rounded.results)

table(rounded.results, testing.data$Class)

# Comparing models

df <- banks

df$Class <- factor(df$Class)
set.seed(101)
split.rf <- sample.split(df$Class, SplitRatio = 0.70)
train.rf <- subset(df, split == T)
test.rf <- subset(df, split == T)

rf.model <- randomForest(Class ~ Image.Var + Image.Skew + Image.Curt + Entropy,
                         data = train.rf)
rf.predictions <- predict(rf.model, testing.data)

table(rf.predictions, testing.data$Class)
