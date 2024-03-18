CREATE DATABASE PhoneStore;

USE PhoneStore;

CREATE TABLE Customers 
	(
	CustomerID INT PRIMARY KEY NOT NULL UNIQUE,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(50),
    AddressLine VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(20)
	);
    
    
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, AddressLine, City, State, ZipCode)
VALUES  (0001, "John", "Peterson", "johnpeterson@gmail.com", 8237465938, "234 South Street", "Houston", "Texas", 72934),
	(0002, "Paul", "Johnson", "pauljohnson@gmail.com", 4657289073, "732 School Road", "Seattle", "Washington", 34566),
	(0003, "Thomas", "Wilson", "thomaswilson@gmail.com", 5673809873, "541 Grove Center", "Irvine", "California", 98532),
	(0004, "Caleb", "Rockson", "calebrockson@gmail.com", 8432456789, "984 Palace Circle", "Fairfax", "Virginia", 67923),
	(0005, "Joel", "Powell", "joelpowell@gmai.com", 8472948560, "432 University Road", "Minneapolis", "Minnesota", 46382),
	(0006, "Joyce", "Braceville", "joycebraceville@gmail.com", 5638245960, "830 Strip Avenue", "Portland", "Oregon", 94826),
	(0007, "Matt", "Ford", "mattford@gmail.com", 83492034568, "742 Cross Street", "Centerville", "Ohio", 45694),
	(0008, "Prince", "Royce", "princeroyce@gmail.com", 7849235967, "923 Lap Avenue", "Chicago", "Illinois", 46024),
	(0009, "Beatrice", "Eastwood", "beatriceeastwood@gmail.com", 3648903475, "634 Permanent Avenue", "Memphis", "Tennesse", 46294),
	(0010, "Howard", "Patterson", "howardpatterson@gmail.com", 7294056472, "510 Press Street", "Las Vegas", "Nevada", 89255),
	(0011, "Solace", "Walls", "solacewalls@gmail.com", 8392074920, "293 Type Road", "Helena", "Montana", 73293),
	(0012, "Jason", "Crabb", "jasoncrabb@gmail.com", 4234561295, "823 Glass Circle", "Atlanta", "Georgia", 23190),
	(0013, "Wes", "Brown", "wesbrown@gmail.com", 2341974697, "572 Key Road", "Lincoln", "Nebraska", 53923),
	(0014, "Bob", "Mullins", "bobmullins@gmail.com", 4204857231, "832 Live Circle", "Orlando", "Florida", 62084),
	(0015, "Adam", "Sumner", "adamsumner@gmail.com", 8342859489, "234 Ross Street", "Anderson", "Indiana", 75629);


CREATE TABLE Phones
	(
	PhoneID INT PRIMARY KEY NOT NULL UNIQUE,
	Brand VARCHAR (50),
	Model VARCHAR (50),
	StorageCapacity VARCHAR (50),
	Color VARCHAR (50),
	Price VARCHAR (50)
	);


INSERT INTO Phones (PhoneID, Brand, Model, StorageCapacity, Color, Price)
VALUES	(1001, "Apple", "iPhone 12", "128GB", "Black", 1800),
	(1002, "Samsung", "Galaxy S20", "250GB", "Brown", 1200),
	(1003, "Nokia", "Harray R24", "120GB", "White", 1000),
	(1004, "Apple", "iPhone 14", "256GB", "Blue", 1500),
	(1005, "Sony", "Hollow R32", "178GB", "Red", 4590),
	(1006, "Blackberry", "Bot R42", "356GB", "Grey", 1739),
	(1007, "ZTE", "ZTE U74", "642GB", "White", 1209),
	(1008, "Apple", "iPhone 15", "715GB", "Black", 1892),
	(1009, "Samsung", "Galaxy A25", "462GB", "Blue", 1235),
	(1010, "Apple", "Galaxy A30", "650GB", "Violet", 1593),
    (1011, "Apple", "iPhone 15", "1TB", "Green", 2983),
    (1012, "Samsung", "Galaxy A26", "428GB", "Black", 1890),
    (1013, "T Mobile", "T M45", "512GB", "Indigo", 1259),
    (1014, "Apple", "iPhone 13 Pro Max", "1TB", "Green", 1420),
    (1015, "Apple", "iPhone 14 Pro Max", "1TB", "Red", 1500);


CREATE TABLE Orders
	(
	OrderID VARCHAR PRIMARY KEY NOT NULL UNIQUE,
	CustomerID INT (50),
	OrderDate DATE,
	TotalAmount DECIMAL (10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
	);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES	(2001, 0001, "2022-09-21", 2456.48),
	(2002, 0002, "2023-01-09", 4750.45),
	(2003, 0003, "2021-09-03", 5730.23),
	(2004, 0004, "2023-04-12", 3576.89),
	(2005, 0005, "2020-08-18", 7582.47),
	(2006, 0006, "2021-05-19", 9483.92),
	(2007, 0007, "2023-09-15", 3293.74),
	(2008, 0008, "2019-04-12", 4399.46),
	(2009, 0009, "2020-05-19", 5298.83),
	(2010, 0010, "2021-04-16", 3694.74),
	(2011, 0011, "2023-12-13", 9832.73),
	(2012, 0012, "2017-12-29", 7493.94),
	(2013, 0013, "2022-11-26", 3857.83),
	(2014, 0014, "2021-10-28", 9273.90),
	(2015, 0015, "2022-11-24", 8439.32);


CREATE TABLE OrderDetails
	(	
	OrderDetailID INT PRIMARY KEY NOT NULL UNIQUE,
	OrderID INT,
	PhoneID INT ,
	Quantity INT,
	Subtotal DECIMAL (10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
    FOREIGN KEY (PhoneID) REFERENCES Phones (PhoneID)
	);

INSERT INTO OrderDetails (OrderDetailID, OrderID, PhoneID, Quantity, Subtotal)
VALUES	(3001, 2001, 1001, 89, 739.89),
	(3002, 2002, 1002, 43, 329.39),
	(3003, 2003, 1003, 48, 498.23),
	(3004, 2004, 1004, 56, 832.18),
	(3005, 2005, 1005, 75, 582.47),
	(3006, 2006, 1006, 93, 943.92),
	(3007, 2007, 1007, 32, 293.74),
	(3008, 2008, 1008, 51, 399.46),
	(3009, 2009, 1009, 80, 298.83),
	(3010, 2010, 1010, 62, 694.74),
	(3011, 2011, 1011, 46, 832.73),
	(3012, 2012, 1012, 67, 493.94),
	(3013, 2013, 1013, 98, 857.83),
	(3014, 2014, 1014, 15, 273.90),
	(3015, 2015, 1015, 29, 439.32);


CREATE TABLE Payment
	(
	PaymentID INT PRIMARY KEY NOT NULL UNIQUE,
	OrderID INT,
	PaymentDate DATE,
	PaymentAmount DECIMAL (10, 2),
     FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
	);

INSERT INTO Payment (PaymentID, OrderID, PaymentDate, PaymentAmount)
VALUES	(4001, 2001, "2021-09-21", 1456.48),
	(4002, 2002, "2022-01-09", 2750.45),
	(4003, 2003, "2020-09-03", 4730.23),
	(4004, 2004, "2022-04-12", 2576.89),
	(4005, 2005, "2021-08-18", 5582.47),
	(4006, 2006, "2020-05-19", 6483.92),
	(4007, 2007, "2022-09-15", 1293.74),
	(4008, 2008, "2018-04-12", 3399.46),
	(4009, 2009, "2021-05-19", 4298.83),
	(4010, 2010, "2020-04-16", 2694.74),
	(4011, 2011, "2022-12-13", 8832.73),
	(4012, 2012, "2018-12-29", 5493.94),
	(4013, 2013, "2023-11-26", 2857.83),
	(4014, 2014, "2022-10-28", 7273.90),
	(4015, 2015, "2021-11-24", 4439.32);



CREATE TABLE Employees
	(
	EmployeeID INT PRIMARY KEY NOT NULL UNIQUE,
	FirstName VARCHAR (50),
	LastName VARCHAR (50),
	Position VARCHAR (50),
	Phone VARCHAR (50),
	Salary VARCHAR (50)
	);
	

INSERT INTO Employees (EmployeeID, FirstName, LastName, Position, Phone, SALARY)
VALUES	(5001, "Jones", "Harris", "Software Architect", 9348732940, 89000),
	(5002, "Tyler", "Collingsworth", "Systems Analyst", 3629475923, 85000),
	(5003, "Prince", "Parker", "System Administrator", 48592340126, 87000),
	(5004, "Jones", "Phelps", "Area Manager", 5639239840, 93000),
	(5005, "Zac", "Vince", "Data Analyst", 89038429384, 88000),
	(5006, "Herbert", "Gardner", "Data Scientist", 73623495839, 89000),
	(5007, "Jerry", "Clinton", "Computer Scientist", 4293853094, 92000),
	(5008, "Benjy", "Easter", "Software Developer", 732937743902, 90000),
	(5009, "Royce", "Yorkshire", "Database Administrator", 4294857203, 88000),
	(5010, "Tom", "West", "Python Developer", 63298492340, 86000),
	(5011, "Wesley", "Penrod", "Procurement Officer", 8372495832, 85900),
	(5012, "George", "Eisenhower", "Sales Manager", 4839857209, 90000),
    (5013, "Prince", "Tissue", "Sales Officer", 3648576219, 87000),
    (5014, "Robert", "Cornerstone", "Chief Manager", 8476234890, 93500),
    (5015, "Henkings", "Jackson", "IT Personnel", 4621984759, 92300);

	
CREATE TABLE Suppliers
	(
	SupplierID INT PRIMARY KEY NOT NULL UNIQUE,
	FirstName VARCHAR (50),
	LastName VARCHAR (50),
	Phone VARCHAR (50),
	Salary VARCHAR (50)
	);


INSERT INTO Suppliers (SupplierID, FirstName, LastName, Phone, SALARY)
VALUES	(6001, "Jonas", "Carris", 348732940, 79000),
	(6002, "Ryler", "Nollingsworth", 629475923, 75000),
	(6003, "Rince", "Warker", 8592340126, 77000),
	(6004, "Bones", "Phelp", 639239840, 73000),
	(6005, "Wac", "Tince", 9038429384, 78000),
	(6006, "Rerbert", "Mardner", 3623495839, 79000),
	(6007, "Jerrie", "Linton", 293853094, 72000),
	(6008, "Benjie", "Easters", 32937743902, 70000),
	(6009, "Boyce", "Borkshire", 1294857203, 78000),
	(6010, "Tim", "East", 3298492540, 76000),
	(6011, "West", "Benrod", 4322495332, 75900),
	(6012, "Moris", "Cris", 4839857203, 70000),
	(6013, "Pencord", "Washington", 47382945003, 68830),
    (6014, "Ken", "Bredford", 63291845639, 73902),
    (6015, "Waston", "Wills", 8426345983, 73478);

CREATE TABLE PhoneReviews
	(
	ReviewID INT PRIMARY KEY NOT NULL UNIQUE,
	CustomerID INT, 
	PhoneID INT, 
	Rating VARCHAR (20),
	ReviewText VARCHAR (100),
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
    FOREIGN KEY (PhoneID) REFERENCES Phones (PhoneID)
	);


INSERT INTO PhoneReviews (ReviewID, CustomerID, PhoneID, Rating, ReviewText)
VALUES 	(7001, 0001, 1001, 53, "I love the phone"),
	(7002, 0002, 1002, 63, "The phone gives me zero problems"),
	(7003, 0003, 1003, 88, "The phone is great"),
	(7004, 0004, 1004, 67, "So much to do with this phone"),
	(7005, 0005, 1005, 85, "The phone gives me zero problems"),
	(7006, 0006, 1006, 93, "The phone functions perfectly"),
	(7007, 0007, 1007, 94, "This is my best phone so far"),
	(7008, 0008, 1008, 90, "Just perfect"),
	(7009, 0009, 1009, 81, "The phone is great"),
	(7010, 0010, 1010, 72, "Just perfect"),
	(7011, 0011, 1011, 76, "The functionality is awesome"),
	(7012, 0012, 1012, 57, "The updates are fine"),
	(7013, 0013, 1013, 88, "Just so fine"),
	(7014, 0014, 1014, 85, "Mighty fine"),
	(7015, 0015, 1015, 78, "The phone gives me zero problems");


CREATE TABLE Department
	(
	DepartmentID INT PRIMARY KEY NOT NULL UNIQUE,
	DepartmentName VARCHAR (50),
	OrderID INT,
	PhoneID INT,
	CustomerID INT,
     FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
     FOREIGN KEY (PhoneID) REFERENCES Phones (PhoneID),
     FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
	);



INSERT INTO Department (DepartmentID, DepartmentName, OrderID, PhoneID, CustomerID)
VALUES	(8001, "Finance", 2001, 1001, 0001),
	(8002, "IT", 2002, 1002, 0002),
	(8003, "Marketing", 2003, 1003, 0003),
	(8004, "IT", 2004, 1004, 0004),
	(8005, "Finance", 2005, 1005, 0005),
	(8006, "IT", 2006, 1006, 0006),
	(8007, "Marketing", 2007, 1007, 0007),
	(8008, "IT", 2008, 1008, 0008),
	(8009, "Finance", 2009, 1009, 0009),
	(8010, "Marketing", 2010, 1010, 0010),
	(8011, "Finance", 2011, 1011, 0011),
	(8012, "IT", 2012, 1012, 0012),
	(8013, "Finance", 2013, 1013, 0013),
	(8014, "Marketing", 2014, 1014, 0014),
	(8015, "IT", 2015, 1015, 0015);


ALTER TABLE Employees
ADD COLUMN OrderID INT;

UPDATE Employees
SET OrderID = 
    CASE 
        WHEN EmployeeID = 5001 THEN 2001
        WHEN EmployeeID = 5002 THEN 2002
        WHEN EmployeeID = 5003 THEN 2003
        WHEN EmployeeID = 5004 THEN 2004
        WHEN EmployeeID = 5005 THEN 2005
        WHEN EmployeeID = 5006 THEN 2006
        WHEN EmployeeID = 5007 THEN 2007
        WHEN EmployeeID = 5008 THEN 2008
        WHEN EmployeeID = 5009 THEN 2009
        WHEN EmployeeID = 5010 THEN 2010
        WHEN EmployeeID = 5011 THEN 2011
        WHEN EmployeeID = 5012 THEN 2012
        WHEN EmployeeID = 5013 THEN 2013
        WHEN EmployeeID = 5014 THEN 2014
        WHEN EmployeeID = 5015 THEN 2015
        ELSE NULL -- Set a default value or NULL if needed
    END
WHERE EmployeeID IN (5001, 5002, 5003, 5004, 5005, 5006, 5007, 5008, 5009, 5010, 5011, 5012, 5013, 5014, 5015);



ALTER TABLE Suppliers
ADD COLUMN OrderID INT;

UPDATE Suppliers
SET OrderID = 
    CASE 
        WHEN SupplierID = 6001 THEN 2001
        WHEN SupplierID = 6002 THEN 2002
        WHEN SupplierID = 6003 THEN 2003
        WHEN SupplierID = 6004 THEN 2004
        WHEN SupplierID = 6005 THEN 2005
        WHEN SupplierID = 6006 THEN 2006
        WHEN SupplierID = 6007 THEN 2007
        WHEN SupplierID = 6008 THEN 2008
        WHEN SupplierID = 6009 THEN 2009
        WHEN SupplierID = 6010 THEN 2010
        WHEN SupplierID = 6011 THEN 2011
        WHEN SupplierID = 6012 THEN 2012
        WHEN SupplierID = 6013 THEN 2013
        WHEN SupplierID = 6014 THEN 2014
        WHEN SupplierID = 6015 THEN 2015
        ELSE NULL -- Set a default value or NULL if needed
    END
WHERE SupplierID IN (6001, 6002, 6003, 6004, 6005, 6006, 6007, 6008, 6009, 6010, 6011, 6012, 6013, 6014, 6015);



ALTER TABLE Phones
ADD COLUMN CustomerID INT;

UPDATE Phones
SET CustomerID = 
    CASE 
        WHEN PhoneID = 1001 THEN 0001
        WHEN PhoneID = 1002 THEN 0002
        WHEN PhoneID = 1003 THEN 0003
        WHEN PhoneID = 1004 THEN 0004
        WHEN PhoneID = 1005 THEN 0005
        WHEN PhoneID = 1006 THEN 0006
        WHEN PhoneID = 1007 THEN 0007
        WHEN PhoneID = 1008 THEN 0008
        WHEN PhoneID = 1009 THEN 0009
        WHEN PhoneID = 1010 THEN 0010
        WHEN PhoneID = 1011 THEN 0011
        WHEN PhoneID = 1012 THEN 0012
        WHEN PhoneID = 1013 THEN 0013
        WHEN PhoneID = 1014 THEN 0014
        WHEN PhoneID = 1015 THEN 0015
        ELSE NULL -- Set a default value or NULL if needed
    END
WHERE PhoneID IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015);


ALTER TABLE Department
ADD COLUMN Sales DECIMAL (10,2);

UPDATE Department
SET Sales = 
    CASE 
        WHEN DepartmentID = 8001 THEN 235.83
        WHEN DepartmentID = 8002 THEN 457.96
        WHEN DepartmentID = 8003 THEN 975.90
        WHEN DepartmentID = 8004 THEN 572.58
        WHEN DepartmentID = 8005 THEN 672.53
        WHEN DepartmentID = 8006 THEN 837.25
        WHEN DepartmentID = 8007 THEN 532.14
        WHEN DepartmentID = 8008 THEN 683.57
        WHEN DepartmentID = 8009 THEN 872.41
        WHEN DepartmentID = 8010 THEN 958.95
        WHEN DepartmentID = 8011 THEN 728.31
        WHEN DepartmentID = 8012 THEN 827.42
        WHEN DepartmentID = 8013 THEN 764.42
        WHEN DepartmentID = 8014 THEN 753.12
        WHEN DepartmentID = 8015 THEN 649.38
        ELSE NULL -- Set a default value or NULL if needed
    END
WHERE DepartmentID IN (8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8012, 8013, 8014, 8015);




ALTER TABLE Department
ADD COLUMN EmployeeID INT;

UPDATE Department
SET EmployeeID = 
    CASE 
        WHEN DepartmentID = 8001 THEN 5001
        WHEN DepartmentID = 8002 THEN 5002
        WHEN DepartmentID = 8003 THEN 5003
        WHEN DepartmentID = 8004 THEN 5004
        WHEN DepartmentID = 8005 THEN 5005
        WHEN DepartmentID = 8006 THEN 5006
        WHEN DepartmentID = 8007 THEN 5007
        WHEN DepartmentID = 8008 THEN 5008
        WHEN DepartmentID = 8009 THEN 5009
        WHEN DepartmentID = 8010 THEN 5010
        WHEN DepartmentID = 8011 THEN 5011
        WHEN DepartmentID = 8012 THEN 5012
        WHEN DepartmentID = 8013 THEN 5013
        WHEN DepartmentID = 8014 THEN 5014
        WHEN DepartmentID = 8015 THEN 5015
        ELSE NULL -- Set a default value or NULL if needed
    END
WHERE DepartmentID IN (8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8012, 8013, 8014, 8015);


