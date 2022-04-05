### Data Frame Basics

state.x77
USPersonalExpenditure
women
data()
WorldPhones

head(state.x77)
tail(state.x77)
str(state.x77)
summary(state.x77)

days <- c('Mon','Tue','Wed','Thu','Fri')
days <- factor(days, levels = c('Mon','Tue','Wed','Thu','Fri'))
days
temp <- c(22.2,21,23,24.3,25)
rain <- c(T, T, F, F, T)
data.frame(days,temp,rain)
df <- data.frame(days,temp,rain)
df

str(df)
summary(df)

### Data Frame Indexing and Selection

# same as above
days <- c('Mon','Tue','Wed','Thu','Fri')
days <- factor(days, levels = c('Mon','Tue','Wed','Thu','Fri'))
days
temp <- c(22.2,21,23,24.3,25)
rain <- c(T, T, F, F, T)
data.frame(days,temp,rain)
df <- data.frame(days,temp,rain)
df

df[1,]
df[,1]

df[,"rain"]
df[1:5,c("days","temp")]

df["days"]
# or, for vector form:
df$days
df$temp
df$rain

subset(df, subset = rain == T)
subset(df, subset = temp > 23)

# to order a data frame:
sorted.temp <- order(df["temp"])
sorted.temp
df[sorted.temp,]

desc.temp <- order(-df["temp"])
desc.temp
df[desc.temp,]

desc.temp <- order(-df$temp)
desc.temp
df[desc.temp,]

### Overview of Data Frame Operations - pt. I

empty <- data.frame()
c1 <- 1:10
c1
letters
c2 <- letters[1:10]
c2
df <- data.frame(col.name.1 = c1, col.name.2 = c2)
df

write.csv(df, file = "saved_df.csv")
df2 <- read.csv("saved_df.csv")
df2

nrow(df)
ncol(df)
colnames(df)
rownames(df)
str(df)
summary(df)

df[[5,2]]
df[[5,"col.name.2"]]
df[[2,"col.name.1"]] <- 9999 # to change a value in a data frame!
df

df[1,] # still returns a data frame
as.numeric(df[1,]) # to return a vector

mtcars
head(mtcars)
mtcars$mpg
mtcars[,"mpg"]
mtcars[,1]
mtcars[["mpg"]]
# all the above is for vectors!
# below is for data frames:
mtcars["mpg"]

head(mtcars[c("mpg", "cyl")])

### Overview of Data Frame Operations - pt. II

df2 <- data.frame(col.name.1 = 2000, col.name.2 = "new")
df2
dfnew <- rbind(df, df2) # to add a new row!
dfnew

df$newcol <- 2*df$col.name.1 # to add a new column!
df

df$newcol.copy <- df$newcol
df
# or:
df[,"newcol.copy2"] <- df$newcol
df

colnames(df)
colnames(df) <- c("1", "2", "3", "4", "5")
df
# or:
colnames(df)[1] <- "NEW COL NAME"
head(df)

df[1:10,]
df[1:3,]
head(df)
head(df,7)
df[-2,] # select everything BUT the 2nd row

head(mtcars)
mtcars[mtcars$mpg > 20] # error!
mtcars[mtcars$mpg > 20,] # correct! (i.e., selecting all columns where rows have
# mpg > 20)

head(mtcars)
mtcars[(mtcars$mpg > 20) & (mtcars$cyl == 6),]
mtcars[(mtcars$mpg > 20) & (mtcars$cyl == 6),c("mpg", "cyl", "hp")]
# or:
subset(mtcars, mpg > 20 & cyl == 6)

head(mtcars)
mtcars[,c(1,2,3)] # for first three columns of the data frame
mtcars[c("mpg", "cyl")]

is.na(mtcars)
any(is.na(mtcars))
any(is.na(mtcars$mpg))
df[is.na(df)] <- 0 # to substitute ALL NA values for a certain value
df
df$`NEW COL NAME`[is.na(df$`NEW COL NAME`)] <- 0 # to substitute ALL NA values
# in a certain column
df
# or:
df$`NEW COL NAME`[is.na(df$`NEW COL NAME`)] <- mean(df$`NEW COL NAME`)
df

### Data Frame Training Exercise

names.df <- c("Sam", "Frank", "Amy")
Age <- c(22,25,26)
Weight <- c(150,165,120)
Sex <- c("M", "M", "F")
df3 <- data.frame(Age,Weight,Sex, row.names = names.df)
df3

is.data.frame(mtcars)

mat <- matrix(1:25, nrow = 5)
mat
df4 <- as.data.frame(mat)
df4

df <- mtcars
df

head(df)
# or:
df[1:6,]

mean(df[["mpg"]])
# or:
mean(df$mpg)

df5 <- subset(df, cyl == 6)
df5
# or:
df5 <- df[(df$cyl == 6),]
df5

df[,c("am","gear","carb")]

performance <- c(df$hp / df$wt)
performance
df$performance <- performance
df
# or:
df$performance <- df$hp/df$wt
df

help(round)
df$performance <- round(performance, digits = 2)
df
# or:
df$performance <- round(df$performance,2)
head(df)

df6 <- df[(df$hp > 100) & (df$wt > 2.5),]
df6
mean(df6$mpg)
# or:
mean(subset(df,(hp > 100) & (wt > 2.5))$mpg)

df["Hornet Sportabout", "mpg"]
# or:
df["Hornet Sportabout",]$mpg