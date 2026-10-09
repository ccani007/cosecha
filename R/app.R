.cosecha_columnas <- c(
  "id", "rama", "fecha", "actividad", "rol_alcance", "estado",
  "evidencia", "para_informe", "notas", "creado_en"
)

.cosecha_ramas <- c("docencia", "investigacion", "servicio")

.cosecha_etiquetas <- c(
  docencia = "\U0001f4da Docencia",
  investigacion = "\U0001f52c Investigaci\u00f3n",
  servicio = "\U0001f91d Servicio"
)

.cosecha_prefijo <- c(docencia = "D", investigacion = "I", servicio = "S")

.cosecha_estados <- c(
  "", "Idea", "En preparaci\u00f3n", "Enviado", "En revisi\u00f3n",
  "Aceptado", "Publicado", "En curso", "Cerrado"
)

.cosecha_css <- "
:root {
  --cosecha-ink: #292524;
  --cosecha-tierra: #9a3412;
  --cosecha-crema: #ffffff;
}
body {
  background: #ffffff !important;
  color: var(--cosecha-ink);
}
.navbar {
  background-color: #1c1917 !important;
  border: none !important;
  box-shadow: none !important;
}
.navbar .navbar-brand {
  color: #fff8f1 !important;
  font-family: Georgia, 'Palatino Linotype', Palatino, serif;
  font-size: 1.35rem;
  letter-spacing: -0.02em;
}
.marca-sub {
  margin-left: 0.55rem;
  font-family: 'Segoe UI', sans-serif;
  font-size: 0.92rem;
  font-weight: 500;
  opacity: 0.72;
}
.bslib-sidebar-layout > .sidebar {
  background: rgba(255, 255, 255, 0.78) !important;
  border-right: 1px solid rgba(28, 25, 23, 0.08) !important;
}
.lado-intro h2 {
  font-family: Georgia, 'Palatino Linotype', serif;
  font-size: 1.35rem;
  margin: 0 0 0.2rem;
}
.lado-intro p {
  color: #57534e;
  font-size: 0.92rem;
  margin-bottom: 0.4rem;
}
.form-control, .form-select {
  border-radius: 12px !important;
  border-color: #e7e5e4 !important;
}
.form-control:focus, .form-select:focus {
  border-color: #c2410c !important;
  box-shadow: 0 0 0 0.2rem rgba(194, 65, 12, 0.15) !important;
}
.btn-guardar {
  background: #3f6212 !important;
  border: 1px solid #3f6212 !important;
  color: #fff !important;
  font-weight: 700 !important;
  padding: 0.72rem 1rem !important;
  border-radius: 999px !important;
  box-shadow: none !important;
}
.btn-guardar:hover, .btn-guardar:focus {
  background: #365314 !important;
  border-color: #365314 !important;
  color: #fff !important;
}
.btn-suave, a.btn-suave {
  background: #fff !important;
  color: #44403c !important;
  border: 1px solid #d6d3d1 !important;
  border-radius: 999px !important;
  font-weight: 600 !important;
  box-shadow: none !important;
}
.btn-suave:hover, .btn-suave:focus, a.btn-suave:hover, a.btn-suave:focus {
  background: #fff7ed !important;
  border-color: #fdba74 !important;
  color: #9a3412 !important;
}
.btn-peligro {
  background: #fff !important;
  color: #9f1239 !important;
  border: 1px solid #fecdd3 !important;
  border-radius: 999px !important;
  font-weight: 600 !important;
}
.btn-peligro:hover, .btn-peligro:focus {
  background: #fff1f2 !important;
  border-color: #fda4af !important;
  color: #9f1239 !important;
}
.ruta-fija {
  margin-top: 0.3rem;
  padding: 0.85rem 0.9rem;
  background: #fff7ed;
  border: 1px solid #fed7aa;
  border-radius: 14px;
}
.ruta-titulo { font-weight: 700; font-size: 0.85rem; }
.ruta-path {
  display: block;
  margin-top: 0.35rem;
  white-space: normal;
  word-break: break-word;
  color: #9a3412;
  background: transparent;
  font-size: 0.78rem;
}
.ruta-nota {
  margin: 0.45rem 0 0;
  color: #78716c;
  font-size: 0.78rem;
  line-height: 1.35;
}
.panel-principal {
  display: flex;
  flex-direction: column;
  gap: 0.9rem;
  padding-bottom: 1.4rem;
}
.banner {
  border-radius: 16px;
  padding: 0.9rem 1.1rem;
  animation: cosecha-pop 0.35s ease;
}
.banner-ok {
  background: #ecfccb;
  color: #365314;
  border: 1px solid #bef264;
}
.banner-hola {
  background: #fff7ed;
  color: #9a3412;
  border: 1px solid #fed7aa;
}
.banner-calma {
  background: #fff;
  color: #44403c;
  border: 1px solid rgba(28, 25, 23, 0.08);
}
.banner-aviso {
  background: #fff1f2;
  color: #9f1239;
  border: 1px solid #fecdd3;
}
.banner-titulo { font-weight: 700; }
.banner-detalle {
  margin-top: 0.2rem;
  font-weight: 500;
  opacity: 0.8;
  font-size: 0.92rem;
}
.card {
  border: none !important;
  border-radius: 18px !important;
  box-shadow: 0 10px 30px rgba(28, 25, 23, 0.06) !important;
}
.card-header .shiny-input-container { margin-bottom: 0; }
.ruta-fija .shiny-input-container { margin-bottom: 0.45rem; width: 100%; }
.ruta-fija .control-label { font-weight: 700; margin-bottom: 0.35rem; }
.bslib-value-box .shiny-text-output { display: inline; }
.bslib-value-box {
  border: none !important;
  box-shadow: 0 8px 24px rgba(28, 25, 23, 0.05) !important;
}
#confetti-layer {
  pointer-events: none;
  position: fixed;
  inset: 0;
  overflow: hidden;
  z-index: 2000;
}
.confetti-bit {
  position: absolute;
  top: -8%;
  animation: cosecha-caer 1.5s ease-in forwards;
}
@keyframes cosecha-caer {
  to { transform: translateY(108vh) rotate(220deg); opacity: 0.15; }
}
@keyframes cosecha-pop {
  from { transform: translateY(6px); opacity: 0; }
  to { transform: none; opacity: 1; }
}
"

.cosecha_js <- "
(function () {
  function celebrar() {
    var layer = document.getElementById('confetti-layer');
    if (!layer) {
      layer = document.createElement('div');
      layer.id = 'confetti-layer';
      document.body.appendChild(layer);
    }
    layer.replaceChildren();
    var bits = ['\U0001f389', '\u2728', '\U0001f33e', '\U0001f4da', '\U0001f31f', '\U0001f973', '\U0001f49b', '\U0001f52c'];
    for (var i = 0; i < 18; i++) {
      var s = document.createElement('span');
      s.className = 'confetti-bit';
      s.textContent = bits[i % bits.length];
      s.style.left = (Math.random() * 100) + '%';
      s.style.animationDelay = (Math.random() * 0.3) + 's';
      s.style.fontSize = (1.05 + Math.random() * 0.9) + 'rem';
      layer.appendChild(s);
    }
    setTimeout(function () { layer.replaceChildren(); }, 1700);
  }
  function registrar() {
    if (!window.Shiny || !Shiny.addCustomMessageHandler) return;
    if (window.__cosechaCelebrar) return;
    window.__cosechaCelebrar = true;
    Shiny.addCustomMessageHandler('cosecha-celebrar', celebrar);
  }
  document.addEventListener('shiny:connected', registrar);
  document.addEventListener('DOMContentLoaded', registrar);
  registrar();
})();
"

leer_actividades <- function(root_dir) {
  csv <- file.path(root_dir, "datos", "actividades.csv")
  df <- readr::read_csv(
    csv,
    show_col_types = FALSE,
    col_types = readr::cols(.default = readr::col_character())
  )
  faltan <- setdiff(.cosecha_columnas, names(df))
  for (c in faltan) df[[c]] <- NA_character_
  df[, .cosecha_columnas]
}

guardar_actividades <- function(df, root_dir) {
  csv <- file.path(root_dir, "datos", "actividades.csv")
  tmp <- file.path(
    dirname(csv),
    paste0(".actividades-", Sys.getpid(), ".tmp.csv")
  )
  readr::write_csv(df[, .cosecha_columnas], tmp, na = "")
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
      "Ci\u00e9rralo si est\u00e1 abierto en Excel e intenta de nuevo. ",
      ultimo_error %||% "",
      call. = FALSE
    )
  }
  invisible(csv)
}

siguiente_id <- function(df, rama) {
  pref <- .cosecha_prefijo[[rama]]
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
    investigacion = "Investigaci\u00f3n",
    servicio = "Servicio"
  )

  lineas <- c(
    paste0("# Registro \u2014 ", titulo),
    "",
    "_Generado autom\u00e1ticamente desde `datos/actividades.csv` (paquete cosecha). No editar a mano._",
    ""
  )

  if (nrow(sub) == 0) {
    lineas <- c(lineas, "_Sin actividades registradas a\u00fan._", "")
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

  write_utf8(lineas, file.path(root_dir, "registro", paste0(rama, ".md")))
}

sincronizar_markdown <- function(df, root_dir) {
  for (r in .cosecha_ramas) escribir_markdown_rama(df, r, root_dir)
}

tabla_visible <- function(df) {
  etiqueta <- unname(.cosecha_etiquetas[df$rama])
  sin_etiqueta <- is.na(etiqueta)
  if (any(sin_etiqueta)) etiqueta[sin_etiqueta] <- df$rama[sin_etiqueta]
  data.frame(
    ID = df$id,
    Sector = etiqueta,
    Fecha = df$fecha,
    Actividad = df$actividad,
    Rol = df$rol_alcance,
    Estado = df$estado,
    Evidencia = df$evidencia,
    `Para el informe` = df$para_informe,
    Notas = df$notas,
    check.names = FALSE,
    stringsAsFactors = FALSE
  )
}

texto_celda <- function(x) {
  x <- x %||% ""
  as.character(x)[[1]]
}

saludo_vacio <- function() {
  saludos <- c(
    "\U0001f331 Todav\u00eda no hay nada, y est\u00e1 bien. La primera actividad es la que m\u00e1s cuesta.",
    "\u2600\ufe0f Anota algo del semestre, aunque sea chiquito: un curso, un art\u00edculo o un comit\u00e9.",
    "\U0001f375 Con una actividad basta para empezar. El informe se arma de a poquitos."
  )
  saludos[[as.integer(format(Sys.Date(), "%j")) %% length(saludos) + 1L]]
}

caja_sector <- function(titulo, output_id, emoji, bg, fg) {
  tema <- tryCatch(
    bslib::value_box_theme(bg = bg, fg = fg),
    error = function(e) "light"
  )
  bslib::value_box(
    title = titulo,
    value = shiny::textOutput(output_id, container = shiny::span),
    showcase = shiny::span(emoji, style = "font-size: 1.8rem; line-height: 1;"),
    theme = tema,
    height = "108px"
  )
}

aviso_elegir_carpeta <- function() {
  if (identical(Sys.info()[["sysname"]], "Darwin")) {
    "Elige la carpeta en la ventana del Finder. Si no la ves, haz clic en Finder en el Dock."
  } else if (.Platform$OS.type == "windows") {
    "Elige la carpeta en la ventana de Windows. Si no la ves, m\u00edrala en la barra de tareas."
  } else {
    "Elige la carpeta en la ventana que se abri\u00f3."
  }
}

#' Objeto Shiny de la app de registro
#'
#' @param root_dir Carpeta de datos. Por defecto [ensure_data_dir()].
#' @return Un objeto `shiny.appobj`.
#' @export
cosecha_app <- function(root_dir = NULL) {
  root_dir <- ensure_data_dir(root_dir)
  version <- tryCatch(
    as.character(utils::packageVersion("cosecha")),
    error = function(e) "0.1.0"
  )

  theme <- bslib::bs_theme(
    version = 5,
    bootswatch = "litera",
    bg = "#FFFFFF",
    fg = "#292524",
    primary = "#9A3412",
    secondary = "#57534E",
    success = "#3F6212",
    danger = "#BE123C"
  )
  theme <- bslib::bs_add_rules(theme, .cosecha_css)

  ui <- bslib::page_sidebar(
    window_title = "Cosecha \u2014 informe trienal",
    lang = "es",
    title = shiny::tags$span(
      shiny::tags$span(class = "marca", "\U0001f33e Cosecha"),
      shiny::tags$span(class = "marca-sub", "tu informe trienal")
    ),
    theme = theme,
    fillable = FALSE,
    sidebar = bslib::sidebar(
      width = 380,
      open = "open",
      shiny::tags$div(
        class = "ruta-fija",
        shiny::textInput(
          "ruta_texto",
          "\u00bfD\u00f3nde est\u00e1 tu carpeta de Cosecha?",
          value = root_dir,
          width = "100%",
          placeholder = "Pega una ruta o el\u00edgela abajo"
        ),
        shiny::actionButton(
          "elegir_ruta", "\U0001f4c2 Elegir carpeta",
          class = "btn-suave w-100"
        ),
        shiny::actionButton(
          "usar_ruta", "Usar esta carpeta",
          class = "btn-guardar w-100 mt-2"
        ),
        shiny::tags$p(
          class = "ruta-nota",
          "Esa carpeta queda con docencia, investigaci\u00f3n, servicio y las evidencias. Si ya ten\u00eda actividades, no se borran."
        )
      ),
      shiny::uiOutput("intro_form"),
      shiny::selectInput("rama", "Sector", choices = c(
        "\U0001f4da Docencia" = "docencia",
        "\U0001f52c Investigaci\u00f3n" = "investigacion",
        "\U0001f91d Servicio" = "servicio"
      )),
      shiny::dateInput("fecha", "Fecha", value = Sys.Date(), format = "yyyy-mm-dd", language = "es"),
      shiny::textAreaInput(
        "actividad", "\u00bfQu\u00e9 hiciste?", rows = 3,
        placeholder = "Ej. Curso Algoritmos 2026-1, art\u00edculo, comit\u00e9\u2026"
      ),
      shiny::textInput(
        "rol", "Tu rol",
        placeholder = "Profesor, investigadora principal, miembro\u2026"
      ),
      shiny::conditionalPanel(
        condition = "input.rama == 'investigacion'",
        shiny::selectInput("estado", "Estado del producto", choices = .cosecha_estados)
      ),
      shiny::textAreaInput(
        "para_informe", "Por qu\u00e9 cuenta en el trienio", rows = 2,
        placeholder = "Una frase que luego puedas pegar en el informe"
      ),
      shiny::textAreaInput(
        "notas", "Notas para ti", rows = 2,
        placeholder = "Detalles que no quieres olvidar"
      ),
      shiny::uiOutput("archivo_ui"),
      shiny::textInput("evidencia_url", "O un enlace", placeholder = "https://doi.org/\u2026"),
      shiny::uiOutput("nota_evidencia"),
      shiny::actionButton("guardar", "Guardar actividad \U0001f389", class = "btn-guardar w-100"),
      shiny::uiOutput("cancelar_edicion_ui")
    ),
    shiny::tags$script(shiny::HTML(.cosecha_js)),
    shiny::tags$div(
      class = "panel-principal",
      bslib::layout_columns(
        col_widths = c(4, 4, 4),
        caja_sector("Docencia", "n_docencia", "\U0001f4da", "#EFF6FF", "#1E3A8A"),
        caja_sector("Investigaci\u00f3n", "n_investigacion", "\U0001f52c", "#F5F3FF", "#5B21B6"),
        caja_sector("Servicio", "n_servicio", "\U0001f91d", "#F0FDFA", "#115E59")
      ),
      shiny::uiOutput("banner"),
      bslib::card(
        bslib::card_header(
          class = "d-flex justify-content-between align-items-center flex-wrap gap-2",
          shiny::tags$span("\U0001f4d2 Lo que llevas anotado"),
          shiny::div(
            style = "min-width: 220px;",
            shiny::selectInput(
              "filtro_rama",
              label = NULL,
              choices = c(
                "Todos los sectores \u2728" = "todas",
                "\U0001f4da Docencia" = "docencia",
                "\U0001f52c Investigaci\u00f3n" = "investigacion",
                "\U0001f91d Servicio" = "servicio"
              ),
              selected = "todas",
              width = "100%"
            )
          )
        ),
        shiny::div(
          class = "d-flex gap-2 flex-wrap mb-2",
          shiny::actionButton("editar", "Editar seleccionada", class = "btn-suave"),
          shiny::actionButton("eliminar", "Quitar seleccionada", class = "btn-suave btn-peligro"),
          shiny::downloadButton("descargar_csv", "Descargar CSV", class = "btn-suave")
        ),
        shiny::tags$p(
          class = "ruta-nota mb-3",
          "Elige una fila para editarla o quitarla."
        ),
        DT::DTOutput("tabla"),
        shiny::tags$p(
          class = "ruta-nota mt-3 mb-0",
          paste0("Cosecha ", version, " \u00b7 el registro vive en datos/actividades.csv")
        )
      )
    )
  )

  server <- function(input, output, session) {
    carpeta <- shiny::reactiveVal(root_dir)
    datos <- shiny::reactiveVal(leer_actividades(root_dir))
    celebra <- shiny::reactiveVal(NULL)
    pendiente_borrar <- shiny::reactiveVal(NULL)
    archivo_token <- shiny::reactiveVal(0L)
    editando <- shiny::reactiveVal(NULL)

    salir_de_edicion <- function(reset_fecha = FALSE) {
      editando(NULL)
      shiny::updateTextAreaInput(session, "actividad", value = "")
      shiny::updateTextInput(session, "rol", value = "")
      shiny::updateTextAreaInput(session, "para_informe", value = "")
      shiny::updateTextAreaInput(session, "notas", value = "")
      shiny::updateTextInput(session, "evidencia_url", value = "")
      shiny::updateSelectInput(session, "estado", selected = "")
      if (isTRUE(reset_fecha)) {
        shiny::updateDateInput(session, "fecha", value = Sys.Date())
      }
      archivo_token(archivo_token() + 1L)
    }

    cargar_en_formulario <- function(row) {
      editando(texto_celda(row$id))
      shiny::updateSelectInput(session, "rama", selected = texto_celda(row$rama))
      fecha <- as.Date(texto_celda(row$fecha))
      if (is.na(fecha)) fecha <- Sys.Date()
      shiny::updateDateInput(session, "fecha", value = fecha)
      shiny::updateTextAreaInput(session, "actividad", value = texto_celda(row$actividad))
      shiny::updateTextInput(session, "rol", value = texto_celda(row$rol_alcance))
      estado <- texto_celda(row$estado)
      if (!estado %in% .cosecha_estados) estado <- ""
      shiny::updateSelectInput(session, "estado", selected = estado)
      shiny::updateTextAreaInput(session, "para_informe", value = texto_celda(row$para_informe))
      shiny::updateTextAreaInput(session, "notas", value = texto_celda(row$notas))
      ev <- texto_celda(row$evidencia)
      shiny::updateTextInput(
        session,
        "evidencia_url",
        value = if (grepl("^https?://", ev)) ev else ""
      )
      archivo_token(archivo_token() + 1L)
    }

    aplicar_carpeta <- function(path) {
      path <- trimws(path %||% "")
      if (!nzchar(path)) {
        shiny::showNotification("Elige o escribe la carpeta.", type = "warning")
        return(invisible(FALSE))
      }
      info <- tryCatch(preparar_carpeta(path), error = function(e) e)
      if (inherits(info, "error")) {
        shiny::showNotification(conditionMessage(info), type = "error", duration = 8)
        return(invisible(FALSE))
      }
      carpeta(info$path)
      df <- leer_actividades(info$path)
      datos(df)
      sincronizar_markdown(df, info$path)
      salir_de_edicion(reset_fecha = TRUE)
      shiny::updateTextInput(session, "ruta_texto", value = info$path)
      n <- nrow(df)
      if (isTRUE(info$ya_existia)) {
        texto <- if (n == 1) {
          "\U0001f4cc Seguimos en tu carpeta. Ya ten\u00eda 1 actividad y no se borr\u00f3 nada."
        } else if (n == 0) {
          "\U0001f4cc Seguimos en tu carpeta. No se borr\u00f3 nada."
        } else {
          sprintf("\U0001f4cc Seguimos en tu carpeta. Ya ten\u00eda %d actividades y no se borr\u00f3 nada.", n)
        }
      } else {
        texto <- "\U0001f4c1 Listo. En esa carpeta quedaron docencia, investigaci\u00f3n, servicio y las evidencias."
      }
      celebra(list(
        texto = texto,
        detalle = info$path,
        clase = if (isTRUE(info$ya_existia)) "banner-calma" else "banner-ok",
        cuando = Sys.time()
      ))
      shiny::showNotification(texto, type = "message", duration = 6)
      invisible(TRUE)
    }

    shiny::observeEvent(input$elegir_ruta, {
      shiny::showNotification(
        aviso_elegir_carpeta(),
        type = "message",
        duration = 8,
        id = "eligiendo"
      )
      elegido <- tryCatch(
        elegir_carpeta_dialogo(carpeta()),
        error = function(e) {
          shiny::showNotification(conditionMessage(e), type = "error", duration = 12)
          NULL
        }
      )
      shiny::removeNotification(id = "eligiendo")
      if (is.null(elegido)) return()
      aplicar_carpeta(elegido)
    })

    shiny::observeEvent(input$usar_ruta, {
      aplicar_carpeta(input$ruta_texto)
    })

    shiny::observeEvent(TRUE, {
      sincronizar_markdown(datos(), carpeta())
    }, once = TRUE)

    output$archivo_ui <- shiny::renderUI({
      archivo_token()
      shiny::fileInput("archivo", "\U0001f4ce Evidencia (opcional)", multiple = FALSE)
    })

    output$intro_form <- shiny::renderUI({
      id <- editando()
      if (is.null(id)) {
        shiny::tags$div(
          class = "lado-intro",
          shiny::tags$h2("Nueva actividad"),
          shiny::tags$p("Docencia, investigaci\u00f3n o servicio. Queda en la carpeta que elegiste, en tu computador.")
        )
      } else {
        shiny::tags$div(
          class = "lado-intro",
          shiny::tags$h2("Editar actividad"),
          shiny::tags$p(paste0(
            "Est\u00e1s editando ", id,
            ". El identificador se queda. Pulsa Guardar cambios cuando termines."
          ))
        )
      }
    })

    output$nota_evidencia <- shiny::renderUI({
      id <- editando()
      if (is.null(id)) return(NULL)
      df <- datos()
      i <- which(df$id == id)
      if (!length(i)) return(NULL)
      ev <- texto_celda(df$evidencia[i[[1]]])
      if (!nzchar(ev) || grepl("^https?://", ev)) return(NULL)
      shiny::tags$p(
        class = "ruta-nota",
        paste0(
          "Evidencia actual: ", ev,
          ". Si no subes otra ni pegas un enlace, se conserva. El archivo viejo no se borra."
        )
      )
    })

    output$cancelar_edicion_ui <- shiny::renderUI({
      if (is.null(editando())) return(NULL)
      shiny::actionButton(
        "cancelar_edicion",
        "Cancelar edici\u00f3n",
        class = "btn-suave w-100 mt-2"
      )
    })

    shiny::observe({
      id <- editando()
      shiny::updateActionButton(
        session,
        "guardar",
        label = if (is.null(id)) {
          "Guardar actividad \U0001f389"
        } else {
          "Guardar cambios"
        }
      )
    })

    contar <- function(rama) {
      df <- datos()
      as.character(sum(df$rama == rama, na.rm = TRUE))
    }
    output$n_docencia <- shiny::renderText(contar("docencia"))
    output$n_investigacion <- shiny::renderText(contar("investigacion"))
    output$n_servicio <- shiny::renderText(contar("servicio"))

    output$banner <- shiny::renderUI({
      msg <- celebra()
      n <- nrow(datos())
      if (!is.null(msg)) {
        return(shiny::tags$div(
          class = paste("banner", msg$clase %||% "banner-ok"),
          shiny::tags$div(class = "banner-titulo", msg$texto),
          if (nzchar(msg$detalle %||% "")) {
            shiny::tags$div(class = "banner-detalle", msg$detalle)
          }
        ))
      }
      if (n == 0) {
        return(shiny::tags$div(class = "banner banner-hola", saludo_vacio()))
      }
      texto <- if (n == 1) {
        "\U0001f4d2 Llevas 1 actividad. Ya est\u00e1 en tu carpeta, esperando el informe."
      } else {
        sprintf("\U0001f4d2 Llevas %d actividades. Todo sigue en tu carpeta.", n)
      }
      shiny::tags$div(class = "banner banner-calma", texto)
    })

    shiny::observe({
      msg <- celebra()
      if (is.null(msg)) return()
      shiny::invalidateLater(12000, session)
      if (isTRUE(difftime(Sys.time(), msg$cuando, units = "secs") >= 11)) {
        celebra(NULL)
      }
    })

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
        tabla_visible(datos_filtrados()),
        selection = "single",
        rownames = FALSE,
        options = list(
          pageLength = 8,
          scrollX = TRUE,
          language = list(
            search = "Buscar:",
            lengthMenu = "Mostrar _MENU_",
            info = "_START_ a _END_ de _TOTAL_",
            infoEmpty = "Sin actividades todav\u00eda",
            zeroRecords = "Sin actividades todav\u00eda",
            paginate = list(previous = "Anterior", `next` = "Siguiente")
          )
        )
      )
    })

    shiny::observeEvent(input$guardar, {
      act <- trimws(input$actividad %||% "")
      if (!nzchar(act)) {
        shiny::showNotification(
          "Falta la actividad. Cu\u00e9ntame qu\u00e9 hiciste, aunque sea en una frase.",
          type = "warning"
        )
        return()
      }

      df <- datos()
      id_edit <- editando()
      es_edicion <- !is.null(id_edit)
      if (es_edicion && !isTRUE(any(df$id == id_edit, na.rm = TRUE))) {
        editando(NULL)
        shiny::showNotification(
          "Esa actividad ya no est\u00e1 en la carpeta.",
          type = "warning"
        )
        return()
      }

      rama <- input$rama
      id <- if (es_edicion) id_edit else siguiente_id(df, rama)
      fecha <- as.character(input$fecha %||% Sys.Date())
      estado <- if (identical(rama, "investigacion")) texto_celda(input$estado) else ""
      prev <- if (es_edicion) texto_celda(df$evidencia[which(df$id == id)[[1]]]) else ""
      url <- trimws(input$evidencia_url %||% "")
      evidencia_nombre <- prev

      if (!is.null(input$archivo) && nzchar(input$archivo$datapath %||% "")) {
        ext <- tools::file_ext(input$archivo$name)
        base <- paste0(fecha, "_", slugify(act))
        evidencia_nombre <- if (nzchar(ext)) paste0(base, ".", ext) else base
        dest <- file.path(carpeta(), "evidencias", rama, evidencia_nombre)
        if (file.exists(dest)) {
          evidencia_nombre <- paste0(base, "_", id, if (nzchar(ext)) paste0(".", ext) else "")
          dest <- file.path(carpeta(), "evidencias", rama, evidencia_nombre)
        }
        ok <- file.copy(input$archivo$datapath, dest, overwrite = FALSE)
        if (!isTRUE(ok)) {
          shiny::showNotification(
            "No pude copiar el archivo a tu carpeta de evidencias.",
            type = "error"
          )
          return()
        }
      } else if (nzchar(url)) {
        evidencia_nombre <- url
      } else if (grepl("^https?://", prev)) {
        evidencia_nombre <- ""
      }

      rol <- trimws(input$rol %||% "")
      para_informe <- trimws(input$para_informe %||% "")
      notas <- trimws(input$notas %||% "")

      if (es_edicion) {
        i <- which(df$id == id)[[1]]
        df$rama[i] <- rama
        df$fecha[i] <- fecha
        df$actividad[i] <- act
        df$rol_alcance[i] <- rol
        df$estado[i] <- estado
        df$evidencia[i] <- evidencia_nombre
        df$para_informe[i] <- para_informe
        df$notas[i] <- notas
        df2 <- df
        texto <- paste0("Listo, actualic\u00e9 ", id, ".")
        clase <- "banner-calma"
        celebrar <- FALSE
      } else {
        nueva <- data.frame(
          id = id,
          rama = rama,
          fecha = fecha,
          actividad = act,
          rol_alcance = rol,
          estado = estado,
          evidencia = evidencia_nombre,
          para_informe = para_informe,
          notas = notas,
          creado_en = format(Sys.time(), "%Y-%m-%dT%H:%M:%S"),
          stringsAsFactors = FALSE
        )
        df2 <- rbind(df, nueva)
        texto <- mensaje_al_guardar(nrow(df2), rama)
        clase <- "banner-ok"
        celebrar <- TRUE
      }

      tryCatch({
        guardar_actividades(df2, carpeta())
        sincronizar_markdown(df2, carpeta())
        datos(df2)
        if (es_edicion) {
          salir_de_edicion(reset_fecha = TRUE)
        } else {
          archivo_token(archivo_token() + 1L)
          shiny::updateTextAreaInput(session, "actividad", value = "")
          shiny::updateTextInput(session, "rol", value = "")
          shiny::updateTextAreaInput(session, "para_informe", value = "")
          shiny::updateTextAreaInput(session, "notas", value = "")
          shiny::updateTextInput(session, "evidencia_url", value = "")
        }
        detalle <- paste(id, "\u00b7", substr(act, 1L, 80L))
        celebra(list(
          texto = texto,
          detalle = detalle,
          clase = clase,
          cuando = Sys.time()
        ))
        if (celebrar) session$sendCustomMessage("cosecha-celebrar", list())
        shiny::showNotification(texto, type = "message", duration = 6)
      }, error = function(e) {
        shiny::showNotification(conditionMessage(e), type = "error", duration = 8)
      })
    })

    shiny::observeEvent(input$editar, {
      sel <- input$tabla_rows_selected
      df <- datos_filtrados()
      if (is.null(sel) || length(sel) == 0 || sel[[1]] > nrow(df)) {
        shiny::showNotification(
          "Elige una actividad en la tabla para editarla.",
          type = "warning"
        )
        return()
      }
      cargar_en_formulario(df[sel[[1]], , drop = FALSE])
    })

    shiny::observeEvent(input$cancelar_edicion, {
      salir_de_edicion(reset_fecha = TRUE)
    })

    shiny::observeEvent(input$eliminar, {
      sel <- input$tabla_rows_selected
      if (is.null(sel) || length(sel) == 0) {
        shiny::showNotification("Selecciona una actividad en la tabla.", type = "warning")
        return()
      }
      id_borrar <- datos_filtrados()$id[sel]
      act <- datos_filtrados()$actividad[sel]
      pendiente_borrar(id_borrar)
      shiny::showModal(shiny::modalDialog(
        title = "Quitar esta actividad",
        shiny::tags$p(
          "\u00bfQuitamos ", shiny::tags$strong(id_borrar), " del registro?"
        ),
        shiny::tags$p(act),
        shiny::tags$p(
          class = "text-muted",
          "Si hab\u00eda un archivo de evidencia, se queda en la carpeta."
        ),
        footer = shiny::tagList(
          shiny::modalButton("Mejor no"),
          shiny::actionButton("confirmar_eliminar", "S\u00ed, quitar", class = "btn-peligro")
        ),
        easyClose = TRUE
      ))
    })

    shiny::observeEvent(input$confirmar_eliminar, {
      id_borrar <- pendiente_borrar()
      shiny::removeModal()
      if (is.null(id_borrar) || !nzchar(id_borrar)) return()
      df <- datos()
      df <- df[which(df$id != id_borrar), , drop = FALSE]
      tryCatch({
        guardar_actividades(df, carpeta())
        sincronizar_markdown(df, carpeta())
        datos(df)
        pendiente_borrar(NULL)
        if (identical(editando(), id_borrar)) salir_de_edicion(reset_fecha = TRUE)
        celebra(list(
          texto = paste0("Listo, quit\u00e9 ", id_borrar, ". El archivo de evidencia, si lo hab\u00eda, sigue en la carpeta."),
          detalle = "",
          clase = "banner-aviso",
          cuando = Sys.time()
        ))
      }, error = function(e) {
        shiny::showNotification(conditionMessage(e), type = "error", duration = 8)
      })
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
