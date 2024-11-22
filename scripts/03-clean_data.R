#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(here)

#### Clean data ####
# Read data
file_path <- "/Users/liz/Downloads/raw_data_wage.csv"
raw_data <- read.csv(file_path)

# Remove unnecessary columns
raw_data <- raw_data %>%
  select(-RACED, -EDUCD, -EMPSTATD)

# Clean the data
cleaned_data <- raw_data %>%
  filter(!is.na(STATEFIP) & STATEFIP %in% c(1:56)) %>%  # Keep valid state codes
  mutate(region = case_when(
    STATEFIP %in% c(9, 23, 25, 33, 34, 36, 42, 44, 50) ~ "Northeast",
    STATEFIP %in% c(17, 18, 19, 20, 26, 27, 29, 31, 38, 39, 46, 55) ~ "Midwest",
    STATEFIP %in% c(21, 22, 24, 28, 37, 40, 45, 47, 48, 51, 54) ~ "South",
    STATEFIP %in% c(4, 6, 8, 15, 16, 30, 32, 35, 41, 49, 53, 56) ~ "West"
  )) %>%
  filter(!is.na(region)) %>%
  filter(!EDUC %in% c(0, 99)) %>%  # Remove invalid education values
  mutate(education_level = case_when(
    EDUC == 1 ~ "No_Education",
    EDUC == 2 ~ "Primary_Education",
    EDUC == 3 ~ "Middle_School",
    EDUC %in% c(4, 5, 6) ~ "High_School",
    EDUC %in% c(7, 8, 9) ~ "Some_College",
    EDUC %in% c(10, 11) ~ "Bachelors_or_Higher"
  )) %>%
  mutate(age = ifelse(AGE == 999, NA, AGE)) %>%  # Replace 999 with NA
  filter(!is.na(age) & age >= 16 & age <= 65) %>%  # Keep working age (16-65)
  filter(!(UHRSWORK %in% c(0, 99))) %>%  # Remove invalid work hours
  filter(!(INCWAGE %in% c(999999, 999998)) & INCWAGE > 0) %>%  # Remove invalid wages
  filter(SEX %in% c(1, 2)) %>%  # Keep valid gender values
  mutate(gender = case_when(
    SEX == 1 ~ "Male",
    SEX == 2 ~ "Female"
  )) %>%
  mutate(race_group = case_when(
    RACE == 1 ~ "White",
    RACE == 2 ~ "Black",
    RACE == 3 ~ "Native",
    RACE %in% c(4, 5, 6) ~ "Asian",
    RACE %in% c(7, 8, 9) ~ "Mixed_Other"
  )) %>%
  filter(EMPSTAT == 1) %>%  # Keep only employed individuals
  select(-STATEFIP, -RACE, -EDUC, -EMPSTAT, -SEX, -AGE)

# Randomly sample data
set.seed(304)
analysis_data <- cleaned_data %>%
  slice_sample(n = 5000)

# Save the cleaned data
output_path <- here("data", "01-analysis_data", "analysis_data.csv")
write.csv(analysis_data, output_path, row.names = FALSE)

