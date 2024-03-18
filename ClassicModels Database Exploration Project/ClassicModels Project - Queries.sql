USE classicmodels;

SHOW TABLES;

SELECT *
FROM customers;

SELECT *
FROM employees;

SELECT *
FROM goods;

SELECT *
FROM offices;

SELECT *
FROM orderdetails;

SELECT *
FROM orders;

SELECT *
FROM payments;

SELECT *
FROM productlines;

SELECT *
FROM products;

# Total sales for each month to identify seasonal patterns.
SELECT YEAR(orderDate) AS salesYear, MONTH(orderDate) AS salesMonth, SUM(quantityOrdered * priceEach) AS totalSales
FROM orders
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY salesYear, salesMonth
ORDER BY salesYear, salesMonth;

# Average monthly sales over the available years.
SELECT MONTH(orderDate) AS salesMonth, AVG(quantityOrdered * priceEach) AS avgMonthlySales
FROM orders
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY salesMonth
ORDER BY salesMonth;

# Total sales for each year to identify yearly trends.
SELECT YEAR(orderDate) AS salesYear, SUM(quantityOrdered * priceEach) AS totalSales
FROM orders
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY salesYear

#Identify which months of the year typically have higher sales.
SELECT MONTH(orderDate) AS salesMonth, SUM(quantityOrdered * priceEach) AS totalSales
FROM orders
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY salesMonth
ORDER BY totalSales DESC;

# Total sales for each quarter to identify quarterly trends.
SELECT YEAR(orderDate) AS salesYear, 
       QUARTER(orderDate) AS salesQuarter, 
       SUM(quantityOrdered * priceEach) AS totalSales
FROM orders
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY salesYear, salesQuarter
ORDER BY salesYear, salesQuarter;

# Retrieve the top-selling products based on the quantity sold.
SELECT p.productName, SUM(od.quantityOrdered) AS totalQuantitySold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY totalQuantitySold DESC
LIMIT 10;

# Retrieve the top-selling products based on revenue.
SELECT p.productName, SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY totalRevenue DESC
LIMIT 10;

# Retrieve the top-selling product lines based on the quantity sold.
SELECT pl.productLine, SUM(od.quantityOrdered) AS totalQuantitySold
FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine
ORDER BY totalQuantitySold DESC
LIMIT 5;

# Retrieve the top-selling product lines based on revenue.
SELECT pl.productLine, SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine
ORDER BY totalRevenue DESC
LIMIT 5;

# Retrieve the distribution of sales across different product lines.
SELECT pl.productLine, COUNT(p.productCode) AS totalProducts,
       SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM productlines pl
LEFT JOIN products p ON pl.productLine = p.productLine
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine
ORDER BY totalRevenue DESC;

# Retrieve the distribution of sales across different product lines.
SELECT customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpending
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY customerName
ORDER BY totalSpending DESC;

# Segment customers by country to analyze sales distribution.
SELECT country, COUNT(*) AS customerCount,
       SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY country
ORDER BY totalRevenue DESC;

# Segment customers based on the types of products they buy the most.
SELECT c.customerName, p.productLine, COUNT(*) AS totalOrders
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
GROUP BY c.customerName, p.productLine
ORDER BY totalOrders DESC;

# Segment customers based on how frequently they place orders.
SELECT c.customerName, COUNT(*) AS orderCount
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
ORDER BY orderCount DESC;

# Segment customers based on their credit limits.
SELECT customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC;

# Segment customers based on the sales representative assigned to them.
SELECT e.firstName AS salesRepFirstName, e.lastName AS salesRepLastName,
       c.customerName, COUNT(*) AS orderCount
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY salesRepFirstName, salesRepLastName, c.customerName
ORDER BY orderCount DESC;

# Percentage of customers who made purchases in consecutive months.
SELECT
    DATE_FORMAT(o1.orderDate, '%Y-%m') AS month,
    COUNT(DISTINCT o1.customerNumber) AS currentCustomers,
    COUNT(DISTINCT o2.customerNumber) AS returningCustomers,
    COUNT(DISTINCT o2.customerNumber) / COUNT(DISTINCT o1.customerNumber) * 100 AS retentionRate
FROM orders o1
LEFT JOIN orders o2 ON o1.customerNumber = o2.customerNumber
    AND DATE_FORMAT(o1.orderDate, '%Y-%m') = DATE_FORMAT(DATE_SUB(o2.orderDate, INTERVAL 1 MONTH), '%Y-%m')
GROUP BY month
ORDER BY month;

# Percentage of customers who made purchases in consecutive years.
SELECT
    DATE_FORMAT(o1.orderDate, '%Y') AS year,
    COUNT(DISTINCT o1.customerNumber) AS currentCustomers,
    COUNT(DISTINCT o2.customerNumber) AS returningCustomers,
    COUNT(DISTINCT o2.customerNumber) / COUNT(DISTINCT o1.customerNumber) * 100 AS retentionRate
FROM orders o1
LEFT JOIN orders o2 ON o1.customerNumber = o2.customerNumber
    AND DATE_FORMAT(o1.orderDate, '%Y') = DATE_FORMAT(DATE_SUB(o2.orderDate, INTERVAL 1 YEAR), '%Y')
GROUP BY year
ORDER BY year;
Calculate Retention Rate by Customer Category:
Analyze customer retention rates based on customer category (high-value, medium-value, low-value).

sql
Copy code
SELECT c.customerNumber, c.customerName, c.creditLimit,
       COUNT(DISTINCT o1.orderNumber) AS totalOrders,
       COUNT(DISTINCT o2.orderNumber) AS returningOrders,
       COUNT(DISTINCT o2.orderNumber) / COUNT(DISTINCT o1.orderNumber) * 100 AS retentionRate
FROM customers c
LEFT JOIN orders o1 ON c.customerNumber = o1.customerNumber
LEFT JOIN orders o2 ON c.customerNumber = o2.customerNumber
    AND o1.orderNumber <> o2.orderNumber
GROUP BY c.customerNumber, c.customerName, c.creditLimit
ORDER BY retentionRate DESC;

# Percentage of customers who made purchases in consecutive years.
SELECT p.productLine,
       COUNT(DISTINCT o1.customerNumber) AS currentCustomers,
       COUNT(DISTINCT o2.customerNumber) AS returningCustomers,
       COUNT(DISTINCT o2.customerNumber) / COUNT(DISTINCT o1.customerNumber) * 100 AS retentionRate
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o1 ON od.orderNumber = o1.orderNumber
LEFT JOIN orders o2 ON od.orderNumber = o2.orderNumber
    AND o1.customerNumber = o2.customerNumber
GROUP BY p.productLine
ORDER BY retentionRate DESC;

# Retention Rate by Customer Category:
SELECT c.customerNumber, c.customerName, c.creditLimit,
       COUNT(DISTINCT o1.orderNumber) AS totalOrders,
       COUNT(DISTINCT o2.orderNumber) AS returningOrders,
       COUNT(DISTINCT o2.orderNumber) / COUNT(DISTINCT o1.orderNumber) * 100 AS retentionRate
FROM customers c
LEFT JOIN orders o1 ON c.customerNumber = o1.customerNumber
LEFT JOIN orders o2 ON c.customerNumber = o2.customerNumber
    AND o1.orderNumber <> o2.orderNumber
GROUP BY c.customerNumber, c.customerName, c.creditLimit
ORDER BY retentionRate DESC;

# Customer retention rates based on the product lines they purchase from.
SELECT p.productLine,
       COUNT(DISTINCT o1.customerNumber) AS currentCustomers,
       COUNT(DISTINCT o2.customerNumber) AS returningCustomers,
       COUNT(DISTINCT o2.customerNumber) / COUNT(DISTINCT o1.customerNumber) * 100 AS retentionRate
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o1 ON od.orderNumber = o1.orderNumber
LEFT JOIN orders o2 ON od.orderNumber = o2.orderNumber
    AND o1.customerNumber = o2.customerNumber
GROUP BY p.productLine
ORDER BY retentionRate DESC;

# Calculate the average order size for different customer segments.
SELECT c.customerName, AVG(od.quantityOrdered * od.priceEach) AS avgOrderSize
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY avgOrderSize DESC;

# Average number of orders placed by different customer segments.
SELECT c.customerName, COUNT(o.orderNumber) AS orderCount,
       COUNT(o.orderNumber) / DATEDIFF(MAX(o.orderDate), MIN(o.orderDate)) AS avgOrderFrequency
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
ORDER BY orderCount DESC;


# Calculate the average order size for customers from different countries.
SELECT c.country, AVG(od.quantityOrdered * od.priceEach) AS avgOrderSize
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY avgOrderSize DESC;

#Average number of orders placed by customers from different countries.
SELECT c.country, COUNT(o.orderNumber) AS orderCount,
       COUNT(o.orderNumber) / DATEDIFF(MAX(o.orderDate), MIN(o.orderDate)) AS avgOrderFrequency
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.country
ORDER BY orderCount DESC;

# Average order size for different product lines.
SELECT p.productLine, AVG(od.quantityOrdered * od.priceEach) AS avgOrderSize
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY avgOrderSize DESC;


SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpending
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY totalSpending DESC
LIMIT 10;


SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpending
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY totalSpending DESC
LIMIT 10;
Top High-Value Customers by Order Count:
Retrieve the top high-value customers based on the number of orders placed.

sql
Copy code
SELECT c.customerName, COUNT(o.orderNumber) AS orderCount
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
ORDER BY orderCount DESC
LIMIT 10;
High-Value Customers with High Average Order Size:
Identify high-value customers with a consistently high average order size.

sql
Copy code
SELECT c.customerName, AVG(od.quantityOrdered * od.priceEach) AS avgOrderSize
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
HAVING avgOrderSize > (SELECT AVG(quantityOrdered * priceEach) FROM orderdetails)
ORDER BY avgOrderSize DESC;
High-Value Customers by Country:
Identify high-value customers from different countries.

sql
Copy code
SELECT c.country, c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpending
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country, c.customerName
ORDER BY totalSpending DESC;
High-Value Customers by Employee Assigned:
Identify high-value customers assigned to different sales representatives.


SELECT e.firstName AS salesRepFirstName, e.lastName AS salesRepLastName,
       c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpending
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY salesRepFirstName, salesRepLastName, c.customerName
ORDER BY totalSpending DESC;


# High-value customers assigned to different sales representatives.
SELECT e.firstName AS salesRepFirstName, e.lastName AS salesRepLastName,
       c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpending
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY salesRepFirstName, salesRepLastName, c.customerName
ORDER BY totalSpending DESC;


# Retrieve the top selling products based on the quantity sold.
SELECT p.productName, SUM(od.quantityOrdered) AS totalUnitsSold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY totalUnitsSold DESC
LIMIT 10;

# Calculate the total units sold for each product line.
SELECT p.productLine, SUM(od.quantityOrdered) AS totalUnitsSold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY totalUnitsSold DESC;

# Monthly units sold for a specific product to observe trends.
SELECT p.productName, DATE_FORMAT(o.orderDate, '%Y-%m') AS month,
       SUM(od.quantityOrdered) AS totalUnitsSold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY p.productName, month
ORDER BY p.productName, month;

# Total units sold for each product in different countries.
SELECT c.country, p.productName, SUM(od.quantityOrdered) AS totalUnitsSold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
GROUP BY c.country, p.productName
ORDER BY totalUnitsSold DESC;

# Total units sold for each product by sales representative.
SELECT e.firstName AS salesRepFirstName, e.lastName AS salesRepLastName,
       p.productName, SUM(od.quantityOrdered) AS totalUnitsSold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY salesRepFirstName, salesRepLastName, p.productName
ORDER BY totalUnitsSold DESC;

SELECT p.productName, 
       SUM((od.quantityOrdered * od.priceEach) - (od.quantityOrdered * p.buyPrice)) AS totalProfit,
       SUM(od.quantityOrdered * od.priceEach) AS totalRevenue,
       SUM(od.quantityOrdered * p.buyPrice) AS totalCost,
       (SUM((od.quantityOrdered * od.priceEach) - (od.quantityOrdered * p.buyPrice)) / SUM(od.quantityOrdered * od.priceEach)) * 100 AS profitMargin
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY profitMargin DESC
LIMIT 10;
Products with Highest Profit Margin by Product Line:
Identify products with the highest profit margin within each product line.

sql
Copy code
SELECT p.productLine, p.productName,
       (SUM((od.quantityOrdered * od.priceEach) - (od.quantityOrdered * p.buyPrice)) / SUM(od.quantityOrdered * od.priceEach)) * 100 AS profitMargin
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine, p.productName
HAVING profitMargin = (SELECT MAX((SUM((quantityOrdered * priceEach) - (quantityOrdered * buyPrice)) / SUM(quantityOrdered * priceEach)) * 100) FROM orderdetails);
Product Lines with Highest Average Profit Margin:
Calculate the average profit margin for each product line.

# Top products based on their profit margin (revenue minus cost).
SELECT p.productLine,
       AVG((od.quantityOrdered * od.priceEach) - (od.quantityOrdered * p.buyPrice)) AS avgProfit,
       AVG(od.quantityOrdered * od.priceEach) AS avgRevenue,
       AVG(od.quantityOrdered * p.buyPrice) AS avgCost,
       (AVG((od.quantityOrdered * od.priceEach) - (od.quantityOrdered * p.buyPrice)) / AVG(od.quantityOrdered * od.priceEach)) * 100 AS avgProfitMargin
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY avgProfitMargin DESC;

# Products with the highest profit margin within each product line.
SELECT p.productLine,
       AVG((od.quantityOrdered * od.priceEach) - (od.quantityOrdered * p.buyPrice)) AS avgProfit,
       AVG(od.quantityOrdered * od.priceEach) AS avgRevenue,
       AVG(od.quantityOrdered * p.buyPrice) AS avgCost,
       (AVG((od.quantityOrdered * od.priceEach) - (od.quantityOrdered * p.buyPrice)) / AVG(od.quantityOrdered * od.priceEach)) * 100 AS avgProfitMargin
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY avgProfitMargin DESC;

# The total sales amount for each country.
SELECT c.country, SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY totalSales DESC;

#Grouping countries into regions and calculate total sales for each region.
SELECT CASE
           WHEN c.country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
           WHEN c.country IN ('UK', 'France', 'Germany', 'Italy', 'Spain') THEN 'Europe'
           ELSE 'Other'
       END AS region,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY region
ORDER BY totalSales DESC;


# Countries with the highest sales and customer counts.
SELECT c.country, COUNT(DISTINCT c.customerNumber) AS customerCount,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY totalSales DESC, customerCount DESC;


# Analyze how sales contribution by countries has changed over different years or months.
SELECT c.country, DATE_FORMAT(o.orderDate, '%Y-%m') AS period,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country, period
ORDER BY c.country, period;


# Calculate sales contribution by country for each product line.
SELECT c.country, p.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
GROUP BY c.country, p.productLine
ORDER BY c.country, totalSales DESC;

# Total sales amount for each geographic region.
SELECT 
   CASE
       WHEN c.country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
       WHEN c.country IN ('UK', 'France', 'Germany', 'Italy', 'Spain') THEN 'Europe'
       ELSE 'Other'
   END AS region,
   SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY region
ORDER BY totalSales DESC;

# Compare sales performance across regions for different years.
SELECT 
   CASE
       WHEN c.country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
       WHEN c.country IN ('UK', 'France', 'Germany', 'Italy', 'Spain') THEN 'Europe'
       ELSE 'Other'
   END AS region,
   DATE_FORMAT(o.orderDate, '%Y') AS year,
   SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY region, year
ORDER BY region, year;

# Compare sales performance across regions for different product lines.
SELECT 
   CASE
       WHEN c.country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
       WHEN c.country IN ('UK', 'France', 'Germany', 'Italy', 'Spain') THEN 'Europe'
       ELSE 'Other'
   END AS region,
   p.productLine,
   SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
GROUP BY region, p.productLine
ORDER BY region, totalSales DESC;

# Compare sales performance across regions for different sales representatives.
SELECT 
   CASE
       WHEN c.country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
       WHEN c.country IN ('UK', 'France', 'Germany', 'Italy', 'Spain') THEN 'Europe'
       ELSE 'Other'
   END AS region,
   e.firstName, e.lastName,
   SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY region, e.firstName, e.lastName
ORDER BY region, totalSales DESC;


# Calculate Average Processing Time
SELECT AVG(DATEDIFF(o.shippedDate, o.orderDate)) AS avgProcessingTime
FROM orders o
WHERE o.shippedDate IS NOT NULL;


# Calculate Average Processing Time In Years and Months
SELECT YEAR(orderDate) AS year,
       MONTH(orderDate) AS month,
       AVG(DATEDIFF(shippedDate, orderDate)) AS avgProcessingTime
FROM orders
WHERE shippedDate IS NOT NULL
GROUP BY year, month
ORDER BY year, month;

# Total number of orders for each day of the week.
SELECT DAYNAME(orderDate) AS dayOfWeek, COUNT(orderNumber) AS orderCount
FROM orders
GROUP BY dayOfWeek
ORDER BY orderCount DESC;

# The total number of orders for each month.
SELECT MONTH(orderDate) AS month, COUNT(orderNumber) AS orderCount
FROM orders
GROUP BY month
ORDER BY month;

# Total number of orders for each year and month.
SELECT YEAR(orderDate) AS year, MONTH(orderDate) AS month, COUNT(orderNumber) AS orderCount
FROM orders
GROUP BY year, month
ORDER BY year, month;


# Total number of orders for each year and quarter.
SELECT YEAR(orderDate) AS year, 
       QUARTER(orderDate) AS quarter, 
       COUNT(orderNumber) AS orderCount
FROM orders
GROUP BY year, quarter
ORDER BY year, quarter;


# Calculate the average order volume for each day of the week.
SELECT DAYNAME(orderDate) AS dayOfWeek, 
       AVG(orderCount) AS avgOrderCount
FROM (
    SELECT orderDate, COUNT(orderNumber) AS orderCount
    FROM orders
    GROUP BY orderDate
) AS daily_orders
GROUP BY dayOfWeek
ORDER BY avgOrderCount DESC;