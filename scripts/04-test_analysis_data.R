#### Preamble ####
# Purpose: Tests the structure and validity of the analysis data.
# Author: Jianing Li
# Date: 22 November 2024
# Contact: lijianing.li@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse`, `testthat`, `readr`，`arrow` and `here` packages must be installed and loaded.
# - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Determinants-of-Wages` rproj

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(readr)
library(here)
library(arrow)

analysis_data <- read_parquet(here("data", "01-analysis_data", "analysis_data.parquet"))

#### Test data ####
# Tests for Dataset Structure and Loading
test_that("Dataset structure and loading", {
  # Test 1: Dataset exists
  expect_true(exists("analysis_data"), "Analysis data was not loaded.")

  # Test 2: Dataset is a data frame
  expect_true(is.data.frame(analysis_data), "Analysis data is not a data frame.")

  # Test 3: Dataset has non-zero rows and columns
  expect_gt(nrow(analysis_data), 0, "Dataset has no rows.")
  expect_gt(ncol(analysis_data), 0, "Dataset has no columns.")

  # Test 4: Dataset contains expected columns
  expected_columns <- c("UHRSWORK", "INCWAGE", "region", "education_level", "age", "gender", "race_group")
  expect_setequal(names(analysis_data), expected_columns)
})

# Tests for Column Data Types
test_that("Column data types", {
  # Test 5: UHRSWORK is numeric
  expect_type(analysis_data$UHRSWORK, "integer")

  # Test 6: INCWAGE is numeric
  expect_type(analysis_data$INCWAGE, "integer")

  # Test 7: region is a character vector
  expect_type(analysis_data$region, "character")

  # Test 8: education_level is a character vector
  expect_type(analysis_data$education_level, "character")

  # Test 9: age is numeric
  expect_type(analysis_data$age, "integer")

  # Test 10: gender is a character vector
  expect_type(analysis_data$gender, "character")

  # Test 11: race_group is a character vector
  expect_type(analysis_data$race_group, "character")
})

# Tests for Value Ranges and Logical Consistency
test_that("Value ranges and logical consistency", {
  # Test 12: UHRSWORK is strictly greater than 0
  expect_true(all(analysis_data$UHRSWORK > 0), "UHRSWORK values must be greater than 0.")

  # Test 13: INCWAGE is non-negative
  expect_true(all(analysis_data$INCWAGE >= 0), "INCWAGE contains negative values.")

  # Test 14: age is within valid range (18–65)
  expect_true(all(analysis_data$age >= 18 & analysis_data$age <= 65), "Age values are out of range.")

  # Test 15: region contains valid categories
  valid_regions <- c("Northeast", "South", "Midwest", "West")
  expect_true(all(analysis_data$region %in% valid_regions), "Invalid values found in region.")

  # Test 16: education_level contains valid categories
  valid_education <- c("Below_High_School", "High_School", "Some_College", "Bachelor", "Above_Bachelor")
  expect_true(all(analysis_data$education_level %in% valid_education), "Invalid values found in education_level.")

  # Test 17: gender contains valid categories
  valid_genders <- c("Male", "Female")
  expect_true(all(analysis_data$gender %in% valid_genders), "Invalid values found in gender.")

  # Test 18: race_group contains valid categories
  valid_race_groups <- c("White", "Black", "Asian", "Other")
  expect_true(all(analysis_data$race_group %in% valid_race_groups), "Invalid values found in race_group.")

  # Test 19: Logical consistency: Individuals with no UHRSWORK should have zero income
  expect_true(all(analysis_data$INCWAGE == 0 | analysis_data$UHRSWORK > 0), "Non-working individuals have positive income.")
})

