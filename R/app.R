.ordenamiento_columnas <- c(
  "id", "rama", "fecha", "actividad", "rol_alcance", "estado",
  "evidencia", "para_informe", "notas", "creado_en"
)

.ordenamiento_ramas <- c("docencia", "investigacion", "servicio")

.ordenamiento_prefijo <- c(docencia = "D", investigacion = "I", servicio = "S")

.ordenamiento_estados <- c(
  "", "Idea", "En preparación", "Enviado", "En revisión",
  "Aceptado", "Publicado", "En curso", "Cerrado"
)

leer_actividades <- function(root_dir) {
  csv <- file.path(root_dir, "datos", "actividades.csv")
  df <- readr::read_csv(
    csv,
    show_col_types = FALSE,
    col_types = readr::cols(.default = readr::col_character())
  )
  faltan <- setdiff(.ordenamiento_columnas, names(df))
  for (c in faltan) df[[c]] <- NA_character_
  df[, .ordenamiento_columnas]
}

guardar_actividades <- function(df, root_dir) {
  csv <- file.path(root_dir, "datos", "actividades.csv")
  tmp <- file.path(
    dirname(csv),
    paste0(".actividades-", Sys.getpid(), ".tmp.csv")
  )
  readr::write_csv(df[, .ordenamiento_columnas], tmp, na = "")
  ok <- FALSE
  ultimo_error <- NULL
  for (i in 1:10) {
    ok <- tryCatch({
      file.copy(tmp, csv, overwrite = TRUE)
      TRUE
    }, error = function(e) {
      ultimo_error <<- conditionMessage(e)
      FALSE
    })
    if (isTRUE(ok) && file.exists(csv)) break
    Sys.sleep(0.35)
  }
  unlink(tmp)
  if (!isTRUE(ok)) {
    stop(
      "No se pudo escribir datos/actividades.csv (archivo bloqueado). ",
      "Ciérralo si está abierto en Excel/Cursor e intenta de nuevo. ",
      ultimo_error %||% "",
      call. = FALSE
    )
  }
  invisible(csv)
}

siguiente_id <- function(df, rama) {
  pref <- .ordenamiento_prefijo[[rama]]
  ids <- df$id
  propios <- ids[!is.na(ids) & grepl(paste0("^", pref, "-\\d+$"), ids)]
  if (length(propios) == 0) return(sprintf("%s-001", pref))
  nums <- as.integer(sub(paste0("^", pref, "-"), "", propios))
  sprintf("%s-%03d", pref, max(nums, na.rm = TRUE) + 1L)
}

enlace_evidencia <- function(ev, rama) {
  ev <- as.character(ev %||% "")
  if (!nzchar(ev)) return("")
  if (grepl("^https?://", ev)) return(sprintf("[enlace](%s)", ev))
  sprintf("[%s](../evidencias/%s/%s)", ev, rama, ev)
}

escribir_markdown_rama <- function(df, rama, root_dir) {
  sub <- df[which(df$rama == rama), , drop = FALSE]
  if (nrow(sub) > 0) {
    o <- order(sub$fecha, sub$id, decreasing = TRUE, na.last = TRUE)
    sub <- sub[o, , drop = FALSE]
  }

  titulo <- switch(
    rama,
    docencia = "Docencia",
    investigacion = "Investigación",
    servicio = "Servicio"
  )

  lineas <- c(
    paste0("# Registro — ", titulo),
    "",
    "_Generado automáticamente desde `datos/actividades.csv` (paquete ordenamiento). No editar a mano._",
    ""
  )

  if (nrow(sub) == 0) {
    lineas <- c(lineas, "_Sin actividades registradas aún._", "")
  } else if (identical(rama, "investigacion")) {
    lineas <- c(
      lineas,
      "| ID | Fecha | Producto / actividad | Estado | Rol / alcance | Evidencia | Para el informe | Notas |",
      "|----|-------|----------------------|--------|---------------|-----------|-----------------|-------|"
    )
    for (i in seq_len(nrow(sub))) {
      r <- sub[i, ]
      lineas <- c(lineas, sprintf(
        "| %s | %s | %s | %s | %s | %s | %s | %s |",
        celda_md(r$id), celda_md(r$fecha), celda_md(r$actividad), celda_md(r$estado),
        celda_md(r$rol_alcance), enlace_evidencia(r$evidencia, rama),
        celda_md(r$para_informe), celda_md(r$notas)
      ))
    }
    lineas <- c(lineas, "")
  } else {
    lineas <- c(
      lineas,
      "| ID | Fecha | Actividad | Rol / alcance | Evidencia | Para el informe | Notas |",
      "|----|-------|-----------|---------------|-----------|-----------------|-------|"
    )
    for (i in seq_len(nrow(sub))) {
      r <- sub[i, ]
      lineas <- c(lineas, sprintf(
        "| %s | %s | %s | %s | %s | %s | %s |",
        celda_md(r$id), celda_md(r$fecha), celda_md(r$actividad), celda_md(r$rol_alcance),
        enlace_evidencia(r$evidencia, rama), celda_md(r$para_informe), celda_md(r$notas)
      ))
    }
    lineas <- c(lineas, "")
  }

  writeLines(
    lineas,
    file.path(root_dir, "registro", paste0(rama, ".md")),
    useBytes = TRUE
  )
}

sincronizar_markdown <- function(df, root_dir) {
  for (r in .ordenamiento_ramas) escribir_markdown_rama(df, r, root_dir)
}

#' Objeto Shiny de la app de registro
#'
#' @param root_dir Carpeta Ordenamiento. Por defecto [ensure_data_dir()].
#' @return Un objeto `shiny.appobj`.
#' @export
ordenamiento_app <- function(root_dir = NULL) {
  root_dir <- ensure_data_dir(root_dir)
  evidencias_dir <- file.path(root_dir, "evidencias")

  ui <- bslib::page_sidebar(
    title = "Registro trienal — Uniandes",
    theme = bslib::bs_theme(version = 5, bootswatch = "flatly"),
    sidebar = bslib::sidebar(
      title = "Nueva actividad",
      width = 360,
      shiny::selectInput("rama", "Rama", choices = c(
        "Docencia" = "docencia",
        "Investigación" = "investigacion",
        "Servicio" = "servicio"
      )),
      shiny::dateInput("fecha", "Fecha", value = Sys.Date(), format = "yyyy-mm-dd"),
      shiny::textAreaInput("actividad", "Actividad / producto", rows = 3,
                           placeholder = "Ej. Curso Algoritmos 2026-1"),
      shiny::textInput("rol", "Rol / alcance", placeholder = "Profesor, PI, Miembro, …"),
      shiny::conditionalPanel(
        condition = "input.rama == 'investigacion'",
        shiny::selectInput("estado", "Estado", choices = .ordenamiento_estados)
      ),
      shiny::textAreaInput("para_informe", "Para el informe", rows = 2,
                           placeholder = "Por qué importa en el trienio"),
      shiny::textAreaInput("notas", "Notas", rows = 2),
      shiny::fileInput("archivo", "Evidencia (opcional)", multiple = FALSE),
      shiny::textInput("evidencia_url", "O URL de evidencia", placeholder = "https://doi.org/..."),
      shiny::actionButton("guardar", "Guardar actividad", class = "btn-primary w-100"),
      shiny::hr(),
      shiny::actionButton("sync_md", "Regenerar Markdown", class = "btn-outline-secondary w-100"),
      shiny::actionButton("abrir", "Abrir carpeta", class = "btn-outline-secondary w-100"),
      shiny::helpText(paste("Carpeta:", root_dir))
    ),
    bslib::layout_columns(
      col_widths = 12,
      bslib::card(
        bslib::card_header("Actividades registradas"),
        shiny::selectInput(
          "filtro_rama", "Filtrar rama",
          choices = c("Todas" = "todas", .ordenamiento_ramas),
          selected = "todas"
        ),
        DT::DTOutput("tabla"),
        shiny::div(
          class = "d-flex gap-2 mt-2",
          shiny::actionButton("eliminar", "Eliminar seleccionada", class = "btn-outline-danger"),
          shiny::downloadButton("descargar_csv", "Descargar CSV")
        )
      )
    )
  )

  server <- function(input, output, session) {
    datos <- shiny::reactiveVal(leer_actividades(root_dir))

    shiny::observeEvent(TRUE, {
      sincronizar_markdown(datos(), root_dir)
    }, once = TRUE)

    datos_filtrados <- shiny::reactive({
      df <- datos()
      if (!identical(input$filtro_rama, "todas")) {
        df <- df[which(df$rama == input$filtro_rama), , drop = FALSE]
      }
      if (nrow(df) > 0) {
        o <- order(df$fecha, df$id, decreasing = TRUE, na.last = TRUE)
        df <- df[o, , drop = FALSE]
      }
      df
    })

    output$tabla <- DT::renderDT({
      DT::datatable(
        datos_filtrados(),
        selection = "single",
        rownames = FALSE,
        options = list(pageLength = 15, scrollX = TRUE)
      )
    })

    shiny::observeEvent(input$guardar, {
      act <- trimws(input$actividad %||% "")
      if (!nzchar(act)) {
        shiny::showNotification("Escribe la actividad / producto.", type = "warning")
        return()
      }

      df <- datos()
      rama <- input$rama
      id <- siguiente_id(df, rama)
      fecha <- as.character(input$fecha)
      evidencia_nombre <- ""

      if (!is.null(input$archivo) && nzchar(input$archivo$datapath %||% "")) {
        ext <- tools::file_ext(input$archivo$name)
        base <- paste0(fecha, "_", slugify(act))
        evidencia_nombre <- if (nzchar(ext)) paste0(base, ".", ext) else base
        dest <- file.path(evidencias_dir, rama, evidencia_nombre)
        if (file.exists(dest)) {
          evidencia_nombre <- paste0(base, "_", id, if (nzchar(ext)) paste0(".", ext) else "")
          dest <- file.path(evidencias_dir, rama, evidencia_nombre)
        }
        ok <- file.copy(input$archivo$datapath, dest, overwrite = FALSE)
        if (!isTRUE(ok)) {
          shiny::showNotification("No se pudo copiar la evidencia.", type = "error")
          return()
        }
      } else if (nzchar(trimws(input$evidencia_url %||% ""))) {
        evidencia_nombre <- trimws(input$evidencia_url)
      }

      nueva <- data.frame(
        id = id,
        rama = rama,
        fecha = fecha,
        actividad = act,
        rol_alcance = trimws(input$rol %||% ""),
        estado = if (identical(rama, "investigacion")) input$estado %||% "" else "",
        evidencia = evidencia_nombre,
        para_informe = trimws(input$para_informe %||% ""),
        notas = trimws(input$notas %||% ""),
        creado_en = format(Sys.time(), "%Y-%m-%dT%H:%M:%S"),
        stringsAsFactors = FALSE
      )

      df2 <- rbind(df, nueva)
      tryCatch({
        guardar_actividades(df2, root_dir)
        sincronizar_markdown(df2, root_dir)
        datos(df2)
        shiny::updateTextAreaInput(session, "actividad", value = "")
        shiny::updateTextInput(session, "rol", value = "")
        shiny::updateTextAreaInput(session, "para_informe", value = "")
        shiny::updateTextAreaInput(session, "notas", value = "")
        shiny::updateTextInput(session, "evidencia_url", value = "")
        shiny::showNotification(paste("Guardada:", id), type = "message")
      }, error = function(e) {
        shiny::showNotification(conditionMessage(e), type = "error", duration = 8)
      })
    })

    shiny::observeEvent(input$eliminar, {
      sel <- input$tabla_rows_selected
      if (is.null(sel) || length(sel) == 0) {
        shiny::showNotification("Selecciona una fila en la tabla.", type = "warning")
        return()
      }
      id_borrar <- datos_filtrados()$id[sel]
      df <- datos()
      df <- df[which(df$id != id_borrar), , drop = FALSE]
      tryCatch({
        guardar_actividades(df, root_dir)
        sincronizar_markdown(df, root_dir)
        datos(df)
        shiny::showNotification(paste("Eliminada:", id_borrar), type = "message")
      }, error = function(e) {
        shiny::showNotification(conditionMessage(e), type = "error", duration = 8)
      })
    })

    shiny::observeEvent(input$sync_md, {
      sincronizar_markdown(datos(), root_dir)
      shiny::showNotification("Markdown regenerado en registro/.", type = "message")
    })

    shiny::observeEvent(input$abrir, {
      abrir_carpeta(root_dir)
    })

    output$descargar_csv <- shiny::downloadHandler(
      filename = function() paste0("actividades-", Sys.Date(), ".csv"),
      content = function(file) {
        readr::write_csv(datos(), file, na = "")
      }
    )
  }

  shiny::shinyApp(ui, server)
}
