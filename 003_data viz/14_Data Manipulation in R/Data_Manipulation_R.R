### Guide to Using Dplyr - pt. I

install.packages("dplyr")
install.packages("nycflights13")

library(dplyr)
library(nycflights13)

head(flights)
summary(flights)

# filter() and slice()
# arrange()
# select() and rename()
# distinct()
# mutate() and transmute()
# summarise()
# sample_n() and sample_frac()

head(filter(flights, month == 11, day == 3, carrier == "AA"))
# or:
head(flights[flights$month == 11 & flights$day == 3 & flights$carrier == "AA",])

slice(flights, 1:10)

head(arrange(flights, year, month, day, air_time))
head(arrange(flights, year, month, day, arr_time))
head(arrange(flights, year, month, day, desc(arr_time)))

### Guide to Using Dplyr - pt. II

head(select(flights, carrier))
head(select(flights, carrier,arr_time))
head(select(flights, carrier,arr_time, month))

head(rename(flights, airline_carrier = carrier))

distinct(select(flights, carrier))

head(mutate(flights, new_col = arr_delay - dep_delay))
head(transmute(flights, new_col = arr_delay - dep_delay))

summarise(flights, avg_air_time = mean(air_time, na.rm = TRUE))
summarise(flights, total_time = sum(air_time, na.rm = TRUE))

sample_n(flights, 10)
sample_frac(flights, 0.0001)

### Pipe Operator %>%

library(dplyr)
df <- mtcars

# Nesting

result <- arrange(sample_n(filter(df, mpg > 20), size = 5), desc(mpg))
result

# Multiple assignments

a <- filter(df, mpg > 20) # filtering the db
b <- sample_n(a, size = 5) # randomizing and taking samples from the filtered 
# db
result <- arrange(b, desc(mpg)) # arranging the randomized sample by descending
# order
result

# Pipe Operator
# Data %>% op1 %>% op2 %>% op3 ...

result <- df %>% 
  filter(mpg > 20) %>% 
  sample_n(size = 5) %>% 
  arrange(desc(mpg))
result

### Dplyr Exercises

library(dplyr)
head(mtcars)

mtcars %>% 
  filter(mpg > 20, cyl == 6)

mtcars %>%
  arrange(cyl, desc(wt))

mtcars %>% 
  select(mpg, hp)

mtcars %>% 
  distinct %>% 
  select(gear) # this will show every observation
# or:
distinct(select(mtcars,gear)) # this will show only distinct values

mtcars %>% 
  mutate(performance = hp/wt)

mtcars %>% 
  summarise(avg_mpg = mean(mpg))

mtcars %>% 
  filter(cyl == 6) %>% 
  summarise(avg_hp = mean(hp))
# or:
mtcars %>% 
  filter(cyl == 6) %>% 
  summarise(std_hp = sd(hp))

### Guide to Using Tidyr

install.packages("tidyr")
install.packages("data.table")

library(tidyr)
library(data.table)

# gather()
# spread()
# separare()
# unite()

comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)
df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)
df

# Going from "wide" to "long"

gather(df, Quarter, Revenue, Qtr1:Qtr4) # "Quarter" collapses headers into a
# column; "Revenue" takes the values from the previous Qtr1:Qtr4 columns
# or:
df %>% 
  gather(Quarter, Revenue, Qtr1:Qtr4)

stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
stocks

stocks.gathered <- stocks %>% 
  gather(Stock, Price, X:Z)
stocks.gathered

stocks.gathered %>% 
  spread(Stock, Price) # first key becomes column head; second key fills
# observations
stocks.gathered %>% 
  spread(time, Price)

df <- data.frame(new_col=c(NA, "a.x", "b.y", "c.z"))
df

df %>% 
  separate(new_col, c("ABC", "XYZ"))

df <- data.frame(new_col=c(NA, "a/x", "b/y", "c/z"))
df

df %>% 
  separate(new_col, c("ABC", "XYZ"), sep = "/")
# or:
df %>% 
  separate(new_col, c("ABC", "XYZ"))

df.sep <- df %>% 
  separate(new_col, c("ABC", "XYZ"))
df.sep

df.sep %>% 
  unite(new_joined_col,ABC,XYZ)
# or:
df.sep %>% 
  unite(new_joined_col,ABC,XYZ, sep = "---")