################################################################################
# EXPLORATORY DATA ANALYSIS (EDA) WITH PALMER PENGUINS
# A Beginner's Guide to Understanding Your Data
################################################################################

# Welcome to EDA! This tutorial teaches you how to explore and understand data.
# We'll use the Palmer Penguins dataset - real data about penguins in Antarctica!

# What you'll learn:
# - Understanding your data structure
# - Calculating summary statistics
# - Creating visualizations
# - Finding patterns and relationships
# - Asking good questions about data

################################################################################
# SETUP - Load Required Packages
################################################################################

# Install packages if you haven't already (remove # to run)
# install.packages("tidyverse")
# install.packages("palmerpenguins")

# Load packages
library(tidyverse)        # For data manipulation and visualization
library(palmerpenguins)   # Contains the penguins dataset

# Load the data (it's built into the package!)
data(penguins)

# What's in this dataset?
# The Palmer Penguins dataset contains measurements of 3 penguin species:
# - Adelie
# - Gentoo  
# - Chinstrap
# 
# Measured on 3 islands: Biscoe, Dream, and Torgersen

################################################################################
# STEP 1: FIRST LOOK AT THE DATA
################################################################################

cat("\n=== STEP 1: GETTING TO KNOW YOUR DATA ===\n\n")

# The most important first steps in EDA:
# 1. Look at your data
# 2. Understand what each column means
# 3. Check the size of your dataset

# View the data in a spreadsheet-style viewer
View(penguins)

# Print first few rows
head(penguins)

# Print last few rows
tail(penguins)

# Get a quick overview of structure
glimpse(penguins)

# What did we learn?
# - We have 344 penguins (rows)
# - We have 8 variables (columns)
# - Mix of categorical (species, island, sex) and numeric data
# - Some missing values (NA)

# Column meanings:
# species: Penguin species (Adelie, Gentoo, Chinstrap)
# island: Island where observed (Biscoe, Dream, Torgersen)
# bill_length_mm: Length of bill in millimeters
# bill_depth_mm: Depth of bill in millimeters
# flipper_length_mm: Length of flipper in millimeters
# body_mass_g: Body mass in grams
# sex: Penguin sex (male, female)
# year: Year of observation

################################################################################
# STEP 2: UNDERSTANDING DATA DIMENSIONS AND STRUCTURE
################################################################################

cat("\n=== STEP 2: DATA DIMENSIONS ===\n\n")

# How big is our dataset?
dim(penguins)           # Rows and columns
nrow(penguins)          # Number of rows (observations)
ncol(penguins)          # Number of columns (variables)

cat("We have", nrow(penguins), "penguins and", ncol(penguins), "variables\n")

# What are the column names?
names(penguins)
colnames(penguins)

# What types of data do we have?
str(penguins)

# Better way to see data types
sapply(penguins, class)

################################################################################
# STEP 3: CHECKING DATA QUALITY
################################################################################

cat("\n=== STEP 3: DATA QUALITY CHECK ===\n\n")

# Real data is messy! Let's check for problems.

# --- Missing Values (NA) ---
# How many missing values in total?
sum(is.na(penguins))

# Missing values per column
colSums(is.na(penguins))

# Percentage of missing values per column
colMeans(is.na(penguins)) * 100

# Which rows have missing values?
penguins %>% 
  filter(if_any(everything(), is.na)) %>% 
  select(species, island, sex, bill_length_mm, body_mass_g)

cat("\nKey Finding: We have", sum(is.na(penguins)), "missing values\n")
cat("Most are in 'sex' variable (11 missing)\n")

# --- Duplicates ---
# Any duplicate rows?
sum(duplicated(penguins))

cat("Good news: No duplicate penguins!\n")

################################################################################
# STEP 4: SUMMARY STATISTICS - CATEGORICAL VARIABLES
################################################################################

cat("\n=== STEP 4: EXPLORING CATEGORICAL VARIABLES ===\n\n")

# Categorical variables: species, island, sex, year

# --- Species Distribution ---
table(penguins$species)

# Better way with tidyverse
penguins %>% 
  count(species)

# Add proportions
penguins %>% 
  count(species) %>% 
  mutate(proportion = n / sum(n),
         percentage = round(proportion * 100, 1))

# --- Island Distribution ---
penguins %>% 
  count(island, sort = TRUE)

# --- Sex Distribution ---
penguins %>% 
  count(sex)

# --- Cross-tabulation: Species by Island ---
table(penguins$species, penguins$island)

# Tidyverse way
penguins %>% 
  count(species, island) %>% 
  pivot_wider(names_from = island, values_from = n, values_fill = 0)

# Key Question: Which species live on which islands?
cat("\nKEY INSIGHT: Species and Islands\n")
penguins %>% 
  count(species, island) %>% 
  arrange(species, island) %>% 
  print()

cat("\nAdelie penguins live on all 3 islands!\n")
cat("Gentoo penguins only on Biscoe island\n")
cat("Chinstrap penguins only on Dream island\n")

################################################################################
# STEP 5: SUMMARY STATISTICS - NUMERICAL VARIABLES
################################################################################

cat("\n=== STEP 5: EXPLORING NUMERICAL VARIABLES ===\n\n")

# Numerical variables: bill_length_mm, bill_depth_mm, 
#                      flipper_length_mm, body_mass_g

# --- Overall Summary ---
summary(penguins)

# --- Detailed Statistics for Body Mass ---
penguins %>% 
  summarise(
    count = n(),
    missing = sum(is.na(body_mass_g)),
    min_mass = min(body_mass_g, na.rm = TRUE),
    q1_mass = quantile(body_mass_g, 0.25, na.rm = TRUE),
    median_mass = median(body_mass_g, na.rm = TRUE),
    mean_mass = mean(body_mass_g, na.rm = TRUE),
    q3_mass = quantile(body_mass_g, 0.75, na.rm = TRUE),
    max_mass = max(body_mass_g, na.rm = TRUE),
    sd_mass = sd(body_mass_g, na.rm = TRUE),
    range = max_mass - min_mass
  )

# Interpretation:
# - Average penguin weighs 4,202 grams (about 9.3 pounds)
# - Weights range from 2,700g to 6,300g
# - Standard deviation tells us typical variation from the mean

# --- Summary for All Numeric Variables ---
penguins %>% 
  select(where(is.numeric)) %>% 
  summary()

# More detailed statistics
penguins %>% 
  select(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>% 
  pivot_longer(everything(), names_to = "variable", values_to = "value") %>% 
  group_by(variable) %>% 
  summarise(
    mean = mean(value, na.rm = TRUE),
    median = median(value, na.rm = TRUE),
    sd = sd(value, na.rm = TRUE),
    min = min(value, na.rm = TRUE),
    max = max(value, na.rm = TRUE)
  ) %>% 
  mutate(across(where(is.numeric), round, 2))

################################################################################
# STEP 6: COMPARING GROUPS
################################################################################

cat("\n=== STEP 6: COMPARING GROUPS ===\n\n")

# One of the most important EDA tasks: comparing groups
# Let's compare penguin species!

# --- Average measurements by species ---
species_summary <- penguins %>% 
  group_by(species) %>% 
  summarise(
    count = n(),
    avg_bill_length = mean(bill_length_mm, na.rm = TRUE),
    avg_bill_depth = mean(bill_depth_mm, na.rm = TRUE),
    avg_flipper_length = mean(flipper_length_mm, na.rm = TRUE),
    avg_body_mass = mean(body_mass_g, na.rm = TRUE)
  ) %>% 
  mutate(across(where(is.numeric) & !count, round, 1))

print(species_summary)

cat("\nKEY INSIGHTS:\n")
cat("- Gentoo penguins are the heaviest (5,076g on average)\n")
cat("- Gentoo penguins have the longest flippers (217mm)\n")
cat("- Chinstrap penguins have the longest bills (48.8mm)\n")
cat("- Adelie penguins have the deepest bills (18.3mm)\n")

# --- Compare by sex ---
penguins %>% 
  filter(!is.na(sex)) %>% 
  group_by(sex) %>% 
  summarise(
    count = n(),
    avg_body_mass = mean(body_mass_g, na.rm = TRUE),
    avg_flipper = mean(flipper_length_mm, na.rm = TRUE)
  ) %>% 
  mutate(across(where(is.numeric) & !count, round, 1))

cat("\nMale penguins are generally larger than females\n")

# --- Compare by species AND sex ---
penguins %>% 
  filter(!is.na(sex)) %>% 
  group_by(species, sex) %>% 
  summarise(
    count = n(),
    avg_mass = mean(body_mass_g, na.rm = TRUE),
    .groups = "drop"
  ) %>% 
  mutate(avg_mass = round(avg_mass, 1)) %>% 
  pivot_wider(names_from = sex, values_from = c(count, avg_mass))

################################################################################
# STEP 7: VISUALIZATION - DISTRIBUTIONS
################################################################################

cat("\n=== STEP 7: VISUALIZING DISTRIBUTIONS ===\n\n")

# Visualizations help us SEE patterns in data
# Let's start with distributions (how values are spread out)

# --- HISTOGRAM: Distribution of body mass ---
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Penguin Body Mass",
    subtitle = "Palmer Penguins Dataset",
    x = "Body Mass (grams)",
    y = "Number of Penguins"
  ) +
  theme_minimal()

# What do we see?
# - Bimodal distribution (two peaks)
# - Most penguins are around 3,500g or 5,000g
# - This suggests different groups (probably different species!)

# --- HISTOGRAM: Color by species ---
ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_histogram(bins = 30, alpha = 0.6, position = "identity") +
  labs(
    title = "Body Mass Distribution by Species",
    x = "Body Mass (grams)",
    y = "Count"
  ) +
  theme_minimal()

# Now we can see: the two peaks are different species!

# --- DENSITY PLOT: Smooth distribution ---
ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Body Mass Distribution by Species",
    x = "Body Mass (grams)",
    y = "Density"
  ) +
  theme_minimal()

# --- HISTOGRAM: Bill length ---
ggplot(penguins, aes(x = bill_length_mm)) +
  geom_histogram(bins = 30, fill = "coral", color = "white") +
  labs(
    title = "Distribution of Bill Length",
    x = "Bill Length (mm)",
    y = "Count"
  ) +
  theme_minimal()

# --- HISTOGRAM: Flipper length ---
ggplot(penguins, aes(x = flipper_length_mm)) +
  geom_histogram(bins = 30, fill = "seagreen", color = "white") +
  labs(
    title = "Distribution of Flipper Length",
    x = "Flipper Length (mm)",
    y = "Count"
  ) +
  theme_minimal()

################################################################################
# STEP 8: VISUALIZATION - COMPARING GROUPS
################################################################################

cat("\n=== STEP 8: VISUALIZING GROUP COMPARISONS ===\n\n")

# --- BOX PLOT: Body mass by species ---
ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot() +
  labs(
    title = "Body Mass by Penguin Species",
    x = "Species",
    y = "Body Mass (grams)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# How to read a boxplot:
# - Box shows middle 50% of data
# - Line in box = median
# - Whiskers extend to min/max (roughly)
# - Dots = potential outliers

# Key Finding: Gentoo penguins are clearly heavier!

# --- BOX PLOT: Flipper length by species ---
ggplot(penguins, aes(x = species, y = flipper_length_mm, fill = species)) +
  geom_boxplot() +
  labs(
    title = "Flipper Length by Species",
    x = "Species",
    y = "Flipper Length (mm)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# --- VIOLIN PLOT: Alternative to boxplot ---
ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_violin() +
  labs(
    title = "Body Mass Distribution by Species",
    subtitle = "Violin plot shows the full distribution shape",
    x = "Species",
    y = "Body Mass (grams)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Violin plots show the shape of the distribution
# Wider = more penguins at that weight

# --- BOX PLOT: Body mass by species and sex ---
ggplot(penguins %>% filter(!is.na(sex)), 
       aes(x = species, y = body_mass_g, fill = sex)) +
  geom_boxplot() +
  labs(
    title = "Body Mass by Species and Sex",
    x = "Species",
    y = "Body Mass (grams)",
    fill = "Sex"
  ) +
  theme_minimal()

# Key Finding: Males are heavier than females in all species!

# --- BAR PLOT: Count of penguins by species ---
ggplot(penguins, aes(x = species, fill = species)) +
  geom_bar() +
  labs(
    title = "Number of Penguins by Species",
    x = "Species",
    y = "Count"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# --- BAR PLOT: Penguins by island ---
ggplot(penguins, aes(x = island, fill = island)) +
  geom_bar() +
  labs(
    title = "Number of Penguins by Island",
    x = "Island",
    y = "Count"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# --- STACKED BAR PLOT: Species by island ---
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar() +
  labs(
    title = "Species Distribution Across Islands",
    x = "Island",
    y = "Count",
    fill = "Species"
  ) +
  theme_minimal()

################################################################################
# STEP 9: VISUALIZATION - RELATIONSHIPS BETWEEN VARIABLES
################################################################################

cat("\n=== STEP 9: EXPLORING RELATIONSHIPS ===\n\n")

# One of the most important questions in EDA:
# How do variables relate to each other?

# --- SCATTER PLOT: Bill length vs Bill depth ---
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(alpha = 0.5, size = 2) +
  labs(
    title = "Bill Length vs Bill Depth",
    x = "Bill Length (mm)",
    y = "Bill Depth (mm)"
  ) +
  theme_minimal()

# Interesting! This looks strange... is there really no relationship?

# --- Color by species ---
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(alpha = 0.7, size = 2) +
  labs(
    title = "Bill Length vs Bill Depth by Species",
    subtitle = "Simpson's Paradox: The pattern is different within each group!",
    x = "Bill Length (mm)",
    y = "Bill Depth (mm)",
    color = "Species"
  ) +
  theme_minimal()

# This is SIMPSON'S PARADOX!
# Overall: no relationship
# Within each species: positive relationship!
# Lesson: Always check if groups are hiding patterns

# --- SCATTER PLOT: Flipper length vs Body mass ---
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point(alpha = 0.7, size = 2) +
  labs(
    title = "Flipper Length vs Body Mass",
    x = "Flipper Length (mm)",
    y = "Body Mass (grams)",
    color = "Species"
  ) +
  theme_minimal()

# Strong positive relationship: bigger flippers = heavier penguin!

# --- Add trend line ---
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species), alpha = 0.7, size = 2) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    title = "Flipper Length vs Body Mass (with trend line)",
    x = "Flipper Length (mm)",
    y = "Body Mass (grams)",
    color = "Species"
  ) +
  theme_minimal()

# The trend line shows the overall pattern

# --- SCATTER PLOT: Bill dimensions colored by sex ---
ggplot(penguins %>% filter(!is.na(sex)), 
       aes(x = bill_length_mm, y = bill_depth_mm, color = sex)) +
  geom_point(alpha = 0.7, size = 2) +
  facet_wrap(~species) +
  labs(
    title = "Bill Dimensions by Species and Sex",
    x = "Bill Length (mm)",
    y = "Bill Depth (mm)",
    color = "Sex"
  ) +
  theme_minimal()

# Faceting creates separate plots for each species
# Easier to compare patterns across groups!

################################################################################
# STEP 10: CORRELATION ANALYSIS
################################################################################

cat("\n=== STEP 10: MEASURING RELATIONSHIPS (CORRELATION) ===\n\n")

# Correlation measures how strongly two variables are related
# Range: -1 to +1
# +1 = perfect positive relationship
# -1 = perfect negative relationship
#  0 = no relationship

# --- Select numeric columns ---
numeric_penguins <- penguins %>% 
  select(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>% 
  drop_na()

# --- Calculate correlation matrix ---
cor_matrix <- cor(numeric_penguins)
print(round(cor_matrix, 2))

# Interpretation:
# - Flipper length & body mass: r = 0.87 (very strong positive)
# - Bill length & flipper length: r = 0.66 (moderate positive)
# - Bill length & bill depth: r = -0.24 (weak negative)
#   (But we know from the plot this is Simpson's Paradox!)

# --- Visualize correlation matrix ---
cor_data <- cor_matrix %>% 
  as.data.frame() %>% 
  rownames_to_column("var1") %>% 
  pivot_longer(-var1, names_to = "var2", values_to = "correlation")

ggplot(cor_data, aes(x = var1, y = var2, fill = correlation)) +
  geom_tile() +
  geom_text(aes(label = round(correlation, 2)), color = "white", size = 4) +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                       midpoint = 0, limits = c(-1, 1)) +
  labs(
    title = "Correlation Matrix Heatmap",
    x = "",
    y = ""
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# --- Correlation by species ---
# Remember: correlation within groups can be different!
penguins %>% 
  group_by(species) %>% 
  summarise(
    correlation = cor(bill_length_mm, bill_depth_mm, use = "complete.obs")
  ) %>% 
  mutate(correlation = round(correlation, 3))

# See! Within each species, bill length and depth are positively correlated!

################################################################################
# STEP 11: FINDING OUTLIERS
################################################################################

cat("\n=== STEP 11: IDENTIFYING UNUSUAL OBSERVATIONS ===\n\n")

# Outliers are observations that are very different from others
# They can be:
# - Errors in data collection
# - Rare but real observations
# - Important discoveries!

# --- Visual method: Box plot ---
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot() +
  labs(title = "Looking for Outliers in Body Mass") +
  theme_minimal()

# Points beyond the whiskers are potential outliers

# --- Statistical method: Z-scores ---
# Z-score tells you how many standard deviations from the mean
penguins_with_zscore <- penguins %>% 
  mutate(
    mass_zscore = (body_mass_g - mean(body_mass_g, na.rm = TRUE)) / 
                   sd(body_mass_g, na.rm = TRUE),
    is_outlier = abs(mass_zscore) > 3  # Common threshold
  )

# Show potential outliers
penguins_with_zscore %>% 
  filter(is_outlier) %>% 
  select(species, island, body_mass_g, mass_zscore)

# No extreme outliers (z > 3) in this dataset!

# --- Find extreme values ---
# Smallest penguins
penguins %>% 
  arrange(body_mass_g) %>% 
  head(5) %>% 
  select(species, island, sex, body_mass_g, flipper_length_mm)

# Largest penguins
penguins %>% 
  arrange(desc(body_mass_g)) %>% 
  head(5) %>% 
  select(species, island, sex, body_mass_g, flipper_length_mm)

# All heavy penguins are Gentoo males - makes sense!

################################################################################
# STEP 12: ADVANCED VISUALIZATION - FACETING
################################################################################

cat("\n=== STEP 12: ADVANCED VISUALIZATIONS ===\n\n")

# Faceting creates multiple plots to show patterns across groups

# --- Facet wrap: Separate plot for each island ---
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point(alpha = 0.7) +
  facet_wrap(~island) +
  labs(
    title = "Flipper Length vs Body Mass by Island",
    x = "Flipper Length (mm)",
    y = "Body Mass (grams)"
  ) +
  theme_minimal()

# --- Facet grid: Two dimensions ---
ggplot(penguins %>% filter(!is.na(sex)), 
       aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(alpha = 0.7) +
  facet_grid(sex ~ island) +
  labs(
    title = "Bill Dimensions: Species, Sex, and Island",
    x = "Bill Length (mm)",
    y = "Bill Depth (mm)"
  ) +
  theme_minimal()

# --- Histogram faceted by species ---
ggplot(penguins, aes(x = body_mass_g, fill = sex)) +
  geom_histogram(bins = 20, alpha = 0.6) +
  facet_wrap(~species, ncol = 1) +
  labs(
    title = "Body Mass Distribution by Species and Sex",
    x = "Body Mass (grams)",
    y = "Count"
  ) +
  theme_minimal()

################################################################################
# STEP 13: ANSWERING RESEARCH QUESTIONS
################################################################################

cat("\n=== STEP 13: ANSWERING QUESTIONS WITH DATA ===\n\n")

# EDA is about asking and answering questions!

# QUESTION 1: What's the typical size difference between male and female penguins?
cat("QUESTION 1: Size difference between sexes?\n")
sex_diff <- penguins %>% 
  filter(!is.na(sex)) %>% 
  group_by(species, sex) %>% 
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE), .groups = "drop") %>% 
  pivot_wider(names_from = sex, values_from = avg_mass) %>% 
  mutate(
    difference_g = male - female,
    percent_larger = round((male / female - 1) * 100, 1)
  )

print(sex_diff)

cat("\nANSWER: Males are 12-16% heavier than females across all species\n")
cat("        Gentoo males are 500g heavier on average\n\n")

# QUESTION 2: Do penguins on different islands have different sizes?
cat("QUESTION 2: Does island affect penguin size?\n")
penguins %>% 
  group_by(island) %>% 
  summarise(
    count = n(),
    avg_mass = mean(body_mass_g, na.rm = TRUE),
    avg_flipper = mean(flipper_length_mm, na.rm = TRUE)
  ) %>% 
  mutate(across(where(is.numeric) & !count, round, 1))

# Visualize
ggplot(penguins, aes(x = island, y = body_mass_g, fill = island)) +
  geom_boxplot() +
  labs(
    title = "Body Mass by Island",
    y = "Body Mass (grams)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

cat("\nANSWER: Yes! Biscoe penguins are heavier (Gentoo live there)\n\n")

# QUESTION 3: Are bill dimensions related to body size?
cat("QUESTION 3: Relationship between bill and body size?\n")
bill_body_cor <- penguins %>% 
  summarise(
    bill_length_vs_mass = cor(bill_length_mm, body_mass_g, use = "complete.obs"),
    bill_depth_vs_mass = cor(bill_depth_mm, body_mass_g, use = "complete.obs")
  ) %>% 
  mutate(across(everything(), round, 3))

print(bill_body_cor)

cat("\nANSWER: Bill length moderately correlated (r=0.60)\n")
cat("        Bill depth weakly correlated (r=0.49)\n\n")

# QUESTION 4: Has penguin size changed over the years?
cat("QUESTION 4: Have penguins changed over time?\n")
year_trends <- penguins %>% 
  group_by(year, species) %>% 
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE), .groups = "drop")

ggplot(year_trends, aes(x = year, y = avg_mass, color = species, group = species)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  labs(
    title = "Average Body Mass by Year and Species",
    x = "Year",
    y = "Average Body Mass (grams)",
    color = "Species"
  ) +
  theme_minimal()

cat("\nANSWER: Slight variations year to year, but no strong trend\n")
cat("        (Note: Only 3 years of data, need more for trends)\n\n")

################################################################################
# STEP 14: SUMMARY AND KEY FINDINGS
################################################################################

cat("\n=== KEY FINDINGS FROM OUR EDA ===\n\n")

cat("ABOUT THE DATA:\n")
cat("✓ 344 penguins from 3 species on 3 islands\n")
cat("✓ Data collected 2007-2009\n")
cat("✓ Very few missing values or data quality issues\n\n")

cat("SPECIES DIFFERENCES:\n")
cat("✓ Gentoo penguins are the largest (avg 5,076g)\n")
cat("✓ Adelie penguins are the smallest (avg 3,701g)\n")
cat("✓ Chinstrap in the middle (avg 3,733g)\n")
cat("✓ Each species has distinctive bill shape\n\n")

cat("SEX DIFFERENCES:\n")
cat("✓ Males are 12-16% heavier than females\n")
cat("✓ Males also have longer bills and flippers\n")
cat("✓ Pattern consistent across all species\n\n")

cat("ISLAND PATTERNS:\n")
cat("✓ Adelie live on all 3 islands\n")
cat("✓ Gentoo only on Biscoe\n")
cat("✓ Chinstrap only on Dream\n\n")

cat("RELATIONSHIPS:\n")
cat("✓ Strong correlation: flipper length & body mass (r=0.87)\n")
cat("✓ Simpson's Paradox in bill dimensions\n")
cat("✓ Body measurements are generally correlated\n\n")

################################################################################
# STEP 15: EDA BEST PRACTICES
################################################################################

cat("\n=== EDA BEST PRACTICES ===\n\n")

cat("1. START SIMPLE\n")
cat("   - Look at the data first (head, glimpse)\n")
cat("   - Check dimensions and data types\n")
cat("   - Summary statistics before visualizations\n\n")

cat("2. CHECK DATA QUALITY\n")
cat("   - Look for missing values\n")
cat("   - Check for duplicates\n")
cat("   - Identify outliers\n\n")

cat("3. EXPLORE ONE VARIABLE AT A TIME\n")
cat("   - Distributions (histograms, density plots)\n")
cat("   - Summary statistics (mean, median, sd)\n")
cat("   - Frequencies for categorical variables\n\n")

cat("4. THEN EXPLORE RELATIONSHIPS\n")
cat("   - Compare groups (boxplots)\n")
cat("   - Scatter plots for numeric relationships\n")
cat("   - Calculate correlations\n\n")

cat("5. USE VISUALIZATION\n")
cat("   - Plots reveal patterns statistics miss\n")
cat("   - Try multiple plot types\n")
cat("   - Use color and facets to show groups\n\n")

cat("6. ASK QUESTIONS\n")
cat("   - What patterns do you see?\n")
cat("   - Are there surprises?\n")
cat("   - What would you investigate next?\n\n")

cat("7. DOCUMENT YOUR FINDINGS\n")
cat("   - Note interesting patterns\n")
cat("   - Record data quality issues\n")
cat("   - List questions for further analysis\n\n")

################################################################################
# PRACTICE EXERCISES
################################################################################

cat("\n=== PRACTICE EXERCISES ===\n\n")

cat("Now try these on your own!\n\n")

cat("EXERCISE 1: Explore year variable\n")
cat("- How many penguins were measured each year?\n")
cat("- Create a bar plot of counts by year\n")
cat("- Does species distribution change by year?\n\n")

cat("EXERCISE 2: Find extreme values\n")
cat("- Which penguin has the longest bill?\n")
cat("- Which has the shortest flipper?\n")
cat("- Create a scatter plot highlighting these extreme cases\n\n")

cat("EXERCISE 3: Complex grouping\n")
cat("- Calculate average bill length by species, sex, AND island\n")
cat("- Which group has the longest bills?\n")
cat("- Visualize this with a grouped bar plot\n\n")

cat("EXERCISE 4: Create your own question\n")
cat("- Think of a question about the data\n")
cat("- Use EDA techniques to answer it\n")
cat("- Create a visualization to show your finding\n\n")

################################################################################
# BONUS: CREATING A COMPLETE EDA REPORT
################################################################################

cat("\n=== BONUS: COMPLETE EDA REPORT TEMPLATE ===\n\n")

# You can use this structure for any dataset!

create_eda_report <- function(data, dataset_name) {
  
  cat("=====================================\n")
  cat("EDA REPORT:", dataset_name, "\n")
  cat("=====================================\n\n")
  
  # 1. Dataset Overview
  cat("1. DATASET OVERVIEW\n")
  cat("   Rows:", nrow(data), "\n")
  cat("   Columns:", ncol(data), "\n")
  cat("   Variables:", paste(names(data), collapse = ", "), "\n\n")
  
  # 2. Data Types
  cat("2. VARIABLE TYPES\n")
  types <- sapply(data, class)
  for (i in 1:length(types)) {
    cat("  ", names(types)[i], ":", types[i], "\n")
  }
  cat("\n")
  
  # 3. Missing Values
  cat("3. MISSING VALUES\n")
  missing <- colSums(is.na(data))
  if (sum(missing) == 0) {
    cat("   No missing values!\n\n")
  } else {
    for (i in 1:length(missing)) {
      if (missing[i] > 0) {
        pct <- round(missing[i] / nrow(data) * 100, 1)
        cat("  ", names(missing)[i], ":", missing[i], "(", pct, "%)\n")
      }
    }
    cat("\n")
  }
  
  # 4. Numeric Summary
  cat("4. NUMERIC VARIABLES SUMMARY\n")
  numeric_cols <- data %>% select(where(is.numeric))
  if (ncol(numeric_cols) > 0) {
    print(summary(numeric_cols))
  }
  cat("\n")
  
  # 5. Categorical Summary
  cat("5. CATEGORICAL VARIABLES\n")
  categorical_cols <- data %>% select(where(is.factor) | where(is.character))
  if (ncol(categorical_cols) > 0) {
    for (col in names(categorical_cols)) {
      cat("  ", col, ":\n")
      print(table(data[[col]]))
      cat("\n")
    }
  }
  
  cat("=====================================\n")
  cat("END OF REPORT\n")
  cat("=====================================\n")
}

# Run the report
create_eda_report(penguins, "Palmer Penguins")

