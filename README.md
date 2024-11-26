# Analysing the factors influencing the wages of the US workforce: Education as the Strongest Factor While Gender and Race Reflect Inequalities

## Overview

This study uses a multiple linear regression model to analyze key factors influencing wages among the U.S. workforce, including education, age, gender, race, region, and hours worked. The results show that education is the strongest factor, with higher levels of education leading to significantly higher wages, while gender and race reveal notable disparities, with men and Asian workers earning the most. The study also finds a nonlinear relationship between age and wages, with region and hours worked playing smaller but significant roles. By identifying these drivers, the research provides evidence to inform policies aimed at reducing wage gaps and promoting fairer economic outcomes.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the raw data as obtained from X.
-   `data/01-analysis_data` contains the cleaned dataset that was constructed.
-   `model` Contains fitted models, along with the training and testing data used for the models.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains R scripts for data simulation, cleaning, and testing, along with steps for data downloading.

## Statement on LLM usage

 Some of the code was completed with the assistance of ChatGPT-4, including code for data cleaning, testing, simulation, generating charts for the Data section, parts of the code in the Model section, and code for testing model assumptions in the appendix. The entire chat history is available in inputs/llms/usage.txt.

