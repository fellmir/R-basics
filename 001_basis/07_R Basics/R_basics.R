### Arithmetic in R

1+2
100+11
12.2+13.1

5-3
5 - 3

1 / 2
2 / 3

2 ^ 3
4 ^ 4

100 * 2 + 50 / 2
100 * (2 + 50) / 2

5 / 2
5 %% 2
10 %% 8

### Variables

print("Hello")
#print("Hello")

variable <- 100
variable

bank <- 1000
bank

bank.account <- 100
bank.account

# Clear console with Ctrl + L!

deposit <- 20
bank.account <- bank.account + deposit # reassign value of a variable with
# itself
bank.account

### R Basic Data Types

2.2
a <- 2.2
a

5
7

TRUE
FALSE
# or
T
F

a <- T
a <- t
a <- T

'hello'
"hello"

a <- "hello"
b <- "hello"

class(a)
class(b)
class(12)
class(32.2)
class(T)
class(F)

### Vector Basics

nvec <- c(1,2,3,4,5)
nvec
class(nvec)

cvec <- c("b","r","a")
cvec
class(cvec)

lvec <- c(T,F)
lvec
class(lvec)

v <- c(TRUE, 20, 40)
v
class(v)

v <- c(FALSE, 20, 40)
v
class(v)

v <- c("Brazil", 20, 31)
v
class(v)

temps <- c(72, 71, 68, 73, 69, 75, 76)
temps
names(temps) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                  "Saturday", "Sunday")
temps
# more practical:
days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                  "Saturday", "Sunday")
names(temps) <- days
temps

### Vector Operations

v1 <- c(1,2,3)
v2 <- c(5,6,7)
v1
v2
v1 + v2
v1 - v2
v2 - v1
v1 * v2
v1 / v2

sum(v1)
sum.of.vec <- sum(v1)
sum.of.vec

mean(v1)
sd(v1)
max(v1)
min(v1)

prod(v1)
prod(v2)

# https://cran.r-project.org/doc/contrib/Short-refcard.pdf

### Comparison Operators

5 > 6
5 < 6
5 <= 6
5 >= 5

2 == 3
2 = 3 # error!
2 != 4
2 != 2
2 == 2

v <- 2
v
v < -1
v <-1
v

my.var <- 2
my.var < -10
my.var <- 10

v <- c(1,2,3,4,5)
v < 2
v == 3

v
v2 <- c(10,20,30,40,50)
v < v2
v * 5 < v2
v * 10 < v2
v * 10 <= v2

### Vector Indexing and Slicing

v1 <- c(100, 200, 300)
v2 <- c("a", "b", "c")
v1
v2

# indexing in R starts at 1!
v1[2]
v2[3]

v1[c(1,2)]
v2[c(1,3)]

# this is slicing:
v <- c(1:10)
v[2:4]
v[7:10]

v <- c(1:4)
names(v) <- c("a", "b", "c", "d")
v[2]
v["b"]
v[c("c","d","a")]

# boolean/logical masking
v
v[v > 2]
v > 2
my.filter <- v > 2
my.filter
v[my.filter]

### Getting Help with R and RStudio

help("vector")
??numeric
help.search("vector")
# Stack Overflow

### R Basics Training Exercise

2 ^ 5

stock.prices <- c(23,27,23,21,34)
stock.prices

days <- c("Mon", "Tue", "Wed", "Thu", "Fri")
days
names(stock.prices) <- days
stock.prices

mean(stock.prices)

over.23 <- stock.prices > 23
over.23

stock.prices[over.23]

max(stock.prices)
# or
stock.prices[stock.prices == 34]
# or
stock.prices[stock.prices == max(stock.prices)]
# or
max.price <- stock.prices == max(stock.prices)
max.price
stock.prices[max.price]