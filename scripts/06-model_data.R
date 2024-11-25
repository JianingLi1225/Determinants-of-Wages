#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(here)
library(caret)

#### Read data ####
data <- read_parquet(here("data", "01-analysis_data", "analysis_data.parquet"))

### Model data ####

data <- data %>%
  mutate(log_INCWAGE = log(INCWAGE))

train_index <- createDataPartition(data$log_INCWAGE, p = 0.6, list = FALSE)  # 60% 训练集
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
  file = "models/final_model.rds"
)

saveRDS(train_data, file = "models/train_data.rds")
saveRDS(test_data, file = "/test_data.rds")







