install.packages(c("readxl", "RJSONIO", "dplyr","tidyr"))

library(readxl)
library(RJSONIO)
library(dplyr)
library(tidyr)

#_______________________________________________________________________


# Definição de diretório (alterar para sua pasta destino)

setwd("C:/Users/Ademir Rocha/Desktop/Marrocos_Rede")


#_______________________________________________________________________

base <- read_excel("data.xlsx", col_names = T) 
test <- data.frame(base)

nrow <- nrow(test)
counter <- 1
test$lon[counter] <- 0
test$lat[counter] <- 0
while (counter <= nrow){
  CityName <- gsub(' ','%20',test$CityLong[counter]) #remove space for URLs
  CountryCode <- test$Country[counter]
  url <- paste(
    "http://nominatim.openstreetmap.org/search?city="
    , CityName
    , "&countrycodes="
    , CountryCode
    , "&limit=9&format=json"
    , sep="")
  x <- fromJSON(url)
  if(is.vector(x)){
    test$lon[counter] <- x[[1]]$lon
    test$lat[counter] <- x[[1]]$lat    
  }
  counter <- counter + 1
}
