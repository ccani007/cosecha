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
    investigacion = "investigaci\u00f3n",
    servicio = "servicio",
    "tu trienio"
  )
  hitos <- c(
    "1" = "\U0001f331 \u00a1Primera actividad! El trienio ya empez\u00f3, y qued\u00f3 guardada.",
    "5" = "\U0001f680 \u00a1Van 5! Ese ritmo se siente bien.",
    "10" = "\U0001f3c6 \u00a1Diez actividades! El informe ya tiene de d\u00f3nde agarrarse.",
    "15" = "\u2728 \u00a1Quince! Vas dejando el trienio en orden.",
    "20" = "\U0001f31f \u00a1Veinte registros! Esto ya es una cosecha.",
    "25" = "\U0001f49b \u00a1Veinticinco! Tu yo del futuro te lo agradece.",
    "50" = "\U0001f973 \u00a1Cincuenta! Qu\u00e9 trienio tan bien contado."
  )
  clave <- as.character(n)
  if (clave %in% names(hitos)) return(unname(hitos[[clave]]))
  comunes <- c(
    sprintf("\U0001f389 \u00a1Qued\u00f3 guardada! Sumaste algo a %s.", rama_txt),
    sprintf("\u2728 \u00a1Listo! Esa actividad de %s ya est\u00e1 a salvo.", rama_txt),
    "\U0001f4c1 \u00a1Bien hecho! Qued\u00f3 en tu carpeta, lista para el informe.",
    "\U0001f33e \u00a1Excelente! Una m\u00e1s en la cosecha del trienio.",
    "\U0001f4aa \u00a1Anotado! Menos memoria, m\u00e1s tranquilidad."
  )
  comunes[((n - 1L) %% length(comunes)) + 1L]
}
