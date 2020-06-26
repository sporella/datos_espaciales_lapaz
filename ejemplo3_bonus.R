# Cargar librerías --------------------------------------------------------

library(sf)
library(tidyverse)


# Cargar datos con sf -----------------------------------------------------

tabla_reciclaje <- read_csv("data/reciclaje.csv")

reciclaje <- st_as_sf(tabla_reciclaje, coords = c("lon", "lat"), crs = 4326)


# Visualización dinámica con mapview --------------------------------------

library(mapview)
mapviewOptions(basemaps = "Stamen.Terrain")
mapview(reciclaje)
