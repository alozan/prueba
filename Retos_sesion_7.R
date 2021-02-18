library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)


MyDataBase = dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

x = dbGetQuery(MyDataBase, "select * from CountryLanguage")
names(x)

SP = x %>% filter(Language == "Spanish")
SP.df = as.data.frame(SP) 


SP.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()
