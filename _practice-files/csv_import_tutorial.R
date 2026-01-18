################################################################################
# IMPORTING CSV DATA WITH TIDYVERSE
# A Complete Tutorial for Data Import and Preparation
################################################################################

# This tutorial covers everything you need to import, clean, and prepare CSV data
# Topics: reading CSVs, data inspection, renaming, type conversion, factors, 
#         missing values, and data validation

################################################################################
# 1. SETUP
################################################################################

# Install required packages (uncomment if needed)
# install.packages("tidyverse")
# install.packages("janitor")  # For cleaning column names
# install.packages("lubridate") # For date handling

# Load libraries
library(tidyverse)   # Includes readr for importing
library(janitor)     # For cleaning names
library(lubridate)   # For date operations

################################################################################
# 2. BASIC CSV IMPORT WITH read_csv()
################################################################################

# --- BASIC SYNTAX ---
# df <- read_csv("path/to/file.csv")

# Let's create a sample CSV file for this tutorial
sample_data <- tibble(
  ID = 1:10,
  `First Name` = c("John", "Jane", "Bob", "Alice", "Charlie", 
                   "Diana", "Eve", "Frank", "Grace", "Henry"),
  `Last Name` = c("Doe", "Smith", "Johnson", "Williams", "Brown",
                  "Jones", "Garcia", "Miller", "Davis", "Rodriguez"),
  Age = c(25, 30, 35, 28, 45, 33, 29, 41, 27, 38),
  Department = c("Sales", "HR", "IT", "Sales", "IT", 
                 "HR", "Sales", "IT", "HR", "Sales"),
  Salary = c(50000, 60000, 75000, 52000, 80000, 
             61000, 49000, 78000, 58000, 53000),
  `Start Date` = c("2020-01-15", "2019-03-22", "2018-07-10", 
                   "2021-02-01", "2017-11-05", "2020-06-18",
                   "2021-09-12", "2016-04-30", "2019-12-03", "2020-10-25"),
  Status = c("Active", "Active", "Active", "Active", "Inactive",
             "Active", "Active", "Inactive", "Active", "Active"),
  `Performance Score` = c(4.2, 4.5, 3.8, 4.0, 4.7, 
                          4.1, 3.9, 4.3, 4.6, 4.0)
)

# Save to CSV
write_csv(sample_data, "employee_data.csv")
cat("Sample CSV file created: employee_data.csv\n")

# --- IMPORT THE CSV ---
employees <- read_csv("employee_data.csv")

# read_csv() automatically:
# - Detects column types
# - Shows you what it parsed
# - Creates a tibble

# View the imported data
print(employees)
glimpse(employees)

################################################################################
# 3. UNDERSTANDING read_csv() PARAMETERS
################################################################################

# --- Common Parameters ---

# col_names: Specify if first row contains column names
# df <- read_csv("file.csv", col_names = TRUE)  # Default
# df <- read_csv("file.csv", col_names = FALSE) # No header row
# df <- read_csv("file.csv", col_names = c("col1", "col2", "col3")) # Custom names

# skip: Skip rows at the beginning
# df <- read_csv("file.csv", skip = 2)  # Skip first 2 rows

# n_max: Read only first n rows
# df <- read_csv("file.csv", n_max = 100)  # Read first 100 rows only

# na: Specify what values should be treated as NA
employees_with_na <- read_csv("employee_data.csv", 
                              na = c("", "NA", "N/A", "null", "NULL"))

# col_types: Specify column types explicitly
employees_typed <- read_csv(
  "employee_data.csv",
  col_types = cols(
    ID = col_integer(),
    `First Name` = col_character(),
    `Last Name` = col_character(),
    Age = col_integer(),
    Department = col_character(),
    Salary = col_double(),
    `Start Date` = col_date(format = "%Y-%m-%d"),
    Status = col_character(),
    `Performance Score` = col_double()
  )
)

# Alternative: Use shorthand notation
# c = character, i = integer, d = double, l = logical, D = date
employees_shorthand <- read_csv(
  "employee_data.csv",
  col_types = "iccicdicd"
)

################################################################################
# 4. CLEANING COLUMN NAMES
################################################################################

# Problem: Column names with spaces, special characters, or inconsistent cases
# are hard to work with

# --- View current names ---
names(employees)

# --- APPROACH 1: Using janitor::clean_names() (RECOMMENDED) ---
employees_clean <- employees %>% 
  clean_names()

# clean_names() converts to snake_case and removes special characters
names(employees_clean)

# Before: "First Name", "Last Name", "Start Date", "Performance Score"
# After: "first_name", "last_name", "start_date", "performance_score"

# --- APPROACH 2: Manual renaming with rename() ---
employees_renamed <- employees %>% 
  rename(
    id = ID,
    first_name = `First Name`,
    last_name = `Last Name`,
    age = Age,
    department = Department,
    salary = Salary,
    start_date = `Start Date`,
    status = Status,
    performance_score = `Performance Score`
  )

names(employees_renamed)

# --- APPROACH 3: Rename based on position ---
employees_pos <- employees %>% 
  rename(
    employee_id = 1,  # Rename first column
    fname = 2,        # Rename second column
    lname = 3         # Rename third column
  )

# --- APPROACH 4: Rename with a function ---
# Convert all to lowercase
employees_lower <- employees %>% 
  rename_with(tolower)

names(employees_lower)

# Convert all to uppercase
employees_upper <- employees %>% 
  rename_with(toupper)

# Remove spaces and replace with underscores
employees_underscore <- employees %>% 
  rename_with(~str_replace_all(., " ", "_"))

names(employees_underscore)

# --- Use cleaned data for rest of tutorial ---
employees <- employees_clean

################################################################################
# 5. CONVERTING DATA TYPES
################################################################################

# After import, you may need to convert column types

# --- View current types ---
glimpse(employees)

# --- Convert character to factor ---
# Factors are used for categorical variables

employees <- employees %>% 
  mutate(
    department = as.factor(department),
    status = as.factor(status)
  )

# Check the conversion
class(employees$department)
levels(employees$department)  # Show all unique categories

# --- Convert character to date ---
employees <- employees %>% 
  mutate(
    start_date = as.Date(start_date)
  )

class(employees$start_date)

# If dates are in different formats, use lubridate
# Common date formats:
# ymd("2020-01-15")  # Year-Month-Day
# mdy("01/15/2020")  # Month-Day-Year
# dmy("15/01/2020")  # Day-Month-Year

# Example with different date formats
sample_dates <- tibble(
  date_str = c("2020-01-15", "03/22/2019", "10-07-2018")
)

sample_dates %>% 
  mutate(
    date1 = ymd(date_str[1]),    # ISO format
    date2 = mdy(date_str[2]),    # US format
    date3 = dmy(date_str[3])     # European format
  )

# --- Convert numeric to integer ---
employees <- employees %>% 
  mutate(
    id = as.integer(id),
    age = as.integer(age)
  )

# --- Convert to logical (boolean) ---
employees <- employees %>% 
  mutate(
    is_active = status == "Active"
  )

# View the changes
glimpse(employees)

################################################################################
# 6. WORKING WITH FACTORS
################################################################################

# Factors are categorical variables with defined levels
# They're useful for:
# - Ensuring valid categories
# - Controlling sort order
# - Statistical modeling

# --- Check factor levels ---
levels(employees$department)
levels(employees$status)

# --- Reorder factor levels ---
# By default, levels are alphabetical
# Reorder by frequency (most common first)
employees <- employees %>% 
  mutate(
    department = fct_infreq(department)
  )

levels(employees$department)

# Count by department (now ordered by frequency)
employees %>% 
  count(department)

# Reorder by another variable (e.g., median salary)
employees <- employees %>% 
  mutate(
    department = fct_reorder(department, salary, median)
  )

# --- Manually set level order ---
employees <- employees %>% 
  mutate(
    status = fct_relevel(status, "Active", "Inactive")
  )

levels(employees$status)

# --- Recode factor levels (rename categories) ---
employees <- employees %>% 
  mutate(
    status_full = fct_recode(
      status,
      "Currently Active" = "Active",
      "Not Active" = "Inactive"
    )
  )

employees %>% 
  count(status, status_full)

################################################################################
# COMPLETE IMPORT AND CLEANING WORKFLOW
################################################################################

# Here's a complete workflow combining all steps:

import_and_clean_csv <- function(file_path) {
  
  cat("Step 1: Importing CSV file...\n")
  df <- read_csv(file_path, 
                 na = c("", "NA", "N/A", "null", "NULL"),
                 show_col_types = FALSE)
  
  cat("Step 2: Cleaning column names...\n")
  df <- df %>% clean_names()
  
  cat("Step 3: Converting data types...\n")
  df <- df %>% 
    mutate(
      across(where(is.character), ~str_trim(.)),  # Trim whitespace
      across(c(department, status), as.factor)    # Convert to factors
    )
  
  cat("Step 4: Handling dates...\n")
  if ("start_date" %in% names(df)) {
    df <- df %>% 
      mutate(start_date = ymd(start_date))
  }
  
  cat("Step 5: Checking for issues...\n")
  # Report missing values
  na_summary <- df %>% 
    summarise(across(everything(), ~sum(is.na(.)))) %>% 
    pivot_longer(everything(), names_to = "column", values_to = "na_count") %>% 
    filter(na_count > 0)
  
  if (nrow(na_summary) > 0) {
    cat("Missing values found:\n")
    print(na_summary)
  } else {
    cat("No missing values detected.\n")
  }
  
  # Report duplicates
  n_duplicates <- sum(duplicated(df))
  cat("Duplicate rows:", n_duplicates, "\n")
  
  cat("\nData import and cleaning complete!\n")
  cat("Dimensions:", nrow(df), "rows x", ncol(df), "columns\n")
  
  return(df)
}

# Use the function
clean_employees <- import_and_clean_csv("employee_data.csv")

################################################################################
# EXPORTING CLEANED DATA
################################################################################

# --- Export to CSV ---
write_csv(employees, "employees_cleaned.csv")


# --- Export to Excel (requires writexl package) ---
# install.packages("writexl")
# library(writexl)
# write_xlsx(employees, "employees_cleaned.xlsx")

################################################################################
# READING OTHER FILE FORMATS
################################################################################

# --- Excel files (requires readxl package) ---
# install.packages("readxl")
# library(readxl)
# df <- read_excel("file.xlsx", sheet = 1)
# df <- read_excel("file.xlsx", sheet = "Sheet1")

# --- SPSS, Stata, SAS files (requires haven package) ---
# install.packages("haven")
# library(haven)
# df <- read_sav("file.sav")   # SPSS
# df <- read_dta("file.dta")   # Stata
# df <- read_sas("file.sas7bdat")  # SAS

################################################################################
# 15. TIPS AND BEST PRACTICES
################################################################################

cat("\n=== TIPS FOR CSV IMPORT AND CLEANING ===\n\n")

cat("2. Use read_csv() instead of read.csv()\n")
cat("   - It's faster and creates tibbles\n")
cat("   - Better type detection\n\n")

cat("3. Clean column names immediately\n")
cat("   - Use janitor::clean_names()\n")
cat("   - Consistent naming makes code easier\n\n")

cat("4. Be explicit about data types\n")
cat("   - Use col_types parameter\n")
cat("   - Convert to factors where appropriate\n\n")

cat("5. Document your cleaning steps\n")
cat("   - Comment your code\n")
cat("   - Keep track of what you changed and why\n\n")
