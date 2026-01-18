# ============================================================================
# R BASICS FOR BEGINNERS
# SARA Institute of Data Science
# ============================================================================
# This file teaches fundamental R operations step by step
# Run each section and observe the output in your console
# ============================================================================

# HOW TO USE THIS FILE:
# 1. Place your cursor on a line of code
# 2. Press Ctrl+Enter (Windows/Linux) or Cmd+Enter (Mac) to run it
# 3. See the result in the Console below
# 4. Try modifying the numbers and run again!

# ============================================================================
# 1. ADDITION
# ============================================================================
# Addition uses the + symbol

# Simple addition
5 + 3

# Multiple numbers
10 + 20 + 30

# With decimals
15.5 + 24.3

# Your turn: Try adding your favorite numbers below
# 


# ============================================================================
# 2. SUBTRACTION
# ============================================================================
# Subtraction uses the - symbol

# Simple subtraction
10 - 4

# Multiple operations
100 - 25 - 10

# With decimals
50.75 - 12.25

# Negative results are OK!
5 - 15

# Your turn: Try subtracting some numbers
# 


# ============================================================================
# 3. MORE ARITHMETIC OPERATIONS
# ============================================================================
# Before we continue, here are other basic operations:

# Multiplication (uses *)
6 * 7

# Division (uses /)
20 / 4

# Exponentiation (uses ^ or **)
2 ^ 3        # 2 to the power of 3
5 ** 2       # 5 squared

# Combined operations (follows BODMAS/PEMDAS rules)
(10 + 5) * 2
10 + 5 * 2   # Notice the difference!

# Your turn: Calculate (20 + 10) / 3
# 


# ============================================================================
# 4. SEQUENCES
# ============================================================================
# Sequences are series of numbers in order
# Very useful for creating data ranges!

# Create a sequence from 1 to 10
1:10

# Create a sequence from 5 to 15
5:15

# Sequences work backwards too!
10:1

# Create a sequence with specific intervals using seq()
seq(from = 0, to = 100, by = 10)    # Count by 10s

seq(from = 1, to = 10, by = 2)      # Odd numbers from 1 to 10

seq(from = 0, to = 1, by = 0.1)     # Decimals work too!

# Create sequence with specific length
seq(from = 0, to = 100, length.out = 10)  # Exactly 11 numbers

# Your turn: Create a sequence from 20 to 50 counting by 5
# 


# ============================================================================
# 5. COMBINE (c function)
# ============================================================================
# The c() function combines multiple values into a vector
# Think of it as creating a list of numbers

# Combine several numbers
c(2, 4, 6, 8, 10)

# Combine with different values
c(5, 10, 15, 20, 25, 30)

# Can combine decimals
c(1.5, 2.7, 3.9, 4.2)

# Can combine negative numbers
c(-5, -2, 0, 3, 7)

# Mix different types (but be careful!)
c(10, 20, 30, 40)

# Combine text (must use quotes)
c("apple", "banana", "orange")

# Your turn: Create a vector with your age and ages of 3 family members
# 


# ============================================================================
# 6. CREATE AN OBJECT (Variables)
# ============================================================================
# Objects store values so you can reuse them
# Use <- or = to assign values (we prefer <-)

# Create a simple object
my_number <- 42
my_number          # Print it by typing its name

# Create object with calculation
age <- 25
age

# Create object with a sequence
my_sequence <- 1:10
my_sequence

# Create object with combined values
my_numbers <- c(5, 10, 15, 20, 25)
my_numbers

# Use objects in calculations
price <- 100
tax <- 18
total <- price + tax
total

# Objects can be updated
score <- 50
score <- score + 10   # Add 10 to current score
score

# Multiple objects working together
length <- 5
width <- 3
area <- length * width
area

# Your turn: Create an object called 'my_age' with your age
# 


# ============================================================================
# 7. FUNCTION STRUCTURE
# ============================================================================
# Functions perform specific tasks
# Structure: function_name(argument1, argument2, ...)

# The mean() function calculates average
numbers <- c(10, 20, 30, 40, 50)
mean(numbers)

# The sum() function adds all numbers
sum(numbers)

# The length() function counts items
length(numbers)

# The max() function finds the largest value
max(numbers)

# The min() function finds the smallest value
min(numbers)

# Functions can have multiple arguments
# The round() function rounds numbers
round(3.14159, digits = 2)    # Round to 2 decimal places
round(3.14159, digits = 3)    # Round to 3 decimal places

# The seq() function (we saw earlier)
seq(from = 1, to = 20, by = 2)

# The rep() function repeats values
rep(5, times = 10)            # Repeat 5 ten times
rep(c(1, 2, 3), times = 3)    # Repeat sequence three times

# Your turn: Calculate the mean of c(15, 25, 35, 45, 55)
# 


# ============================================================================
# 8. PUTTING IT ALL TOGETHER - PRACTICAL EXAMPLES
# ============================================================================

# Example 1: Calculate monthly expenses
rent <- 5000
food <- 3000
transport <- 1500
total_expenses <- rent + food + transport
total_expenses

# Example 2: Calculate class average
student_scores <- c(85, 92, 78, 90, 88, 95, 82)
class_average <- mean(student_scores)
class_average

# Example 3: Create age groups
children_ages <- seq(from = 1, to = 10, by = 1)
children_ages

# Example 4: Store and analyze survey responses (1-5 scale)
responses <- c(5, 4, 5, 3, 4, 5, 4, 3, 5, 4)
average_rating <- mean(responses)
total_responses <- length(responses)

cat("Average Rating:", average_rating, "\n")
cat("Total Responses:", total_responses, "\n")

# Example 5: Calculate percentage
obtained_marks <- c(450, 50)
total_marks <- 500
percentage <- (obtained_marks / total_marks) * 100
percentage

# Your turn: Calculate your monthly savings
# Create objects for income and expenses, then calculate savings
# 


# ============================================================================
# 9. VIEWING YOUR OBJECTS
# ============================================================================
# See all objects you've created
ls()

# Remove a specific object
# rm(object_name)

# Remove all objects (clean slate)
# rm(list = ls())     # Uncomment to use


# ============================================================================
# 10. PRACTICE EXERCISES
# ============================================================================

# Exercise 1: Create a sequence from 0 to 100, counting by 5
# Your code here:


# Exercise 2: Create a vector with temperatures: 25, 28, 30, 27, 26
# Calculate the average temperature
# Your code here:


# Exercise 3: Calculate compound interest
# Principal = 10000, Rate = 5%, Time = 3 years
# Formula: A = P(1 + r/100)^t
# Your code here:


# Exercise 4: Create an object with your family members' ages
# Find the oldest and youngest age
# Your code here:


# Exercise 5: Create a sequence of even numbers from 2 to 20
# Calculate their sum
# Your code here:


# ============================================================================
# CONGRATULATIONS!
# ============================================================================
# You've learned the basics of R:
# ✓ Addition and Subtraction
# ✓ Creating Sequences
# ✓ Combining values with c()
# ✓ Understanding Function structure
# ✓ Creating and using Objects
#
# Next steps:
# - Practice these concepts daily
# - Try modifying the examples
# - Create your own calculations
# - Move on to data frames and data visualization!
#
# Questions? Ask your instructor!
# ============================================================================


# ============================================================================
# BONUS: HELPFUL FUNCTIONS FOR BEGINNERS
# ============================================================================

# Get help on any function
?mean          # Opens help documentation
?seq

# View structure of an object
str(my_numbers)

# Summary statistics
summary(student_scores)

# Check data type
class(my_number)
class(my_numbers)

# Check if object exists
exists("my_number")

# Print with formatting
print(paste("The total is:", total_expenses))

# ============================================================================
# COMMON ERRORS AND SOLUTIONS
# ============================================================================

# Error: object 'x' not found
# Solution: Make sure you've created the object first!

# Error: unexpected symbol
# Solution: Check for missing commas or parentheses

# Error: non-numeric argument
# Solution: Make sure you're using numbers for math operations

# Remember: R is case-sensitive! 
# myNumber and mynumber are different objects

# ============================================================================
# END OF TUTORIAL
# Save this file and practice regularly!
# ============================================================================
