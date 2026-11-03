

DROP DATABASE IF EXISTS Shopping_Management;
CREATE DATABASE Shopping_Management;
USE Shopping_Management;


-- PARENT TABLE
CREATE TABLE customers (
    Customer_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone_Number CHAR(10) NOT NULL UNIQUE
        CHECK (Phone_Number REGEXP '^[0-9]{10}$'),
    Age INT CHECK (Age > 0),
    Gender ENUM('Male','Female','Other'),
    Country VARCHAR(50) DEFAULT 'India',
    City VARCHAR(50) NOT NULL,
    Pincode CHAR(6) DEFAULT '201301',
    Registration_Date DATE DEFAULT (CURRENT_DATE),
    Registration_Time TIME DEFAULT (CURRENT_TIME),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Address VARCHAR(250),
    Customer_Status ENUM('Active','Inactive','Blocked')
        DEFAULT 'Active',
    Customer_Notes TINYTEXT
) ;


-- INSERT CUSTOMERS
INSERT INTO customers
(Customer_Name, Email, Phone_Number, Age, Gender, City, Address)
VALUES
('Rahul Sharma','rahul@gmail.com','9876543210',25,'Male','Noida','Sector 15'),
('Priya Verma','priya@gmail.com','9876543211',23,'Female','Delhi','Laxmi Nagar'),
('Amit Kumar','amit@gmail.com','9876543212',28,'Male','Noida','Sector 62'),
('Neha Singh','neha@gmail.com','9876543213',24,'Female','Ghaziabad','Indirapuram'),
('Vikas Gupta','vikas@gmail.com','9876543214',30,'Male','Delhi','Karol Bagh');


-- CHILD TABLE
CREATE TABLE orders (
    Order_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id INT,
    Order_Date DATE DEFAULT (CURRENT_DATE),
    Order_Amount DECIMAL(10,2) NOT NULL,
    Order_Status ENUM('Pending','Processing','Shipped','Delivered','Cancelled')
        DEFAULT 'Pending',
    Payment_Method ENUM('Cash','Card','UPI','Net Banking'),
    Payment_Status ENUM('Pending','Paid','Failed')
        DEFAULT 'Pending',
    Shipping_Address VARCHAR(250) NOT NULL,
    Delivery_Pincode CHAR(6),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Discount_Amount DECIMAL(10,2) DEFAULT 0.00,
    Delivery_Date DATE DEFAULT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Tracking_Number VARCHAR(30) UNIQUE,
    Delivery_Status ENUM('Not Dispatched','In Transit','Delivered','Returned')
        DEFAULT 'Not Dispatched',
    Order_Notes TINYTEXT,

    CONSTRAINT fk_customer
    FOREIGN KEY (Customer_Id)
    REFERENCES customers(Customer_Id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



INSERT INTO orders
(Customer_Id, Order_Amount, Order_Status, Payment_Method,
 Payment_Status, Shipping_Address, Delivery_Pincode,
 Quantity, Discount_Amount, Tracking_Number, Delivery_Status)
VALUES
(1,2500.00,'Shipped','UPI','Paid','Sector 15 Noida','201301',2,100,'TRK1001','In Transit'),
(1,1500.00,'Pending','Card','Pending','Sector 15 Noida','201301',1,0,'TRK1002','Not Dispatched'),
(2,3500.00,'Delivered','Cash','Paid','Laxmi Nagar Delhi','110092',3,200,'TRK1003','Delivered'),
(3,5000.00,'Processing','Net Banking','Paid','Sector 62 Noida','201309',4,300,'TRK1004','Not Dispatched'),
(4,1200.00,'Shipped','UPI','Paid','Indirapuram Ghaziabad','201014',1,50,'TRK1005','In Transit'),
(5,4500.00,'Delivered','Card','Paid','Karol Bagh Delhi','110005',2,150,'TRK1006','Delivered');


-- DISPLAY RECORDS
SELECT * FROM customers;
SELECT * FROM orders;


-- JOIN BOTH TABLES
SELECT
    c.Customer_Id,
    c.Customer_Name,
    o.Order_Id,
    o.Order_Amount,
    o.Payment_Method,
    o.Order_Status
FROM customers AS c
INNER JOIN orders AS o
ON c.Customer_Id = o.Customer_Id;
