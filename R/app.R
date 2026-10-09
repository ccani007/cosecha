.cosecha_columnas <- c(
  "id", "rama", "fecha", "actividad", "rol_alcance", "estado",
  "evidencia", "para_informe", "notas", "creado_en"
)

.cosecha_ramas <- c("docencia", "investigacion", "servicio")

.cosecha_etiquetas <- c(
  docencia = "📚 Docencia",
  investigacion = "🔬 Investigación",
  servicio = "🤝 Servicio"
)

.cosecha_prefijo <- c(docencia = "D", investigacion = "I", servicio = "S")

.cosecha_estados <- c(
  "", "Idea", "En preparación", "Enviado", "En revisión",
  "Aceptado", "Publicado", "En curso", "Cerrado"
)

.cosecha_css <- "
:root {
  --cosecha-ink: #292524;
  --cosecha-tierra: #9a3412;
  --cosecha-crema: #fff8f1;
}
body {
  background:
    radial-gradient(1100px 420px at 100% -10%, rgba(245, 193, 108, 0.45), transparent 55%),
    radial-gradient(800px 380px at -10% 0%, rgba(154, 52, 18, 0.08), transparent 50%),
    var(--cosecha-crema) !important;
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
  background: #9a3412 !important;
  border: none !important;
  color: #fff !important;
  font-weight: 700 !important;
  padding: 0.72rem 1rem !important;
  border-radius: 999px !important;
  box-shadow: 0 8px 20px rgba(154, 52, 18, 0.22);
}
.btn-guardar:hover { background: #7c2d12 !important; color: #fff !important; }
.btn-suave { border-radius: 999px !important; }
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
    var bits = ['🎉', '✨', '🌾', '📚', '🌟', '🥳', '💛', '🔬'];
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
      "Ciérralo si está abierto en Excel e intenta de nuevo. ",
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
    investigacion = "Investigación",
    servicio = "Servicio"
  )

  lineas <- c(
    paste0("# Registro — ", titulo),
    "",
    "_Generado automáticamente desde `datos/actividades.csv` (paquete cosecha). No editar a mano._",
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

saludo_vacio <- function() {
  saludos <- c(
    "🌱 Todavía no hay nada, y está bien. La primera actividad es la que más cuesta.",
    "☀️ Anota algo del semestre, aunque sea chiquito: un curso, un artículo o un comité.",
    "🍵 Con una actividad basta para empezar. El informe se arma de a poquitos."
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
    bg = "#FFF8F1",
    fg = "#292524",
    primary = "#9A3412",
    secondary = "#57534E",
    success = "#3F6212",
    danger = "#BE123C"
  )
  theme <- bslib::bs_add_rules(theme, .cosecha_css)

  ui <- bslib::page_sidebar(
    window_title = "Cosecha — informe trienal",
    lang = "es",
    title = shiny::tags$span(
      shiny::tags$span(class = "marca", "🌾 Cosecha"),
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
          "¿Dónde está tu carpeta de Cosecha?",
          value = root_dir,
          width = "100%",
          placeholder = "Pega una ruta o elígela abajo"
        ),
        shiny::actionButton(
          "elegir_ruta", "📂 Elegir carpeta",
          class = "btn-outline-secondary btn-suave w-100"
        ),
        shiny::actionButton(
          "usar_ruta", "Usar esta carpeta",
          class = "btn-guardar w-100 mt-2"
        ),
        shiny::tags$p(
          class = "ruta-nota",
          "Esa carpeta queda con docencia, investigación, servicio y las evidencias. Si ya tenía actividades, no se borran."
        )
      ),
      shiny::tags$div(
        class = "lado-intro",
        shiny::tags$h2("Nueva actividad"),
        shiny::tags$p("Docencia, investigación o servicio. Queda en la carpeta que elegiste, en tu computador.")
      ),
      shiny::selectInput("rama", "Sector", choices = c(
        "📚 Docencia" = "docencia",
        "🔬 Investigación" = "investigacion",
        "🤝 Servicio" = "servicio"
      )),
      shiny::dateInput("fecha", "Fecha", value = Sys.Date(), format = "yyyy-mm-dd", language = "es"),
      shiny::textAreaInput(
        "actividad", "¿Qué hiciste?", rows = 3,
        placeholder = "Ej. Curso Algoritmos 2026-1, artículo, comité…"
      ),
      shiny::textInput(
        "rol", "Tu rol",
        placeholder = "Profesor, investigadora principal, miembro…"
      ),
      shiny::conditionalPanel(
        condition = "input.rama == 'investigacion'",
        shiny::selectInput("estado", "Estado del producto", choices = .cosecha_estados)
      ),
      shiny::textAreaInput(
        "para_informe", "Por qué cuenta en el trienio", rows = 2,
        placeholder = "Una frase que luego puedas pegar en el informe"
      ),
      shiny::textAreaInput(
        "notas", "Notas para ti", rows = 2,
        placeholder = "Detalles que no quieres olvidar"
      ),
      shiny::uiOutput("archivo_ui"),
      shiny::textInput("evidencia_url", "O un enlace", placeholder = "https://doi.org/…"),
      shiny::actionButton("guardar", "Guardar actividad 🎉", class = "btn-guardar w-100"),
      shiny::div(
        class = "d-flex gap-2 mt-2",
        shiny::actionButton("sync_md", "📝 Vistas", class = "btn-outline-secondary btn-suave flex-fill"),
        shiny::actionButton("abrir", "📂 Carpeta", class = "btn-outline-secondary btn-suave flex-fill")
      )
    ),
    shiny::tags$script(shiny::HTML(.cosecha_js)),
    shiny::tags$div(
      class = "panel-principal",
      bslib::layout_columns(
        col_widths = c(4, 4, 4),
        caja_sector("Docencia", "n_docencia", "📚", "#EFF6FF", "#1E3A8A"),
        caja_sector("Investigación", "n_investigacion", "🔬", "#F5F3FF", "#5B21B6"),
        caja_sector("Servicio", "n_servicio", "🤝", "#F0FDFA", "#115E59")
      ),
      shiny::uiOutput("banner"),
      bslib::card(
        bslib::card_header(
          class = "d-flex justify-content-between align-items-center flex-wrap gap-2",
          shiny::tags$span("📒 Lo que llevas anotado"),
          shiny::div(
            style = "min-width: 220px;",
            shiny::selectInput(
              "filtro_rama",
              label = NULL,
              choices = c(
                "Todos los sectores ✨" = "todas",
                "📚 Docencia" = "docencia",
                "🔬 Investigación" = "investigacion",
                "🤝 Servicio" = "servicio"
              ),
              selected = "todas",
              width = "100%"
            )
          )
        ),
        DT::DTOutput("tabla"),
        shiny::div(
          class = "d-flex gap-2 mt-3 flex-wrap",
          shiny::actionButton("eliminar", "Quitar seleccionada", class = "btn-outline-danger btn-suave"),
          shiny::downloadButton("descargar_csv", "Descargar CSV", class = "btn-suave")
        ),
        shiny::tags$p(
          class = "ruta-nota mt-3 mb-0",
          paste0("Cosecha ", version, " · el registro vive en datos/actividades.csv")
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
      shiny::updateTextInput(session, "ruta_texto", value = info$path)
      n <- nrow(df)
      if (isTRUE(info$ya_existia)) {
        texto <- if (n == 1) {
          "📌 Seguimos en tu carpeta. Ya tenía 1 actividad y no se borró nada."
        } else if (n == 0) {
          "📌 Seguimos en tu carpeta. No se borró nada."
        } else {
          sprintf("📌 Seguimos en tu carpeta. Ya tenía %d actividades y no se borró nada.", n)
        }
      } else {
        texto <- "📁 Listo. En esa carpeta quedaron docencia, investigación, servicio y las evidencias."
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
        "Elige la carpeta en la ventana de Windows. Si no la ves, mírala en la barra de tareas.",
        type = "message",
        duration = 8,
        id = "eligiendo"
      )
      elegido <- elegir_carpeta_dialogo(carpeta())
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
      shiny::fileInput("archivo", "📎 Evidencia (opcional)", multiple = FALSE)
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
        "📒 Llevas 1 actividad. Ya está en tu carpeta, esperando el informe."
      } else {
        sprintf("📒 Llevas %d actividades. Todo sigue en tu carpeta.", n)
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
            infoEmpty = "Sin actividades todavía",
            zeroRecords = "Sin actividades todavía",
            paginate = list(previous = "Anterior", `next` = "Siguiente")
          )
        )
      )
    })

    shiny::observeEvent(input$guardar, {
      act <- trimws(input$actividad %||% "")
      if (!nzchar(act)) {
        shiny::showNotification(
          "Falta la actividad. Cuéntame qué hiciste, aunque sea en una frase.",
          type = "warning"
        )
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
        guardar_actividades(df2, carpeta())
        sincronizar_markdown(df2, carpeta())
        datos(df2)
        archivo_token(archivo_token() + 1L)
        shiny::updateTextAreaInput(session, "actividad", value = "")
        shiny::updateTextInput(session, "rol", value = "")
        shiny::updateTextAreaInput(session, "para_informe", value = "")
        shiny::updateTextAreaInput(session, "notas", value = "")
        shiny::updateTextInput(session, "evidencia_url", value = "")
        texto <- mensaje_al_guardar(nrow(df2), rama)
        detalle <- paste(id, "·", substr(act, 1L, 80L))
        celebra(list(
          texto = texto,
          detalle = detalle,
          clase = "banner-ok",
          cuando = Sys.time()
        ))
        session$sendCustomMessage("cosecha-celebrar", list())
        shiny::showNotification(texto, type = "message", duration = 6)
      }, error = function(e) {
        shiny::showNotification(conditionMessage(e), type = "error", duration = 8)
      })
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
          "¿Quitamos ", shiny::tags$strong(id_borrar), " del registro?"
        ),
        shiny::tags$p(act),
        shiny::tags$p(
          class = "text-muted",
          "Si había un archivo de evidencia, se queda en la carpeta."
        ),
        footer = shiny::tagList(
          shiny::modalButton("Mejor no"),
          shiny::actionButton("confirmar_eliminar", "Sí, quitar", class = "btn-danger")
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
        celebra(list(
          texto = paste0("Listo, quité ", id_borrar, ". El archivo de evidencia, si lo había, sigue en la carpeta."),
          detalle = "",
          clase = "banner-aviso",
          cuando = Sys.time()
        ))
      }, error = function(e) {
        shiny::showNotification(conditionMessage(e), type = "error", duration = 8)
      })
    })

    shiny::observeEvent(input$sync_md, {
      sincronizar_markdown(datos(), carpeta())
      celebra(list(
        texto = "📝 Actualicé las vistas en registro/. Sirven de borrador para el informe.",
        detalle = "",
        clase = "banner-calma",
        cuando = Sys.time()
      ))
    })

    shiny::observeEvent(input$abrir, {
      abrir_carpeta(carpeta())
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
