USE PhoneStore;

SELECT *
FROM Customers;

SELECT *
FROM Phones;

SELECT *
FROM Orders;

SELECT *
FROM orderdetails;

SELECT *
FROM Payment;

SELECT *
FROM Employees;

SELECT *
FROM Suppliers;

SELECT *
FROM PhoneReviews


SELECT *
FROM Department;


SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
JOIN Orders o on c.CustomerID = o.CustomerID;


SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
LEFT JOIN Orders o on c.CustomerID = o.CustomerID;


SELECT c.CustomerID, c.FirstName, c.LastName, c.Email
FROM Customers c
WHERE City = "Seattle"


SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;


SELECT  p.PhoneID, p.Brand, p.Model, o.orderID, o.quantity, o.SubTotal
FROM OrderDetails o
JOIN Phones p ON o.PhoneID = p.PhoneID;


SELECT o.OrderID, o.OrderDate, o.TotalAmount, p.PaymentID, p.PaymentDate, p.PaymentAmount
FROM Payment p
JOIN Orders o ON p.ORDERID = o.ORDERID;


SELECT o.TotalAmount, p.PaymentAmount, (o.TotalAmount - p.PaymentAmount) AS Deficit
FROM Orders o
JOIN Payment p ON o.ORDERID = p.OrderID;


SELECT EmployeeID, FirstName, LastName
FROM Employees
UNION
SELECT SupplierID, FirstName, LastName
FROM Suppliers;


SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees e
UNION
SELECT o.OrderID, o.CustomerID, o.orderDate
FROM Orders o
LEFT JOIN Customers c on o.CustomerID = c.CustomerID 



SELECT e.EmployeeID, e.FirstName, e.LastName, NULL AS OrderID, NULL AS CustomerID, NULL AS OrderDate
FROM Employees e

UNION

SELECT NULL AS EmployeeID, NULL AS FirstName, NULL AS LastName, o.OrderID, o.CustomerID, o.OrderDate
FROM Orders o
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID;



SELECT
    e.EmployeeID,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName,
    o.OrderID,
    o.OrderDate,
    c.CustomerID,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName
FROM
    Orders o
JOIN
    Customers c ON o.CustomerID = c.CustomerID
JOIN
    Employees e ON o.OrderID = e.OrderID;
   
   
   
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Department d ON e.EmployeeID = d.EmployeeID


SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
CROSS JOIN Department d

SELECT c.CustomerID, c.FirstName, c.LastName, p.PhoneID, p.Brand, p.Price, r.ReviewText
FROM Customers c
JOIN Phones p ON c.CustomerID = p.CustomerID
JOIN PhoneReviews r ON c.CustomerID = r.CustomerID


SELECT 	s.SupplierID, 
		CONCAT(s.FirstName, ' ', s.LastName) AS SupplierFullName,
		p.PhoneID,
        p.Brand,
        o.OrderID,
        o.OrderDate,
        ord.Quantity,
        o.TotalAmount
FROM Orders o
JOIN Suppliers s ON o.OrderID = s.OrderID
JOIN Phones p ON o.CustomerID = p.CustomerID
JOIN OrderDetails ord ON o.OrderID = ord.OrderID 
 
 
SELECT AVG(SALARY) AS AverageSalary
FROM Employees;


SELECT 	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
		SALARY,
		(SELECT AVG(SALARY) FROM Employees) AS AverageSalary
FROM Employees e


# Subquery in the SELECT and WHERE clause
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
		e.Salary, (SELECT AVG(SALARY) FROM Employees) AS AverageSalary
FROM Employees e
WHERE e.Salary > (SELECT AVG(SALARY) AS AverageSalary FROM Employees);


# Subquery in the SELECT and WHERE clause
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
		e.Salary, (SELECT AVG(SALARY) FROM Employees) AS AverageSalary
FROM Employees e
WHERE e.Salary < (SELECT AVG(SALARY) AS AverageSalary FROM Employees);



# Subquery in the JOIN clause (desired style)
SELECT 
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	e.Salary, 
    AverageSalary
FROM 
	Employees e
JOIN 
	(SELECT AVG(SALARY) AS AverageSalary 
	 FROM Employees) AS sal
  ON e.Salary > sal.AverageSalary;



# Subquery in the JOIN clause (desired style)
SELECT *
FROM 
	Employees e
JOIN 
	(SELECT AVG(SALARY) AS AverageSalary 
		FROM Employees) AS sal
		ON e.Salary > sal.AverageSalary;



# Retrieving Customer Names and Total Amount
# This query did not sum the total amount because customer names are distinct 
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(o.TotalAmount) AS TotalOrderAmount
FROM
    Customers c
JOIN
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID, c.FirstName, c.LastName;


# Subquery in the WHERE clause
SELECT *
FROM 
	Employees e
WHERE 
	e.Salary < (SELECT AVG(SALARY) AS AverageSalary FROM Employees);


# Trying to Use Group By
# Retrieving Customer Names, Department Names and Total Sales
# This query did not sum the total sales because customer names are distinct 
SELECT
    c.CustomerID,
    CONCAT (c.FirstName, ' ', c.LastName) AS CustomerFullName,
    d.DepartmentName,
    SUM(d.sales) AS TotalSales
FROM
    Customers c
JOIN
	Department d ON c.CustomerID = d.CustomerID
JOIN
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY
    d.DepartmentID, d.DepartmentName, CustomerFullName
    
    

# Department Name and the Total Sales They Make
SELECT
    d.DepartmentName,
    SUM(d.sales) AS TotalSales
FROM
	Department d
GROUP BY
    d.DepartmentName

    
# Department Name and the Average Sales They Make
SELECT 
	d.DepartmentName,  AVG(d.Sales) AS AverageSales
FROM 
	Department d
GROUP BY 
	d.DepartmentName


# Department Name and the Average Employees Salary They Make
SELECT 
	d.DepartmentName, AVG(e.SALARY) AS Salary
FROM 
	Employees e
JOIN 
	Department d ON e.EmployeeID = d.EmployeeID 
GROUP BY
	d.DepartmentName



# Department Name and the Average Employees Salary They Make
SELECT 
	d.DepartmentName, AVG(e.SALARY) AS Salary
FROM 
	Employees e
JOIN 
	Department d ON e.EmployeeID = d.EmployeeID 
GROUP BY
	d.DepartmentName
HAVING 
	AVG(e.SALARY) > 87580;
	


# Department Name and the Maximum Employees Salary They Make
SELECT 
	d.DepartmentName, MAX(SALARY) AS MaxSalary
FROM 
	Employees e
JOIN Department d 
	ON 
	 e.EmployeeID = d.EmployeeID 
GROUP BY 
	d.DepartmentName



# Names of employees who earn the highest salary with their respective department
SELECT 
	e.FirstName, e.LastName, e.Position, d.DepartmentName, e.Salary
FROM 
	Employees e
JOIN 
	Department d ON e.EmployeeID = d.EmployeeID
WHERE (d.DepartmentName, e.Salary) 
	IN 
    (SELECT d.DepartmentName, MAX(e.SALARY) AS MaxSalary
	FROM Employees e
	JOIN Department d ON e.EmployeeID = d.EmployeeID 
	GROUP BY d.DepartmentName)
                                    

# Modified The Query And Added Total Amount
SELECT 
    e.FirstName, e.LastName, e.Position, d.DepartmentName, e.Salary, o.TotalAmount
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID
JOIN 
    Orders o ON e.OrderID = o.OrderID
WHERE 
    (d.DepartmentName, e.Salary) IN 
    (SELECT 
        d.DepartmentName, MAX(e.Salary) AS MaxSalary
    FROM 
        Employees e
    JOIN 
        Department d ON e.EmployeeID = d.EmployeeID 
    GROUP BY 
        d.DepartmentName);
        

# Its Subquery 
SELECT 
	d.DepartmentName, MAX(e.Salary) AS MaxSalary
FROM 
	Employees e
JOIN 
	Department d ON e.EmployeeID = d.EmployeeID 
GROUP BY 
	d.DepartmentName;
        
        


# Department Name and Average Salary
SELECT 
	d.DepartmentName, AVG(SALARY) AS AvgSalary
FROM 
	Employees e
JOIN 
	Department d ON e.EmployeeID = d.EmployeeID 
GROUP BY 
	d.DepartmentName                                    


# Employees position, department name, max salary, and sum of orders
# We really did not get maximum salary because positions are distinct
SELECT 
	DISTINCT e.position,
	d.DepartmentName, 
	MAX(e.Salary) AS MaxSalary, 
	SUM(o.TotalAmount) AS TotalOrderAmount
FROM 
	Employees e
JOIN 
	Department d ON e.EmployeeID = d.EmployeeID
JOIN 
	Orders o ON d.OrderID = o.OrderID
GROUP BY 
	d.DepartmentName, e.position

    


# Employee Name, Sum of Total Amount, Position, Department Name, and Salary
# We really did not Sum of Total Amount because positions are distinct
SELECT 
    e.FirstName, 
    e.LastName, 
    MAX(e.Salary) AS MaxSalary, 
    SUM(o.TotalAmount) AS TotalOrderAmount, 
    e.Position, 
    d.DepartmentName, 
    e.Salary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID
JOIN 
    Orders o ON e.OrderID = o.OrderID
GROUP BY 
    e.FirstName, e.LastName, e.Position, d.DepartmentName, e.Salary;

                                    
                                    
# Department Name, Maximum Salary, Sum of TotalAmount
SELECT 
	d.DepartmentName, 
    MAX(e.Salary) AS MaxSalary, 
    SUM(o.TotalAmount) AS TotalOrderAmount
FROM 
	Employees e
JOIN 
	Department d ON e.EmployeeID = d.EmployeeID
JOIN 
	Orders o ON d.OrderID = o.OrderID
GROUP BY 
	d.DepartmentName;
    
    
# This query gives an idea of how to write a query for departments that have not employees
SELECT *
FROM 
	Department d
WHERE
	d.DepartmentName NOT IN (
		SELECT DISTINCT d.DepartmentName
        FROM 
			Department d
	)



SELECT DISTINCT d.DepartmentName
FROM Department d


# Customers who have not placed orders
SELECT 
    c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    c.Email, 
    c.Phone
FROM 
    Customers
WHERE 
    CustomerID NOT IN
				(SELECT CustomerID 
				 FROM Orders)


# Its Subquery
SELECT CustomerID 
FROM Orders


# Retrieve the details of phones that have not been reviewed by any customer.
SELECT PhoneID
FROM PhoneReviews

SELECT 
	PhoneID, 
	Brand, Model, 
    StorageCapacity, 
    Color, 
    Price
FROM 
	Phones
WHERE
	PhoneID NOT IN (SELECT PhoneID FROM PhoneReviews)


SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalQuantityOrdered
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName


# Find the phones that have the highest price
SELECT p.Brand, MAX(p.Price) AS MaximumPrice
FROM Phones p
GROUP BY p.Brand




# Customers who have placed orders with a total amount greater than the average total amount of all orders.
SELECT AVG(o.TotalAmount) AS AverageAmount 
FROM Orders o


SELECT 
	c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    c.Email, 
    o.TotalAmount,
    (SELECT AVG(o.TotalAmount) FROM Orders o) AS AverageAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > (SELECT AVG(o.TotalAmount) AS AverageAmount FROM Orders o)  



# Phones Whose Quantity Is Greater Than The Average Quantity
SELECT AVG(ord.Quantity) AS AvgQuantity
FROM OrderDetails ord


SELECT  ord.PhoneID,
		p.Brand, 
		p.Model, 
        p.StorageCapacity,
        ord.Quantity,
        (SELECT AVG(ord.Quantity) FROM OrderDetails ord) AS AvgQuantity
FROM
	OrderDetails ord
JOIN 
	Phones p ON ord.PhoneID = p.PhoneID
WHERE
	ord.Quantity > (SELECT AVG(ord.Quantity) FROM OrderDetails ord) 



SELECT MONTH(o.OrderDate)
FROM Orders o


SELECT DAY(o.OrderDate)
FROM Orders o


SELECT	CONCAT(c.FirstName, ' ' , c.LastName) AS CustomerFullName,
		MONTH(o.OrderDate) AS MonthOfOrder,
		DAY(o.OrderDate) AS DayOfOrder,
        YEAR(o.OrderDate) AS YearOfOrder
FROM
	Customers c
JOIN
	Orders o ON c.CustomerID = o.CustomerID
    
    
    
# Employees in each Department whose Salary is Greater Than the Average Salary in that Department
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Position,
    e.Phone,
    e.Salary,
    d.DepartmentName
FROM Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID
WHERE 
    e.Salary > (
        SELECT AVG(e2.Salary)
        FROM Employees e2
        JOIN Department d2 ON e2.EmployeeID = d2.EmployeeID
        WHERE d2.DepartmentName = d.DepartmentName
    );
    
    
    
# Finance Department And Their Average Salary
SELECT 
    d.DepartmentName,
    AVG(e.Salary) AS AverageSalaryInDepartment
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID
WHERE 
    d.DepartmentName = "Finance"
GROUP BY 
    d.DepartmentName;


# Finance Employees Names And The Average Salary In Finace Department
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
    d.DepartmentName = "Finance";
    

# IT Employees Names And The Average Salary In IT Department
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
    
    
# The name that comes immediately after the WITH is the name SQL gives to the invisible table
# and the name(s) in the bracket are the names of the columns in the execution 

WITH average_salary (average_sal) AS
	(SELECT AVG(e.Salary) FROM Employees e)
SELECT e.FirstName, e.LastName, e.Salary, average_sal
FROM Employees e, average_salary 
WHERE e.Salary > average_sal



WITH average_sal (Average_Sales) AS
	(SELECT AVG(d.Sales) FROM Department d)
SELECT d.DepartmentName, d.Sales, Average_Sales
FROM Department d, average_sal
WHERE d.Sales > Average_Sales



SELECT d.DepartmentName, MAX(e.Salary) AS MaximumSalary
FROM Department d
JOIN Employees e ON d.EmployeeID = e.EmployeeID
GROUP BY d.DepartmentName


SELECT 	e.*, 
		MAX(e.Salary) OVER() AS MaximumSalary
FROM Employees e


SELECT 
    e.*,
    d.DepartmentName,
    MAX(e.Salary) OVER(PARTITION BY d.DepartmentName) AS MaximumSalary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID


SELECT 
    e.*,
    d.DepartmentName,
    AVG(e.Salary) OVER(PARTITION BY d.DepartmentName) AS AverageSalary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID
    
    
    
SELECT 
    e.*,
    d.DepartmentName,
    MAX(e.Salary) OVER(PARTITION BY d.DepartmentName) AS MaximumSalary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;





SELECT 
    e.*,
    d.DepartmentName,
    ROW_NUMBER() OVER(PARTITION BY d.DepartmentName) AS RowNumber
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;




# Fetch The First Two Employees From Each Department Who Joined The Company
# We Will Use The Window Functions Row Number, Partition By, And Order By

SELECT 
    e.*,
    d.DepartmentName,
    ROW_NUMBER() OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID) AS RowNumber
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;



SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    e.Salary,
    d.DepartmentName,
    e.EmployeeID,
    ROW_NUMBER() OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID) AS RowNumber
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;


# Now We Have All The Records For All The Employees
# Let Us Restrict It To The First Two
# We Will Use Subquery 

SELECT * 
FROM
	(
    SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    e.Salary,
    d.DepartmentName,
    e.EmployeeID,
    ROW_NUMBER() OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID) AS RowNumber
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID) AS Subquery_Output
WHERE Subquery_Output.RowNumber < 3



SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    e.Salary,
    d.DepartmentName,
    e.EmployeeID,
    RANK() OVER(PARTITION BY d.DepartmentName ORDER BY e.Salary DESC) AS Ranked_Salary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;


SELECT *
FROM 
	(SELECT 
		e.FirstName,
		e.LastName,
		e.Position,
		d.DepartmentName,
        e.Salary,
		e.EmployeeID,
		RANK() OVER(PARTITION BY d.DepartmentName ORDER BY e.Salary DESC) AS Ranked_Salary
	FROM 
		Employees e
	JOIN 
		Department d ON e.EmployeeID = d.EmployeeID) AS Subquery
WHERE Subquery.Ranked_Salary < 4



# Dense_Rank Compacts The Ordering And Doesn't Skip Even Though There Is A Duplicate In The Values Being Compared
# Rank		 (1, 2, 2, 4, 5)
# Dense_Rank (1, 2, 3, 4, 5)

SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    e.Salary,
    d.DepartmentName,
    e.EmployeeID,
    DENSE_RANK() OVER(PARTITION BY d.DepartmentName ORDER BY e.Salary DESC) AS Densed_Ranked_Salary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;



# LAG And LEAD Window Functions

# LAG Window Function
SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    e.Salary,
    d.DepartmentName,
    e.EmployeeID,
    LAG(e.Salary) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID DESC) AS Lagged_Salary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;

# LEAD Window Function
SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    e.Salary,
    d.DepartmentName,
    e.EmployeeID,
    LEAD(e.Salary) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID DESC) AS Lead_Salary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;


# Lagging By '2' And Replacing Null With '0'
SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    d.DepartmentName,
    e.EmployeeID,
    e.Salary,
    LAG(e.Salary, 2, 0) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID DESC) AS Lagged_Salary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;
    
    
    
# Leading By '2' And Replacing Null With '0'
SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    d.DepartmentName,
    e.EmployeeID,
    e.Salary,
    LEAD(e.Salary, 2, 0) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID DESC) AS Lead_Salary
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;




# Adding More Context To The Use Of Lag And Lead Window Functions
SELECT 
    e.FirstName,
    e.LastName,
    e.Position,
    d.DepartmentName,
    e.EmployeeID,
    e.Salary,
    LAG(e.Salary) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID) AS Lag_Salary,
CASE WHEN e.Salary > LAG(e.Salary) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID DESC)
	THEN "Greater Than The Previous Employee"
	WHEN e.Salary < LAG(e.Salary) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID DESC)
	THEN "Lower Than The Previous Employee"
	WHEN e.Salary = LAG(e.Salary) OVER(PARTITION BY d.DepartmentName ORDER BY e.EmployeeID DESC)
	THEN "Same As The Previous Employee"
END AS Lag_Comparison_Description
FROM 
    Employees e
JOIN 
    Department d ON e.EmployeeID = d.EmployeeID;



# FIRST_VALUE Window Function
# Most Expensive Phone Models In Each Category (Brand)
SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.Price,
        p.PhoneID,
        FIRST_VALUE(p.Model) OVER (PARTITION BY p.Brand ORDER BY p.Price DESC) AS Expensive_Models
FROM 
	Phones p
    
    
# LAST_VALUE Window Function
# Least Expensive Phone Models In Each Category (Brand)

SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.Price,
        p.PhoneID,
        LAST_VALUE(p.Model) OVER (PARTITION BY p.Brand ORDER BY p.Price DESC) AS Cheap_Models
FROM 
	Phones p






SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.Price,
        p.PhoneID,
        LAST_VALUE(p.Model) OVER 
        (PARTITION BY p.Brand ORDER BY p.Price DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Cheap_Models
FROM 
	Phones p



SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
		FIRST_VALUE(p.Model) OVER w AS Expensive_Models,
        LAST_VALUE(p.Model) OVER w AS Cheap_Models
FROM 
	Phones p
WINDOW w AS (PARTITION BY p.Brand ORDER BY p.Price DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)





# NTH_VALUE Window Function
# Write A Query To Display The Second Most Expensive Phone Model Under Each Category (Brand) 
SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.Price,
        p.PhoneID,
        NTH_VALUE(p.Model, 2) OVER (PARTITION BY p.Brand ORDER BY p.Price DESC) AS Second_Most_Expensive_Model
FROM 
	Phones p



SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
		FIRST_VALUE(p.Model) OVER w AS Expensive_Models,
        LAST_VALUE(p.Model) OVER w AS Cheap_Models,
        NTH_VALUE(p.Model, 2) OVER w AS Second_Most_Expensive_Model
FROM 
	Phones p
WINDOW w AS (PARTITION BY p.Brand ORDER BY p.Price DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)




SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
		FIRST_VALUE(p.Model) OVER w AS Expensive_Models,
        LAST_VALUE(p.Model) OVER w AS Cheap_Models,
        NTH_VALUE(p.Model, 3) OVER w AS Third_Most_Expensive_Model
FROM 
	Phones p
WINDOW w AS (PARTITION BY p.Brand ORDER BY p.Price DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)





# NTILE Window Function
# It Is Used To Group Columns Into Groups Or Sections And Assign Values To Them
# It Groups Them Per The Number You Specify In The Bracket
SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
        NTILE(3) OVER (ORDER BY p.Price DESC) AS Sections
FROM
	Phones P
    


# Adding Descriptions To It
SELECT *,	
CASE WHEN Subquery.Sections = 1 THEN "Expensive Phones"
	WHEN Subquery.Sections = 2 THEN "Mid_Range Phones"
	WHEN Subquery.Sections = 3 THEN "Cheap Phones" END Phone_Price_Description
FROM (SELECT 	p.Brand,
				p.Model,
				p.Color,
				p.PhoneID,
				p.Price,
	NTILE(3) OVER (ORDER BY p.Price DESC) AS Sections
		FROM
			Phones P) AS Subquery
            


# CUME_DIST Window Function
# We Use It To Fetch A Given Percentage (Portion) Of The Data Based On One Of The Columns
# Fetch The First 40% Of The Data Based On Price


SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
		CUME_DIST() OVER (ORDER BY p.Price DESC) AS Cume_Dist_Percentage
FROM Phones p


SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
		ROUND(CUME_DIST() OVER (ORDER BY p.Price DESC)::NUMERIC, 2) AS Cume_Dist_Percentage
FROM Phones p



# Rounding It Up To Two Decimal Places And Extracting The First 40% Of The Data Based On Price

# Using FORMAT Function To Round It
SELECT *
FROM (SELECT 	p.Brand,
				p.Model,
				p.Color,
				p.PhoneID,
				p.Price,
				FORMAT(CUME_DIST() OVER (ORDER BY p.Price DESC) * 100, 2) AS Cume_Dist_Percentage
		FROM Phones p) AS Subquery
WHERE Subquery.Cume_Dist_Percentage <= 40;



# Using ROUND Function To Round It
SELECT *
FROM (SELECT 	p.Brand,
				p.Model,
				p.Color,
				p.PhoneID,
				p.Price,
				ROUND(CUME_DIST() OVER (ORDER BY p.Price DESC) * 100, 2) AS Cume_Dist_Percentage
		FROM Phones p) AS Subquery
WHERE Subquery.Cume_Dist_Percentage <= 40;



# PERCENT_RANK Window Function
# It's Formula is (Current Row No - 1 / Total Number of Rows - 1)

SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
		PERCENT_RANK() OVER (ORDER BY p.Price) AS Percentage_Ranked
FROM Phones p



SELECT 	p.Brand,
		p.Model,
		p.Color,
        p.PhoneID,
        p.Price,
		FORMAT(PERCENT_RANK() OVER (ORDER BY p.Price) * 100, 2) AS Percentage_Ranked_Adjusted
FROM Phones p



# Finding How Expensive Bot R42 Is With Respect To Other Phones
SELECT *
FROM (
		SELECT 	p.Brand,
				p.Model,
				p.Color,
				p.PhoneID,
				p.Price,
				FORMAT(PERCENT_RANK() OVER (ORDER BY p.Price) * 100, 2) AS Percentage_Ranked_Adjusted
		FROM Phones p) AS Subquery
WHERE Subquery.Model = "Bot R42"


