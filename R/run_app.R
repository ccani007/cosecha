#' Lanza la app de registro trienal
#'
#' La primera vez crea (o reutiliza) la carpeta Ordenamiento en el computador.
#' En cada ejecución abre la Shiny y escribe en esa misma carpeta.
#'
#' @param data_dir Carpeta de trabajo. Si es `NULL`, usa la configurada o la
#'   ruta por defecto (OneDrive Uniandes / Documentos).
#' @param launch.browser Abrir el navegador automáticamente.
#' @param ... Argumentos adicionales para [shiny::runApp()].
#' @return Valor de retorno de [shiny::runApp()] (normalmente no regresa
#'   hasta cerrar la app).
#' @export
#' @examples
#' \dontrun{
#' ordenamiento::run_app()
#' ordenamiento::run_app("D:/mi-ordenamiento")
#' }
run_app <- function(data_dir = NULL, launch.browser = TRUE, ...) {
  root <- ensure_data_dir(data_dir)
  message("Carpeta Ordenamiento: ", root)
  app <- ordenamiento_app(root_dir = root)
  shiny::runApp(app, launch.browser = launch.browser, ...)
}
