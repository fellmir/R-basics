### Built-in R Features

# seq()
# sort()
# rev()
# srt()
# append()

seq(0,100,by = 2) # jumping by 2
seq(0,100, by = 10) # jumping by 10
seq(0,24, by = 2)
help("seq")

v <- c(1,4,7,2,13,3,11)
sort(v)
sort(v, decreasing = TRUE)

cv <- c("b", "d", "a")
sort(cv)
cv <- c("b", "d", "a", "C", "A")
sort(cv) # prioritizes lower-case letters

v <- c(1:10)
rev(v)

str(v)
str(mtcars)

summary(mtcars)

v <- 1:10
v2 <- 35:40
append(v,v2)6

# checking data type
# is.

v <- 1:3
is.vector(v)
is.data.frame(v)
is.data.frame(mtcars)

# converting data type
# as.
v
as.list(v)
as.matrix(v)

### Apply
sample(x = 1:10, 1) # to select one or more random elements of a value (e.g.,
# a vector)
print(sample(x = 1:10, 1))

v <- 1:5
addrand <- function(x){
  ran <- sample(1:100, 1)
  return(x + ran)
}

print(addrand(10))

result <- lapply(v, addrand) # apply a function to every single element of a
# value (e.g., a vector), returning a list
print(result)

result <- sapply(v, addrand) # apply a function to every single element of a
# value (e.g., a vector), returning a vector
print(result)

v <- 1:5
times2 <- function(int){
  return(int * 2)
}
result <- sapply(v, times2)
print(result)

help("sapply")

# Anonymous Functions

v <- 1:5
result <- sapply(v, function(int){int * 2}) # no need to "expand" this function!
print(result)

# formal function:
times2 <- function(int){
  return(int * 2)
}

# in an anonymous function you don't formally name a function!

# Apply w/ Multiple Inputs

v <- 1:5
add.choice <- function(int, choice){
  return(int + choice)
}
print(sapply(v, add.choice)) # error: no argument for "choice"

# correct way:
v <- 1:5
add.choice <- function(int, choice){
  return(int + choice)
}
print(sapply(v, add.choice, choice = 100)) # last items sets the argument for 
# the undefined element in the function

### Math Functions with R

# abs()
# sum()
# mean()
# round()

abs(2)
abs(-2)
v <- c(-2,-3,0,4)
abs(v)

sum(v)

mean(v)

2.3131242134
round(2.3151242134, 2)

# R reference card: https://cran.r-project.org/doc/contrib/Short-refcard.pdf

### Regular Expressions

# grepl() - logical (T/F)
# grep() - index

text <- "Hi there, do you know who you are voting for?"
text

grepl("voting", text)
grepl("dog", text)
grepl("do you", text)
grepl("hi", text) # this is case sensitive!

v <- c("a", "b", "c", "d", "d")
v
grepl("b", v)

grep("b", v)
grep("d", v)

### Dates and Timestamps

Sys.Date() # this is case sensitive!
today <- Sys.Date()
class(today)

c <- "1990-01-01"
class(c)

my.date <- as.Date(c)
class(my.date)

as.Date("Nov-03-1990") # error

my.date <- as.Date("Nov-03-90", format = "%b-%d-%y")
my.date

# %d	Day of the month (decimal number)
# %m	Month (decimal number)
# %b	Month (abbreviated)
# %B	Month (full name)
# %y	Year (2 digit)
# %Y	Year (4 digit)

as.Date("June,01,2002", format = "%B,%d,%Y") # do not forget "" !

# For Timestamps

as.POSIXct("11:02:03", format = "%H:%M:%S")

help("strptime")

strptime("11:02:03", format = "%H:%M:%S")