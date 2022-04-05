# Support Vector Machines in R

install.packages("e1071")

library(ISLR)
library(e1071)

head(iris)

help("svm")

model <- svm(Species ~ ., data = iris)
summary(model)

predicted.values <- predict(model, iris[1:4])
head(predicted.values)
table(predicted.values, iris[,5]) # "confusion matrix" of sorts

# Tuning values of cost and gamma for SVM (e.g., "grid search")

tune.results <- tune(svm, train.x = iris[1:4], train.y = iris[,5], 
                     kernel = "radial", ranges = list(cost = c(0.5, 1 ,1.5), 
                                                      gamma = c(0.1, 0.5, 0.5)))
summary(tune.results)
# best cost = 1.5
# best gamma = 0.1

tuned.svm <- svm (Species ~ ., data = iris, kernel = "radial", cost = 1.5,
                  gamma = 0.1)
summary(tuned.svm)