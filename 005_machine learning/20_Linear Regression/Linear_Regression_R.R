### Linear Regression with R

# Dataset here: https://archive.ics.uci.edu/ml/datasets/student+performance

install.packages("corrgram")
install.packages("corrplot")
install.packages("caTools")

library(dplyr)
library(ggplot2)
library(ggthemes)
library(corrgram)
library(corrplot)
library(caTools)

df <- read.csv("student-mat.csv", sep = ";")
head(df)
summary(df)

any(is.na(df)) # to check if there are any NA values in the data frame

str(df)

# Correlation

num.cols <- df %>% 
  sapply(is.numeric)
cor.data <- cor(df[,num.cols])
print(cor.data)

color.plot <- cor.data %>% 
  corrplot(method = "color")
color.plot

cor.smosgard <- df %>% 
  corrgram(order = T, lower.panel = panel.shade, upper.panel = panel.pie, 
           text.panel=panel.txt)
cor.smosgard

G3.histogram <- df %>% 
  ggplot(aes(x = G3)) + geom_histogram(bins = 20, alpha = 0.4, fill = "blue") +
  theme_minimal()
G3.histogram # count of grades

# General form of building a linear regression model in R
# model <- lm(y ~ x1 + x2,data)
# or:
# model <- lm(y ~. , data) <- Uses all features (i.e explanatory variables)

set.seed(101) # seed for sampling, similar to Stata
sample <- df$age %>% 
  sample.split(SplitRatio = 0.7) # SplitRatio <- percentage of OG sample which
# will be used for training data, from a random seed
train <- subset(df, sample == T) # 70% of OG model used for "training"
test <- subset(df, sample == F) # 30% of OG model used for "testing"

# Training the model

model <- lm(G3 ~ .,train) # (formula, data)
summary(model) # regression table, with coefficients, t-test, p-values etc.

# Visualizing the model

res <- residuals(model) # grabbing residuals
res <- as.data.frame(res) # converting to data frame for ggplot2
head(res)

# Anscombe's Quartet: https://en.wikipedia.org/wiki/Anscombe%27s_quartet
# As expected, plot residuals to check if relationship can be "summed" as linear
# or if it needs to take another form (e.g., non-linear/polynomial)

res.histogram <- res %>% 
  ggplot(aes(res)) + geom_histogram(bins = 20, fill = "blue", alpha = 0.4)
res.histogram # most residuals around zero, but some skew on the negative side

plot(model) # to see graphical comparisons between residuals and estimated
# values
# issue: model predicts negative values on their tests, which is impossible
# (since it goes from 0 to 20)

# Predictions

G3.predictions <- model %>% 
  predict(test) # using linear regression model as basis, taking predicted
# values of Y using the "test" (30% of OG sample) data frame

results <- G3.predictions %>% 
  cbind(test$G3) # creating a new object with predicted and real values of G3,
# with predicted values coming from the "test" sample
colnames(results) <- c("pred", "real") # adding names to the new object
results <- as.data.frame(results) # turning the object into a data frame for
# ggplot2
results

to_zero <- function(x){
  if  (x < 0){
    return(0)
  }else{
    return(x)
  }
} # creating a function that transforms negative predicted values into zero
# (prediction interval). Therefore for every x (i.e., value in "pred" column)
# in "results", it checks for less than zero values and transform them to zero
results$pred <- sapply(results$pred,to_zero)
results

mse <- mean((results$real - results$pred) ^ 2) # mean squared error, measuring
# quality of the estimated model
mse

rmse <- mse ^ 0.5 # root mean squared error, to measure accuracy of the
# estimated model
rmse

SSE <- sum((results$pred - results$real)^2) # sum of square of errors
SST <- sum((mean(df$G3) - results$real)^2) # total square sum
R2 <- 1 - (SSE/SST)
R2 # high R2, which at first glance seems good