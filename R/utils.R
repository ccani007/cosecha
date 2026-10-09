`%||%` <- function(x, y) {
  if (is.null(x) || length(x) == 0) return(y)
  if (length(x) == 1 && (is.na(x) || !nzchar(as.character(x)))) return(y)
  x
}

slugify <- function(x) {
  x <- tolower(as.character(x %||% "evidencia"))
  x <- iconv(x, to = "ASCII//TRANSLIT")
  x <- gsub("[^a-z0-9]+", "-", x)
  x <- gsub("(^-|-$)", "", x)
  if (!nzchar(x)) x <- "evidencia"
  substr(x, 1L, 60L)
}

celda_md <- function(x) {
  x <- as.character(x %||% "")
  x <- gsub("\\|", "/", x)
  x <- gsub("\n", " ", x)
  x
}
