### Overview of ggplot2

# library(ggplot2) - library
# pl <- ggplot(data = mtcars, aes(x = mpg, y = hp)) - data and aesthetics
# pl + geom_point() - geometries
# pl + facet_grid(cyl ~ .) - different graphs for each distinct value of cyl
# pl + facet_grid(cyl ~ .) + stat_smooth() - for a line fit (regression)
# pl2 <- pl + facet_grid(cyl ~ .) + stat_smooth()
# pl2 + coord_cartesian(xlim = c(15,25)) - limiting x-axis coordinate values
# pl2 + coord_cartesian(xlim = c(15,25)) + theme_bw() - adding a theme to the
# graph

### Histograms

install.packages("ggplot2")
install.packages("ggplot2movies")

# Cheatsheet:
# https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf

library(dplyr)
library(ggplot2)
library(ggplot2movies)

# Data and Aesthetics

colnames(movies)
head(movies)

pl <- movies %>% 
  ggplot(aes(x = rating))

# Geometry

pl + geom_histogram() # y-axis is count/frequency of ratings in the "movies"
# db
pl + geom_histogram(binwidth = 0.1)
pl + geom_histogram(binwidth = 0.1, color = "red")
pl + geom_histogram(binwidth = 0.1, color = "red", fill = "pink")
pl + geom_histogram(binwidth = 0.1, color = "red", fill = "pink", alpha = 0.4)

pl2 <- pl + geom_histogram(binwidth = 0.1, color = "red", fill = "pink", 
                           alpha = 0.4)
pl3 <- pl2 + xlab("Movie Ratings") + ylab("Count")
pl3
print(pl3)

pl3 + ggtitle("My Title")

pl4 <- pl + geom_histogram(binwidth = 0.1, aes(fill = ..count..)) # creating a
# "degradé" histogram based on count
pl4

### Scatterplots

df <- mtcars
df

# Data and Aesthetics

pl <- mtcars %>% 
  ggplot(aes(x = wt, y = mpg))

# Geometry
pl + geom_point()
pl + geom_point(size = 10)
pl + geom_point(size = 5, alpha = 0.5)
pl + geom_point(aes(size = hp))
pl + geom_point(aes(size = cyl))
pl + geom_point(aes(size = factor(cyl)))
pl + geom_point(aes(shape = factor(cyl)))
pl + geom_point(aes(shape = factor(cyl), size = 5))
pl + geom_point(aes(shape = factor(cyl), color = factor(cyl), size = 5))

pl2 <- pl + geom_point(size = 5, color = "#56ea29") # do not forget the #!
pl2

pl3 <- pl + geom_point(size = 5, aes(color = hp))
pl3 # create a coloured scale of hp
pl4 <- pl3 + scale_color_gradient(low = "blue", high = "red")
pl4

### Barplots

df <- mpg
head(mpg)

pl <- df %>% 
  ggplot(aes(x = class)) # ideal to use a categorical variable for x-axis

pl + geom_bar() # count of cars per class in the db

pl + geom_bar(color = "blue", fill = "blue")
pl + geom_bar(aes(fill = drv)) # in each bar, there's also a count of types of 
# drives per class of car
pl + geom_bar(aes(fill = drv), position = "dodge") # separate count bars for 
# each car class (first) and (then) drive type
pl + geom_bar(aes(fill = drv), position = "fill") # for percentages of cars'
# drive type per class

### Boxplots

df <- mtcars
df

pl <- df %>% 
  ggplot(aes(x = cyl, y = mpg))
pl + geom_boxplot() # error!

pl <- df %>% 
  ggplot(aes(x = factor(cyl), y = mpg)) # always group/factor by a categorical
# variable
pl + geom_boxplot()
pl + geom_boxplot() + coord_flip()
pl + geom_boxplot(fill = "blue")
pl + geom_boxplot(aes(fill = factor(cyl))) + theme_bw()

### Two Variable Plotting

pl <- movies %>% 
  ggplot(aes(x=year, y = rating))
pl + geom_bin2d() # "heat map" of count of movie ratings per year
pl2 <- pl + geom_bin2d() + scale_fill_gradient(high = "red", low = "green")
pl2
pl3 <- pl + geom_bin2d(binwidth = c(3,1)) +
  scale_fill_gradient(high = "red", low = "blue")
pl3

pl + geom_hex()
pl + geom_hex() + scale_fill_gradient(high = "red", low = "blue")

pl + geom_density2d()

### Coordinates and Faceting

pl <- mpg %>% 
  ggplot(aes(x = displ, y = hwy)) + geom_point()
pl

pl2 <- pl + coord_cartesian(xlim = c(1,4), ylim = c(15,30))
pl2

pl3 <- pl + coord_fixed(ratio = 1/3)
pl3

help("facet_grid")

pl4 <- pl + facet_grid(. ~ cyl) # facet by the x-axis
pl4
pl5 <- pl + facet_grid(drv ~ .) # facet by the y-axis
pl5
pl6 <- pl + facet_grid(drv ~ cyl)
pl6

### Themes

pl <- mtcars %>% 
  ggplot(aes(x = wt, y = mpg)) + geom_point()
pl

theme_set(theme_minimal()) # to add theme to all plots

pl + theme_dark() # to add theme to a single plot

install.packages("ggthemes")
library(ggthemes)

pl + theme_economist()
pl + theme_fivethirtyeight()

theme_set(theme_grey())

### ggplot2 Exercises

head(mpg)

plE1 <- mpg %>% 
  ggplot(aes(x = hwy))
plE1 + geom_histogram(bins = 20, fill = "red", alpha = 0.4)

plE2 <- mpg %>% 
  ggplot(aes(x = manufacturer))
plE2 + geom_bar(aes(fill = factor(cyl))) + theme_gdocs()

head(txhousing)

plE3 <- txhousing %>% 
  ggplot(aes(x = sales, y = volume))
plE3 + geom_point(alpha = 0.4, color = "blue")

plE4 <- txhousing %>% 
  ggplot(aes(x = sales, y = volume))
plE4 + geom_point(alpha = 0.4, color = "blue") + geom_smooth(color = "red")