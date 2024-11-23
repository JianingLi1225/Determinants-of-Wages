#### Preamble ####
# Purpose: Simulates a dataset to study the impact of several variables, 
# including education, region, gender, and age, on wages. 
# Author: Jianing Li
# Date: 22 November 2024
# Contact: lijianing.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Determinants-of-Wages` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)

#### Simulate data ####

# Number of samples to simulate
n_samples <- 5000

# Simulate age: uniformly distributed between 18 and 65
age <- sample(18:65, n_samples, replace = TRUE)

# Simulate gender with equal probability
gender <- sample(c("Male", "Female"), n_samples, replace = TRUE, prob = c(0.5, 0.5))

# Simulate region
region <- sample(c("Northeast", "South", "Midwest", "West"), n_samples, replace = TRUE, prob = c(0.25, 0.25, 0.25, 0.25))

# Simulate detailed education levels
education_level <- sample(
  c("No_Education", "Primary_Education", "Middle_School", "High_School", 
    "Some_College", "Bachelors_or_Higher"),
  n_samples, 
  replace = TRUE, 
  prob = c(0.05, 0.1, 0.15, 0.4, 0.2, 0.1)
)

# Simulate working hours based on education level
uhrswork <- rnorm(n_samples, mean = 40, sd = 5)
uhrswork[education_level == "No_Education"] <- rnorm(sum(education_level == "No_Education"), mean = 25, sd = 5)
uhrswork[education_level == "Primary_Education"] <- rnorm(sum(education_level == "Primary_Education"), mean = 30, sd = 5)
uhrswork[education_level == "Middle_School"] <- rnorm(sum(education_level == "Middle_School"), mean = 35, sd = 5)

# Simulate income based on education, region, and gender with interaction effects
education_to_income <- c(
  "No_Education" = 15000,
  "Primary_Education" = 20000,
  "Middle_School" = 25000,
  "High_School" = 35000,
  "Some_College" = 45000,
  "Bachelors_or_Higher" = 65000
)
base_income <- as.numeric(education_to_income[education_level])
region_factor <- ifelse(region == "Northeast", 1.1, ifelse(region == "South", 0.9, 1.0))
gender_factor <- ifelse(gender == "Male", 1.0, 0.95)
random_noise <- rnorm(n_samples, mean = 0, sd = 5000)
incwage <- base_income * region_factor * gender_factor + random_noise

# Simulate expanded race categories with regional correlation
race_group <- ifelse(
  region %in% c("Northeast", "Midwest"),
  sample(c("White", "Black", "Asian", "Native", "Mixed_Other"), n_samples, replace = TRUE, prob = c(0.7, 0.15, 0.05, 0.05, 0.05)),
  sample(c("White", "Black", "Asian", "Native", "Mixed_Other"), n_samples, replace = TRUE, prob = c(0.5, 0.3, 0.1, 0.05, 0.05))
)

# Combine into a data frame
simulated_data <- data.frame(
  UHRSWORK = round(uhrswork),
  INCWAGE = round(incwage),
  region = region,
  education_level = education_level,
  age = age,
  gender = gender,
  race_group = race_group
)

#  Clean simulated data
cleaned_data <- simulated_data %>%
  filter(age >= 18 & age <= 65) %>%  # Keep working age (18-65)
  filter(UHRSWORK > 0) %>%  # Remove invalid work hours
  filter(INCWAGE > 0) %>%  # Remove invalid wages
  mutate(
    region = factor(region),
    education_level = factor(education_level, levels = c("No_Education", "Primary_Education", "Middle_School", 
                                                         "High_School", "Some_College", "Bachelors_or_Higher")),
    gender = factor(gender),
    race_group = factor(race_group, levels = c("White", "Black", "Asian", "Native", "Mixed_Other"))
  )


#### Save data ####
write_csv(cleaned_data, here("data", "00-simulated_data", "simulated_data.csv"))

