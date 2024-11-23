#### Preamble ####
# Purpose: Tests the structure and validity of the simulated wages dataset.
# Author: Jianing Li
# Date: 22 November 2024
# Contact: lijianing.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, `testthat`, `readr` and `here` packages must be installed and loaded.
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `Determinants-of-Wages` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(readr)
library(here)

simulated_data <- read_csv(here("data", "00-simulated_data", "simulated_data.csv"))


test_that("Dataset structure and loading", {
  # Test 1: Dataset exists
  expect_true(exists("simulated_data"), "Simulated data was not loaded.")
  
  # Test 2: Dataset is a data frame
  expect_true(is.data.frame(simulated_data), "Simulated data is not a data frame.")
  
  # Test 3: Dataset has non-zero rows and columns
  expect_gt(nrow(simulated_data), 0, "Dataset has no rows.")
  expect_gt(ncol(simulated_data), 0, "Dataset has no columns.")
  
  # Test 4: Dataset contains expected columns
  expected_columns <- c("UHRSWORK", "INCWAGE", "region", "education_level", "age", "gender", "race_group")
  expect_setequal(names(simulated_data), expected_columns)  # Removed custom error message
})

test_that("Column data types", {
  # Test 5: UHRSWORK is numeric
  expect_type(simulated_data$UHRSWORK, "double")
  
  # Test 6: INCWAGE is numeric
  expect_type(simulated_data$INCWAGE, "double")
  
  # Test 7: region is a character vector
  expect_type(simulated_data$region, "character")
  
  # Test 8: education_level is a character vector
  expect_type(simulated_data$education_level, "character")
  
  # Test 9: age is numeric
  expect_type(simulated_data$age, "double")
  
  # Test 10: gender is a character vector
  expect_type(simulated_data$gender, "character")
  
  # Test 11: race_group is a character vector
  expect_type(simulated_data$race_group, "character")
})


test_that("Value ranges and logical consistency", {
  # Test 12: UHRSWORK is strictly greater than 0
  expect_true(all(simulated_data$UHRSWORK > 0), "UHRSWORK values must be greater than 0.")
  
  # Test 13: INCWAGE is non-negative
  expect_true(all(simulated_data$INCWAGE >= 0), "INCWAGE contains negative values.")
  
  # Test 14: age is within valid range (18–65)
  expect_true(all(simulated_data$age >= 18 & simulated_data$age <= 65), "Age values are out of range.")
  
  # Test 15: region contains valid categories
  valid_regions <- c("Northeast", "South", "Midwest", "West")
  expect_true(all(simulated_data$region %in% valid_regions), "Invalid values found in region.")
  
  # Test 16: education_level contains valid categories
  valid_education <- c("No_Education", "Primary_Education", "Middle_School", 
                       "High_School", "Some_College", "Bachelors_or_Higher")
  expect_true(all(simulated_data$education_level %in% valid_education), "Invalid values found in education_level.")
  
  # Test 17: gender contains valid categories
  valid_genders <- c("Male", "Female")
  expect_true(all(simulated_data$gender %in% valid_genders), "Invalid values found in gender.")
  
  # Test 18: race_group contains valid categories
  valid_race_groups <- c("White", "Black", "Asian", "Native", "Mixed_Other")
  expect_true(all(simulated_data$race_group %in% valid_race_groups), "Invalid values found in race_group.")
})

  





