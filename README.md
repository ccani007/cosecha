# ordenamiento

Paquete R con una app Shiny para registrar actividades del **informe trienal** académico (docencia, investigación y servicio).

## Separación importante

| Carpeta | Qué es | ¿Va a Git? |
|---------|--------|------------|
| Este repo (`paquete-ordenamiento`) | Código del paquete | Sí |
| Carpeta personal `Ordenamiento` | Tus evidencias y CSV | **No** |

La app **nunca** guarda datos dentro del paquete. Escribe en una carpeta de usuario (por defecto en OneDrive/Documentos).

## Instalación

```r
# Desde GitHub (cuando publiques), por ejemplo:
# remotes::install_github("tu-usuario/ordenamiento")

# Desde esta carpeta en local:
install.packages(c("devtools", "pkgload"))
devtools::install(".")
```

## Uso

```r
library(ordenamiento)
run_app()
```

La primera vez crea (o reutiliza) la carpeta de datos, por ejemplo:

`OneDrive - Universidad de los Andes/Ordenamiento`

```r
data_dir()              # ver dónde guarda
set_data_dir("D:/ruta") # elegir otra carpeta
abrir_carpeta()         # abrir en el explorador
```

## Desarrollo

```r
pkgload::load_all()
run_app()
```

O botón **Play** en `app/app.R`.
