# Leer un conjunto de rásters de temperatura superficial en Kelvin
# Convertir unidades multiplicando por factor 0.02 y luego convertir a Celcius 
# Visualizar rásters de temperaturas por mes


# Cargar librerías --------------------------------------------------------
library(raster)
library(tidyverse)
library(sf)


# Hacer raster stack y cáculos --------------------------------------------

l <- list.files("data/raster/", full.names = T)
lst <- stack(l)
lst <- (lst * 0.02) - 273.15

# Leer comunas ------------------------------------------------------------

provincias <- st_read("data/provincias/provincias.shp") %>% 
  filter(NOM_DEP == "Potosi") %>% 
  st_transform(crs = crs(lst))


lst_mask <- crop(mask(lst, provincias), provincias)


# Gráfico Rápido ----------------------------------------------------------

plot(lst_mask)


# Gráfico con ggplot2 -----------------------------------------------------

lst_mask_tb <- data.frame(rasterToPoints(lst_mask))
lst_mask_tbl <- lst_mask_tb %>%
  pivot_longer(
    cols = -c(1, 2),
    names_to = "mes",
    values_to = "temp",
    names_prefix = "lst_"
  ) %>% 
  mutate(mes = factor(as.numeric(mes), levels = 1:12, labels = locale("es")$date_names$mon))

p <- ggplot() +
  geom_raster(data = lst_mask_tbl, mapping = aes(x = x, y = y, fill = temp)) +
  facet_wrap( ~ mes) +
  scale_fill_distiller(palette = "RdYlBu")
p +  theme_dark()
