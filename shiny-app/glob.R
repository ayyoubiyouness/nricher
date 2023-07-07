library(shiny)
library(plotly)
library(highcharter)
library(shinydashboard)
library(readxl)


# Filtration de data par vendeur

data_vendeur1 <- filter(data, data$Vendeur == "Vendeur 1")
data_vendeur2 <-  filter(data, data$Vendeur == "Vendeur 2")
data_vendeur3 <- filter(data, data$Vendeur == "Vendeur 3")
data_vendeur4 <-  filter(data, data$Vendeur == "Vendeur 4")
data_vendeur5 <-  filter(data, data$Vendeur == "Vendeur 5")
data_vendeur6 <-  filter(data, data$Vendeur == "Vendeur 6")
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
data_vendeur6  <- data_vendeur6[order(data_vendeur6$`Date de commande`), ]

data_autre_vendeur$`Date de commande`<- as.Date(data_autre_vendeur$`Date de commande`, format = "%d-%m-%y %H:%M")
data_autre_vendeur  <- data_autre_vendeur[order(data_autre_vendeur$`Date de commande`), ]


# préparation des données de ventes pour chaque jour de chaque vendeur

calculate_sum_by_date <- function(data, variable) {
  result <- as.data.frame(by(data[[variable]], list(data$`Date de commande`), sum))
  Date <- unique(data$`Date de commande`)
  result <- cbind(result, Date)
  colnames(result) <- c( "Montant", "Date")
  # type_vend <-as.data.frame(rep(data[1,3], nrow(result)))
  # colnames(type_vend) <- data[1,3]
  # result <- cbind(type_vend, result  )
  return(result)
  
}

vend1_sum <- calculate_sum_by_date(data_vendeur1, "Montant cmd" )
type_vend <-as.data.frame(rep("Vendeur 1", nrow(vend1_sum)))
colnames(type_vend) <- "Vendeur"
vend1_sum <- cbind(type_vend, vend1_sum  )


vend2_sum <- calculate_sum_by_date(data_vendeur2, "Montant cmd" )
type_vend <-as.data.frame(rep("Vendeur 2", nrow(vend2_sum)))
colnames(type_vend) <- "Vendeur"
vend2_sum <- cbind(type_vend, vend2_sum  )


vend3_sum <- calculate_sum_by_date(data_vendeur3, "Montant cmd" )
type_vend <-as.data.frame(rep("Vendeur 3", nrow(vend3_sum)))
colnames(type_vend) <- "Vendeur"
vend3_sum <- cbind(type_vend, vend3_sum  )


vend4_sum <- calculate_sum_by_date(data_vendeur4, "Montant cmd" )
type_vend <-as.data.frame(rep("Vendeur 4", nrow(vend4_sum)))
colnames(type_vend) <- "Vendeur"
vend4_sum <- cbind(type_vend, vend4_sum  )

vend5_sum <- calculate_sum_by_date(data_vendeur5, "Montant cmd" )
type_vend <-as.data.frame(rep("Vendeur 5", nrow(vend5_sum)))
colnames(type_vend) <- "Vendeur"
vend5_sum <- cbind(type_vend, vend5_sum  )

vend6_sum <- calculate_sum_by_date(data_vendeur6, "Montant cmd" )
type_vend <-as.data.frame(rep("Vendeur 6", nrow(vend6_sum)))
colnames(type_vend) <- "Vendeur"
vend6_sum <- cbind(type_vend, vend6_sum  )

vendautre_sum <- calculate_sum_by_date(data_autre_vendeur, "Montant cmd" )
type_vend <-as.data.frame(rep("Autre vendeur", nrow(vendautre_sum)))
colnames(type_vend) <- "Vendeur"
vendautre_sum <- cbind(type_vend, vendautre_sum  )


datavend <- rbind(vend1_sum, vend2_sum, vend3_sum, vend4_sum, vend5_sum, vend6_sum, vendautre_sum)
