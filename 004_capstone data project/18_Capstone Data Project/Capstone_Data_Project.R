### Capstone Data Project

library(dplyr)
library(ggplot2)

batting <- read.csv('Batting.csv')
head(batting)
str(batting)
head(batting$AB, n = 5)
head(batting$X2B)

batting$BA <- batting$H / batting$AB
head(batting)
tail(batting$BA, 5)

batting$OBP <- ((batting$H + batting$BB + batting$HBP)/(batting$AB +
                batting$BB + batting$HBP + batting$SF) )
head(batting)
tail(batting$OBP, 5)

batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
tail(batting$X1B, 5)
batting$SLG <- ((batting$X1B + (2 * batting$X2B) + (3 * batting$X3B) +
                (4 * batting$HR))/batting$AB)
tail(batting$SLG, 5)

str(batting)

salaries <- read.csv("Salaries.csv")

summary(batting)

batting.new <- batting %>% 
  subset(yearID >= 1985)
summary(batting.new)

combo <- merge(batting.new, salaries, by = c("playerID", "yearID"))
summary(combo)

lost.players.id <- c("giambja01", "damonjo01", "saenzol01")
lost.players <- combo %>% 
  data.frame() %>% 
  subset(playerID %in% lost.players.id)
lost.players

lost.players.year <- lost.players %>% 
  subset(yearID == 2001)
lost.players.year

lost.players <- lost.players %>% 
  select(yearID, playerID, H, X2B, X3B, HR, OBP, SLG, BA, AB)
lost.players

lost.players.year <- lost.players %>% 
  subset(yearID == 2001)
lost.players.year

lost.players.year %>% 
  summarise(mean(AB))
lost.players.year %>% 
  summarise(mean(OBP))

replacements <- combo %>% 
  filter(yearID == 2001)
replacements %>% 
  ggplot(aes(OBP, salary)) + geom_point()
replacements <- replacements %>% 
  filter(salary < 8000000, OBP > 0, AB >= 500)
replacements

possibilities <- replacements %>% 
  arrange(desc(OBP), 10)
possibilities
possibilities[2:4,]