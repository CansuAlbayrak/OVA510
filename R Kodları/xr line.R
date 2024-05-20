library(ggplot2)
library(dplyr)

# Calculate average XR and gün per year
exchange_avg <- nokta %>%
  group_by(Yıl) %>%
  summarise(AvgXR = mean(XR),
            Avggün = mean(gün))

# Define a vector of new values
ülke <- c("1", "3","0","0","0","0","0","1", "1", "4","8", "9", "1", "3", "2","2", "6", "10", 
          "1", "4","3", "6","0", "2", "2", "5", "3")


# Add a new column with the new values
exchange_avg$new_column <- ülke


# Plotting both lines on the same plot
ggplot(exchange_avg, aes(x = Yıl)) +
  geom_line(aes(y = AvgXR, color = "Average Exchange Rate"), size = 1.2) +
  geom_line(aes(y = Avggün, color = "Average Days"), linetype = "dashed", size = 1.2) +
  labs(x = "", y = "", title = "Yıllara Göre Ortalama Kur ve Yurtdışında Ortalama Kalınan Gün") +
  scale_color_manual(values = c("blue", "orange"), 
                     labels = c("Ortalama Kur ($)", "Ortalama Kalış"),
                     breaks = c("Average Exchange Rate", "Average Days") ,
name = NULL) +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title








