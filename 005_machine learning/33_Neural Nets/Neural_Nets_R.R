### Neural Nets in R

install.packages("MASS")
install.packages("neuralnet")

library(MASS)
library(neuralnet)
library(caTools)
library(ggplot2)
library(dplyr)

head(Boston)
str(Boston)
any(is.na(Boston)) # no missing obs.

data <- Boston

# Normalising data

maxs <- apply(data, 2, max) # max values of each column
maxs
mins <- apply(data, 2, min) # min values of each column
mins

help("scale")
scaled.data <- scale(data, center = mins, scale = maxs - mins) # "center" arg
# indicates vector of numbers to substract from; "scale" arg indicates vector
# of numbers to divide obs.. combining the two standardizes the obs.
scaled <- as.data.frame(scaled.data)
head(scaled)
head(Boston)

# Training and Testing Data

split <- sample.split(scaled$medv, SplitRatio = 0.7)
training.data <- subset(scaled, split == T)
testing.data <- subset(scaled, split == F)
head(training.data)
head(testing.data)

n <- names(training.data)
n
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))
# concatenating variable names
f

nn <- neuralnet(f, data = training.data, hidden = c(5, 3), linear.output = T)
plot(nn)

predicted.nn.values <- compute(nn, testing.data[1:13])
str(predicted.nn.values)

true.predictions <- predicted.nn.values$net.result * (max(data$medv) - 
                                                      min(data$medv)) +
                                                      min(data$medv) # inverting
# the standardization process done
test.r <- (testing.data$medv) * (max(data$medv) - min(data$medv)) +
  min(data$medv)
MSE.nn <- sum((test.r - true.predictions)^2) / nrow(testing.data)
MSE.nn

error.df <- data.frame(test.r, true.predictions)
head(error.df)

error.df %>% 
  ggplot(aes(x = test.r, y = true.predictions)) +
  geom_point() +
  stat_smooth()