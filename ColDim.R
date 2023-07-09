# code pour extraire la couleur dans une chaine
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
      return(category)
      break
    }
  }
  return(NA)
}



findColor("lot de 4 chaise scandinave noires style eiffel")

# code pour determiner la dimension
findDimension <- function(chaine) {
  dimension <- regmatches(chaine, regexpr("\\d+\\s*[xX*]\\s*\\d+", chaine))
  if (length(dimension) > 0) {
    dimension <- gsub("\\s", "", dimension)  
    return( dimension)
  } else {
    return(NA)
  }
}


chaine <- "pari prix paire de voilage eucaly 70x200cm anthracite"


findDimension(chaine)

ColDim <- function(chaine) {
  a <- findDimension(chaine)
  b <- findColor(chaine)
  if(is.na(a) & is.na(b)) {
    return(paste("Ce texte ne présente pas de dimension ni de couleur"))
  } else if ( !is.na(a) & !is.na(b) ) {
    return(paste("Dans ce texte, il y a la couleur", b, " et la dimension", a))
  } else if( !is.na(a) & is.na(b) ) {
    return(paste("Ce texte présente la dimension", a))
  } else if ( is.na(a) & !is.na(b) ) {
    return(paste(" ce texte présente la couleur", b))
  }
}


chaine <- "Matelas mousse rouge 140x190   cm"

ColDim(chaine)
