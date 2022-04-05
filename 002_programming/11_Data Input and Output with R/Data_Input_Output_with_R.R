### CSV Files with R

write.csv(mtcars, file = "my_example.csv")

ex <- read.csv("example.csv")
head(ex)
class(ex)

write.csv(ex, file = "my_new_example.csv")

read.csv("my_new_example.csv")

help(read.csv)

### Excel Files with R

install.packages("readxl")
library(readxl)

excel_sheets("Sample-Sales-Data.xlsx")
df <- read_excel("Sample-Sales-Data.xlsx", sheet = "Sheet1")
head(df)

sum(df$Value)
summary(df)

entire.workbook <- lapply(excel_sheets("Sample-Sales-Data.xlsx"), read_excel, 
                          path = "Sample-Sales-Data.xlsx" ) # to upload an 
# entire workbook, and not just one sheet!
entire.workbook

install.packages("xlsx")
library(xlsx)

head(mtcars)
write.xlsx(mtcars, "output_example.xlsx")

### SQL with R

# RODBC - General use

install.packages("RODBC")
library(RODBC)

# basic query:
# myconn <-odbcConnect("Database_Name", uid="User_ID", pwd="password")
# dat <- sqlFetch(myconn, "Table_Name")
# querydat <- sqlQuery(myconn, "SELECT * FROM table")
# close(myconn)

# other packages:
# - RMySql
# - ROracle
# - RJDBC
# - RPostgreSQL

# another tip - visit https://www.r-bloggers.com/

### Web Scraping with R

install.packages("rvest")
library(rvest)

demo(package = "rvest")
demo(package = "rvest", topic = "tripadvisor")