--  Create & Use your Solar Power database
Create database SolarPower;
USE SolarPower;

-- View dataset
SELECT * FROM merged_dataset;

-- View first 10 records
SELECT * FROM merged_dataset LIMIT 10;

-- Count total records
SELECT COUNT(*) AS total_records FROM merged_dataset;

-- Check structure
DESCRIBE merged_dataset;

---------------------------------------------------------------
#1. Average inverter performance & irradiance
---------------------------------------------------------------
SELECT
    ROUND(AVG(UNIT1_INV1), 2) AS avg_inv1,
    ROUND(AVG(UNIT1_INV2), 2) AS avg_inv2,
    ROUND(AVG(UNIT2_INV1), 2) AS avg_inv3,
    ROUND(AVG(UNIT2_INV2), 2) AS avg_inv4,
    ROUND(MIN(Gobal_irradiance_index), 2) AS min_irradiance,
    ROUND(MAX(Gobal_irradiance_index), 2) AS max_irradiance,
    ROUND(AVG(Gobal_irradiance_index), 2) AS avg_irradiance
FROM merged_dataset;


---------------------------------------------------------------
#2. Top 5 days with highest power output
---------------------------------------------------------------
SELECT 
    DATE(Date_Time) AS date,
    ROUND(SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS total_output
FROM merged_dataset
GROUP BY DATE(Date_Time)
ORDER BY total_output DESC
LIMIT 5;


---------------------------------------------------------------
#3. Top 5 days with lowest power output
---------------------------------------------------------------
SELECT 
    DATE(Date_Time) AS date,
    ROUND(SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS total_output
FROM merged_dataset
GROUP BY DATE(Date_Time)
ORDER BY total_output ASC
LIMIT 5;


---------------------------------------------------------------
#4. High vs Low Irradiance power output
---------------------------------------------------------------
SELECT 
    CASE 
        WHEN Gobal_irradiance_index > 
             (SELECT AVG(Gobal_irradiance_index) FROM merged_dataset)
        THEN 'High Irradiance'
        ELSE 'Low Irradiance'
    END AS Irradiance_Level,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS avg_power
FROM merged_dataset
GROUP BY Irradiance_Level;


---------------------------------------------------------------
#5. Power output across temperature
---------------------------------------------------------------
SELECT
    ROUND(AMBIENT_TEMPRETURE, 0) AS Ambient_Temp,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 2) AS Avg_Power_Output
FROM merged_dataset
GROUP BY ROUND(AMBIENT_TEMPRETURE, 0)
ORDER BY Ambient_Temp;


---------------------------------------------------------------
#6. Rain impact on output
---------------------------------------------------------------
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

---------------------------------------------------------------
#7. Average output of each inverter
---------------------------------------------------------------
SELECT 'UNIT1_INV1' AS inverter, ROUND(AVG(UNIT1_INV1), 2) AS avg_output FROM merged_dataset
UNION ALL SELECT 'UNIT1_INV2', ROUND(AVG(UNIT1_INV2), 2) FROM merged_dataset
UNION ALL SELECT 'UNIT2_INV1', ROUND(AVG(UNIT2_INV1), 2) FROM merged_dataset
UNION ALL SELECT 'UNIT2_INV2', ROUND(AVG(UNIT2_INV2), 2) FROM merged_dataset;


---------------------------------------------------------------
#8. Set Price & Cost 
---------------------------------------------------------------
SET @cost_per_kWh = 3;
SET @selling_price_per_kWh = 5;
SET @profit_margin = @selling_price_per_kWh - @cost_per_kWh;
-- profit_margin = 2 per kWh
---------------------------------------------------------------
#9. Daily kWh & Daily Profit 
---------------------------------------------------------------
SELECT 
    DATE(Date_Time) AS date,
    ROUND(SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000, 3) AS total_kWh,
    ROUND((SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000)*@profit_margin, 3) AS daily_profit
FROM merged_dataset
GROUP BY DATE(Date_Time)
ORDER BY date;


---------------------------------------------------------------
#10. Average Daily Profit & Total Revenue 
---------------------------------------------------------------
SELECT 
    ROUND(AVG((UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000 * @profit_margin), 3) 
        AS avg_daily_profit,
    ROUND(SUM((UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000 * @selling_price_per_kWh), 3)
        AS total_revenue
FROM merged_dataset;


---------------------------------------------------------------
#11. Hours with max power
---------------------------------------------------------------
SELECT 
    HOUR(Date_Time) AS hour,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 3) AS avg_generation
FROM merged_dataset
GROUP BY HOUR(Date_Time)
ORDER BY avg_generation DESC
LIMIT 5;


---------------------------------------------------------------
#12. 5 least productive hours
---------------------------------------------------------------
SELECT 
    HOUR(Date_Time) AS hour,
    ROUND(AVG(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2), 3) AS avg_generation
FROM merged_dataset
GROUP BY HOUR(Date_Time)
ORDER BY avg_generation ASC
LIMIT 5;


---------------------------------------------------------------
#13. Simple 30% Profit Growth Calculation 
---------------------------------------------------------------
-- Current profit 
SELECT 
    ROUND(
        (SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000) * @profit_margin,
        2
    ) AS current_profit
FROM merged_dataset;

-- Profit after 30% increase 
SELECT 
    ROUND(
        ((SUM(UNIT1_INV1 + UNIT1_INV2 + UNIT2_INV1 + UNIT2_INV2)/1000) * @profit_margin)
        * 1.30,
        2
    ) AS profit_after_30_percent_increase
FROM merged_dataset;
