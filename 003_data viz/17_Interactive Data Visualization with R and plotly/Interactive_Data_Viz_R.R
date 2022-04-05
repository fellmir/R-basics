### Interactive Data Visualizations with Plotly

install.packages("plotly")
library(ggplot2)
library(plotly)

pl <- mtcars %>% 
  ggplot(aes(mpg,wt)) + geom_point()
pl

gpl <- pl %>% 
  ggplotly()
gpl

# ref: https://plotly.com/ggplot2/