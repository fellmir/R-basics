### K-Means Clustering in R

library(ISLR)
library(ggplot2)
library(dplyr)
library(cluster)

head(iris)

pl <- iris %>% 
  ggplot(aes(Petal.Length, Petal.Width, color = Species)) +
  geom_point(size = 4)
pl

set.seed(101)
iris.cluster <- kmeans(iris[,1:4], centers = 3, nstart = 20)
iris.cluster

table(iris.cluster$cluster, iris$Species)

clusplot(iris, iris.cluster$cluster, color = T, shade = T, labels = 0,
         lines = 0)
help("clusplot")