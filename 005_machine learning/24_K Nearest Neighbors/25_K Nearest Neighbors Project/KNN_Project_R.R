### KNN Project in R

library(ISLR)
library(caTools)
library(class)
library(ggplot2)
library(dplyr)

head(iris)
str(iris)


standardized.features <- scale(iris[1:4])
var(standardized.features[,1])
var(standardized.features[,1:4])

iris.species <- cbind(standardized.features, iris[5])
head(iris.species)

set.seed(101)
sampling <- sample.split(iris.species$Species, SplitRatio = .70) # best practice
# is to use dependent variable as splitting basis
training.data <- subset(iris.species, sampling == T)
testing.data <- subset(iris.species, sampling == F)
head(sampling)

help("knn")
predicted.species <- knn(training.data[1:4], testing.data[1:4], 
                         training.data$Species, k = 1)
predicted.species

mean(predicted.species != testing.data$Species)

predicted.species.loop <- NULL
error.rate <- NULL
looping <- 1:10
for(i in looping){
  set.seed(101)
  predicted.species.loop <- knn(training.data[1:4], testing.data[1:4], 
                           training.data$Species, k = i)
  error.rate[i] <- mean(predicted.species.loop != testing.data$Species)
}

k.values <- 1:10
error.df <- data.frame(k.values, error.rate)
error.df

pl <- error.df %>% 
  ggplot(aes(x = k.values, y = error.rate)) +
  geom_point() +
  geom_line(lty = "dotted", color = "red")
pl