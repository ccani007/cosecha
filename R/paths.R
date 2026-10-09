config_path <- function() {
  file.path(tools::R_user_dir("ordenamiento", which = "config"), "data_dir.txt")
}

#' Ruta por defecto de la carpeta Ordenamiento
#' @noRd
default_data_dir <- function() {
  home <- Sys.getenv("USERPROFILE", unset = path.expand("~"))
  candidatos <- c(
    file.path(home, "OneDrive - Universidad de los Andes", "Ordenamiento"),
    {
      od <- Sys.getenv("OneDrive", unset = "")
      if (nzchar(od)) file.path(od, "Ordenamiento") else NULL
    },
    file.path(home, "Documents", "Ordenamiento")
  )
  candidatos <- Filter(Negate(is.null), candidatos)

  # Solo reutilizar carpetas que ya son de DATOS (nunca el repo del paquete)
  for (p in candidatos) {
    if (dir.exists(p) &&
        (dir.exists(file.path(p, "evidencias")) ||
         file.exists(file.path(p, "datos", "actividades.csv")))) {
      return(normalizePath(p, winslash = "/", mustWork = FALSE))
    }
  }
  normalizePath(candidatos[[1]], winslash = "/", mustWork = FALSE)
}

#' Obtiene la carpeta de datos configurada
#'
#' @return Ruta absoluta a la carpeta Ordenamiento.
#' @export
data_dir <- function() {
  opt <- getOption("ordenamiento.data_dir", NULL)
  if (!is.null(opt) && nzchar(opt)) {
    return(normalizePath(opt, winslash = "/", mustWork = FALSE))
  }
  cfg <- config_path()
  if (file.exists(cfg)) {
    p <- str_trim_line(readLines(cfg, warn = FALSE, encoding = "UTF-8")[1])
    if (nzchar(p)) return(normalizePath(p, winslash = "/", mustWork = FALSE))
  }
  default_data_dir()
}

#' Fija la carpeta de datos (y la recuerda para próximas sesiones)
#'
#' @param path Ruta a la carpeta Ordenamiento.
#' @return La ruta normalizada (invisible).
#' @export
set_data_dir <- function(path) {
  path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  fs::dir_create(dirname(config_path()), recurse = TRUE)
  writeLines(path, config_path(), useBytes = TRUE)
  options(ordenamiento.data_dir = path)
  invisible(path)
}

str_trim_line <- function(x) {
  x <- as.character(x %||% "")
  gsub("^\\s+|\\s+$", "", x)
}

#' Crea la estructura de carpetas si no existe
#'
#' @param path Carpeta de datos. Por defecto [data_dir()].
#' @return La ruta asegurada (invisible).
#' @export
ensure_data_dir <- function(path = NULL) {
  path <- path %||% data_dir()
  path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  set_data_dir(path)

  ramas <- c("docencia", "investigacion", "servicio")
  fs::dir_create(file.path(path, "datos"), recurse = TRUE)
  fs::dir_create(file.path(path, "registro"), recurse = TRUE)
  fs::dir_create(file.path(path, "informe-trienal", "borrador"), recurse = TRUE)
  for (r in ramas) {
    fs::dir_create(file.path(path, "evidencias", r), recurse = TRUE)
  }

  csv <- file.path(path, "datos", "actividades.csv")
  if (!file.exists(csv)) {
    header <- paste(
      c(
        "id", "rama", "fecha", "actividad", "rol_alcance", "estado",
        "evidencia", "para_informe", "notas", "creado_en"
      ),
      collapse = ","
    )
    writeLines(header, csv, useBytes = TRUE)
  }

  invisible(path)
}

#' Abre la carpeta de datos en el explorador de archivos
#'
#' @param path Carpeta de datos. Por defecto [data_dir()].
#' @export
abrir_carpeta <- function(path = NULL) {
  path <- ensure_data_dir(path)
  if (.Platform$OS.type == "windows") {
    shell.exec(normalizePath(path, winslash = "\\"))
  } else {
    utils::browseURL(path)
  }
  invisible(path)
}
