install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
library(tidyr)


# Making Sample website traffic data
set.seed(123)  
days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
hours <- 0:23

visitor_counts <- matrix(sample(50:200, 7 * 24, replace = TRUE), ncol = 24, byrow = TRUE)
colnames(visitor_counts) <- hours
rownames(visitor_counts) <- days

# Converting matrix to a data frame
traffic_df <- as.data.frame(visitor_counts)
traffic_df$Day <- days

# Reshaping the data using pivot_longer
traffic_data <- traffic_df %>%
  pivot_longer(cols = -Day,  # Reshape all columns except "Day"
               names_to = "Hour", values_to = "Visitors")

# Converting Hour column to integer
traffic_data$Hour <- as.integer(traffic_data$Hour)

head(traffic_data)

# Creating the heatmap using ggplot2 Library

ggplot(traffic_data, aes(x = Hour, y = Day, fill = Visitors)) +
  geom_tile() + scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Website Traffic Heatmap",
       x = "Hour of Day", y = "Day of Week", fill = "Number of Visitors") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels

