#' Lanza la app de registro trienal
#'
#' Usa la carpeta que [crear_carpeta()] dej`r "\u00f3"` recordada. Si todav`r "\u00ed"`a no
#' existe, la crea una vez. Volver a llamarla no abre otra carpeta ni
#' borra actividades.
#'
#' @param data_dir Carpeta de trabajo. Si es `NULL`, usa la recordada o la
#'   ruta por defecto (OneDrive Uniandes / Documentos).
#' @param launch.browser Abrir el navegador autom`r "\u00e1"`ticamente.
#' @param ... Argumentos adicionales para [shiny::runApp()].
#' @return Valor de retorno de [shiny::runApp()] (normalmente no regresa
#'   hasta cerrar la app).
#' @export
#' @examples
#' \dontrun{
#' library(cosecha)
#' crear_carpeta()
#' run_app()
#' }
run_app <- function(data_dir = NULL, launch.browser = TRUE, ...) {
  # El argumento se llama data_dir, asi que aqui no se puede llamar
  # a la funcion data_dir(): quedaria tapada por el argumento.
  info <- preparar_carpeta(data_dir)
  if (isTRUE(info$cambio)) {
    message(
      "Cosecha ahora guarda en:\n  ", info$path,
      "\nLa carpeta anterior sigue en:\n  ", info$anterior
    )
  } else if (isTRUE(info$ya_existia)) {
    message(
      "Cosecha abre tu carpeta de siempre (no crea otra):\n  ", info$path
    )
    if (!identical(tolower(basename(info$path)), "cosecha")) {
      message(
        "Esa carpeta ya ten\u00eda tus datos y se llama ", basename(info$path),
        ". No se crea otra llamada cosecha."
      )
    }
  } else {
    message(
      "Primera vez: cre\u00e9 la carpeta cosecha y record\u00e9 la ruta.\n  ",
      info$path,
      "\nLa pr\u00f3xima vez, aunque cierres R, run_app() vuelve aqu\u00ed."
    )
  }
  message("Abriendo la app\u2026")
  app <- cosecha_app(root_dir = info$path)
  shiny::runApp(app, launch.browser = launch.browser, ...)
}
