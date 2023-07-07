library(shiny)
library(plotly)
library(highcharter)
library(shinydashboard)
library(readxl)

source("C:/Users/Youness/Desktop/R project/nricher/code/global.R")

# Filtration de data par vendeur

data_vendeur1 <- filter(data, data$Vendeur == "Vendeur 1")
data_vendeur2 <-  filter(data, data$`Libellé produit` == "Vendeur 2")
data_vendeur3 <- filter(data, data$`Libellé produit` == "Vendeur 3")
data_vendeur4 <-  filter(data, data$`Libellé produit` == "Vendeur 4")
data_vendeur5 <-  filter(data, data$`Libellé produit` == "Vendeur 5")
data_vendeur6 <-  filter(data, data$`Libellé produit` == "Vendeur 6")
data_autre_vendeur <-  filter(data, data$Vendeur == "Autre vendeur")

# on ordonne les données selon les dates 
data_vendeur1$`Date de commande`<- as.Date(data_vendeur1$`Date de commande`, format = "%d-%m-%y %H:%M")
data_vendeur1  <- data_vendeur1[order(data_vendeur1$`Date de commande`), ]


data_vendeur2$`Date de commande`<- as.Date(data_vendeur2$`Date de commande`, format = "%d-%m-%y %H:%M")
data_vendeur2  <- data_vendeur2[order(data_vendeur2$`Date de commande`), ]

data_vendeur3$`Date de commande`<- as.Date(data_vendeur3$`Date de commande`, format = "%d-%m-%y %H:%M")
data_vendeur3  <- data_vendeur3[order(data_vendeur3$`Date de commande`), ]

data_vendeur4$`Date de commande`<- as.Date(data_vendeur4$`Date de commande`, format = "%d-%m-%y %H:%M")
data_vendeur4  <- data_vendeur4[order(data_vendeur4$`Date de commande`), ]

data_vendeur5$`Date de commande`<- as.Date(data_vendeur5$`Date de commande`, format = "%d-%m-%y %H:%M")
data_vendeur5  <- data_vendeur5[order(data_vendeur5$`Date de commande`), ]

data_vendeur6$`Date de commande`<- as.Date(data_vendeur6$`Date de commande`, format = "%d-%m-%y %H:%M")
data_vendeur6  <- data_vendeur6[order(data_vendeur4$`Date de commande`), ]

data_autre_vendeur$`Date de commande`<- as.Date(data_autre_vendeur$`Date de commande`, format = "%d-%m-%y %H:%M")
data_autre_vendeur  <- data_autre_vendeur[order(data_autre_vendeur$`Date de commande`), ]
