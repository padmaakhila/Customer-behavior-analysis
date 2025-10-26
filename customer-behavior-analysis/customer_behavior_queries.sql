/* ===========================================================
   Project: Customer Behavior Analysis
   Database: customer_behavior
   Table: customer
   Author: Padma Akhila
   Description:
       SQL queries to analyze customer purchase behavior,
       spending trends, and segmentation patterns.
   =========================================================== */

USE customer_behavior;
GO

------------------------------------------------------------
-- 1️ View the structure of the customer table
------------------------------------------------------------
SELECT TOP 10 *
FROM customer;

------------------------------------------------------------
-- 2️ Total number of customers
------------------------------------------------------------
SELECT COUNT(*) AS Total_Customers
FROM customer;

------------------------------------------------------------
-- 3️ Gender-wise customer distribution
------------------------------------------------------------
SELECT 
    Gender,
    COUNT(*) AS Total_Customers
FROM customer
GROUP BY Gender
ORDER BY Total_Customers DESC;

------------------------------------------------------------
-- 4️ Categorize customers by age group
------------------------------------------------------------
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN 'Young Adult'
        WHEN Age BETWEEN 26 AND 40 THEN 'Adult'
        WHEN Age BETWEEN 41 AND 60 THEN 'Middle Aged'
        ELSE 'Senior'
    END AS Age_Group,
    COUNT(*) AS Total_Customers
FROM customer
GROUP BY 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN 'Young Adult'
        WHEN Age BETWEEN 26 AND 40 THEN 'Adult'
        WHEN Age BETWEEN 41 AND 60 THEN 'Middle Aged'
        ELSE 'Senior'
    END
ORDER BY Total_Customers DESC;

------------------------------------------------------------
-- 5️ Total purchase amount by age group
------------------------------------------------------------
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN 'Young Adult'
        WHEN Age BETWEEN 26 AND 40 THEN 'Adult'
        WHEN Age BETWEEN 41 AND 60 THEN 'Middle Aged'
        ELSE 'Senior'
    END AS Age_Group,
    SUM(Purchase_Amount_USD) AS Total_Purchase
FROM customer
GROUP BY 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN 'Young Adult'
        WHEN Age BETWEEN 26 AND 40 THEN 'Adult'
        WHEN Age BETWEEN 41 AND 60 THEN 'Middle Aged'
        ELSE 'Senior'
    END
ORDER BY Total_Purchase DESC;

------------------------------------------------------------
-- 6️ Average spending by gender
------------------------------------------------------------
SELECT 
    Gender,
    ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spending
FROM customer
GROUP BY Gender
ORDER BY Avg_Spending DESC;

------------------------------------------------------------
-- 7️ Top 10 customers with highest spending
------------------------------------------------------------
SELECT TOP 10 
    Customer_ID,
    Gender,
    Age,
    Purchase_Amount_USD
FROM customer
ORDER BY Purchase_Amount_USD DESC;

------------------------------------------------------------
-- 8 Find customers who purchased above average spending
------------------------------------------------------------
SELECT 
    Customer_ID,
    Age,
    Gender,
    Purchase_Amount_USD
FROM customer
WHERE Purchase_Amount_USD > (
    SELECT AVG(Purchase_Amount_USD) FROM customer
)
ORDER BY Purchase_Amount_USD DESC;

------------------------------------------------------------
-- 9 Total revenue and average purchase value
------------------------------------------------------------
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(Purchase_Amount_USD) AS Total_Revenue,
    ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Purchase_Value
FROM customer;
