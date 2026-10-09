# La ruta NO depende de la carpeta donde este parada R.
# Se recuerda en el directorio de configuracion del usuario
# (tools::R_user_dir), que sobrevive a cerrar la sesion.

config_path <- function() {
  file.path(tools::R_user_dir("cosecha", which = "config"), "data_dir.txt")
}

legacy_config_path <- function() {
  file.path(tools::R_user_dir("ordenamiento", which = "config"), "data_dir.txt")
}

normalize_dir <- function(path) {
  path <- gsub("\\\\", "/", as.character(path %||% ""))
  path <- gsub("/+$", "", path)
  if (!nzchar(path)) return(path)
  if (dir.exists(path) || file.exists(path)) {
    return(suppressWarnings(normalizePath(path, winslash = "/", mustWork = TRUE)))
  }
  parent <- gsub("/+$", "", gsub("\\\\", "/", dirname(path)))
  if (!nzchar(parent) || identical(parent, path)) {
    return(suppressWarnings(normalizePath(path, winslash = "/", mustWork = FALSE)))
  }
  paste0(normalize_dir(parent), "/", basename(path))
}

str_trim_line <- function(x) {
  x <- as.character(x %||% "")
  gsub("^\\s+|\\s+$", "", x)
}

read_config_line <- function(path) {
  if (!file.exists(path)) return("")
  line <- readLines(path, warn = FALSE, encoding = "UTF-8")[1]
  str_trim_line(line)
}

remembered_dir <- function() {
  for (cfg in c(config_path(), legacy_config_path())) {
    p <- read_config_line(cfg)
    if (nzchar(p)) return(normalize_dir(p))
  }
  ""
}

padres_datos <- function() {
  home <- Sys.getenv("USERPROFILE", unset = path.expand("~"))
  od <- Sys.getenv("OneDrive", unset = "")
  unicos <- unique(c(
    file.path(home, "OneDrive - Universidad de los Andes"),
    if (nzchar(od)) od else NULL,
    file.path(home, "Documents")
  ))
  Filter(Negate(is.null), unicos)
}

tiene_datos <- function(path) {
  dir.exists(path) && (
    file.exists(file.path(path, "datos", "actividades.csv")) ||
    dir.exists(file.path(path, "evidencias"))
  )
}

#' Busca una carpeta que ya tenga actividades.
#'
#' `Ordenamiento` va primero: si el profesor ya guard`r "\u00f3"` ah`r "\u00ed"`, esa gana
#' y no se abre una `cosecha` vac`r "\u00ed"`a al lado.
#' @noRd
buscar_carpeta_existente <- function(padres) {
  for (padre in padres) {
    if (!dir.exists(padre)) next
    for (nombre in c("Ordenamiento", "cosecha")) {
      p <- file.path(padre, nombre)
      if (tiene_datos(p)) return(normalize_dir(p))
    }
  }
  ""
}

#' Ruta por defecto de la carpeta de datos
#'
#' Si ya hay actividades en `Ordenamiento` o en `cosecha`, usa esa carpeta.
#' Si no hay ninguna, la carpeta nueva se llama `cosecha`.
#' @noRd
default_data_dir <- function() {
  padres <- padres_datos()
  encontrada <- buscar_carpeta_existente(padres)
  if (nzchar(encontrada)) return(encontrada)
  for (padre in padres) {
    if (dir.exists(padre)) return(normalize_dir(file.path(padre, "cosecha")))
  }
  home <- Sys.getenv("USERPROFILE", unset = path.expand("~"))
  normalize_dir(file.path(home, "Documents", "cosecha"))
}

#' Obtiene la carpeta de datos configurada
#'
#' Primero mira la ruta recordada en este computador. Si todav`r "\u00ed"`a no hay,
#' usa OneDrive de Uniandes, otro OneDrive, o Documentos.
#'
#' @return Ruta absoluta a la carpeta de datos.
#' @export
data_dir <- function() {
  opt <- getOption("cosecha.data_dir", NULL)
  if (is.null(opt) || !nzchar(opt)) {
    opt <- getOption("ordenamiento.data_dir", NULL)
  }
  if (!is.null(opt) && nzchar(opt)) return(normalize_dir(opt))
  recordada <- remembered_dir()
  if (nzchar(recordada)) return(recordada)
  default_data_dir()
}

#' Fija la carpeta de datos (y la recuerda para pr`r "\u00f3"`ximas sesiones)
#'
#' @param path Ruta a la carpeta de datos.
#' @return La ruta normalizada (invisible).
#' @export
set_data_dir <- function(path) {
  path <- normalize_dir(path)
  fs::dir_create(dirname(config_path()), recurse = TRUE)
  write_utf8(path, config_path())
  options(cosecha.data_dir = path)
  invisible(path)
}

es_codigo_del_paquete <- function(path) {
  desc <- file.path(path, "DESCRIPTION")
  if (!file.exists(desc)) return(FALSE)
  lineas <- readLines(desc, warn = FALSE, n = 8, encoding = "UTF-8")
  any(grepl("^Package:\\s*(cosecha|ordenamiento)\\s*$", lineas))
}

leeme_lineas <- function() {
  c(
    "Cosecha",
    "=======",
    "",
    "Aqu\u00ed viven tus actividades del informe trienal.",
    "No borres esta carpeta: la app recuerda esta ruta y vuelve a escribir aqu\u00ed.",
    "",
    "datos/                      actividades.csv (el registro)",
    "evidencias/docencia/        archivos de docencia",
    "evidencias/investigacion/   archivos de investigaci\u00f3n",
    "evidencias/servicio/        archivos de servicio",
    "registro/                   vistas en Markdown para armar el informe",
    "informe-trienal/            borrador",
    "",
    "Volver a correr crear_carpeta() no borra nada.",
    "Solo crea lo que falte."
  )
}

#' Crea la estructura de carpetas si no existe
#'
#' Si la carpeta ya tiene datos, no los toca. Solo crea lo que falte
#' y vuelve a recordar la ruta.
#'
#' @param path Carpeta de datos. Por defecto [data_dir()].
#' @return La ruta asegurada (invisible).
#' @export
ensure_data_dir <- function(path = NULL) {
  path <- normalize_dir(path %||% data_dir())
  # Si la carpeta ya tiene el registro, se sigue usando aunque ahi tambien
  # haya una copia del codigo. Solo se bloquea una carpeta de paquete vacia,
  # para no mezclar un repo nuevo con evidencias.
  if (es_codigo_del_paquete(path) &&
      !file.exists(file.path(path, "datos", "actividades.csv"))) {
    stop(
      "Esa ruta es el c\u00f3digo del paquete y todav\u00eda no tiene actividades. ",
      "Usa crear_carpeta() sin argumentos, o p\u00e1sale una carpeta tuya ",
      "(por ejemplo en Documentos).",
      call. = FALSE
    )
  }
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
    write_utf8(header, csv)
  }

  leeme <- file.path(path, "LEEME.txt")
  if (!file.exists(leeme)) write_utf8(leeme_lineas(), leeme)

  invisible(path)
}

#' Crea la carpeta cosecha una sola vez y recuerda la ruta
#'
#' La primera vez arma docencia, investigaci`r "\u00f3"`n, servicio y evidencias.
#' Si el profesor ya ten`r "\u00ed"`a una carpeta (por ejemplo `Ordenamiento`),
#' sigue usando esa: no crea otra ni mueve los archivos.
#' Esa ruta se guarda en el computador, as`r "\u00ed"` que la pr`r "\u00f3"`xima sesi`r "\u00f3"`n de R
#' `r "\u2014"`aunque cambies de carpeta de trabajo`r "\u2014"` vuelve al mismo lugar.
#'
#' @param path Carpeta de trabajo. Si es `NULL`, usa la recordada o la
#'   ruta por defecto (OneDrive Uniandes / Documentos).
#' @return La ruta de la carpeta (invisible).
#' @export
#' @examples
#' \dontrun{
#' crear_carpeta()
#' crear_carpeta("D:/Uniandes/cosecha")
#' }
crear_carpeta <- function(path = NULL) {
  info <- preparar_carpeta(path)
  if (isTRUE(info$cambio)) {
    message(
      "A partir de ahora Cosecha usar\u00e1 esta carpeta.\n",
      "  ", info$path, "\n",
      "La anterior no se borr\u00f3:\n",
      "  ", info$anterior
    )
    if (!isTRUE(info$ya_existia)) {
      message("En esa ruta acabo de armar docencia, investigaci\u00f3n, servicio y las evidencias.")
    }
  } else if (isTRUE(info$ya_existia)) {
    message(
      "Ya ten\u00edas esta carpeta. Cosecha sigue guardando aqu\u00ed y no crea otra:\n",
      "  ", info$path
    )
    if (!identical(tolower(basename(info$path)), "cosecha")) {
      message(
        "Sigue llam\u00e1ndose ", basename(info$path),
        ": ah\u00ed ya estaban tus actividades. No se crea una carpeta cosecha vac\u00eda."
      )
    }
    message("La pr\u00f3xima vez, run_app() vuelve a esta misma ruta.")
  } else {
    message(
      "Listo. Carpeta cosecha creada en:\n",
      "  ", info$path, "\n",
      "Adentro est\u00e1n docencia, investigaci\u00f3n, servicio y las evidencias.\n",
      "Esa ruta qued\u00f3 recordada en este computador. Cerrar R no la cambia.\n",
      "Ahora abre la app con run_app()."
    )
  }
  invisible(info$path)
}

#' Arma la carpeta si falta y dice si ya ten`r "\u00ed"`a datos
#' @noRd
preparar_carpeta <- function(path = NULL) {
  anterior <- remembered_dir()
  path <- normalize_dir(path %||% data_dir())
  ya <- file.exists(file.path(path, "datos", "actividades.csv"))
  path <- ensure_data_dir(path)
  list(
    path = path,
    ya_existia = ya,
    anterior = anterior,
    cambio = nzchar(anterior) && normalize_dir(anterior) != normalize_dir(path)
  )
}

#' Abre el selector de carpetas del computador
#'
#' @param inicial Carpeta que aparece seleccionada al abrir. Si no existe,
#'   se abre su carpeta padre.
#' @return La ruta elegida, o `NULL` si se cancela.
#' @export
elegir_carpeta_dialogo <- function(inicial = NULL) {
  if (.Platform$OS.type != "windows") {
    return(elegir_carpeta_dialogo_otro(inicial))
  }

  inicial <- carpeta_inicial_dialogo(inicial)
  inicial_ps <- gsub("'", "''", inicial)
  ps1 <- tempfile(fileext = ".ps1")
  write_utf8(
    c(
      "Add-Type -AssemblyName System.Windows.Forms",
      "$d = New-Object System.Windows.Forms.FolderBrowserDialog",
      "$d.Description = 'Elige la carpeta de Cosecha'",
      "$d.ShowNewFolderButton = $true",
      sprintf("$d.SelectedPath = '%s'", inicial_ps),
      "$owner = New-Object System.Windows.Forms.Form",
      "$owner.TopMost = $true",
      "$owner.ShowInTaskbar = $false",
      "$owner.WindowState = [System.Windows.Forms.FormWindowState]::Minimized",
      "$owner.Show()",
      "$ok = $d.ShowDialog($owner)",
      "$owner.Close()",
      "if ($ok -eq [System.Windows.Forms.DialogResult]::OK) { [Console]::Out.WriteLine($d.SelectedPath) }"
    ),
    ps1
  )
  on.exit(unlink(ps1), add = TRUE)
  out <- system2(
    "powershell.exe",
    c("-STA", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", ps1),
    stdout = TRUE,
    stderr = FALSE
  )
  lineas <- str_trim_line(out)
  lineas <- lineas[nzchar(lineas)]
  if (!length(lineas)) return(NULL)
  elegido <- lineas[[length(lineas)]]
  if (!dir.exists(elegido)) return(NULL)
  normalize_dir(elegido)
}

carpeta_inicial_dialogo <- function(inicial) {
  inicial <- as.character(inicial %||% "")
  if (dir.exists(inicial)) {
    return(normalizePath(inicial, winslash = "\\", mustWork = TRUE))
  }
  padre <- if (nzchar(inicial)) dirname(inicial) else ""
  if (nzchar(padre) && dir.exists(padre)) {
    return(normalizePath(padre, winslash = "\\", mustWork = TRUE))
  }
  normalizePath("~", winslash = "\\", mustWork = FALSE)
}

elegir_carpeta_dialogo_otro <- function(inicial) {
  elegido <- NULL
  if (requireNamespace("rstudioapi", quietly = TRUE) &&
      isTRUE(rstudioapi::isAvailable())) {
    elegido <- rstudioapi::selectDirectory(
      caption = "Elige la carpeta de Cosecha",
      path = inicial %||% "~"
    )
  } else if (requireNamespace("tcltk", quietly = TRUE)) {
    elegido <- tcltk::tk_choose.dir(
      default = inicial %||% "~",
      caption = "Elige la carpeta de Cosecha"
    )
  }
  if (is.null(elegido) || length(elegido) == 0 || is.na(elegido) || !nzchar(elegido)) {
    return(NULL)
  }
  if (!dir.exists(elegido)) return(NULL)
  normalize_dir(elegido)
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
