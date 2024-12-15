# Amazon Analysis - SQL

[dataset](https://drive.google.com/file/d/1sWfLpve4JIiOCPeT2VOGc9owy7RR8PbN/view?usp=drive_link)

---
## Basic Processes

After Data Cleaning & Processing.
Use SQL queries to explore sales, customer behavior, and product performance from the Amazon dataset. The dataset contains transaction details such as product prices, quantities, and customer demographics. 
Through SQL, we analyze trends and insights to support data-driven decisions.

## Questions

1. What is the count of distinct cities in the dataset?
2. For each branch, what is the corresponding city?
3. What is the count of distinct product lines in the dataset?
4. Which payment method occurs most frequently?
5. Which product line has the highest sales?
6. How much revenue is generated each month?
7. In which month did the cost of goods sold reach its peak?
8. Which product line generated the highest revenue?
9. In which city was the highest revenue recorded?
10. Which product line incurred the highest Value Added Tax?
11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
12. Identify the branch that exceeded the average number of products sold.
13. Which product line is most frequently associated with each gender?
14. Calculate the average rating for each product line.
15. Count the sales occurrences for each time of day on every weekday.
16. Identify the customer type contributing the highest revenue.
17. Determine the city with the highest VAT percentage.
18. Identify the customer type with the highest VAT payments.
19. What is the count of distinct customer types in the dataset?
20. What is the count of distinct payment methods in the dataset?
21. Which customer type occurs most frequently?
22. Identify the customer type with the highest purchase frequency.
23. Determine the predominant gender among customers.
24. Examine the distribution of genders within each branch.
25. Identify the time of day when customers provide the most ratings.
26. Determine the time of day with the highest customer ratings for each branch.
27. Identify the day of the week with the highest average ratings.
28. Determine the day of the week with the highest average ratings for each branch.

---


## Top 10 Questions Querry & Results


## 1. What is the count of distinct cities in the dataset?  
Querry :    SELECT COUNT(DISTINCT City) AS Distinct_Cities FROM amazon;    
Result : 3



## 2. For each branch, what is the corresponding city?  
Querry :    SELECT Branch, City FROM amazon GROUP BY Branch, City;     
Result : 
		A Yangon, 
		C Naypyitaw, 
		B Mandalay. 



## 3. What is the count of distinct product lines in the dataset?  
Querry :    SELECT COUNT(DISTINCT Pdt_line) AS Distinct_Product_Lines FROM amazon;   
Result : 6



## 4. Which payment method occurs most frequently?  
Querry :    SELECT Payment, COUNT(*) AS Frequency FROM amazon GROUP BY Payment ORDER BY Frequency DESC LIMIT 1;   
Result : Cash = 344



## 5. Which product line has the highest sales?  
Querry :    SELECT Pdt_line, ROUND(SUM(Total), 2) AS Total_Sales FROM amazon GROUP BY Pdt_line ORDER BY Total_Sales DESC LIMIT 1;         
Result :  Food and beverages = 56144.96



## 6. How much revenue is generated each month?  
Querry :    SELECT month_name, ROUND(SUM(Total), 2) AS Monthly_Revenue FROM amazon GROUP BY month_name;   
Result : 
		January = 116292.11,
		March = 108867.38,
		February = 95727.58



## 7. In which month did the cost of goods sold reach its peak?  
Querry :    SELECT month_name, ROUND(SUM(cogs), 2) AS Total_COGS FROM amazon GROUP BY month_name ORDER BY Total_COGS DESC LIMIT 1;  
Result : January = 110754.16



## 8. Which product line generated the highest revenue?  
Querry :    SELECT Pdt_line, MAX(Total) AS Highest_Revenue FROM amazon GROUP BY Pdt_line;  
Result : 
		Health and beauty = 950.25,
		Electronic accessories = 942.45,
		Home and lifestyle = 1023.75,
		Sports and travel = 1002.12,
		Food and beverages = 1034.46,
		Fashion accessories = 1042.65.




## 9. In which city was the highest revenue recorded?  
Querry :    SELECT City, ROUND(SUM(Total), 2) AS Total_Revenue FROM amazon GROUP BY City ORDER BY Total_Revenue DESC LIMIT 1;  
Result :  Naypyitaw = 110490.93



## 10. Which product line incurred the highest Value Added Tax?  

Querry :    SELECT Pdt_line, MAX(tax5perc) AS Highest_VAT FROM amazon GROUP BY Pdt_line;  
Result : 
		Health and beauty = 45.25,
		Electronic accessories = 44.88,
		Home and lifestyle = 48.75,
		Sports and travel = 47.72,
		Food and beverages = 49.26,
		Fashion accessories = 49.65,


  **********






## Conclusion

This analysis uncovers valuable insights into sales trends, customer behavior, and product performance, helping businesses make informed decisions for growth and optimization.  
* ALL Questions are Resolved.  
* Check PPT Presentation for Key Insights.  

---

