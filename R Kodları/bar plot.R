
install.packages("ggplot2")
install.packages("wesanderson")
install.packages("dplyr")
install.packages("magick")
library(ggplot2)
library(dplyr)
library(wesanderson)
library(magick)

# Define continent colors
continent_colors <- c("Avrupa" = "#f9a65a", "Amerika" = "#d77fb3", 
                      "Afrika" = "#79c36a", "Asya" = "#599ad3")

# Map colors to Kıta based on the dataset
bar_plot_veri$color <- continent_colors[bar_plot_veri$Kıta]

# Arrange data by gün in descending order using dplyr's arrange function
bar_plot_veri <- dplyr::arrange(bar_plot_veri, desc(gün))

# Convert Ülke to a factor with reversed levels for descending order in the plot
bar_plot_veri$Ülke <- factor(bar_plot_veri$Ülke, levels = rev(bar_plot_veri$Ülke))

# Create the bar plot using ggplot with sorted data
ggplot(bar_plot_veri, aes(x = gün, y = Ülke, fill = Kıta)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(
    name = "Kıtalar",  
    values = continent_colors,  
    labels = c("Afrika", "Amerika", "Asya", "Avrupa")  
  ) +
  labs(x = "Gün", y = "", title = "Ülkelerde Geçirilen Süreler") +
  theme_minimal() +
  # Customize x-axis breaks and labels
  scale_x_continuous(
    breaks = seq(0, max(bar_plot_veri$gün), by = 7),  # Set breaks every 7 days
    labels = seq(0, max(bar_plot_veri$gün), by = 7)  # Set labels as multiples of 7 days
  ) +
  theme(plot.title = element_text(hjust = 0.5))# Center the plot title horizontally

