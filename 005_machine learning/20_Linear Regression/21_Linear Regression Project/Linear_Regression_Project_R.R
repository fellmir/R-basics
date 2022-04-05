### Linear Regression Project

library(dplyr)
library(ggplot2)

bike <- read.csv("bikeshare.csv")
head(bike)

# prediction target -> "count"

bike.scatter <- bike %>% 
  ggplot(aes(x = temp, y = count)) +
  geom_point(alpha = 0.2, aes(color = temp)) + theme_bw()
bike.scatter

# just a test

bike.datetime <- as.POSIXct(bike$datetime)
bike.datetime

# the real deal

bike$datetime <- as.POSIXct(bike$datetime)
str(bike) # success?

count.datetime.scatter <- bike %>% 
  ggplot(aes(x = datetime, y = count)) +
  geom_point(alpha = 0.2, aes(color = temp)) + 
  scale_color_continuous(low='#55D8CE',high='#FF6E2E') + # color gradient!
  theme_bw()
count.datetime.scatter

count.temp.cor <- cor(bike$count, bike$temp)
count.temp.cor
# or:
count.temp.cor.table <- cor(bike[,c('temp','count')]) # to produce a 
# correlation table
count.temp.cor.table

count.season.boxplot <- bike %>% 
  ggplot(aes(factor(season), count)) + 
  geom_boxplot(aes(color = factor(season))) +
  theme_bw()
count.season.boxplot # this show a non-linear relationship between bike rentals
# and seasons!

# just an example w/o "factoring" season
count.season.boxplot.ex <- bike %>% 
  ggplot(aes(season, count)) + geom_boxplot()
count.season.boxplot.ex # wrong!

rm(count.season.boxplot.ex) # to remove example above

time.stamp <- bike$datetime[4]
format(time.stamp, "%H")

bike.hour <- bike$datetime %>% 
  format("%H")
bike.hour # just a test

bike.test <- bike
head(bike.test)

bike.test$hour <- bike.test$datetime %>% 
  format("%H")
head(bike.test) # it worked! therefore...

bike$hour <- bike$datetime %>% 
  format("%H")
head(bike)
# or:
bike$hour <- bike$datetime %>% 
  sapply(function(x){format(x, "%H")})
head(bike)

count.hour.filter <- bike %>% 
  filter(workingday == 1)
count.hour.scatter <- count.hour.filter %>% 
  ggplot(aes(hour, count)) + 
  geom_point(aes(color = temp)) + 
  scale_color_continuous(low='#55D8CE',high='#FF6E2E') + 
  theme_bw()
count.hour.scatter
# or:
pl <- ggplot(filter(bike, workingday == 1),aes(hour, count)) 
pl <- pl + 
  geom_point(position = position_jitter(w = 1, h = 0), aes(color = temp),
             alpha = 0.4)
pl <- pl + 
  scale_color_gradient(low='#55D8CE',high='#FF6E2E')
pl + theme_bw()

count.hour.filter.offdays <- bike %>% 
  filter(workingday == 0)
count.hour.scatter.offdays <- count.hour.filter.offdays %>% 
  ggplot(aes(hour, count)) + 
  geom_point(aes(color = temp), position = position_jitter(w = 1, h = 0),
             alpha = 0.4) + 
  scale_color_continuous(low='#55D8CE',high='#FF6E2E') + 
  theme_bw()
count.hour.scatter.offdays

temp.model <- lm(count ~ temp, bike)
summary(temp.model) # temperature is a good estimator of bike rentals

# Bike rentals at 25ºC

6.0462 + (25 * 9.1705)
# or:
temp.test <- data.frame(temp=c(25))
predict(temp.model,temp.test)

bike$hour <- sapply(bike$hour,as.numeric)
str(bike)

new.model <- lm(count ~ . -casual - registered -datetime -atemp, bike)
summary(new.model)