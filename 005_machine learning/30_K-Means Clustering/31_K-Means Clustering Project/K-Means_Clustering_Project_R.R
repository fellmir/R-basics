### K-Means Clustering Project

library(dplyr)
library(ggplot2)

df1 <- read.csv("winequality-red.csv", sep = ";")
df2 <- read.csv("winequality-white.csv", sep = ";")

df1$label <- "red"
df2$label <- "white"
# or:
df1$label <- sapply(df1$pH,function(x){'red'})
df2$label <- sapply(df2$pH,function(x){'white'})

head(df1)
head(df2)

wine <- full_join(df1, df2)
# or:
wine <- rbind(df1,df2)
any(is.na(wine))
str(wine)

# EDA

sugar.hist <- wine %>% 
  ggplot(aes(residual.sugar)) +
  geom_histogram(aes(fill = label), color = "black", bins = 100) +
  theme_bw() +
  scale_fill_manual(values = c('#ae4554','#faf7ea'))
sugar.hist

citric.hist <- wine %>% 
  ggplot(aes(citric.acid)) +
  geom_histogram(aes(fill = label), color = "black", bins = 100) +
  theme_bw() +
  scale_fill_manual(values = c('#ae4554','#faf7ea'))
citric.hist

alcohol.hist <- wine %>% 
  ggplot(aes(alcohol)) +
  geom_histogram(aes(fill = label), color = "black", bins = 100) +
  theme_bw() +
  scale_fill_manual(values = c('#ae4554','#faf7ea'))
alcohol.hist

sugar.v.acid <- wine %>% 
  ggplot(aes(citric.acid, residual.sugar)) +
  geom_point(aes(color = label),alpha = 0.2) +
  scale_color_manual(values = c('#ae4554','#faf7ea')) +
  theme_dark()
sugar.v.acid

sugar.v.volatility <- wine %>% 
  ggplot(aes(volatile.acidity, residual.sugar)) +
  geom_point(aes(color=label),alpha=0.2) +
  scale_color_manual(values = c('#ae4554','#faf7ea')) +
  theme_dark()
sugar.v.volatility

clus.data <- wine[,-13]
# or:
clus.data <- wine[,1:12]
head(clus.data)
str(clus.data)

wine.cluster <- kmeans(clus.data, centers = 2)
# or:
wine.cluster <- kmeans(wine[1:12], 2)
wine.cluster

wine.cluster$centers

table(wine$label, wine.cluster$cluster)