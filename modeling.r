# Heart Transplant Mortality Prediction - Modeling
# This script trains and evaluates predictive models

# Required libraries
library(h2o)
library(dplyr)

# Load preprocessed data
load("data/preprocessed_data.RData")

# Create directory for models
dir.create("models", showWarnings = FALSE)

# Initialize H2O cluster
h2o.init(max_mem_size = "8G")  # Adjust based on your system resources

# Function to create H2O frame and set up target variable
create_h2o_frame <- function(data, target_col = "One_year_mortality_retransplant") {
  # Convert to H2O frame
  h2o_frame <- as.h2o(data)
  
  # Define target variable and features
  h2o_frame[target_col] <- as.factor(h2o_frame[target_col])
  
  # Get feature names (all columns except target)
  features <- setdiff(colnames(h2o_frame), target_col)
  
  return(list(frame = h2o_frame, features = features, target = target_col))
}

# Function to run GLM model
run_glm <- function(h2o_data, seed_value = 1, model_id_prefix = "glm_model") {
  # Extract data components
  h2o_frame <- h2o_data$frame
  features <- h2o_data$features
  target <- h2o_data$target
  
  # Create model ID
  model_id <- paste0(model_id_prefix, "_", as.integer(Sys.time()))
  
  # Train GLM model
  glm_model <- h2o.glm(
    x = features,
    y = target,
    training_frame = h2o_frame,
    family = "binomial",
    lambda = 0,
    nfolds = 5,
    seed = seed_value,
    model_id = model_id
  )
  
  # Calculate AUC
  auc_value <- h2o.auc(glm_model, xval = TRUE)
  
  return(list(model = glm_model, auc = auc_value))
}

# Function to run AutoML
run_automl <- function(h2o_data, seed_value = 1, max_models = 10, model_id_prefix = "automl",
                       exclude_algos = c("GLM", "DeepLearning")) {
  # Extract data components
  h2o_frame <- h2o_data$frame
  features <- h2o_data$features
  target <- h2o_data$target
  
  # Create model ID
  model_id <- paste0(model_id_prefix, "_", as.integer(Sys.time()))
  
  # Run AutoML
  automl_model <- h2o.automl(
    x = features,
    y = target,
    training_frame = h2o_frame,
    max_models = max_models,
    seed = seed_value,
    nfolds = 5,
    exclude_algos = exclude_algos,
    project_name = model_id
  )
  
  # Get leaderboard
  leaderboard <- automl_model@leaderboard
  
  return(list(model = automl_model, leaderboard = leaderboard))
}

# Function to run AutoML for Deep Learning
run_automl_dl <- function(h2o_data, seed_value = 1, max_models = 10, model_id_prefix = "automl_dl") {
  # Run AutoML excluding GLM
  return(run_automl(
    h2o_data, 
    seed_value = seed_value, 
    max_models = max_models, 
    model_id_prefix = model_id_prefix,
    exclude_algos = c("GLM")
  ))
}

# Process full dataset
h2o_data_full <- create_h2o_frame(data)

# Run GLM on full dataset
glm_result_full <- run_glm(h2o_data_full, seed_value = 1, model_id_prefix = "glm_full")
print(paste("Full dataset GLM AUC:", glm_result_full$auc))

# Run AutoML on full dataset
automl_result_full <- run_automl(h2o_data_full, seed_value = 2, model_id_prefix = "automl_full")
print("Full dataset AutoML leaderboard:")
print(automl_result_full$leaderboard)

# Run AutoML for Deep Learning on full dataset
automl_dl_result_full <- run_automl_dl(h2o_data_full, seed_value = 200, model_id_prefix = "automl_dl_full")
print("Full dataset AutoML Deep Learning leaderboard:")
print(automl_dl_result_full$leaderboard)

# Process LVAD_0 dataset
h2o_data_LVAD_0 <- create_h2o_frame(data_LVAD_0)

# Run GLM on LVAD_0 dataset
glm_result_LVAD_0 <- run_glm(h2o_data_LVAD_0, seed_value = 4, model_id_prefix = "glm_LVAD_0")
print(paste("LVAD_0 dataset GLM AUC:", glm_result_LVAD_0$auc))

# Run AutoML on LVAD_0 dataset
automl_result_LVAD_0 <- run_automl(h2o_data_LVAD_0, seed_value = 5, model_id_prefix = "automl_LVAD_0")
print("LVAD_0 dataset AutoML leaderboard:")
print(automl_result_LVAD_0$leaderboard)

# Process LVAD_1 dataset
h2o_data_LVAD_1 <- create_h2o_frame(data_LVAD_1)

# Run GLM on LVAD_1 dataset
glm_result_LVAD_1 <- run_glm(h2o_data_LVAD_1, seed_value = 6, model_id_prefix = "glm_LVAD_1")
print(paste("LVAD_1 dataset GLM AUC:", glm_result_LVAD_1$auc))

# Run AutoML on LVAD_1 dataset
automl_result_LVAD_1 <- run_automl(h2o_data_LVAD_1, seed_value = 7, model_id_prefix = "automl_LVAD_1")
print("LVAD_1 dataset AutoML leaderboard:")
print(automl_result_LVAD_1$leaderboard)

# Process pre-2006 dataset
h2o_data_1990 <- create_h2o_frame(data_1990)

# Run GLM on pre-2006 dataset
glm_result_1990 <- run_glm(h2o_data_1990, seed_value = 8, model_id_prefix = "glm_1990")
print(paste("Pre-2006 dataset GLM AUC:", glm_result_1990$auc))

# Run AutoML on pre-2006 dataset
automl_result_1990 <- run_automl(h2o_data_1990, seed_value = 9, model_id_prefix = "automl_1990")
print("Pre-2006 dataset AutoML leaderboard:")
print(automl_result_1990$leaderboard)

# Process post-2006 dataset
h2o_data_2006 <- create_h2o_frame(data_2006)

# Run GLM on post-2006 dataset
glm_result_2006 <- run_glm(h2o_data_2006, seed_value = 10, model_id_prefix = "glm_2006")
print(paste("Post-2006 dataset GLM AUC:", glm_result_2006$auc))

# Run AutoML on post-2006 dataset
automl_result_2006 <- run_automl(h2o_data_2006, seed_value = 11, model_id_prefix = "automl_2006")
print("Post-2006 dataset AutoML leaderboard:")
print(automl_result_2006$leaderboard)

# Gender-specific models (one example shown, repeat for other combinations)
h2o_data_ff <- create_h2o_frame(data_female_donor_female_recipient)
glm_result_ff <- run_glm(h2o_data_ff, seed_value = 12, model_id_prefix = "glm_ff")
print(paste("Female-Female dataset GLM AUC:", glm_result_ff$auc))

# Save important models
h2o.saveModel(glm_result_full$model, path = "models")
h2o.saveModel(automl_result_full$model@leader, path = "models")

# Create model comparison table
model_comparison <- data.frame(
  Dataset = c("Full", "Without LVAD", "With LVAD", "Pre-2006", "Post-2006", "Female-Female"),
  GLM_AUC = c(
    glm_result_full$auc,
    glm_result_LVAD_0$auc,
    glm_result_LVAD_1$auc,
    glm_result_1990$auc,
    glm_result_2006$auc,
    glm_result_ff$auc
  ),
  Best_Model = c(
    as.character(automl_result_full$leaderboard[1, "model_id"]),
    as.character(automl_result_LVAD_0$leaderboard[1, "model_id"]),
    as.character(automl_result_LVAD_1$leaderboard[1, "model_id"]),
    as.character(automl_result_1990$leaderboard[1, "model_id"]),
    as.character(automl_result_2006$leaderboard[1, "model_id"]),
    NA
  ),
  Best_Model_AUC = c(
    automl_result_full$leaderboard[1, "auc"],
    automl_result_LVAD_0$leaderboard[1, "auc"],
    automl_result_LVAD_1$leaderboard[1, "auc"],
    automl_result_1990$leaderboard[1, "auc"],
    automl_result_2006$leaderboard[1, "auc"],
    NA
  )
)

# Save model comparison
write.csv(model_comparison, "models/model_comparison.csv", row.names = FALSE)

# Shutdown H2O cluster
h2o.shutdown(prompt = FALSE)

cat("Modeling complete. Models saved to models/ directory\n")
