### Assignment for ggplot2

install.packages("readr")
library(readr)
df <- read_csv("Economist_Assignment_Data.csv", 
               col_types = cols(...1 = col_skip())) # to skip the first column
head(df)

library(dplyr)
library(ggplot2)

pl <- df %>% 
  ggplot(aes(x = CPI, y = HDI, color = Region))
pl + geom_point()

pl2 <- pl + geom_point(shape = 1, size = 5)
pl2

pl3 <- pl + geom_point(shape = 1, size = 5) + geom_smooth(aes(group = 1))
pl3

pl4 <- pl + geom_point(shape = 1, size = 5) + geom_smooth(aes(group = 1), 
            method = "lm", formula = y ~ log(x), se = F, color = "red")
pl4

pl5 <- pl + geom_point(shape = 1, size = 5) + geom_smooth(aes(group = 1), 
            method = "lm", formula = y ~ log(x), se = F, color = "red") +
            geom_text(aes(label = Country)) # labeling each point/obs with the 
# "Country" variable
pl5

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway",
                   "Japan", "New Zealand", "Singapore")
pl6 <- pl4 + geom_text(aes(label = Country), color = "gray20", 
              data = subset(df, Country %in% pointsToLabel), # selecting
              # which countries to label from "Country" variable, as listed in
              # "pointsToLabel"
              check_overlap = T)
pl6

pl7 <- pl6 + theme_bw()
pl7

pl8 <- pl7 +
  scale_x_continuous(
    name = "Corruption Perceptions Index, 2011 (10 = least corrupt)",
                     limits = c(1,10), breaks = 1:10)
pl8

pl9 <- pl8 + 
  scale_y_continuous(
    name = "Human Development Index, 2011 (1 = Best)", 
    limits = c(0.2,1.0))
pl9

pl10 <- pl9 + ggtitle("Corruption and Human development")
pl10