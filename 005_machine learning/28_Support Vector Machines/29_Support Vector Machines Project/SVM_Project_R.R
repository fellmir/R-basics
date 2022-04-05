### Support Vector Machine Project in R

library(dplyr)
library(ggplot2)
library(e1071)
library(caTools)

loans <- read.csv("loan_data.csv")

str(loans)
summary(loans)

loans$purpose <- factor(loans$purpose)
loans$inq.last.6mths <- factor(loans$inq.last.6mths)
loans$delinq.2yrs <- factor(loans$delinq.2yrs)
loans$pub.rec <- factor(loans$pub.rec)
loans$not.fully.paid <- factor(loans$not.fully.paid)
loans$credit.policy <- factor(loans$credit.policy)
str(loans)

# EDA

fico.not.fully.paid <- loans %>% 
  ggplot(aes(x = fico)) +
  geom_histogram(aes(fill = not.fully.paid), color = "black")
fico.not.fully.paid

purpose.count <- loans %>% 
  ggplot(aes(x = purpose)) +
  geom_bar(aes(fill = not.fully.paid), position = "dodge")
purpose.count

fico.int.rate <- loans %>% 
  ggplot(aes(x = int.rate, y = fico)) +
  geom_point(aes(color = not.fully.paid), alpha = 0.4)
fico.int.rate

# Building the model

set.seed(101)
sampling <- sample.split(loans$not.fully.paid, SplitRatio = 0.7)
training.data <- subset(loans, sampling == T)
testing.data <- subset(loans, sampling == F)

training.model <- svm(not.fully.paid ~ ., data = training.data, 
                      kernel = "radial")
summary(training.model)

predicted.values <- predict(training.model, testing.data[1:13])
table(predicted.values, testing.data$not.fully.paid)

cost.vector <- c(1, 10)
gamma.vector <- c(0.1, 1)
tune.results <- tune(svm, train.x = not.fully.paid ~ ., data = training.data,
                     kernel = "radial", ranges = list(cost = cost.vector,
                                                      gamma = gamma.vector))
# this will take a long while...
summary(tune.results)

final.model <- svm(not.fully.paid ~ ., data = training.data, cost = 10, 
                   gamma = 0.1)
final.predicted.values <- predict(final.model, testing.data[1:13])
table(final.predicted.values, testing.data$not.fully.paid)