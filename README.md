# Cafe Sales Data Cleaning
## Project Overview
The Coffee House is a newly opened café specializing in coffee, desserts, and grab-and-go meals. As the business begins to grow, the company has started collecting sales transaction data to better understand customer behavior and make informed decisions. However, the dataset contains several data quality issues, including inconsistent values, incorrect data types, missing fields, and formatting errors.

This project focuses on cleaning and preparing a synthetic dataset of sales transactions from The Roast. The objective is to apply fundamental data cleaning techniques using SQL to transform the raw dataset into a structured, accurate, and analysis-ready format suitable for future reporting and business analysis.
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
### Data Import
During the initial import, all columns were temporarily defined as TEXT to accommodate inconsistencies within the raw dataset. This approach ensured that formatting issues or unexpected data types did not interfere with the import process. Treating all fields as text allowed the data to be loaded reliably and set the stage for a more controlled cleaning and transformation phase.
### Preview of Raw Data
![image](https://github.com/user-attachments/assets/66fb76e1-b685-45e1-a622-56778dc6775d)
### Data Cleaning Queries
The SQL queries utilized to clean, organize, and prepare data can be found [here](https://github.com/Jlee2537/Cafe-Sales/blob/main/SQL/cafe_sales_queries.sql)
