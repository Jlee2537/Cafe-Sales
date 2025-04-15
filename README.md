# Cafe Sales Data Cleaning
## Project Overview
This project focuses on cleaning and preparing a synthetic dataset of cafe sales transactions for further analysis. The dataset contains various data quality issues such as inconsistent values, incorrect data types, missing fields, and formatting errors. The goal of this project is to apply fundamental data cleaning techniques using SQL to transform the raw dataset into a structured, accurate, and analysis-ready format.
## Objectives
* Identify and remove duplicate records to ensure data accuracy and integrity
* Standardize column names and enforce consistent data types across the dataset
* Clean and impute missing, inconsistent, or invalid values
* Recalculate key fields to ensure consistency
## Data Description
The dataset used in this project is sourced from [Kaggle](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training) and contains 10,000 rows of synthetic cafe sales transactions.
### Entity Relationship Diagram:
![image](https://github.com/user-attachments/assets/222a4e49-5b93-4337-ab4c-54979172e091)
## Data Cleaning Process
While working with this dataset, I followed a process similar to what you'd do in a real-world scenario. First, I imported the raw data into one table, keeping it exactly as it was to preserve the original data for reference or backup. Then, I created a second table, sales_staging, and set all the columns to the TEXT data type temporarily. The reason for this is simple: the raw data wasn’t perfect. It had lots of inconsistencies, like non-numeric values in fields where only numbers should be, especially in the sales amount column. If I hadn't done this, those errors would’ve caused issues during the import process, so this step made sure I could work with the data without any interruptions.
### Preview of Raw Data
![image](https://github.com/user-attachments/assets/66fb76e1-b685-45e1-a622-56778dc6775d)
### Checking for Duplicates
To ensure that there were no duplicate records based on transaction_id, a query was run to check for duplicate entries.
```
    SELECT transaction_id, COUNT(*) count
    FROM sales_staging
    GROUP BY 1 HAVING count > 1;
```
No duplicates were found in the dataset.
