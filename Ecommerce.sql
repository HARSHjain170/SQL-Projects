-- ===============================================================
-- Database: E-Commerce Management System
-- ===============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- ===============================================================
-- 1. Admin Table
-- ===============================================================
CREATE TABLE Admin (
    ad_id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 2. Auth_Permission Table
-- ===============================================================
CREATE TABLE Auth_Permission (
    id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 3. Customer_Address Table
-- ===============================================================
CREATE TABLE Customer_Address (
    id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Address VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Postal_Code VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 4. Inventory_Inventory Table
-- ===============================================================
CREATE TABLE Inventory_Inventory (
    id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Quality VARCHAR(50) NOT NULL,
    Last_Update VARCHAR(50) NOT NULL,
    Product_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 5. Store_Order Table
-- ===============================================================
CREATE TABLE Store_Order (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Postal_Code VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Total VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 6. Product_Brand Table
-- ===============================================================
CREATE TABLE Product_Brand (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 7. Products_Product Table
-- ===============================================================
CREATE TABLE Products_Product (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(50) NOT NULL,
    Price VARCHAR(50) NOT NULL,
    Created_At VARCHAR(50) NOT NULL,
    Updated_At VARCHAR(50) NOT NULL,
    Image VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 8. Reviews_Review Table
-- ===============================================================
CREATE TABLE Reviews_Review (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Rating VARCHAR(50) NOT NULL,
    Comment VARCHAR(50) NOT NULL,
    Customer_Id VARCHAR(50) NOT NULL,
    Product_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 9. Store_Cart Table
-- ===============================================================
CREATE TABLE Store_Cart (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Created_At VARCHAR(50) NOT NULL,
    User_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 10. Auth_Group Table
-- ===============================================================
CREATE TABLE Auth_Group (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 11. Auth_Permission (Detailed Version)
-- ===============================================================
CREATE TABLE Auth_Permission_Detail (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Content_Type_Id VARCHAR(50) NOT NULL,
    Codename VARCHAR(50) NOT NULL,
    Name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 12. Auth_User Table
-- ===============================================================
CREATE TABLE Auth_User (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Password VARCHAR(50) NOT NULL,
    Last_Login VARCHAR(50) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 13. Inventory_StockMovement Table
-- ===============================================================
CREATE TABLE Inventory_StockMovement (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Change_Value VARCHAR(50) NOT NULL,
    Reason VARCHAR(50) NOT NULL,
    Date VARCHAR(50) NOT NULL,
    Inventory_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 14. Orders_Order Table
-- ===============================================================
CREATE TABLE Orders_Order (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Created_At VARCHAR(50) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Total VARCHAR(50) NOT NULL,
    Address_Id VARCHAR(50) NOT NULL,
    Customer_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 15. Orders_OrderItem Table
-- ===============================================================
CREATE TABLE Orders_OrderItem (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Quantity VARCHAR(50) NOT NULL,
    Price VARCHAR(50) NOT NULL,
    Order_Id VARCHAR(50) NOT NULL,
    Product_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 16. Store_CartItem Table
-- ===============================================================
CREATE TABLE Store_CartItem (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Quantity VARCHAR(50) NOT NULL,
    Added_At VARCHAR(50) NOT NULL,
    Carted_At VARCHAR(50) NOT NULL,
    Product_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- 17. Store_OrderItem Table
-- ===============================================================
CREATE TABLE Store_OrderItem (
    Id INT(5) PRIMARY KEY AUTO_INCREMENT,
    Quantity VARCHAR(50) NOT NULL,
    Price VARCHAR(50) NOT NULL,
    Order_Id VARCHAR(50) NOT NULL,
    Product_Id VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ===============================================================
-- END OF DATABASE SCRIPT
-- ===============================================================
