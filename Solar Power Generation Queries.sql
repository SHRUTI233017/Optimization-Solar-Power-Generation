-- Use your Solar Power database
USE SolarPower;

Select * from merged_dataset; 

#View first 10 records 
SELECT * FROM merged_dataset LIMIT 10; 
 
#Check total records 
SELECT COUNT(*) AS total_records FROM merged_dataset; 

#Check column names and structure 
DESCRIBE merged_dataset;

#1. Find average inverter performance and irradiance levels
SELECT
    ROUND(AVG(UNIT1_INV1), 2) AS avg_inv1,
    ROUND(AVG(UNIT1_INV2), 2) AS avg_inv2,
    ROUND(AVG(UNIT2_INV1), 2) AS avg_inv3,
    ROUND(AVG(UNIT2_INV2), 2) AS avg_inv4,
    ROUND(MIN(Gobal_irradiance_index), 2) AS min_irradiance,
    ROUND(MAX(Gobal_irradiance_index), 2) AS max_irradiance,
    ROUND(AVG(Gobal_irradiance_index), 2) AS avg_irradiance
FROM merged_dataset;

#2. Show top 5 days with highest power output
SELECT 
    DATE(Date_Time) AS date,
    ROUND(SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS total_output
FROM merged_dataset
GROUP BY DATE(Date_Time)
ORDER BY total_output DESC
LIMIT 5;

#3. Show top 5 days with lowest power output
SELECT 
    DATE(Date_Time) AS date,
    ROUND(SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS total_output
FROM merged_dataset
GROUP BY DATE(Date_Time)
ORDER BY total_output ASC
LIMIT 5;

#4. Compare average power output during high and low irradiance
SELECT 
    CASE 
        WHEN Gobal_irradiance_index > (SELECT AVG(Gobal_irradiance_index) FROM merged_dataset)
        THEN 'High Irradiance'
        ELSE 'Low Irradiance'
    END AS Irradiance_Level,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS avg_power
FROM merged_dataset
GROUP BY Irradiance_Level;

#5. Compare power output across different ambient temperatures
SELECT
    ROUND(AMBIENT_TEMPRETURE, 0) AS Ambient_Temp,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS Avg_Power_Output
FROM merged_dataset
GROUP BY ROUND(AMBIENT_TEMPRETURE, 0)
ORDER BY Ambient_Temp;

#6. Check how rain affects solar power output
SELECT 
    CASE 
        WHEN RAIN = 0 THEN 'No Rain'
        ELSE 'Rainy'
    END AS Rain_Condition,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS avg_power_output,
    COUNT(*) AS total_records
FROM merged_dataset
GROUP BY Rain_Condition
ORDER BY avg_power_output DESC;

#7. Find records where power output is less than 50% of average
SELECT 
    Date_Time,
    ROUND((UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS Total_Power
FROM merged_dataset
WHERE (UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2) < 
      (SELECT AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2) * 0.5 FROM merged_dataset)
ORDER BY Date_Time;

#8. Show average output of each inverter
SELECT 'UNIT1_INV1' AS inverter, ROUND(AVG(UNIT1_INV1), 2) AS avg_output FROM merged_dataset
UNION ALL
SELECT 'UNIT1_INV2', ROUND(AVG(UNIT1_INV2), 2) FROM merged_dataset
UNION ALL
SELECT 'UNIT2_INV1', ROUND(AVG(UNIT2_INV1), 2) FROM merged_dataset
UNION ALL
SELECT 'UNIT2_INV2', ROUND(AVG(UNIT2_INV2), 2) FROM merged_dataset;

#9. Set cost and selling price per kWh (you can change values)
SET @cost_per_kWh = 3.5;
SET @selling_price_per_kWh = 6.0;

#10. Calculate daily total power and profit
SELECT 
    DATE(Date_Time) AS date,
    ROUND(SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000, 2) AS total_kWh,
    ROUND(SUM((@selling_price_per_kWh - @cost_per_kWh) * 
    (UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000), 2) AS daily_profit
FROM merged_dataset
GROUP BY DATE(Date_Time)
ORDER BY date;

#11. Find average daily profit and total revenue
SELECT 
    ROUND(AVG((@selling_price_per_kWh - @cost_per_kWh) * 
    (UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000), 2) AS avg_daily_profit,
    ROUND(SUM((@selling_price_per_kWh) * 
    (UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000), 2) AS total_revenue
FROM merged_dataset;

#12. Find which hours produce maximum power
SELECT 
    HOUR(Date_Time) AS hour,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS avg_generation
FROM merged_dataset
GROUP BY HOUR(Date_Time)
ORDER BY avg_generation DESC;

#13. Find 5 least productive hours (lowest power generation)
SELECT 
    HOUR(Date_Time) AS hour,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS avg_generation
FROM merged_dataset
GROUP BY HOUR(Date_Time)
ORDER BY avg_generation ASC
LIMIT 5;

#14. Calculate projected profit growth (expected business success)
WITH summary AS (
    SELECT 
        ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS avg_current_output
    FROM merged_dataset
)
SELECT 
    avg_current_output,
    ROUND(((avg_current_output - (avg_current_output * 0.75)) / (avg_current_output * 0.75)) * 100, 2) AS projected_profit_growth
FROM summary;
