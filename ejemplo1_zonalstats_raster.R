# Leer un conjunto de rásters de temperatura superficial en Kelvin
# Convertir unidades multiplicando por factor 0.02 y luego convertir a Celcius 
# Realizar estadísticas zonales por provincia para el mes de enero


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
  filter(NOM_DEP == "La Paz") 


# Hacer estadística zonal -------------------------------------------------

max_ene <- provincias %>% 
  dplyr::select(NOM_DEP, NOM_PROV) %>% 
  mutate(ene = raster::extract(lst$lst_01, provincias["NOM_PROV"], fun=mean, na.rm=T))
  

# Hacer gráfico -----------------------------------------------------------

ggplot(max_ene) +
  geom_sf(aes(fill = ene )) +
  geom_sf_text(aes(label = NOM_PROV), size=3, colour= "grey22")+
  scale_fill_viridis_c(option = "C")+
  scale_x_continuous(expand = c(0.2, 0))

