# Heart Transplant Mortality Prediction - Data Visualization
# This script creates visualizations for exploratory data analysis

# Required libraries
library(ggplot2)
library(gridExtra)
library(dplyr)

# Load preprocessed data
load("data/preprocessed_data.RData")

# Create directory for plots
dir.create("plots", showWarnings = FALSE)

# Function to create boxplot
create_boxplot <- function(data, title = "", x_lab = "", y_lab = "") {
  p <- ggplot(data, aes(x = factor(One_year_mortality_retransplant), y = RV_mass_DR_Ratio)) +
    geom_boxplot() +
    labs(title = title, x = x_lab, y = y_lab) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  return(p)
}

# Full Data
p_full <- create_boxplot(
  data, 
  title = "Full Data",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

# Save the plot
ggsave("plots/full_data_boxplot.png", p_full, width = 10, height = 8)

# LVAD Support
p_lvad_0 <- create_boxplot(
  data_LVAD_0, 
  title = "Without LVAD",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

p_lvad_1 <- create_boxplot(
  data_LVAD_1, 
  title = "With LVAD",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

# Combine plots
p_lvad_combined <- grid.arrange(p_lvad_0, p_lvad_1, ncol = 2)

# Save the plot
ggsave("plots/lvad_comparison.png", p_lvad_combined, width = 16, height = 8)

# Time Period
p_1990 <- create_boxplot(
  data_1990, 
  title = "Transplants Before 2006",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

p_2006 <- create_boxplot(
  data_2006, 
  title = "Transplants After 2006",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

# Combine plots
p_time_combined <- grid.arrange(p_1990, p_2006, ncol = 2)

# Save the plot
ggsave("plots/time_period_comparison.png", p_time_combined, width = 16, height = 8)

# Gender Donor/Rec Combos
p_ff <- create_boxplot(
  data_female_donor_female_recipient, 
  title = "Female Donor Female Recipient",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

p_fm <- create_boxplot(
  data_female_donor_male_recipient, 
  title = "Female Donor Male Recipient",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

p_mf <- create_boxplot(
  data_male_donor_female_recipient, 
  title = "Male Donor Female Recipient",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

p_mm <- create_boxplot(
  data_male_donor_male_recipient, 
  title = "Male Donor Male Recipient",
  x_lab = "One Year Mortality/Retransplant",
  y_lab = "RV Mass Ratio"
)

# Combine plots
p_gender_combined <- grid.arrange(p_ff, p_mf, p_fm, p_mm, ncol = 2)

# Save the plot
ggsave("plots/gender_combination_comparison.png", p_gender_combined, width = 16, height = 16)

cat("Data visualization complete. Plots saved to plots/ directory\n")
