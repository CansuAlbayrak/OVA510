install.packages("sf")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("ggplot2")
install.packages("ggpattern")

library(ggplot2)
library(sf)
library(rnaturalearth)
library(dplyr)
library(ggpattern)


# Retrieve world map data
world <- ne_countries(scale = "medium", returnclass = "sf")

# Define countries of Europe
countries_of_europe <- c("United Kingdom", "Germany", "Austria", "Belgium", "Bosnia and Herzegovina", "Czechia", 
                         "Denmark", "Finland", "France", "Croatia", "Netherlands", "Spain", "Sweden", "Switzerland", 
                         "Italy", "Cyprus", "Hungary", "North Macedonia", "Malta", "Poland", "Portugal", "Romania", 
                         "Republic of Serbia", "Slovakia", "Slovenia", "Ukraine", "Greece", "Latvia", "Lithuania", "Russia")

# Filter world map data for Europe
europe <- world[world$admin %in% countries_of_europe, ]

# Create a column for nudging the y-axis and fill pattern
europe <- europe %>%
  mutate(nudge_y = case_when(
    admin == "Bosnia and Herzegovina" ~ -0.5,
    admin == "Republic of Serbia" ~ -0.1,
    TRUE ~ 0
  ),
  fill_color = case_when(
    admin == "Latvia" ~ "transparent",
    admin == "Lithuania" ~ "transparent",
    TRUE ~ "#FF6600"
  ),
  pattern = case_when(
    admin == "Latvia" ~ "stripe", 
    admin == "Lithuania" ~ "stripe",
    TRUE ~ "none"
  ))

# Plot world map and zoom into Europe
ggplot() +
  geom_sf(data = world, fill = "#d3d3d3") +
  geom_sf_pattern(data = europe, aes(fill = fill_color, pattern = pattern), 
                  pattern_density = 0.1, pattern_spacing = 0.01, pattern_fill = "#669900") + # Adjust pattern_density
  geom_sf_label(data = europe, aes(label = admin), nudge_y = europe$nudge_y, size = 2.5, color = "#663300", fontface = "bold") +
  scale_fill_identity() + 
  scale_pattern_identity() +
  theme_void() +
  coord_sf(xlim = c(-10, 40), ylim = c(35, 70))  # Adjust viewport to focus on Europe



