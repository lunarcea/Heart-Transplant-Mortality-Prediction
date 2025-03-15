# Heart-Transplant-Mortality-Prediction
This repository contains R code for predicting one-year mortality rates in heart transplant patients based on donor matching characteristics. The analysis explores the relationship between donor-recipient matching variables (particularly RV mass ratio) and post-transplant outcomes.
![fulldata](https://github.com/user-attachments/assets/64ce3097-c15b-443f-a8ad-d6219ca89af5)
![timeperiod](https://github.com/user-attachments/assets/7ae86d45-cebb-40fa-b224-f46e78143fea)
![lvda](https://github.com/user-attachments/assets/ffc86c19-53a2-4991-9386-83706e5be33b)
![demo](https://github.com/user-attachments/assets/4f1e95e4-0325-4d79-9925-4488a23bd4e2)
<p align="center">
  <img src="plots/rv_mass_ratio_example.png" alt="RV Mass Ratio Visualization" width="600"/>
</p>
Overview
The project analyzes a comprehensive heart transplant database to identify factors that predict one-year mortality or retransplantation. It examines various subgroups including:

LVAD vs. non-LVAD patients
Transplants before and after 2006
Different gender combinations between donors and recipients
Repository Structure

data_preprocessing.R: Loads and preprocesses the raw data files
data_visualization.R: Creates visualizations for exploratory data analysis
modeling.R: Implements machine learning models using H2O framework

Installation
Prerequisites

R (version ≥ 4.0.0)
RStudio (recommended)

Setup

1. Clone this repository:
   git clone https://github.com/yourusername/heart-transplant-mortality-prediction.git
cd heart-transplant-mortality-prediction

2. Install required packages:
  install.packages(c("dplyr", "readr", "tidyr", "ggplot2", "gridExtra", "h2o"))

Usage
Command Line

1. Run data processing:
   Rscript data_preprocessing.R
2. Generate Visualizations:
   Rscript data_visualization.R
3. Train and evaluate models:
   Rscript modeling.R
RStudio
You can also run each script directly in RStudio:

Open the project in RStudio
Open each script file
Click "Source" or use the keyboard shortcut (Ctrl+Shift+S / Cmd+Shift+S)

Example Output
After running the scripts, you'll find:

Processed data files in the data/ directory
Visualizations in the plots/ directory
Model files and comparison metrics in the models/ directory

Key Features

Data Preprocessing: Filtering relevant columns and calculating donor-recipient ratios
Visualization: Boxplots showing RV mass ratio differences between outcome groups
Modeling: Multiple machine learning approaches including:

Generalized Linear Models (GLM)
Gradient Boosting Machines (GBM)
Random Forests
XGBoost
Deep Learning models
Stacked ensembles



Results
The models evaluate the impact of various factors on heart transplant outcomes, with particular focus on:

RV mass donor-recipient ratio
LVAD support status
Transplant era (before vs. after 2006)
Gender matching between donors and recipients

Performance metrics including AUC (Area Under ROC Curve) are used to evaluate model performance.
Analysis Workflow

Data Processing: The original Python code processed multiple datasets representing different patient subgroups. The R implementation maintains this structure while improving code organization and reusability.
Exploratory Analysis: Boxplots visualize the relationship between RV mass ratio and mortality outcomes across different patient groups.
Machine Learning: Multiple models are trained and compared, with performance metrics captured for future reference.

Notes on Code Conversion
This codebase was converted from Python to R while improving:

Code organization and modularity
Consistent variable naming
Comprehensive documentation
Error handling
Output organization (data, plots, and models in separate directories)

Contributing
Contributions, bug reports, and feature requests are welcome! Please feel free to submit a pull request or open an issue.

Fork the repository
Create your feature branch (git checkout -b feature/amazing-feature)
Commit your changes (git commit -m 'Add some amazing feature')
Push to the branch (git push origin feature/amazing-feature)
Open a Pull Request

License
This project is licensed under the MIT License - see the LICENSE file for details.



