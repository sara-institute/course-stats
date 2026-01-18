################################################################################
# EXPLORATORY DATA ANALYSIS PRACTICE
# Beginner-Friendly Exercises with Palmer Penguins Dataset
################################################################################

# Welcome! This practice file will help you learn EDA step by step.
# The palmerpenguins dataset contains data about 3 penguin species from Antarctica.
# Work through each section, try the exercises, then check the solutions at the end.

################################################################################
# SETUP
################################################################################

# Install packages (remove the # to run these lines if needed)
# install.packages("tidyverse")
# install.packages("palmerpenguins")

# Load libraries
library(tidyverse)
library(palmerpenguins)

# Load the penguins dataset
data(penguins)

# Take a quick look
View(penguins)  # Opens in a spreadsheet-like viewer

################################################################################
# PART 1: GETTING TO KNOW YOUR DATA
################################################################################

# First, always explore what you're working with!

# --- DEMONSTRATION ---
glimpse(penguins)  # Shows structure: columns, types, first values
head(penguins)     # First 6 rows
tail(penguins)     # Last 6 rows

# EXERCISE 1.1: Find the dimensions of the dataset
# How many rows and columns does penguins have?
# YOUR CODE HERE:



# EXERCISE 1.2: Get the column names
# What variables (columns) are in this dataset?
# YOUR CODE HERE:



# EXERCISE 1.3: Check the data types
# Use str() to see the structure of the data
# YOUR CODE HERE:



# EXERCISE 1.4: Get a summary
# Use summary() to see basic statistics for all columns
# YOUR CODE HERE:



################################################################################
# PART 2: HANDLING MISSING VALUES
################################################################################

# Real data often has missing values (NA). Let's investigate!

# --- DEMONSTRATION ---
# Count total missing values
sum(is.na(penguins))

# EXERCISE 2.1: Check missing values per column
# How many NAs are in each column?
# Hint: Use colSums() with is.na()
# YOUR CODE HERE:



# EXERCISE 2.2: Use tidyverse to count NAs
# Try this approach: penguins %>% summarise(across(everything(), ~sum(is.na(.))))
# YOUR CODE HERE:



# EXERCISE 2.3: Remove rows with ANY missing values
# Create a new dataset called penguins_complete with no NAs
# Hint: Use drop_na() or na.omit()
# YOUR CODE HERE:



# Check how many rows remain
# YOUR CODE HERE:



################################################################################
# PART 3: FILTERING DATA (Subsetting Rows)
################################################################################

# filter() lets you keep only rows that meet certain conditions

# --- DEMONSTRATION ---
# Get only Adelie penguins
penguins %>% 
  filter(species == "Adelie")

# EXERCISE 3.1: Filter for Gentoo penguins
# YOUR CODE HERE:



# EXERCISE 3.2: Filter for penguins with body mass > 4500g
# YOUR CODE HERE:



# EXERCISE 3.3: Filter for male penguins on Biscoe island
# Hint: Use & for "and" condition, or just add another comma in filter()
# YOUR CODE HERE:



# EXERCISE 3.4: Filter for penguins with flipper length between 190 and 210 mm
# Hint: flipper_length_mm >= 190 & flipper_length_mm <= 210
# YOUR CODE HERE:



# EXERCISE 3.5: Filter for either Adelie OR Chinstrap species
# Hint: Use | for "or", or use %in% c("Adelie", "Chinstrap")
# YOUR CODE HERE:



################################################################################
# PART 4: SELECTING COLUMNS
################################################################################

# select() helps you choose which columns to keep

# --- DEMONSTRATION ---
# Select only species and island
penguins %>% 
  select(species, island)

# EXERCISE 4.1: Select species, bill_length_mm, and bill_depth_mm
# YOUR CODE HERE:



# EXERCISE 4.2: Select all columns EXCEPT year
# Hint: Use the minus sign: select(-year)
# YOUR CODE HERE:



# EXERCISE 4.3: Select all columns that start with "bill"
# Hint: Use starts_with()
# YOUR CODE HERE:



# EXERCISE 4.4: Select species and all numeric columns
# Hint: Use where(is.numeric)
# YOUR CODE HERE:



################################################################################
# PART 5: CREATING NEW COLUMNS (MUTATE)
################################################################################

# mutate() creates new columns or modifies existing ones

# --- DEMONSTRATION ---
# Create a new column for body mass in kg
penguins %>% 
  mutate(body_mass_kg = body_mass_g / 1000) %>% 
  select(species, body_mass_g, body_mass_kg)

# EXERCISE 5.1: Create a column for bill ratio (length divided by depth)
# Name it bill_ratio
# YOUR CODE HERE:



# EXERCISE 5.2: Create a column called size_category
# If body_mass_g > 4500, assign "Large", otherwise "Small"
# Hint: Use ifelse(condition, if_true, if_false)
# YOUR CODE HERE:



# EXERCISE 5.3: Create multiple columns at once
# - flipper_length_cm (convert from mm to cm)
# - bill_length_cm (convert from mm to cm)
# YOUR CODE HERE:



# EXERCISE 5.4: Use case_when for multiple categories
# Create weight_class: 
#   body_mass_g >= 5000 → "Heavy"
#   body_mass_g >= 4000 → "Medium"
#   body_mass_g < 4000  → "Light"
# Hint: case_when(condition1 ~ value1, condition2 ~ value2, TRUE ~ default)
# YOUR CODE HERE:



################################################################################
# PART 6: SORTING DATA (ARRANGE)
################################################################################

# arrange() sorts rows by one or more columns

# --- DEMONSTRATION ---
# Sort by body mass (ascending)
penguins %>% 
  arrange(body_mass_g)

# EXERCISE 6.1: Sort by body mass in descending order
# Hint: Use desc()
# YOUR CODE HERE:



# EXERCISE 6.2: Sort by species (A-Z), then by body mass (largest first)
# YOUR CODE HERE:



# EXERCISE 6.3: Find the 5 penguins with the longest flippers
# Hint: Combine arrange() with head()
# YOUR CODE HERE:



################################################################################
# PART 7: SUMMARIZING DATA
################################################################################

# summarise() calculates summary statistics

# --- DEMONSTRATION ---
# Calculate average body mass
penguins %>% 
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE))

# EXERCISE 7.1: Calculate the mean bill length
# Remember: na.rm = TRUE removes NAs
# YOUR CODE HERE:



# EXERCISE 7.2: Calculate multiple statistics for flipper length
# Find: mean, median, min, max, and standard deviation
# YOUR CODE HERE:



# EXERCISE 7.3: Count the total number of penguins
# Hint: Use n()
# YOUR CODE HERE:



# EXERCISE 7.4: Calculate the mean and standard deviation of body mass
# for each species separately
# Hint: Use group_by(species) before summarise()
# YOUR CODE HERE:



################################################################################
# PART 8: COUNTING AND GROUPING
################################################################################

# count() is a quick way to make frequency tables

# --- DEMONSTRATION ---
# Count penguins by species
penguins %>% 
  count(species)

# EXERCISE 8.1: Count penguins by island
# YOUR CODE HERE:



# EXERCISE 8.2: Count by both species and island
# YOUR CODE HERE:



# EXERCISE 8.3: Count by species and sort from most to least common
# Hint: Add sort = TRUE to count()
# YOUR CODE HERE:



# EXERCISE 8.4: Calculate average measurements by species
# Group by species, then calculate mean of bill_length_mm, 
# bill_depth_mm, and flipper_length_mm
# YOUR CODE HERE:



# EXERCISE 8.5: Find which island has the heaviest penguins on average
# Group by island, calculate mean body_mass_g, and arrange in descending order
# YOUR CODE HERE:



################################################################################
# PART 9: CHAINING OPERATIONS (THE PIPE %>%)
################################################################################

# The pipe %>% lets you chain multiple operations together

# --- DEMONSTRATION ---
# Multi-step analysis
penguins %>% 
  filter(species == "Adelie") %>% 
  select(island, body_mass_g, flipper_length_mm) %>% 
  arrange(desc(body_mass_g)) %>% 
  head(5)

# EXERCISE 9.1: Find the 3 heaviest Gentoo penguins
# Filter for Gentoo, select relevant columns, sort, and get top 3
# YOUR CODE HERE:



# EXERCISE 9.2: Calculate average bill length for each species on Dream island
# Filter for Dream island, group by species, summarise mean bill_length_mm
# YOUR CODE HERE:



# EXERCISE 9.3: Complex pipeline challenge!
# 1. Remove rows with missing values
# 2. Filter for penguins with body mass > 4000g
# 3. Create a new column: bill_length_cm (convert from mm)
# 4. Group by species
# 5. Calculate mean and max of bill_length_cm
# YOUR CODE HERE:



################################################################################
# PART 10: DATA VISUALIZATION BASICS
################################################################################

# ggplot2 is the tidyverse visualization package
# Basic structure: ggplot(data, aes(x, y)) + geom_type()

# --- DEMONSTRATION ---
# Simple histogram
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 30, fill = "steelblue") +
  labs(title = "Distribution of Penguin Body Mass",
       x = "Body Mass (g)",
       y = "Count")

# EXERCISE 10.1: Create a histogram of flipper lengths
# Use bins = 20 and a color of your choice
# YOUR CODE HERE:



# EXERCISE 10.2: Create a boxplot of body mass by species
# Hint: ggplot(penguins, aes(x = species, y = body_mass_g)) + geom_boxplot()
# YOUR CODE HERE:



# EXERCISE 10.3: Create a scatter plot
# x-axis: bill_length_mm, y-axis: bill_depth_mm
# YOUR CODE HERE:



# EXERCISE 10.4: Color the scatter plot by species
# Add: color = species inside aes()
# YOUR CODE HERE:



# EXERCISE 10.5: Add a title and better axis labels to your scatter plot
# Use labs(title = "...", x = "...", y = "...")
# YOUR CODE HERE:



# EXERCISE 10.6: Create a bar chart of penguin counts by island
# Hint: ggplot(penguins, aes(x = island)) + geom_bar()
# YOUR CODE HERE:



# EXERCISE 10.7: Boxplot challenge
# Create a boxplot showing flipper length by species
# Fill each box with a different color by species
# Add theme_minimal() for a clean look
# YOUR CODE HERE:



################################################################################
# PART 11: ADVANCED VISUALIZATION
################################################################################

# EXERCISE 11.1: Create a scatter plot with a trend line
# Plot bill_length_mm vs flipper_length_mm
# Add geom_smooth(method = "lm") to add a linear trend line
# YOUR CODE HERE:



# EXERCISE 11.2: Facet wrap - multiple plots by category
# Create a scatter plot of bill_length_mm vs bill_depth_mm
# Color by species
# Add facet_wrap(~island) to create separate plots for each island
# YOUR CODE HERE:



# EXERCISE 11.3: Density plot by species
# Create a density plot of body mass with different colors for each species
# Hint: Use geom_density() with fill = species and alpha = 0.5 for transparency
# YOUR CODE HERE:



################################################################################
# PART 12: PUTTING IT ALL TOGETHER - MINI PROJECT
################################################################################

# PROJECT: Analyze sex differences in penguin measurements

# TASK 1: Create a clean dataset
# Remove all rows with missing sex values and store in penguins_clean
# YOUR CODE HERE:



# TASK 2: Calculate average measurements by sex
# For each sex, calculate mean body_mass_g, bill_length_mm, and flipper_length_mm
# YOUR CODE HERE:



# TASK 3: Compare species by sex
# Group by both species and sex, then calculate average body mass
# Arrange by species and then sex
# YOUR CODE HERE:



# TASK 4: Visualize sex differences
# Create a boxplot of body mass with sex on x-axis, color by sex
# Facet by species to see differences across species
# YOUR CODE HERE:



# TASK 5: Statistical insight
# Which species shows the biggest size difference between males and females?
# Calculate the difference in average body mass for each species
# Hint: You may need to use pivot_wider() or separate male/female analyses
# YOUR CODE HERE:



################################################################################
# BONUS CHALLENGES (For students who want more practice!)
################################################################################

# BONUS 1: Find correlations
# Calculate the correlation between bill_length_mm and bill_depth_mm
# Hint: cor(data$var1, data$var2, use = "complete.obs")
# YOUR CODE HERE:



# BONUS 2: Create a summary report
# For each species:
# - Count of penguins
# - Average body mass
# - Average flipper length
# - Number of islands they live on
# YOUR CODE HERE:



# BONUS 3: Advanced filtering
# Find all penguins that are:
# - Female
# - Have above-average body mass for their species
# - From Biscoe island
# (This is tricky! You'll need to calculate species averages first)
# YOUR CODE HERE:



# BONUS 4: Create a beautiful multi-panel plot
# Create 4 plots in one figure:
# 1. Histogram of body mass
# 2. Boxplot of flipper length by species
# 3. Scatter plot of bill dimensions colored by species
# 4. Bar chart of counts by island
# Hint: Use library(patchwork) and the + or / operators to combine plots
# YOUR CODE HERE:



################################################################################
#                           SOLUTIONS SECTION
#          (Scroll down only after attempting the exercises!)
################################################################################

cat("\n\n\n\n\n\n\n\n\n\n")
cat("============================================================\n")
cat("                    SOLUTIONS BELOW                          \n")
cat("           Try the exercises first before looking!          \n")
cat("============================================================\n")
cat("\n\n\n\n\n")

# PART 1 SOLUTIONS ----
cat("PART 1 SOLUTIONS:\n")

# 1.1
dim(penguins)  # 344 rows, 8 columns

# 1.2
names(penguins)

# 1.3
str(penguins)

# 1.4
summary(penguins)

cat("\n---\n\n")

# PART 2 SOLUTIONS ----
cat("PART 2 SOLUTIONS:\n")

# 2.1
colSums(is.na(penguins))

# 2.2
penguins %>% 
  summarise(across(everything(), ~sum(is.na(.))))

# 2.3
penguins_complete <- penguins %>% 
  drop_na()

# Or: penguins_complete <- na.omit(penguins)

nrow(penguins_complete)  # 333 rows remain

cat("\n---\n\n")

# PART 3 SOLUTIONS ----
cat("PART 3 SOLUTIONS:\n")

# 3.1
penguins %>% 
  filter(species == "Gentoo")

# 3.2
penguins %>% 
  filter(body_mass_g > 4500)

# 3.3
penguins %>% 
  filter(sex == "male" & island == "Biscoe")
# Or: filter(sex == "male", island == "Biscoe")

# 3.4
penguins %>% 
  filter(flipper_length_mm >= 190 & flipper_length_mm <= 210)

# 3.5
penguins %>% 
  filter(species %in% c("Adelie", "Chinstrap"))
# Or: filter(species == "Adelie" | species == "Chinstrap")

cat("\n---\n\n")

# PART 4 SOLUTIONS ----
cat("PART 4 SOLUTIONS:\n")

# 4.1
penguins %>% 
  select(species, bill_length_mm, bill_depth_mm)

# 4.2
penguins %>% 
  select(-year)

# 4.3
penguins %>% 
  select(starts_with("bill"))

# 4.4
penguins %>% 
  select(species, where(is.numeric))

cat("\n---\n\n")

# PART 5 SOLUTIONS ----
cat("PART 5 SOLUTIONS:\n")

# 5.1
penguins %>% 
  mutate(bill_ratio = bill_length_mm / bill_depth_mm) %>% 
  select(species, bill_length_mm, bill_depth_mm, bill_ratio)

# 5.2
penguins %>% 
  mutate(size_category = ifelse(body_mass_g > 4500, "Large", "Small")) %>% 
  select(species, body_mass_g, size_category)

# 5.3
penguins %>% 
  mutate(
    flipper_length_cm = flipper_length_mm / 10,
    bill_length_cm = bill_length_mm / 10
  ) %>% 
  select(species, contains("length"))

# 5.4
penguins %>% 
  mutate(
    weight_class = case_when(
      body_mass_g >= 5000 ~ "Heavy",
      body_mass_g >= 4000 ~ "Medium",
      TRUE ~ "Light"
    )
  ) %>% 
  select(species, body_mass_g, weight_class)

cat("\n---\n\n")

# PART 6 SOLUTIONS ----
cat("PART 6 SOLUTIONS:\n")

# 6.1
penguins %>% 
  arrange(desc(body_mass_g))

# 6.2
penguins %>% 
  arrange(species, desc(body_mass_g))

# 6.3
penguins %>% 
  arrange(desc(flipper_length_mm)) %>% 
  head(5)

cat("\n---\n\n")

# PART 7 SOLUTIONS ----
cat("PART 7 SOLUTIONS:\n")

# 7.1
penguins %>% 
  summarise(avg_bill_length = mean(bill_length_mm, na.rm = TRUE))

# 7.2
penguins %>% 
  summarise(
    mean_flipper = mean(flipper_length_mm, na.rm = TRUE),
    median_flipper = median(flipper_length_mm, na.rm = TRUE),
    min_flipper = min(flipper_length_mm, na.rm = TRUE),
    max_flipper = max(flipper_length_mm, na.rm = TRUE),
    sd_flipper = sd(flipper_length_mm, na.rm = TRUE)
  )

# 7.3
penguins %>% 
  summarise(total_penguins = n())

# 7.4
penguins %>% 
  group_by(species) %>% 
  summarise(
    avg_mass = mean(body_mass_g, na.rm = TRUE),
    sd_mass = sd(body_mass_g, na.rm = TRUE)
  )

cat("\n---\n\n")

# PART 8 SOLUTIONS ----
cat("PART 8 SOLUTIONS:\n")

# 8.1
penguins %>% 
  count(island)

# 8.2
penguins %>% 
  count(species, island)

# 8.3
penguins %>% 
  count(species, sort = TRUE)

# 8.4
penguins %>% 
  group_by(species) %>% 
  summarise(
    avg_bill_length = mean(bill_length_mm, na.rm = TRUE),
    avg_bill_depth = mean(bill_depth_mm, na.rm = TRUE),
    avg_flipper = mean(flipper_length_mm, na.rm = TRUE)
  )

# 8.5
penguins %>% 
  group_by(island) %>% 
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE)) %>% 
  arrange(desc(avg_mass))

cat("\n---\n\n")

# PART 9 SOLUTIONS ----
cat("PART 9 SOLUTIONS:\n")

# 9.1
penguins %>% 
  filter(species == "Gentoo") %>% 
  select(species, island, body_mass_g, flipper_length_mm) %>% 
  arrange(desc(body_mass_g)) %>% 
  head(3)

# 9.2
penguins %>% 
  filter(island == "Dream") %>% 
  group_by(species) %>% 
  summarise(avg_bill_length = mean(bill_length_mm, na.rm = TRUE))

# 9.3
penguins %>% 
  drop_na() %>% 
  filter(body_mass_g > 4000) %>% 
  mutate(bill_length_cm = bill_length_mm / 10) %>% 
  group_by(species) %>% 
  summarise(
    mean_bill_cm = mean(bill_length_cm),
    max_bill_cm = max(bill_length_cm)
  )

cat("\n---\n\n")

# PART 10 SOLUTIONS ----
cat("PART 10 SOLUTIONS:\n")

# 10.1
ggplot(penguins, aes(x = flipper_length_mm)) +
  geom_histogram(bins = 20, fill = "coral") +
  labs(title = "Distribution of Flipper Length",
       x = "Flipper Length (mm)",
       y = "Count")

# 10.2
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

# 10.3
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()

# 10.4
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point()

# 10.5
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point() +
  labs(title = "Penguin Bill Dimensions by Species",
       x = "Bill Length (mm)",
       y = "Bill Depth (mm)")

# 10.6
ggplot(penguins, aes(x = island)) +
  geom_bar(fill = "steelblue")

# 10.7
ggplot(penguins, aes(x = species, y = flipper_length_mm, fill = species)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Flipper Length by Species")

cat("\n---\n\n")

# PART 11 SOLUTIONS ----
cat("PART 11 SOLUTIONS:\n")

# 11.1
ggplot(penguins, aes(x = bill_length_mm, y = flipper_length_mm)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "red") +
  theme_minimal()

# 11.2
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(alpha = 0.6) +
  facet_wrap(~island) +
  theme_minimal()

# 11.3
ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_density(alpha = 0.5) +
  theme_minimal()

cat("\n---\n\n")

# PART 12 SOLUTIONS ----
cat("PART 12 SOLUTIONS:\n")

# Task 1
penguins_clean <- penguins %>% 
  filter(!is.na(sex))

# Task 2
penguins_clean %>% 
  group_by(sex) %>% 
  summarise(
    avg_mass = mean(body_mass_g, na.rm = TRUE),
    avg_bill = mean(bill_length_mm, na.rm = TRUE),
    avg_flipper = mean(flipper_length_mm, na.rm = TRUE)
  )

# Task 3
penguins_clean %>% 
  group_by(species, sex) %>% 
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE), .groups = "drop") %>% 
  arrange(species, sex)

# Task 4
ggplot(penguins_clean, aes(x = sex, y = body_mass_g, fill = sex)) +
  geom_boxplot() +
  facet_wrap(~species) +
  theme_minimal() +
  labs(title = "Body Mass Differences Between Male and Female Penguins")

# Task 5
penguins_clean %>% 
  group_by(species, sex) %>% 
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE), .groups = "drop") %>% 
  pivot_wider(names_from = sex, values_from = avg_mass) %>% 
  mutate(difference = male - female) %>% 
  arrange(desc(difference))

cat("\n---\n\n")

# BONUS SOLUTIONS ----
cat("BONUS SOLUTIONS:\n")

# Bonus 1
cor(penguins$bill_length_mm, penguins$bill_depth_mm, use = "complete.obs")

# Bonus 2
penguins %>% 
  group_by(species) %>% 
  summarise(
    count = n(),
    avg_mass = mean(body_mass_g, na.rm = TRUE),
    avg_flipper = mean(flipper_length_mm, na.rm = TRUE),
    n_islands = n_distinct(island)
  )

# Bonus 3
species_avg <- penguins %>% 
  group_by(species) %>% 
  summarise(species_avg_mass = mean(body_mass_g, na.rm = TRUE))

penguins %>% 
  left_join(species_avg, by = "species") %>% 
  filter(
    sex == "female",
    body_mass_g > species_avg_mass,
    island == "Biscoe"
  ) %>% 
  select(species, island, sex, body_mass_g, species_avg_mass)

# Bonus 4 (requires patchwork package)
# install.packages("patchwork")
library(patchwork)

p1 <- ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 30, fill = "skyblue") +
  theme_minimal() +
  labs(title = "Body Mass Distribution")

p2 <- ggplot(penguins, aes(x = species, y = flipper_length_mm, fill = species)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Flipper Length by Species")

p3 <- ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Bill Dimensions")

p4 <- ggplot(penguins, aes(x = island)) +
  geom_bar(fill = "coral") +
  theme_minimal() +
  labs(title = "Penguins by Island")

(p1 + p2) / (p3 + p4)

cat("\n============================================================\n")
cat("                  END OF PRACTICE FILE                      \n")
cat("Great job working through these exercises!                  \n")
cat("Keep practicing with your own datasets!                     \n")
cat("============================================================\n")
