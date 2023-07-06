extractDimension <- function(chaine) {
  dimension <- regmatches(chaine, regexpr("\\d+\\s*[xX]\\s*\\d+", chaine))
  if (length(dimension) > 0) {
    dimension <- gsub("\\s", "", dimension)  
    return( paste(" La dimension dans la chiane est  " ,dimension))
  } else {
    return(NULL)
  }
}


chaine <- "Matelas 140x190 mousse  cm"


extractDimension(chaine)
