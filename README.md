<h1 align="center">🌾 Cosecha</h1>
<p align="center">
  <strong>Tu informe trienal, sin afán.</strong><br>
  Docencia, investigación y servicio, guardados en tu computador a medida que van pasando.
</p>

<p align="center">
  <img alt="R 4.1 o más" src="https://img.shields.io/badge/R-%E2%89%A5%204.1-276DC3?style=flat-square&logo=r&logoColor=white">
  <img alt="Shiny" src="https://img.shields.io/badge/app-Shiny-9A3412?style=flat-square">
  <img alt="Licencia MIT" src="https://img.shields.io/badge/licencia-MIT-3F6212?style=flat-square">
</p>

Cosecha es un paquete de R con una app para profesores de la Universidad de los Andes. Cada actividad queda anotada, con su evidencia, para cuando llegue el momento de armar el informe trienal.

Los datos no viven en el paquete. Viven en una carpeta tuya.

## Cómo funciona

El video recorre la primera vez: crear la carpeta y anotar una actividad.

<video controls preload="metadata" width="100%" style="max-width: 960px;" src="instructive.mp4">
  <a href="pkgdown/assets/instructive.mp4">Ver el video</a>
</video>

| | Sector | Qué va ahí |
|---|---|---|
| 📚 | **Docencia** | Cursos, asesorías, materiales |
| 🔬 | **Investigación** | Artículos, proyectos, productos y su estado |
| 🤝 | **Servicio** | Comités, coordinación, extensión |

## Empezar

Desde esta carpeta, o cuando el repositorio ya esté publicado:

```r
install.packages("devtools")
devtools::install_github("ccani007/cosecha")

library(cosecha)
crear_carpeta()
run_app()
```

`crear_carpeta()` arma la carpeta una vez y recuerda la ruta. `run_app()` abre la app. Cerrar R no cambia esa ruta, y volver a correr las funciones no borra lo que ya guardaste.

## La carpeta

Por defecto queda en OneDrive de Uniandes o en Documentos, con este nombre:

```text
cosecha/
├── datos/actividades.csv
├── evidencias/
│   ├── docencia/
│   ├── investigacion/
│   └── servicio/
├── registro/
├── informe-trienal/borrador/
└── LEEME.txt
```

En la app, la primera pregunta es **¿Dónde está tu carpeta de Cosecha?**

- **Elegir carpeta** abre el Finder en Mac, o la ventana de Windows.
- O pegas la ruta y pulsas **Usar esta carpeta**.

Si eliges un lugar (el Escritorio, Documentos, OneDrive), ahí se crea una carpeta llamada `cosecha` y adentro van `datos/`, `evidencias/`, `registro/` e `informe-trienal/`. Si eliges una carpeta que ya se llama `cosecha`, se usa esa. Si ya tenía actividades, siguen ahí. La próxima apertura vuelve a la misma ruta.

```r
crear_carpeta("~/Desktop")             # crea ~/Desktop/cosecha
crear_carpeta("D:/Uniandes/cosecha")   # la ruta ya se llama cosecha
data_dir()                              # ver dónde guarda
abrir_carpeta()                         # abrirla en el explorador
```

## Si ya tenías carpeta

Una carpeta anterior con `datos/actividades.csv` o con `evidencias/` —aunque se llame `Ordenamiento`— se sigue usando. Cosecha no le cambia el nombre y no crea otra vacía al lado. En la app también puedes señalarla tú.

## Para desarrollar

```r
pkgload::load_all()
run_app()
```

El botón **Play** de `app/app.R` abre la misma app y usa la ruta recordada.

## Licencia

MIT. El código se puede compartir. Las evidencias de cada profesor se quedan en su computador.
