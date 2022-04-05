### Decision Trees and Random Forests in R

install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")

library(rpart)
library(rpart.plot)
library(randomForest)

help("rpart")

str(kyphosis)
head(kyphosis)

tree <- rpart(Kyphosis ~ . , method = "class", data = kyphosis)
# "class" for classification tree methodology

printcp(tree)
plotcp(tree)
print(tree)
summary(tree)

# Tree Visualization

plot(tree, uniform = TRUE, main = "Main Title")
text(tree, use.n = TRUE, all= TRUE)

prp(tree)

# Random Forests

model <- randomForest(Kyphosis ~ .,   data = kyphosis)
print(model) # for results and confusion matrix
importance(model) # for importance of predictors - the higher the value, the 
# more important it is