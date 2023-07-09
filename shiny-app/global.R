library(readxl)
library(tidyverse)

setwd("C:/Users/Youness/Desktop/R project/nricher/code/www")

# Importation des données
datap <- read_excel("data.xlsx")
data <- datap
nature <- as.data.frame(data$Nature)
colnames(nature) <- c("Nature")
libelle <- as.data.frame(data$`Libellé produit`)
colnames(libelle) <- c("Libelle")
# Déterminer les indices où il y a les NA dans nature
valeur_unique <- is.na(nature)
indice <-as.data.frame(which(valeur_unique))
colnames(indice) <- c("Indice")

colonne1 <- c("libelle")
colonne2 <- c("indice")

df <- data.frame(libelle = colonne1, indice = colonne2)

# filtrer les données de valeurs manquantes 
for (i in  1:nrow(indice)) {
  
  a <- indice$Indice[i]
  m <- libelle$Libelle[a]
  d <- data.frame( libelle = m , indice = a)
  df <- rbind(df, d)
  print(a)
}

base_na <- df[2:nrow(df),]
# Déterminer le nom des produits qui ont na comme nature
uni <- unique(base_na$libelle)

# filtrer les données pour calculer la dimension de chaque produit

fil <- filter(data, data$`Libellé produit` == "1 an d assistance Téléphonique PC")
fil2 <- filter(data, data$`Libellé produit` == "Adhérer au programme fidélité Ma Carte Confo +")
fil3 <- filter(data, data$`Libellé produit` == "Reprise de l ancien matériel")
fil4 <- filter(data, data$`Libellé produit` == "REPRISE MEUBLES LITERIE 20")
fil5 <- filter(data, data$`Libellé produit` == "Reprise ancien produit")
fil6 <- filter(data, data$`Libellé produit` == "1 an supplémentaire d assistance téléphonique PC soit 2 ans d assistance")



filter(nature, nature$Nature == "Pc portable")



# Pour catégoriser les libelles de valeurs NA dans nature
ind1 <- which(data$`Libellé produit` == "1 an d assistance Téléphonique PC")
data$Nature[ind1] <- "Pc portable"

ind2 <- which(data$`Libellé produit` == "Adhérer au programme fidélité Ma Carte Confo +")
data$Nature[ind2] <- "Loisirs créatifs"

ind3 <- which(data$`Libellé produit` == "REPRISE MEUBLES LITERIE 20")
data$Nature[ind3] <- "Lit adulte"

ind4 <- which(data$`Libellé produit` == "Reprise ancien produit")
data$Nature[ind4] <- "Outil multifonction"

ind5 <- which(data$`Libellé produit` == "Reprise de l ancien matériel")
data$Nature[ind5] <- "Outil multifonction"

ind6 <- which(data$`Libellé produit` == "1 an supplémentaire d assistance téléphonique PC soit 2 ans d assistance")
data$Nature[ind6] <- "Pc portable"





