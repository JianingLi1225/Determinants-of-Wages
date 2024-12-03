# Analysing the Factors Influencing the Wages of the US Workforce in 2023: Higher Education and Male Gender as Key Determinants of Wage Increases Controlling for Region and Race

## Overview

This study uses a multiple linear regression model to analyze key factors influencing wages among the U.S. workforce, including education, age, gender, race, region, and hours worked. The results show that education is the strongest factor, with bachelor’s degree holders earning nearly 50% more than those without a high school diploma, while men earn more than women, and Asian workers have the highest earnings among racial groups. The study also finds a nonlinear relationship between age and wages, with region and hours worked playing smaller but significant roles. By identifying these drivers, the research provides evidence to inform policies aimed at reducing wage gaps and promoting fairer economic outcomes.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the raw data as obtained from X.
-   `data/01-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models, along with the training and testing data used for the models.
-   `other` contains relevant datasheet, literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains R scripts for data simulation, cleaning, and testing, along with steps for data downloading.

## Statement on LLM usage

Some of the code, including data cleaning, testing, simulation, chart generation for the Data section, model-related code, testing model assumptions in the appendix, and presenting model results, was completed with assistance from ChatGPT-4, along with key points in the Model Validation section. The entire chat history is available in other/llm_usage/usage.txt.
