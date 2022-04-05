### K Nearest Neighbors in R

install.packages("ISLR")
library(ISLR)
library(class)
library(ggplot2)
library(dplyr)
library(ggplotly)

str(Caravan)
summary(Caravan$Purchase)

# Cleaning Data

any(is.na(Caravan)) # checking whether there are ANY missing values in "Caravan"
# dataset

# Standardize Variables

# important step as to not bias KNN estimation when variables are larger in 
# scale than others

var(Caravan[,1]) # variance of variable "MOSTYPE"
var(Caravan[,2]) # variance of variable "MAANTHUI"

purchase <- Caravan[,86] # saving to a different variable, since this is a
# factor with 1 and 2 values ("yes" and "no")
standardized.Caravan <- scale(Caravan[,-86]) # scaling every variable in Caravan
# dataset BUT "Purchase"
var(standardized.Caravan[,1])
var(standardized.Caravan[,2]) # variance is now 1 for every "explanatory"
# variable (mean 1, stdv 0)!

# Testing and Training Data

test.index <- 1:1000
test.data <- standardized.Caravan[test.index,] # taking first 1,000 obs.
test.purchase <- purchase[test.index] # taking first 1,000 obs.

train.data <- standardized.Caravan[-test.index,] # taking the rest of obs. in
# "Caravan" dataset
train.purchase <- purchase[-test.index]

# Using KNN

set.seed(101)
predicted.purchase <- knn(train.data, test.data, train.purchase, k = 1) # trai-
# -ning data, testing data, training "main variable" ("Purchase"), k for KNN
# returns a set of predicted Y's
head(predicted.purchase)
mean(test.purchase != predicted.purchase) # i.e. percentage of "misses" from
# predicted.purchase, in comparison to testing variable

# Choosing K value

predicted.purchase.3 <- knn(train.data, test.data, train.purchase, k = 3)
mean(test.purchase != predicted.purchase.3)

predicted.purchase.5 <- knn(train.data, test.data, train.purchase, k = 5)
mean(test.purchase != predicted.purchase.5)

# Looping to check different values of K and their effectiveness

predicted.purchase <- NULL
error.rate <- NULL
for(i in 1:20){
  set.seed(101)
  predicted.purchase <- knn(train.data, test.data, train.purchase, k = i)
  error.rate[i] <- mean(test.purchase != predicted.purchase)
}
print(error.rate)

# Elbow method

k.values <- 1:20
error.df <- data.frame(k.values, error.rate)
error.df

error.df %>% 
  ggplot(aes(x = k.values, y = error.rate)) +
  geom_point() +
  geom_line(lty = "dotted", color = "red")

# best K for this model is 9!