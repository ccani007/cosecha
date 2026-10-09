# Launcher para Play (Cursor / Posit Shiny / RStudio).
# No escribe datos aquí: usa la carpeta personal configurada por el paquete.

pkg_root <- normalizePath("..", winslash = "/", mustWork = FALSE)
if (file.exists(file.path(pkg_root, "DESCRIPTION")) &&
    requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all(pkg_root, quiet = TRUE)
} else {
  library(ordenamiento)
}

ordenamiento::ordenamiento_app()
