# Heart Transplant Mortality Prediction - Data Preprocessing
# This script loads and preprocesses heart transplant datasets

# Required libraries
library(dplyr)
library(readr)
library(tidyr)

# Function to load and preprocess data
preprocess_data <- function(filepath, columns_to_remove = NULL) {
  # Read in data
  data <- read_csv(filepath)
  
  # Remove specified columns if provided
  if (!is.null(columns_to_remove)) {
    data <- data %>% select(-all_of(columns_to_remove))
  }
  
  # Create RV mass donor-recipient ratio
  data <- data %>%
    mutate(
      RV_mass_donor = as.numeric(RV_mass_donor),
      RV_mass_recipient = as.numeric(RV_mass_recipient),
      RV_mass_DR_Ratio = RV_mass_donor / RV_mass_recipient
    )
  
  return(data)
}

# Define columns to remove (common across all datasets)
columns_to_remove <- c(
  'VAD_DEVICE_TY_TRR', 'ECD_DONOR', 'PST_AIRWAY', 'MED_COND_TRR', 'ACTIVATE_DATE',
  'ADMISSION_DATE', 'PST_DIAL', 'hosp_extra', 'PST_STROKE', 'COD', 'GTIME', 'GSTATUS',
  'DEATH_DATE', 'cod_extra', 'cod_ostxt_extra', 'cod2_extra', 'cod2_ostxt_extra',
  'cod3_extra', 'cod3_ostxt_extra', 'FUNC_STAT_TCR', 'SUD_DEATH', 'FUNC_STAT_TRR',
  'COD_CAD_DON', 'DEATH_CIRCUM_DON', 'DEATH_MECH_DON', 'COD_OSTXT', 'END_DATE', 'COD2',
  'COMPOSITE_DEATH_DATE', 'FUNC_STAT_TRF', 'TRR_ID_CODE', 'SSDMF_DEATH_DATE',
  'COD2_OSTXT', 'COD3', 'COD3_OSTXT', 'Dead', 'PX_STAT_DATE', 'LASTFUNO', 'PSTATUS',
  'PX_STAT', 'PTIME', 'TRTREJ1Y', 'TX_DATE', 'RETXDATE', 'DISCHARGE_DATE',
  'ADMIT_DATE_DON', 'DONOR_ID', 'REFERRAL_DATE', 'MEASUREMENT_DATE_TRR',
  'PRETITERA_DATE', 'PRETITERB_DATE', 'RECOVERY_DATE_DON', 'LISTYR', 'GRF_FAIL_CAUSE',
  'GRF_STAT', 'GRF_FAIL_DATE', 'TITERA_DATE', 'TITERB_DATE', 'INIT_DATE', 'COD_WL',
  'COD_OSTXT_WL', 'INIT_OPO_CTR_CODE', 'AGE_GROUP', 'CALC_LAS_LISTDATE',
  'CMV_OLD_LIV_DON', 'CMV_TEST_DON', 'COD_LIV_DON', 'COGNITIVE_DEV_TRR',
  'DATA_TRANSPLANT', 'DATA_WAITLIST', 'Dual_Organ', 'EBV_DNA_DON', 'EBV_TEST_DON',
  'ECMO_72HOURS', 'END_BLU_FLG', 'END_CALC_LAS', 'END_CREAT', 'END_LLU_FLG',
  'END_MATCH_LAS', 'END_O2', 'END_PRIORITY', 'END_RLU_FLG', 'EXERCISE_O2',
  'FIO2_72HOURS', 'HBV_TEST_DON', 'HCV_TEST_DON', 'Heart_transplant',
  'INHALEDNO_72HOURS', 'INIT_CALC_LAS', 'INIT_CREAT', 'INIT_MATCH_LAS', 'INIT_O2',
  'INIT_PRIORITY', 'INTUBATED_72HOURS', 'LT_ONE_WEEK_DON', 'LU2_RECEIVED',
  'LU_RECEIVED', 'MOTOR_DEV_TRR', 'MULTIORG', 'O2_REQ_CALC', 'PAO2_72HOURS',
  'PCO2_TRR', 'PERFUSED_BY', 'PERFUSED_PRIOR', 'PERFUSION_LOCATION', 'PRETITERA',
  'PRETITERB', 'PROSTACYCLIN_TCR', 'PROSTACYCLIN_TRR', 'PROS_INFUS_TCR',
  'PROS_INFUS_TRR', 'Recipient_sex', 'TCR_CDC_GROWTH_BMI', 'TCR_CDC_GROWTH_HGT',
  'TCR_CDC_GROWTH_WGT', 'TITERA', 'TITERB', 'TOTAL_PERFUSION_TIME',
  'TRANSPLANT_COUNTRY', 'TXHRT', 'TXINT', 'TXKID', 'TXLIV', 'TXPAN', 'WLHR', 'WLIN',
  'WLPI', 'WL_ORG', 'Cause_of_death_MSetiology', 'Broad_death_categories',
  'Cause_of_death_etiologies', 'Time_to_retransplant', 'One_year_mortality',
  'REM_CD', 'DONOR_ID', 'LOS', 'GRF_FAIL_CAUSE_OSTXT', 'PT_CODE',
  'Final_death_cause_6grps'
)

# Load all datasets
# Full Data
data_path <- "thorax-database-Sept28.csv"
data <- preprocess_data(data_path, columns_to_remove)

# LVAD Support
data_path_LVAD_0 <- "unos-Durable_LVAD_0-oct-18.csv"
data_LVAD_0 <- preprocess_data(data_path_LVAD_0, columns_to_remove)

data_path_LVAD_1 <- "unos-Durable_LVAD_1-oct-18.csv"
data_LVAD_1 <- preprocess_data(data_path_LVAD_1, columns_to_remove)

# Time Periods
data_path_1990 <- "unos-data1990-oct-18.csv"
data_1990 <- preprocess_data(data_path_1990, columns_to_remove)

data_path_2006 <- "unos-data2006-oct-18.csv"
data_2006 <- preprocess_data(data_path_2006, columns_to_remove)

# Gender Combos
data_path_female_donor_female_recipient <- "unos-data_female_donor_female_recipient-oct-18.csv"
data_female_donor_female_recipient <- preprocess_data(data_path_female_donor_female_recipient, columns_to_remove)

data_path_female_donor_male_recipient <- "unos-data_female_donor_male_recipient-oct-18.csv"
data_female_donor_male_recipient <- preprocess_data(data_path_female_donor_male_recipient, columns_to_remove)

data_path_male_donor_female_recipient <- "unos-data_male_donor_female_recipient-oct-18.csv"
data_male_donor_female_recipient <- preprocess_data(data_path_male_donor_female_recipient, columns_to_remove)

data_path_male_donor_male_recipient <- "unos-data_male_donor_male_recipient-oct-18.csv"
data_male_donor_male_recipient <- preprocess_data(data_path_male_donor_male_recipient, columns_to_remove)

# Create directory for processed data
dir.create("data", showWarnings = FALSE)

# Save preprocessed data
save(
  data, data_LVAD_0, data_LVAD_1, data_1990, data_2006,
  data_female_donor_female_recipient, data_female_donor_male_recipient,
  data_male_donor_female_recipient, data_male_donor_male_recipient,
  file = "data/preprocessed_data.RData"
)

cat("Data preprocessing complete. Data saved to data/preprocessed_data.RData\n")
