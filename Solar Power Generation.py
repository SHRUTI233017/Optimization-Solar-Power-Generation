import pandas as pd

# Load the dataset
inverter = pd.read_csv(r"C:\Users\User\Downloads\Optimization In Solar Power Project\Data Set (1)\Inverter dataset.csv")
inverter

# Display the first few rows and column names to understand the structure
inverter.head(), inverter.columns

# Set the second row as the header and remove the first row
inverter.columns = inverter.iloc[1]
inverter = inverter[2:].reset_index(drop=True)

# Rename the columns
inverter.columns = ['Date_Time', 'UNIT1_INV1', 'UNIT1_INV2', 'UNIT2_INV1', 'UNIT2_INV2']

# Convert 'Date_Time' column to datetime format
inverter['Date_Time'] = pd.to_datetime(inverter['Date_Time'], format='%d-%m-%Y %H:%M', errors='coerce')

# Reformat the 'DATE_TIME' column to 'DD-MM-YYYY HH:MM:SS' format
inverter['Date_Time'] = inverter['Date_Time'].dt.strftime('%d-%m-%Y %H:%M:%S')

# --------------------------------- WMS_dataset ----------------------------------------
# Load the dataset from an Excel file
WMS_dataset = pd.read_excel(r"C:\Users\User\Downloads\Optimization In Solar Power Project\Data Set (1)\WMS_Report.xlsx")

WMS_dataset

# Convert 'DATE_TIME' column to datetime format
WMS_dataset['DATE_TIME'] = pd.to_datetime(WMS_dataset['DATE_TIME'], format='%d-%m-%Y %H:%M', errors='coerce')

# Reformat the 'DATE_TIME' column to 'DD-MM-YYYY HH:MM:SS' format
WMS_dataset['DATE_TIME'] = WMS_dataset['DATE_TIME'].dt.strftime('%d-%m-%Y %H:%M:%S')

# Strip column names (remove spaces)
WMS_dataset.columns = WMS_dataset.columns.str.strip()


# Display the cleaned dataset
WMS_dataset

#Preview cleaned data
inverter.head(), WMS_dataset.head()
# ---------------------------------- Merge the datasets -----------------------------------------
# Merge the datasets on the datetime column
merged_dataset = pd.merge(inverter, WMS_dataset, left_on='Date_Time', right_on='DATE_TIME', how='inner')

# Drop the duplicate datetime column
merged_dataset.drop(columns=['DATE_TIME'], inplace=True)

merged_dataset['Date_Time'] = pd.to_datetime(merged_dataset['Date_Time'], format='%d-%m-%Y %H:%M:%S')

# Convert object columns to numeric first
num_cols = ['UNIT1_INV1', 'UNIT1_INV2', 'UNIT2_INV1', 'UNIT2_INV2']
merged_dataset[num_cols] = merged_dataset[num_cols].apply(pd.to_numeric, errors='coerce')


# round all inverter power columns properly to 2 decimal places
merged_dataset = merged_dataset.round({'UNIT1_INV1': 2, 'UNIT1_INV2': 2, 'UNIT2_INV1': 2, 'UNIT2_INV2': 2})

#Step 8: Check the top few rows to confirm rounding worked
print(merged_dataset.head())

# ------------------------ Checking Datatypes------------------------

# Displaying the data types of each column in the DataFrame
merged_dataset.dtypes 
merged_dataset.info()

# ------------------------ Checking for Duplicate Rows ------------------------

# Finding all duplicate rows in the DataFrame
duplicate = merged_dataset.duplicated(keep=False)
duplicate
sum(duplicate)

# ------------------------ Checking for Missing Values ------------------------

# Detecting missing values in each column
merged_dataset.isnull().sum()

# ------------------------ Data Type Conversions ------------------------

# Convert UNIT columns to numeric (if they contain numbers)
unit_columns = ['UNIT1_INV1', 'UNIT1_INV2', 'UNIT2_INV1', 'UNIT2_INV2']
merged_dataset[unit_columns] = merged_dataset[unit_columns].apply(pd.to_numeric, errors='coerce')

# Verify the changes
print(merged_dataset.dtypes)

merged_dataset['Date_Time'] = pd.to_datetime(merged_dataset['Date_Time'], format='%d-%m-%Y %H:%M:%S')  # add: convert 'Date_Time' column to datetime format (day-month-year hour:minute:second)

#------------------ Statistical Analysis & Visualization of Solar Plant Data ---------------------- 

import matplotlib.pyplot as plt
import seaborn as sns

# Histograms for numerical columns
merged_dataset.hist(figsize=(12, 8), bins=30)
plt.suptitle("Univariate Analysis - Histograms", fontsize=14)
plt.show()

# Boxplots for numerical columns
plt.figure(figsize=(12, 6))
sns.boxplot(data=merged_dataset)
plt.title("Univariate Analysis - Boxplots")
plt.xticks(rotation=90)
plt.show()


# Example: Histogram for Global Irradiance
plt.figure(figsize=(6,4))
sns.histplot(merged_dataset["Gobal_irradiance_index"], bins=30, kde=True, color="orange")
plt.title("Univariate - Distribution of Global Irradiance")
plt.xlabel("Irradiance (W/m²)")
plt.ylabel("Frequency")
plt.show()


# Line plot: Ambient Temperature vs Module Temperature
plt.figure(figsize=(6,4))
sns.lineplot(x=merged_dataset["AMBIENT_TEMPRETURE"], y=merged_dataset["MODULE_TEMP_1"])
plt.title("Bivariate - Ambient Temp vs Module Temp")
plt.xlabel("Ambient Temperature (°C)")
plt.ylabel("Module Temperature (°C)")
plt.show()

# Heatmap - Correlation between multiple variables
plt.figure(figsize=(10,6))
corr = merged_dataset[["UNIT1_INV1","UNIT1_INV2","UNIT2_INV1","UNIT2_INV2",
                       "Gobal_irradiance_index","MODULE_TEMP_1","AMBIENT_TEMPRETURE"]].corr()

sns.heatmap(corr, annot=True, cmap="coolwarm", fmt=".2f")
plt.title("Multivariate - Correlation Heatmap")
plt.show()


#------------------------  Excel file data  -----------------------
# Save the data to an Excel file
output_file_path = r"C:\Users\User\Downloads\Optimization In Solar Power Project\Mereged_Dataset.xlsx"  
merged_dataset.to_excel(output_file_path, index=False)

merged_dataset.columns = merged_dataset.columns.str.strip().str.upper()  # Convert to uppercase and remove spaces
print(merged_dataset.columns) 


















