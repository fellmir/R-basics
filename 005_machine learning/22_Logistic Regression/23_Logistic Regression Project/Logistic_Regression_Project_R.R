### Logistic Regression Project

library(ggplot2)
library(dplyr)
library(caTools)
library(Amelia)

adult <- read.csv("adult_sal.csv")
head(adult)
adult <- select(adult, -X)

head(adult)
str(adult)
summary(adult)

# Data Cleaning

help("table")
table(adult$type_employer) # basically a "tabulate" from Stata, showing count
# of values per factor of "type_employer"

unemp <- function(job){ # function to pass through adult$type_employer, going
  # obs. by obs. ("job")
  job <- as.character(job)
  if (job == "Never-worked" | job == "Without-pay"){ # if "Never-worked" OR
    # "Without-pay"
    return("Unemployed")
  }else{
    return(job) # Do not change a thing
  }
}
adult$type_employer <- sapply(adult$type_employer, unemp)
table(adult$type_employer) # Now "Unemployed"

comb.jobs <- function(job){ # function to pass through adult$type_employer, 
  # going obs. by obs. ("job")
  job <- as.character(job)
  if (job == "Local-gov" | job == "State-gov"){
    return("SL-gov")
  }else if (job == "Self-emp-inc" | job == "Self-emp-not-inc") {
    return("Self-emp")
  }else{
    return(job) # Do not change a thing
  }
}
adult$type_employer <- sapply(adult$type_employer, comb.jobs)
table(adult$type_employer) # Now "Self-emp" and "SL-gov"

table(adult$marital)
comb.marital <- function(i){
  i <- as.character(i)
  if (i == "Married-AF-spouse" | i == "Married-civ-spouse" | 
      i == "Married-spouse-absent"){
    return("Married")
  }else if (i == "Divorced" | i == "Separated" | i == "Widowed") {
    return("Not-Married")
  }else{
    return(i)
  }
}
adult$marital <- sapply(adult$marital, comb.marital)
table(adult$marital)

table(adult$country)
Asia <- c('China', 'Hong', 'India', 'Iran', 'Cambodia', 'Japan', 'Laos',
          'Philippines', 'Vietnam', 'Taiwan', 'Thailand')

North.America <- c('Canada', 'United-States', 'Puerto-Rico',
                   'Outlying-US(Guam-USVI-etc)')

Europe <- c('England', 'France', 'Germany', 'Greece', 'Holand-Netherlands',
            'Hungary', 'Ireland', 'Italy', 'Poland', 'Portugal', 'Scotland',
            'Yugoslavia')

Latin.and.South.America <- c('Columbia', 'Cuba', 'Dominican-Republic', 
                             'Ecuador', 'El-Salvador', 'Guatemala', 'Haiti',
                             'Honduras', 'Mexico', 'Nicaragua', 'Peru',
                             'Jamaica', 'Trinadad&Tobago')
Other <- c('South')
comb.countries <- group.country <- function(ctry){
  if (ctry %in% Asia){
    return('Asia')
  }else if (ctry %in% North.America){
    return('North.America')
  }else if (ctry %in% Europe){
    return('Europe')
  }else if (ctry %in% Latin.and.South.America){
    return('Latin.and.South.America')
  }else{
    return('Other')      
  }
}
adult$country <- sapply(adult$country, group.country)
table(adult$country)
str(adult)

adult$type_employer <- sapply(adult$type_employer, factor)
adult$country <- sapply(adult$country, factor)
adult$marital <- sapply(adult$marital, factor)
adult$education <- sapply(adult$education, factor)
adult$occupation <- sapply(adult$occupation, factor)
adult$relationship <- sapply(adult$relationship, factor)
adult$race <- sapply(adult$race, factor)
adult$sex <- sapply(adult$sex, factor)
adult$income <- sapply(adult$income, factor)
str(adult)

adult[adult == '?'] <- NA # to convert "?" values into NA values in "adult"
any(is.na(adult)) # checking for NA values in "adult"
table(adult$type_employer)
missmap(adult) # producing a map of missing values in the data table
missmap(adult, y.at = c(1), y.labels = c(""),col = c("yellow","black"))
# getting rid of y-labels, changing colors in missmap to better check missing
# values

adult <- adult %>% 
  na.omit() # omitting every NA value (which is NOT recommended)
adult %>% 
  missmap() # checking for missing values... none!
# or:
missmap(adult, y.at = c(1), y.labels = c(""),col = c("yellow","black"))

str(adult) # can we get ommited values back? should check later
ages.hist <- adult %>% 
  ggplot(aes(age)) + geom_histogram(binwidth = 1, aes(fill = income),
                                    color = "black") + theme_bw()
ages.hist

hrs.week.hist <- adult %>% 
  ggplot(aes(hr_per_week)) + geom_histogram(binwidth = 1, fill = "blue") +
  theme_bw()
hrs.week.hist

str(adult)
adult <- adult %>% 
  rename(region = country) # first the new column name, then OG column name
str(adult)

region.barplot <- adult %>% 
  ggplot(aes(region)) + geom_bar(aes(fill = income), color = "black") +
  coord_flip() +  theme_bw()
region.barplot
# or:
region.barplot <- adult %>% 
  ggplot(aes(region)) + geom_bar(aes(fill = income), color = "black") +
  theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
region.barplot

head(adult)

# the same old for training and testing

set.seed(101) 
sample <- sample.split(adult$income, SplitRatio = 0.70)
train <- subset(adult, sample == T)
test <- subset(adult, sample == F)

help(glm)
model <- glm(income ~ ., family = binomial(logit), data = train)
summary(model)

help(step) # using AIC to select best model (from a previously built model)
new.model <- step(model)
summary(new.model)

# confusion/error matrix: https://en.wikipedia.org/wiki/Confusion_matrix

test$predicted.income <-  predict(model, newdata = test, type = "response")
# adding a "predicted.income" column to "test"
# https://www.science.smith.edu/~jcrouser/SDS293/labs/lab4-r.html for an
# explanation on type = "response"
str(test)
table(test$income, test$predicted.income > 0.5) # creating the confusion/error
# matrix, using real values of income and predicted values of income
# result: 548 false positives and 873 false negatives
# rank deficient fit: 
# https://www.statology.org/prediction-from-rank-deficient-fit-may-be-misleading/

(6372 + 1423) / (6372 + 1423 + 548 + 872) # model accuracy
6732 / (6372 + 548) # recall/sensitivity (true positive rate)
6732 / (6372 + 872) # precision (positive predictive value)