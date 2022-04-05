### Creating a Matrix

1:10
v <- 1:10
v

matrix(v)

matrix(v, nrow = 2)

matrix(1:12, byrow = FALSE, nrow = 4) # fill values up-down (by columns) using
# whatever values are specified

matrix(1:12, byrow = T, nrow = 4) #fill values left-right (by rows) using
# whatever values are specified

goog <- c(450,451,452,445,468)
msft <- c(230,231,232,233,220)
stocks <- c(goog,msft)
stocks
print(stocks)

stock.matrix <- matrix(stocks, byrow = T, nrow = 2)
stock.matrix
print(stock.matrix)

days <- c("Mon", "Tue", "Wed", "Thu", "Fri")
st.names <- c("GOOG", "MSFT")
colnames(stock.matrix) <- days
rownames(stock.matrix) <- st.names
stock.matrix
print(stock.matrix)

### Matrix Arithmetic

mat <- matrix(1:25, byrow = T, nrow = 5)
mat

mat * 2
mat / 2
mat ^ 2

1 / mat # reciprocal matrix

mat > 15
mat[mat>15]

mat + mat
mat / mat
mat ^ mat
mat * mat

# for true matrix multiplication:
mat %*% mat

### Matrix Operations

# if needed, from previous class:
goog <- c(450,451,452,445,468)
msft <- c(230,231,232,233,220)
stocks <- c(goog,msft)
stocks
print(stocks)

stock.matrix <- matrix(stocks, byrow = T, nrow = 2)
stock.matrix
print(stock.matrix)

days <- c("Mon", "Tue", "Wed", "Thu", "Fri")
st.names <- c("GOOG", "MSFT")
colnames(stock.matrix) <- days
rownames(stock.matrix) <- st.names
stock.matrix
print(stock.matrix)

colSums(stock.matrix)
rowSums(stock.matrix)

rowMeans(stock.matrix)

FB <- c(111,112,113,129,145)
FB
tech.stocks <- rbind(stock.matrix, FB) # to create a new row out of a vector!
tech.stocks

avg <- rowMeans(tech.stocks)
avg
tech.stocks <- cbind(tech.stocks, avg) # to create a new column out of a vector!
tech.stocks

### Matrix Selection and Indexing

v <- c(1:5)
v
v[2]

mat <- matrix(1:50, byrow = T, nrow = 5)
mat

# mat[rows,columns]:
mat[1,]
mat[,1]
mat[1:3,]

mat[1:2,1:3]
mat[,9:10]
mat[2:3,5:6]
mat[4:5,3:5]

### Factor and Categorial Matrices

animal <- c("d", "c", "d", "c", "c")
id <- c(1:5)
animal
id

# Nominal categorical variables
factor(animal)
fact.ani <- factor(animal)

# Ordinal categorical variables
ord.cat <- c("cold", "med", "hot")
temps <- c("cold", "med", "hot", "hot", "hot", "cold", "med")
temps
fact.temp <- factor(temps, ordered = TRUE, levels = c("cold", "med", "hot"))
fact.temp
summary(fact.temp)
summary(temps)

### Matrix Training Exercise

A <- c(1,2,3)
B <- c(4,5,6)
C <- matrix(c(A,B), byrow = T, nrow = 2)
rownames(C) <- c("A","B")
C
#or
A <- c(1,2,3)
B <- c(4,5,6)
rbind(A,B)

mat <- matrix(1:9, byrow = T, nrow = 3)
mat

is.matrix(mat)

mat2 <- matrix(1:25, byrow = T, nrow = 5)
mat2

mat2[2:3,2:3]

mat2[4:5,4:5]

sum(mat2)

help(runif)
u <- runif(20)
u
z <- matrix(runif(20, min = 0, max = 100), nrow = 4)
z