### List Basics

v <- c(1,2,3)
v
m <- matrix(1:10, nrow = 2)
m
df <- mtcars
df

class(v)
class(m)
class(df)

my.list <- list(v, m, df)
my.list

my.named.list <- list(sample.vec = v, my.matrix = m, sample.df = df) # adding
# names to items of a list
my.named.list
my.named.list$sample.df

my.list
my.list[1]
my.named.list[1]
my.named.list["sample.vec"]
class(my.named.list["sample.vec"]) # still a list!
my.named.list$sample.vec
class(my.named.list$sample.vec) # this is a vector
# or:
my.named.list[["sample.vec"]]
class(my.named.list[["sample.vec"]]) # this is a vector

double.list <- c(my.named.list, my.named.list)
double.list

str(my.named.list)