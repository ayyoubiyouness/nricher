library(shiny)
library(plotly)
library(highcharter)
library(shinydashboard)
library(readxl)

# ce script est utilisé à la fois dans l'app shiny et pour la préparation des données 
# d'entrainement du modèle

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

# La fonction permet de donner la somme des valeurs de la variable dans la data pour chaque jour
calculate_sum_by_date <- function(data, variable) {
  result <- as.data.frame(by(data[[variable]], list(data$`Date de commande`), sum))
  Date <- unique(data$`Date de commande`)
  result <- cbind(result, Date)
  colnames(result) <- c( "Montant", "Date")
  return(result)
  
}

# Je calcule le prix de vente de chaque vendeur par jour
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

# je rassemble les données dans une matrice pour faciliter la visualisation 
datavend <- rbind(vend1_sum, vend2_sum, vend3_sum, vend4_sum, vend5_sum, vend6_sum, vendautre_sum)



# maintenant on filtre les données pour matelas

datamatelas <- filter(datap, datap$Nature == "Matelas")
# je détermine la quantité vendue des matelats de chaque vendeur 
result <- as.data.frame(by(datamatelas$Quantité, list(datamatelas$`Vendeur`), sum))
a <- as.data.frame(rownames(result))
quant_matela <- cbind(a, result)
colnames(quant_matela) <- c("Vendeur", "Quantité")
# je détermine le prix de vente des matelats pour chaque vendeur
result2 <- as.data.frame(by(datamatelas$`Montant cmd`, list(datamatelas$`Vendeur`), sum))
aa <- a <- as.data.frame(rownames(result))
prix_matela <- cbind(aa, result2)
colnames(prix_matela) <- c("Vendeur", "prix")




# préparatin des données pour l'entrainement 
# l'idée est de préparer une data de deux colonnes libelle et nature 
# et que dans la colonne nature on trouve tous les natures présentes dans le dataset 

# fonction pour déterminer la catègorie et retourne na s'il arrive pas à catégoriser

nature_unique <- as.data.frame(unique(data$Nature))
colnames(nature_unique) <- c("Nature")
# il y a 596 types de natures
findCategory <- function(inputString) {
  inputString <- tolower(inputString)
  matchedCategory <- NA
  for (i in 1:nrow(nature_unique)) {
    category <- tolower(nature_unique$Nature[i])
    if (str_detect(inputString, paste0("\\b", category, "\\b"))) {
      matchedCategory <- nature_unique$Nature[i]
      break
    }
  }
  return(matchedCategory)
}

# filtrer les données pour avoir juste les seuls libelles avec
# natures correspondantes de la data d'origine
datapre <- select(data, c(2,5))
filtered_datapre <-  subset(datapre, !duplicated(`Libellé produit`))
# il y a 55997 produits présents dans le dataset
print(filtered_datapre)


# Pour déterminer le nombre de libelle que l'algo permet de catégoriser
df_test <- data.frame()
for (i in 1:nrow(filtered_datapre)) {
  lib <- filtered_datapre$`Libellé produit`[i]
  matchedCategory <- findCategory(lib)
  category <- filtered_datapre$Nature[i]
  if (!is.na(matchedCategory)  && (matchedCategory == category) ) {
    print(i)
    df_test <- rbind(df_test, i)
    filtered_datapre$Nature[i] <- matchedCategory
  }
  
}
colnames(df_test) <- c("indice")

# La dimension de df_test est 20011 il reste donc 35986

# on choisit les données qui sont bien classés par l'algo
# Dans cette data on a 342 natures uniques, il reste donc 254
filtered_datap <- filtered_datapre[df_test$indice, ]



# on choisit les données que l'algo n'arrive pas à classer
filtered_datan <- filtered_datapre[-df_test$indice, ]

# Maintenant je vais faire des traitements sur les données pour que l'algo 
# puisse les catégoriser, l'objectif est d'avoir plus de nature 
# pour passer à l'entrainelent du modèle 
# Majuscule to minuscule
filtered_datan <- filtered_datan %>% mutate(Nature = tolower(Nature))
filtered_datan <- filtered_datan %>% mutate(`Libellé produit` = tolower(`Libellé produit`))

# on remplace les caractères spéciaux par leurs équivalents normaux 
# j'utilise des fonctions d'expression régulière 
replacetext <- function(text) {
  text <- gsub("é", "e", text, ignore.case = TRUE)
  text <- gsub("è", "e", text, ignore.case = TRUE)
  text <- gsub("à", "a", text, ignore.case = TRUE)
  return(text)
}

# Maintenent j'applique cette fonction au dataset qu'on veut catégoriser
for (i in 1:nrow(filtered_datan)) {
  text1 <- filtered_datan$`Libellé produit`[i]
  text2 <- filtered_datan$Nature[i]
  text1 <- replacetext(text1)
  text2 <- replacetext(text2)
  filtered_datan$`Libellé produit`[i] <- text1
  filtered_datan$Nature[i] <- text2
  print(i)
  
}




# Ensuite, on refait la catégorisation des produits

nature_unique2 <- as.data.frame(unique(filtered_datan$Nature))
colnames(nature_unique2) <- c("Nature")

findCategory2 <- function(inputString) {
  inputString <- tolower(inputString)
  matchedCategory <- NA
  for (i in 1:nrow(nature_unique2)) {
    category <- tolower(nature_unique2$Nature[i])
    if (str_detect(inputString, paste0("\\b", category, "\\b"))) {
      #print(i)
      matchedCategory <- nature_unique2$Nature[i]
      break
    }
  }
  return(matchedCategory)
}

# Maintenant je vois les autres produits que l'algo permet de catégoriser
df_test3 <- data.frame()
for (i in 1:nrow(filtered_datan)) {
  
  lib <- filtered_datan$`Libellé produit`[i]
  matchedCategory <- findCategory2(lib)
  category <- filtered_datan$Nature[i]
  if (!is.na(matchedCategory) && (matchedCategory == category) ) {
    print(i)
    df_test3 <- rbind(df_test3, i)
    filtered_datan$Nature[i] <- matchedCategory
  }
  
}
colnames(df_test3) <- c("indice")
# je rappelle que 35986 produit que l'algo ne permet pas de catégoriser
# maintenant je crée deux data : une contient les nouveux produits
# que l'algo arrive à catégorise
# l'autre contient les produits que j'arrive pas à catégoriser
datan1 <- filtered_datan[df_test3$indice, ]

datan2 <- filtered_datan[-df_test3$indice, ]

# la dimension de datan1 est 3038 et la dimension de datan2 est 32948
# j'arrive à catégoriser 23049 produits. il reste 32948 
# on oublie datan1 et je travaille sur datan2
#  on continue le traitement de datan2 avec python 
library(writexl)

write_xlsx(datan2, "C:/Users/Youness/Desktop/R project/nricher/fichier.xlsx")

