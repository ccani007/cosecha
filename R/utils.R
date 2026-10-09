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

write_utf8 <- function(lineas, path) {
  con <- file(path, open = "wt", encoding = "UTF-8")
  on.exit(close(con), add = TRUE)
  writeLines(lineas, con)
}

mensaje_al_guardar <- function(n, rama) {
  n <- as.integer(n)
  rama_txt <- switch(
    rama,
    docencia = "docencia",
    investigacion = "investigación",
    servicio = "servicio",
    "tu trienio"
  )
  hitos <- c(
    "1" = "🌱 ¡Primera actividad! El trienio ya empezó, y quedó guardada.",
    "5" = "🚀 ¡Van 5! Ese ritmo se siente bien.",
    "10" = "🏆 ¡Diez actividades! El informe ya tiene de dónde agarrarse.",
    "15" = "✨ ¡Quince! Vas dejando el trienio en orden.",
    "20" = "🌟 ¡Veinte registros! Esto ya es una cosecha.",
    "25" = "💛 ¡Veinticinco! Tu yo del futuro te lo agradece.",
    "50" = "🥳 ¡Cincuenta! Qué trienio tan bien contado."
  )
  clave <- as.character(n)
  if (clave %in% names(hitos)) return(unname(hitos[[clave]]))
  comunes <- c(
    sprintf("🎉 ¡Quedó guardada! Sumaste algo a %s.", rama_txt),
    sprintf("✨ ¡Listo! Esa actividad de %s ya está a salvo.", rama_txt),
    "📁 ¡Bien hecho! Quedó en tu carpeta, lista para el informe.",
    "🌾 ¡Excelente! Una más en la cosecha del trienio.",
    "💪 ¡Anotado! Menos memoria, más tranquilidad."
  )
  comunes[((n - 1L) %% length(comunes)) + 1L]
}
