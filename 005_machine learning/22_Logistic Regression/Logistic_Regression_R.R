### Logistic Regression with R

install.packages("Amelia")

library(dplyr)
library(ggplot2)
library(Amelia)
library(caTools)

df.train <- read.csv("titanic_train.csv")
head(df.train)

# Exploratory Data Analysis

df.train %>% 
  missmap(main = "Titanic Training Data - Missings Map", col = c("yellow",
          "black"), legend = F) # yellow are missing observations

survival.count <- df.train %>% 
  ggplot(aes(Survived)) + geom_bar()
survival.count

Pclass.count <- df.train %>% 
  ggplot(aes(Pclass)) + geom_bar(aes(fill = factor(Pclass)), alpha = 0.4)
Pclass.count

gender.count <- df.train %>% 
  ggplot(aes(Sex)) + geom_bar(aes(fill = factor(Sex)), alpha = 0.4)
gender.count

age.count <- df.train %>% 
  ggplot(aes(Age)) + geom_histogram(bins = 40, fill = "blue", alpha = 0.4)
age.count

SibSp.count <- df.train %>% 
  ggplot(aes(SibSp)) + geom_bar(fill = "red", alpha = 0.4)
SibSp.count

fare.count <- df.train %>% 
  ggplot(aes(Fare)) + geom_histogram(fill = "green", color = "black",
                                     alpha = 0.4, binwidth = 5)
fare.count

# Data cleaning

pl <- df.train %>% 
  ggplot(aes(Pclass, Age)) + geom_boxplot(aes(group = Pclass, 
                              fill = factor(Pclass), alpha = 0.4))
pl + scale_y_continuous(breaks = seq(min(0), max(80), by = 2))
# wealthier passengers are older

impute_age <- function(age,class){
  out <- age
  for (i in 1:length(age)){ # for every obs. of variable "age", from 1st to last
    
    if (is.na(age[i])){ # if age is missing
      
      if (class[i] == 1){
        out[i] <- 37 # avg. age of 1st class
        
      }else if (class[i] == 2){
        out[i] <- 29 # avg. age of 2nd class
        
      }else{
        out[i] <- 24 # avg. age of 3rd class
      }
    }else{
      out[i]<-age[i] 
    }
  }
  return(out)
}
fixed.ages <- impute_age(df.train$Age, df.train$Pclass) # passing function to
# Age and Class variables
head(fixed.ages)
df.train$Age <- fixed.ages # substituting OG "Age" variable to fixed.ages
head(df.train)

df.train %>% 
  missmap(main="Titanic Training Data - Missings Map", col=c("yellow", "black"),
          legend=FALSE) # it worked!

# Building a Logistic Regression Model

str(df.train)
head(df.train)

df.train <- df.train %>% 
  select(-PassengerId, -Name, -Ticket, -Cabin) # removing variables that won't
# be used
head(df.train)

str(df.train)
df.train$Survived <- factor(df.train$Survived)
df.train$Sex <- factor(df.train$Sex)
df.train$Pclass <- factor(df.train$Pclass)
df.train$Parch <- factor(df.train$Parch)
df.train$SibSp <- factor(df.train$SibSp)
df.train$Embarked <- factor(df.train$Embarked)
# setting every variable above as a factor
str(df.train)

# Training the model

log.model <-   glm(formula = Survived ~ ., family = binomial(link = "logit"), 
                   data = df.train) # logit model, with "Survival" as the 
# dependent variable
summary(log.model) # Sex, Age, and Class are the most significant features

# Predicting using Test Cases

set.seed(101)
split <- df.train$Survived %>% 
  sample.split(SplitRatio = 0.7) # splitting OG data in 0.7 ~ 0.3 proportions
final.train <- df.train %>% 
  subset(split == T) # 70% of data to train
final.test <- df.train %>% 
  subset(split == F) # 30% of data to test

final.log.model <- glm(formula = Survived ~ . , family = binomial(link="logit"),
                       data = final.train) # using training data
summary(final.log.model)

fitted.probabilities <- predict(final.log.model, newdata = final.test,
                                type = "response") # using original model w/
# test data (having used the train data to "train" the model)
fitted.results <- ifelse(fitted.probabilities > 0.5, 1, 0) # if value of 
# fitted.probabilities > 1, assign 1; otherwise, assign 0
misClasificError <- mean(fitted.results != final.test$Survived) # percentage of
# predicted results which are not the same as the original in the testing sample
misClasificError
print(paste("Accuracy is",1-misClasificError))

final.test$Survived
fitted.probabilities
confusion.matrix <- table(final.test$Survived, fitted.probabilities > 0.5)
confusion.matrix