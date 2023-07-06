couleurs <- c("rouge", "bleu", "vert", "jaune", "orange", "violet", "rose", "noir", "blanc", "gris", "marron",
              "cyan", "argent", "or", "turquoise", "indigo", "magenta", "bronze", "beige", "olive", "aubergine", "ivoire")

datacolor <-  as.data.frame(couleurs)

findColor <- function(inputString ) {
  inputString <- tolower(inputString)
  matchedColor <- NA
  for (i in 1:nrow(datacolor)) {
    category <- tolower(datacolor$couleurs[i])
    if ( grepl(category, inputString) ) {
      matchedColor <- category
      return( paste("ce texte contient la couleur : ",category))
      break
    }
  }
  return(print("pas de couleur"))
}


description <- "Matelas  rouge mousse 140x190 cm"
findColor("Matelas  mousse 140x190 cm")
findColor(description)
