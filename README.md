# 📘 Project Overview

☀️ Optimization in Solar Power Generation

📊 Data Analytics | SQL | Python | Power BI

The project focuses on optimizing solar power generation by integrating inverter and weather data to improve performance and profitability.
It uses Python for data preprocessing and analysis, SQL for insight generation, Power BI for visualization, and PowerPoint for presentation forming a complete data-driven energy optimization.


## 🎯 Business Problem and Objective

| **Category**                  | **Description**                                                                                                           |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Business Problem         | The company faces frequent fluctuations in solar energy output due to environmental variations and system inefficiencies. |
|Business Constraint       | Reduce operational cost and maintain continuous performance.                                                              |
|Business Objective        | Maximize power production efficiency and inverter performance.                                                            |
| Business Success Criteria | Achieve a 20–30% increase in profit and 30% growth in revenue through improved solar generation efficiency.          



🧩 Project Files Description

| **File Name** | **Description** |
|---------------|-----------------|
| 🐍 **Solar Power Generation.py** | Performs data cleaning, preprocessing, merging inverter and weather datasets, handling duplicates, formatting timestamps, and conducting **EDA** (Univariate, Bivariate, Multivariate Analysis). Includes visualizations like heatmaps, scatterplots, and pairplots. |
| 🗃️ **Solar Power Generation Queries.sql** | Executes SQL analysis on cleaned data stored in MySQL. Calculates inverter performance, irradiance effect, hourly generation, profitability, and projected business growth. |
| 📊 **Optimization In Solar Power Generation.pbix** | Power BI dashboard visualizing **daily and hourly energy output**, **irradiance trends**, **temperature effects**, and **profit KPIs**. Enables interactive insights for business decision-making. |
| 🧱 **PROJECT_ARCHITECTURE.pdf** | Shows the data flow architecture — from raw data collection to client decision-making. Highlights stages: data preprocessing, database integration, analysis, and visualization. |
| 🎥 **DA Final Presentation.pptx** | Final presentation covering **problem statement, objectives, project flow, EDA, visualizations, and solution strategies** for energy optimization. |


## 🧱 Project Architecture 
<img width="1436" height="507" alt="Screenshot 2025-11-03 130244" src="https://github.com/user-attachments/assets/f4f58722-3bf1-4838-8642-57d5496b0bc2" />

## 🔄 Project Workflow

RAW DATA 
   ↓
PYTHON (EDA & CLEANING)
   ↓
CLEANED DATA
   ↓
SQL ANALYSIS
   ↓
VISUALIZATION (POWER BI)
   ↓
BUSINESS DECISION MAKING

## 🧠 Python Exploratory Data Analysis (EDA)

Tasks Performed:

Data Cleaning – removed unwanted rows, duplicates, and standardized columns

Data Type Conversion – converted timestamps and numeric fields

Data Integration – merged Inverter and Weather (WMS) datasets

Data Transformation – formatted and rounded numeric data

Data Visualization – histograms, scatterplots, pairplots, and correlation heatmap


Key Insights:

Peak power generation occurs between 11 AM – 2 PM

High irradiance → higher inverter output

Rainy conditions cause ~20 % drop in performance

Temperature stability improves power efficiency


## 🧮 SQL Analytical Insights

Key Queries and Metrics:

1.Average inverter and irradiance performance

2.Top 5 and Bottom 5 days by power output

3.Profit estimation (cost vs selling price per kWh)

4.Hourly generation analysis

5.Impact of rain and temperature on power output

6.Daily profit and total revenue calculation

7.Projected business profit growth (~25 %)

Outcome: Quantified inverter efficiency and financial performance to guide operational optimization.

## 📊 Power BI Dashboard Overview

The Power BI dashboard presents:

📅 Daily & Hourly Power Output Trends

⚙️ Inverter Performance Comparison

🌤️ Weather Impact Analysis (Irradiance, Rain, Temperature)

💰 Profitability and Revenue KPIs

🎛️ Interactive Filters for time, rain condition and temperature

Business Impact: Enabled real-time monitoring and data-driven decisions, projecting a 25 – 30 % increase in profit margins.

## POWER BI Dashboard 
<img width="1310" height="650" alt="Screenshot 2025-11-03 133243" src="https://github.com/user-attachments/assets/5b4dde30-f658-4248-a08e-a9a9ad885690" />


## 💼 Presentation Summary  

From the DA Final Presentation.pptx:  

Summarizes data dictionary, architecture, overview, scope, and visualizations  

Outlines final solutions such as:  
1.Plan operations using irradiance predictions  
2.Schedule maintenance during low-output hours  
3.Enhance panel cooling and cleaning frequency 
4.Implement energy storage systems for surplus 

## ⚙️ Tech Stack

| Tool                                       | Purpose                             |
| ------------------------------------------ | ----------------------------------- |
| Python (Pandas · Seaborn · Matplotlib)| Data Cleaning & EDA                 |
|MySQL                                  | Data Storage & Analytical Queries   |
|Power BI                               | Visualization & Dashboarding        |
|PowerPoint                        |            Project Architecture & Presentation |

## 📈 Business Impact

Improved identification of generation inefficiencies

Reduced downtime through weather-based scheduling

Enhanced inverter performance analysis

Achieved projected 25–30 % increase in profit and 30 % growth in revenue

      
