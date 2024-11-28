#### Preamble ####
# Purpose: Build a multiple linear regression model to explore the effect of each variable on wages
# Author: Jianing Li
# Date: 24 November 2024
# Contact: lijianing.li@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#- The `tidyverse`， `caret`， `arrow` and `here` packages must be installed and loaded.
#- 03-clean_data.R must have been run
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(here)
library(caret)

#### Read data ####
data <- read_parquet(here("data", "01-analysis_data", "analysis_data.parquet"))

### Model data ####

data <- data %>%
  mutate(log_INCWAGE = log(INCWAGE))

train_index <- createDataPartition(data$log_INCWAGE, p = 0.6, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]


# build a multiple linear regression model that includes a quadratic term for age
final_model <- lm(
  formula = log_INCWAGE ~ UHRSWORK + region + education_level +
    age + I(age^2) + gender + race_group,
  data = data
)

summary(final_model)

#### Save model ####

saveRDS(
  final_model,
  file = here("models", "final_model.rds")
)

saveRDS(
  train_data,
  file = here("models", "train_data.rds")
)

saveRDS(
  test_data,
  file = here("models", "test_data.rds")
)

