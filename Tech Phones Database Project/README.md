**Welcome to "TechPhones" Database Project**

**Introduction:**

Welcome to the TechPhones project! This repository contains a comprehensive SQL database named "TechPhones," designed specifically for managing a phone shop's operations efficiently. Whether you're a developer, data analyst, or simply interested in exploring SQL databases, this project provides valuable insights and advanced querying techniques.

**Database Overview:**

The TechPhones database comprises nine tables, each serving a distinct purpose in organizing and managing the phone shop's data:

Customers: Stores information about customers.

Employees: Manages employee details.

Departments: Tracks various departments within the shop.

Orders: Records order details.

OrderDetails: Contains specifics about order items.

Payment: Manages payment information.

Phones: Stores details about available phone models.

PhoneReviews: Stores customer reviews for phones.

Suppliers: Manages supplier information.

Advanced Queries and Window Functions:

The repository includes a plethora of advanced SQL queries, utilizing various types of joins and employing window functions extensively to extract insightful information from the database. Here's a glimpse of what you'll find:

**Joins:**

Utilizing INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN to merge data from multiple tables.

**Window Functions:** 

Leveraging window functions such as LEAD, LAG, FIRST_VALUE, LAST_VALUE, RANK, DENSE_RANK, along with the OVER and PARTITION BY clauses to perform complex analytical tasks within the database.

**Subqueries:** 

Employing subqueries to break down complex problems into manageable components, enhancing query readability and efficiency.

**Common Table Expressions (CTEs):**

Leveraging CTEs to create temporary result sets, facilitating recursive queries and enhancing query modularity.



**Example Queries**


**Retrieve Department Name and the Total Sales They Make**

SELECT

    d.DepartmentName,
    
    SUM(d.sales) AS TotalSales

FROM

    Department d

GROUP BY

    d.DepartmentName


**Use a Subquery to Retrieve The Details of Employees Who Earn More Than The Average Salary**

SELECT *

FROM 

    Employees e

JOIN 

 (SELECT AVG(SALARY) AS AverageSalary 

  FROM Employees) AS sal

  ON e.Salary > sal.AverageSalary;
  

**Use CTE to Retrieve Employees Who Earn More Than The Average Salary**


WITH 
    average_salary (average_sal) AS

    (SELECT AVG(e.Salary) FROM Employees e)

SELECT 
    e.FirstName, e.LastName, e.Salary, average_sal

FROM 
    
    Employees e, average_salary 

WHERE 
    e.Salary > average_sal


**Use Window Function, OVER And Partition By To Retrieve Details of IT Employees And The Average Salary In IT Department**

SELECT 

    e.EmployeeID,
    
    e.FirstName,
    
    e.LastName,
    
    e.Position,
    
    e.Phone,
    
    e.Salary,
    
    d.DepartmentName,
    
    AVG(e.Salary) OVER (PARTITION BY d.DepartmentName) AS AverageSalaryInDepartment

FROM 

    Employees e

JOIN 

    Department d ON e.EmployeeID = d.EmployeeID

WHERE 

    d.DepartmentName = "IT";

  
**Getting Started:**

To explore the TechPhones database and advanced querying techniques:

**Clone this repository to your local machine.**

Set up a SQL environment such as MySQL, PostgreSQL, or SQLite.

Import the provided SQL script to create the TechPhones database structure and populate it with sample data.

Dive into the queries to understand how various operations are performed using SQL.

**Contributing:**

Contributions to this project are welcome! If you have suggestions for improving queries, adding new features, or fixing bugs, feel free to open an issue or submit a pull request.


Start exploring the TechPhones database now and uncover valuable insights into the operations of a phone shop! Happy querying!
