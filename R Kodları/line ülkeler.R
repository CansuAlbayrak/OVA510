install.packages("ggplot2")
install.packages("dplyr")
install.packages("reshape2")
library(ggplot2)
library(reshape2)
library(dplyr)


x <- line$Yaş
y1 <- c(1, 4, 4, 4, 4, 4, 4, 4, 4, 7, 11, 19, 19, 22, 24, 25, 29, 38, 39, 41, 43, 43, 43, 45, 45, 48, 49)
y2 <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4)

# Combine data into a data frame
data <- data.frame(
  Yaş = x,
  y1 = y1,
  y2 = y2
)

# Convert data to long format using melt from reshape2
data_long <- melt(data, id.vars = "Yaş", variable.name = "Line", value.name = "Value")

# Plotting with ggplot2
ggplot(data_long, aes(x = Yaş, y = Value, fill = Line)) +
  geom_area(alpha = 0.4, position = "identity") +
  geom_line(aes(color = Line), size = 1) +
  scale_fill_manual(values = c("y1" = "#CC9933", "y2" = "#669933"), 
                    labels = c("Ülke", "Kıta"),
                    breaks = c("y1", "y2"),
                    name = NULL) +
  scale_color_manual(values = c("y1" = "#CC9933", "y2" = "#669933"), 
                     labels = c("Ülke", "Kıta"),
                     breaks = c("y1", "y2"),
                     name = NULL) +
  labs(x = "Yaş", y = "Ülke ve Kıta", title = "Yaşlara Göre Toplam Gezilen Ülke ve Kıta Sayıları") +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14), # Center the plot title and adjust size
    panel.grid.major = element_blank(),
    axis.text.x = element_text(size = 10),
    legend.text = element_text(size = 12) ) +
  xlim(10, 40)  # Limit x-axis between 10 and 40

