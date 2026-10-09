# Lanza la app sin mezclar datos con el código del paquete
local({
  root <- NULL
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg)) {
    root <- dirname(normalizePath(sub("^--file=", "", file_arg[[1]])))
  }
  if (is.null(root) || !dir.exists(root)) root <- getwd()
  if (basename(root) == "app") root <- dirname(root)
  setwd(root)

  deps <- c("devtools", "pkgload", "shiny", "bslib", "DT", "readr", "dplyr", "stringr", "fs")
  faltan <- deps[!vapply(deps, requireNamespace, quietly = TRUE, FUN.VALUE = logical(1))]
  if (length(faltan)) {
    install.packages(faltan, repos = "https://cloud.r-project.org")
  }

  if (requireNamespace("pkgload", quietly = TRUE)) {
    pkgload::load_all(root, quiet = TRUE)
  } else {
    devtools::load_all(root, quiet = TRUE)
  }

  # Importante: sin data_dir = root, para no guardar evidencias dentro del repo
  cosecha::run_app()
})
