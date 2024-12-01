use nithin; #use any existing database

CREATE TABLE amazon (
    inv_id VARCHAR(255),
    branch CHAR(1),
    city VARCHAR(255),
    c_type VARCHAR(10),
    gender VARCHAR(10),
    pdt_line VARCHAR(255),
    unit_price DECIMAL(10, 2),
    quantity INT,
    tax5perc DECIMAL(10, 2),
    total DECIMAL(10, 2),
    dt DATE,
    tm TIME,
    payment VARCHAR(50),
    cogs DECIMAL(10, 2),
    g_margin_percentage DECIMAL(5, 2),
    gross_income DECIMAL(10, 2),
    rating DECIMAL(3, 2),
    tod VARCHAR(10),
    day_name VARCHAR(10),
    month_name VARCHAR(10)
);


desc amazon;

/*
Import data feom import wizard through table
*/

select * from amazon;

UPDATE amazon SET TOD = CASE 
    WHEN SUBSTRING_INDEX(tm, ':', 1) > 6 AND SUBSTRING_INDEX(tm, ':', 1) < 12 THEN 'Morning'
    WHEN SUBSTRING_INDEX(tm, ':', 1) >= 12 AND SUBSTRING_INDEX(tm, ':', 1) < 15 THEN 'Afternoon'
    WHEN SUBSTRING_INDEX(tm, ':', 1) >= 15 AND SUBSTRING_INDEX(tm, ':', 1) < 20 THEN 'Evening' 
    ELSE 'Night' -- (Before 6am and after 8pm are considered as night)
END WHERE Inv_id > 0;

ALTER TABLE amazon ADD COLUMN day_name VARCHAR(20);
UPDATE amazon SET day_name = DAYNAME(dt);

ALTER TABLE amazon ADD COLUMN month_name VARCHAR(20);
UPDATE amazon SET month_name = MONTHNAME(dt);

SELECT * FROM amazon;

-- 1. What is the count of distinct cities in the dataset?
SELECT COUNT(DISTINCT City) AS Distinct_Cities FROM amazon;  
#3

-- 2. For each branch, what is the corresponding city?
SELECT Branch, City FROM amazon GROUP BY Branch, City;   
/*
A Yangon 
C Naypyitaw
B Mandalay
*/
-- 3. What is the count of distinct product lines in the dataset?
SELECT COUNT(DISTINCT Pdt_line) AS Distinct_Product_Lines FROM amazon; 
#6

-- 4. Which payment method occurs most frequently?
SELECT Payment, COUNT(*) AS Frequency FROM amazon GROUP BY Payment ORDER BY Frequency DESC LIMIT 1; 
#Cash 344

-- 5. Which product line has the highest sales?
SELECT Pdt_line, ROUND(SUM(Total), 2) AS Total_Sales FROM amazon 
GROUP BY Pdt_line ORDER BY Total_Sales DESC LIMIT 1;       
# Food and beverages	56144.96


-- 6. How much revenue is generated each month?
SELECT month_name, ROUND(SUM(Total), 2) AS Monthly_Revenue 
FROM amazon GROUP BY month_name; 
/*
January	116292.11
March	108867.38
February	95727.58
*/

-- 7. In which month did the cost of goods sold reach its peak?
SELECT month_name, ROUND(SUM(cogs), 2) AS Total_COGS FROM amazon 
GROUP BY month_name ORDER BY Total_COGS DESC LIMIT 1;
#	January	110754.16

-- 8. Which product line generated the highest revenue?

SELECT Pdt_line, MAX(Total) AS Highest_Revenue
FROM amazon
GROUP BY Pdt_line;
/*
Health and beauty	950.25
Electronic accessories	942.45
Home and lifestyle	1023.75
Sports and travel	1002.12
Food and beverages	1034.46
Fashion accessories	1042.65
*/

-- 9. In which city was the highest revenue recorded?

SELECT City, ROUND(SUM(Total), 2) AS Total_Revenue FROM amazon 
GROUP BY City ORDER BY Total_Revenue DESC LIMIT 1;
# Naypyitaw	110490.93

-- 10. Which product line incurred the highest Value Added Tax?

SELECT Pdt_line, MAX(tax5perc) AS Highest_VAT FROM amazon 
GROUP BY Pdt_line;
/*
Health and beauty	45.25
Electronic accessories	44.88
Home and lifestyle	48.75
Sports and travel	47.72
Food and beverages	49.26
Fashion accessories	49.65
*/

-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

SELECT Inv_id, Branch, City, C_type, Gender, Pdt_line, unit_price, Quantity, tax5perc, Total, dt, tm, Payment, cogs, g_margin_percentage, gross_income, Rating, TOD, day_name, month_name,
    IF(Total > (SELECT AVG(Total) FROM amazon), 'Good', 'Bad') AS Sales_Category FROM amazon;


-- 12. Identify the branch that exceeded the average number of products sold.

SELECT Branch, COUNT(*) AS Products_Sold FROM amazon GROUP BY Branch HAVING Products_Sold > (SELECT AVG(Quantity) FROM amazon);
/*
A	339
B	329
C	327
*/

-- 13. Which product line is most frequently associated with each gender?
SELECT Gender, Pdt_line, COUNT(*) AS Frequency FROM amazon GROUP BY Gender, Pdt_line ORDER BY Frequency DESC;
/*
Female	Fashion accessories	96
Female	Food and beverages	90
Male	Health and beauty	88
Male	Electronic accessories	86
Female	Sports and travel	86
Male	Food and beverages	84
Female	Electronic accessories	83
Male	Fashion accessories	82
Male	Home and lifestyle	81
Female	Home and lifestyle	79
Male	Sports and travel	77
Female	Health and beauty	63
*/

-- 14. Calculate the average rating for each product line.
SELECT Pdt_line, AVG(Rating) AS Average_Rating FROM amazon GROUP BY Pdt_line;
/*
Health and beauty	6.983444
Electronic accessories	6.906509
Home and lifestyle	6.837500
Sports and travel	6.859509
Food and beverages	7.113218
Fashion accessories	7.029213
*/

-- 15. Count the sales occurrences for each time of day on every weekday.
SELECT day_name, TOD, COUNT(*) AS Sales_Occurrences FROM amazon GROUP BY day_name, TOD;
/*
Saturday	Afternoon	81
Friday	Morning	29
Sunday	Afternoon	69
Sunday	Evening	41
Monday	Evening	29
Monday	Afternoon	75
Sunday	Morning	22
Thursday	Afternoon	76
Wednesday	Afternoon	80
Wednesday	Evening	39
Tuesday	Morning	36
Friday	Evening	36
Tuesday	Afternoon	71
Monday	Morning	20
Friday	Afternoon	73
Wednesday	Morning	22
Thursday	Evening	29
Saturday	Morning	28
Saturday	Evening	55
Thursday	Morning	33
Tuesday	Evening	51
*/

-- 16. Identify the customer type contributing the highest revenue.
SELECT C_type, ROUND(SUM(Total), 2) AS Total_Revenue FROM amazon 
GROUP BY C_type ORDER BY Total_Revenue DESC LIMIT 1;
# Member	163625.47


-- 17. Determine the city with the highest VAT percentage.
SELECT City, AVG(tax5perc) AS Avg_VAT_Percentage FROM amazon GROUP BY City ORDER BY Avg_VAT_Percentage DESC LIMIT 1;
# Naypyitaw	16.090581

-- 18. Identify the customer type with the highest VAT payments.
SELECT C_type, SUM(tax5perc) AS Total_VAT_Payments FROM amazon GROUP BY C_type ORDER BY Total_VAT_Payments DESC LIMIT 1;
# Member	7792.04

-- 19. What is the count of distinct customer types in the dataset?
SELECT COUNT(DISTINCT C_type) AS Distinct_Customer_Types FROM amazon;
# 2

-- 20. What is the count of distinct payment methods in the dataset?
SELECT COUNT(DISTINCT Payment) AS Distinct_Payment_Methods FROM amazon;
# 3

-- 21. Which customer type occurs most frequently?
SELECT C_type, COUNT(*) AS Frequency FROM amazon GROUP BY C_type ORDER BY Frequency DESC LIMIT 1;
# Member	499

-- 22. Identify the customer type with the highest purchase frequency.
SELECT C_type, COUNT(*) AS Purchase_Frequency FROM amazon GROUP BY C_type ORDER BY Purchase_Frequency DESC LIMIT 1;
# Member	499

-- 23. Determine the predominant gender among customers.
SELECT Gender, COUNT(*) AS Frequency FROM amazon GROUP BY Gender ORDER BY Frequency DESC LIMIT 1;
# Male	498

-- 24. Examine the distribution of genders within each branch.
SELECT Branch, Gender, COUNT(*) AS Frequency FROM amazon GROUP BY Branch, Gender;
/*
A	Female	160
C	Female	177
A	Male	179
C	Male	150
B	Female	160
B	Male	169
*/

-- 25. Identify the time of day when customers provide the most ratings.
SELECT TOD, COUNT(*) AS Rating_Count FROM amazon WHERE Rating IS NOT NULL GROUP BY TOD ORDER BY Rating_Count DESC LIMIT 1;
# Afternoon	525

-- 26. Determine the time of day with the highest customer ratings for each branch.
SELECT Branch, TOD, MAX(Rating) AS Highest_Rating FROM amazon GROUP BY Branch, TOD;
/*
A	Afternoon	9.90
C	Morning	9.90
A	Evening	9.80
A	Morning	9.90
C	Evening	9.90
B	Afternoon	9.90
B	Evening	9.90
B	Morning	9.90
C	Afternoon	9.90
*/

-- 27. Identify the day of the week with the highest average ratings.
SELECT day_name, ROUND(AVG(Rating), 2) AS Average_Rating FROM amazon 
GROUP BY day_name ORDER BY Average_Rating DESC LIMIT 1;
# Monday	7.13

-- 28. Determine the day of the week with the highest average ratings for each branch.
SELECT Branch, day_name, ROUND(AVG(Rating), 2) AS Average_Rating FROM amazon 
GROUP BY Branch, day_name ORDER BY Branch;
/*
A	Friday	7.31
A	Monday	7.10
A	Saturday	6.75
A	Sunday	7.08
A	Thursday	6.96
A	Tuesday	7.06
A	Wednesday	6.84
B	Friday	6.69
B	Monday	7.27
B	Saturday	6.74
B	Sunday	6.80
B	Thursday	6.75
B	Tuesday	7.00
B	Wednesday	6.38
C	Friday	7.21
C	Monday	7.04
C	Saturday	7.23
C	Sunday	7.03
C	Thursday	6.95
C	Tuesday	6.95
C	Wednesday	7.06
*/