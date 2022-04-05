### Logical Operators

# & - AND 
# | - OR
# ! - NOT

x <- 10
x < 20
x > 5
x < 20 & x > 5
(x < 20) & (x > 5)
(x < 20) & (x > 5) & (x == 10)
(x < 20) & (x > 5) & (x == 9)

TRUE & TRUE
TRUE & FALSE

x == 100
x == 10
(x == 10) | (x == 100)
(x == 10000) | (x == 100)

(10 == 1)
!(10 == 1)
!!(10 == 1) # avoid this!

df <- mtcars
head(df)
df[df$mpg > 20,]
df[df$mpg > 20,"mpg"]
# or:
subset(df, mpg > 20)
df[(df$mpg > 20) & (df$hp > 100),]
df[(df$mpg > 20) | (df$hp > 100),]

### if, else and else if Statements

x <- 10
if (x == 10) {
  # Code
  print("X is equal to 10!")
}else if(x == 12) {
  # Code
  print("X is equal to 12!")
}else {
  # Code
  print("X is neither 10 nor 12!")
}

hot <- F
temp <- 10
if(temp > 80){
  # Execute if condition was TRUE
  print("Temp is greater than 80!")
} # weird: if you don't run the code on its entirety (or from "if"), the 
# condition is valid!

temp <- 100
if(temp > 80){
  # Execute if condition was TRUE
  hot <- TRUE
}
print(hot)

temp <- 30
if(temp > 80){
  # Execute if condition was TRUE
  print("Hot outside!")
}else{
  print("Temp is not greater than 80")
}

temp <- 75
if(temp > 80){
  # Execute if condition was TRUE
  print("Hot outside!")
}else if((temp <= 80) & (temp >= 50)){
  print("Nice outside!")
}else{
  print("It's less than 50 degrees outside!")
}

temp <- 45
if(temp > 80){
  # Execute if condition was TRUE
  print("Hot outside!")
}else if((temp <= 80) & (temp >= 50)){
  print("Nice outside!")
}else if(temp == 45){
  print("Exactly 45 degrees outside!")
}else{
  print("It's less than 50 degrees outside and it's not exactly 45 degrees!")
}

ham <- 0
cheese <- 5
report <- "blank"
if(ham >= 10 & cheese >= 10){
  report <- "Strong sales of both ham and cheese!"
}else if(ham == 0 & cheese == 0){
  report <- "No sales today!"
}else{
  report <- "We sold something today!"
}
print(report)

### Conditional Statements Training Exercise

x <- 1
if (x ==1){
  print("Hello")
}

x <- 3
if (x %% 2 == 0){
  print("Even number")
}else{
  print("Not even")
}

x <- matrix()
if(is.matrix(x) == T){
  print("This is a matrix")
}else{
  print("Not a matrix")
}

x <- c(3,7,1)
if (x[1] > x[2]){
  fir <- x[1]
  sec <- x[2]
} else {
  fir <- x[2]
  sec <- x[1]
}
if ( x[3] > fir & x[3] > sec ) {
  thi <- sec
  sec <- fir
  fir <- x[3]
} else if ( x[3] < fir & x[3] < sec ) {
  thi <- x[3]
} else {
  thi <- sec
  sec <- x[3]
}
print(paste(fir, sec, thi))

x <- c(20, 10, 1)
if (x[1] > x[2] & x[1] > x[3] ) {
  print(x[1] )
} else if (x[2] > x[3] ) {
  print(x[2])
} else {
  print(x[3])
}

### While Loops

while (condition){
  # code executed here
  # while condition is TRUE
}

x <- 0
while (x < 10){
  print(paste0('x is: ' ,x))
  
  x <- x + 1
  if (x == 10){
    print("x is now equal to 10! Breaking loop...")
  }
}

x <- 0
while (x < 10){
  print(paste0('x is: ' ,x))
  
  x <- x + 1
  if (x == 10){
    print("x is now equal to 10! Breaking loop...")
    break
    print("ayyyy") # this won't appear thanks to the "break" statement!
  }
}

x <- 0
while (x < 10){
  print(paste0('x is: ' ,x))
  
  x <- x + 1
  if (x == 5){
    print("x is now equal to 5! Breaking loop...")
    break
  }
}

### For Loops

v <- c(1,2,3)
for (variable in v) {
  print(variable)
}

v <- c(1:5)
for (temp.var in v) {
  # Execute some code
  # for every temp.var in v (temp.var can be anything)
  print(temp.var)
}

v <- c(1:5)
for (temp.var in v) {

  print("Hello!")
}

v <- c(1:5)
for (temp.var in v) {
  result <- temp.var + 1
  print('The temp.var plus 1 is equal to: ')
  print(result)
}

my.list <- list(c(1:3), mtcars, 12)
for (item in my.list) {
  print(item) # "item" can be anything!
}

mat <- matrix(1:25, nrow=5)
print(mat)

for (num in mat) {
  print(num) # it prints by columns!
}

1:nrow(mat) # vector of a row in the matrix "mat"

for (row in 1:nrow(mat)) {
  for (col in 1:ncol(mat)) {
    print(paste("The element at row: ", row, 'and col: ', col, 'is', 
                mat[row,col]))
  }
}

for (row in 1:nrow(mat)) {
  for (col in 1:ncol(mat)) {
    print(paste("The selected row is: ", row))
    print(paste("The element at row: ", row, 'and col: ', col, 'is', 
                mat[row,col]))
  }
}

### Functions

name_of_func <- function(input1, input2, input3 = 45){
  # code execute
  result <- input1 + input2
  return(result)
}

hello <- function(){
  print("Hello!")
}
hello()
hello

hello <- function(name){
  # code which executes when the function is called
  print(paste("Hello,",name,"!"))
}
hello("Sammy")
hello() # error since there is no default!

hello <- function(name="Frank"){
  # code which executes when the function is called
  print(paste("Hello,",name,"!"))
}
hello()
hello("Sammy")

add_num <- function(num1,num2){
  print(num1 + num2)
}
add_num(4,5)

add_num <- function(num1,num2){
  my.sum <- num1 + num2
  return(my.sum) # allows you to store the result of a function as a variable
}
result <- add_num(4,5)
result
print(result)

times5 <- function(num){
  return(num*5)
}
print(times5(20))

times5 <- function(num){
  my.result <- num*5
  return(my.result)
}
my.output <- times5(100)
print(my.output)
my.result # not found; scope of this variable is limited within the times5
# function (a LOCAL variable!)

v <- "I'm a global variable!"
stuff <- "I'm global stuff!"
fun <- function(stuff){
  print(v)
  stuff <- "Reassign stuff inside of this function fun"
  print(stuff)
}
fun(stuff) # this reproduces the reassigned/local variable version of "stuff"
stuff # this reproduces the global variable "stuff". therefore the function
# does NOT alter the global variable!

### Functions Training Exercise

hello_you <- function(name){
  print(paste('Hello',name))
}
hello_you('Sam')

hello_you2 <- function(name){
  return(paste('Hello',name))
}
print(hello_you2('Sam'))

prod <- function(num1,num2){
  print(num1 * num2)
}
prod(3,4)
# or:
prod <- function(num1,num2){
  return(num1 * num2)
}
prod(3,4)

num_check <- function(int,vec){
  for (i in vec){ # for each item in vector vec
    if (i == int){ # if one item of the vector is equal to the integer
      return(TRUE)
    }
  }
  return(FALSE)
}
num_check(2,c(1:3))
num_check(2,c(1,4,5))

num_count <- function(int,vec){
  count = 0 # set initial count to 0
  for (i in vec){
    if (i == int){ # if there is an instance of the item in the vector
      count = count + 1 # add 1 to the count
    }
  }
  return(count)
}
num_count(2,c(1:3))
num_count(2,c(1,1,2,2,2,3,3,3,4,4,4))
num_count(1,c(1,1,2,2,3,1,4,5,5,2,2,1,3))

bar_count <- function(pack){
  one_kilos = pack %% 5 # module of 5 - numbers below 5 return themselves!
  five_kilos = (pack - one_kilos)/5 # if pack < 5, numerator == 0 -> five_kilos
  # == 0!
  return(one_kilos + five_kilos)
}
bar_count(6)
bar_count(17)
bar_count(4)
bar_count(5)

help(append) # add elements to a vector
summer <- function(int.a, int.b, int.c){
  out <- c(0) # creates a vector with one element, 0
  if (int.a %% 3 != 0){ # if integer is NOT divisible by 3
    out <- append(int.a,out) # add it to the vector above; otherwise it does NOT
    # count to the sum!
  }
  if (int.b %% 3 != 0){
    out <- append(int.b,out)
  }
  if (int.c %% 3 != 0){
    out <- append(int.c,out)
  }
  return(sum(out))       
}
summer(7,2,3)
summer(3,6,9)
summer(9,11,12)

prime_check <- function(int) {
  if (int == 2) {
    return(TRUE)
  } else if (any(int %% 2:(int - 1) == 0)) {
    return(FALSE)
  } else { 
    return(TRUE)
  }
}
prime_check(2)
prime_check(5)
prime_check(4)
prime_check(237)
prime_check(131)

# or:
prime_check <- function(int){
  if (int == 2) {
    return(TRUE)
  }
  for (i in 2:(int-1)){
    
    if ((int %% i) == 0){
      return(FALSE) # if number is divisible by any number other than 1 and 
      # itself, return FALSE
    }
  }
  return(TRUE) # otherwise, it IS a prime number!
}
prime_check(2)
prime_check(5)
prime_check(4)
prime_check(237)
prime_check(131)