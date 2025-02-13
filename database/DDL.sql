SET FOREIGN_KEY_CHECKS =0;
SET AUTOCOMMIT =0;
-- ----------------------------------------------------------------------------
-- CREATE TABLES FOR Customers, Invoices, Products, InvoiceDetails, Deliveries
-- ----------------------------------------------------------------------------

-- Customers
CREATE OR REPLACE TABLE Customers (
    customerID int AUTO_INCREMENT PRIMARY KEY,
    name varchar(30) NOT NULL,
    address varchar(150) NOT NULL,
    phone char(10) NOT NULL
);

-- Invoices
CREATE OR REPLACE TABLE Invoices (
    invoiceID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
    customerID int NOT NULL,
    invoiceDate date NOT NULL,
    invoiceTotal decimal(10,2) NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
     ON DELETE CASCADE
     ON UPDATE CASCADE 
);

-- Products
CREATE OR REPLACE TABLE Products (
    productID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
    productName varchar(30) NOT NULL,
    cost decimal(10,2) NOT NULL,
    inventory int NOT NULL default 0
);

-- InvoiceDetails
CREATE OR REPLACE TABLE InvoiceDetails(
    detailsID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
    invoiceID int NOT NULL,
    productID int NOT NULL,
    quantity int NOT NULL default 0,
    FOREIGN KEY (invoiceID) REFERENCES Invoices(invoiceID)
     ON DELETE CASCADE
     ON UPDATE CASCADE,
    FOREIGN KEY (productID) REFERENCES Products(productID)
     ON DELETE RESTRICT
     ON UPDATE CASCADE
);

-- Deliveries
CREATE OR REPLACE TABLE Deliveries(
    deliveryID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
    deliveryDue date NOT NULL,
    invoiceID int NOT NULL,
    customerID int NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE RESTRICT,
    FOREIGN KEY (invoiceID) REFERENCES Invoices(invoiceID) ON DELETE RESTRICT
);
-- ----------------------------------------------------------------------------
-- INSERT TABLES FOR Customers, Invoices, Products, InvoiceDetails, Deliveries
-- ----------------------------------------------------------------------------

-- Customers
INSERT INTO Customers (
    customerID,
    name,
    address,
    phone
)
VALUES
(
    1,
    "John Johnson",
    "4343 Walker Rd, Lebanon OR",
    "5554443332"
),
(
    2,
    "Mary Jones",
    "553 Stoltz Hill Rd, Lebanon OR",
    "5556663332"
),
(
    3,
    "Jones Maryson",
    "233 Main St, Albany OR",
    "2132446534"
);

-- Invoices
INSERT INTO Invoices (
    invoiceID,
    customerID,
    invoiceDate,
    invoiceTotal
)
VALUES
(
    1,
    1,
    '2025-01-05',
    480.00
),
(
    2,
    2,
    '2024-11-25',
    1240.00
),
(
   3,
   2,
   '2024-12-25',
   200.00 
),
( 
   4,
   3,
   '2025-01-02',
   456.78
);

-- Products
INSERT INTO Products (
    productID,
    productName,
    cost,
    inventory
)
VALUES
(
    1,
    "Steam Deck",
    500,
    3
),
(
    2,
    "Xbox Controller",
    60,
    20
),
(
    3,
    "Keyboard",
    100,
    24
),
(
    4,
    "1080p Monitor",
    150,
    5
);

-- Deliveries
INSERT INTO Deliveries (
    deliveryID,
    deliveryDue,
    customerID,
    invoiceID
)
VALUES
(
    1,
    '2025-02-03',
    1,
    1
),
(
    2,
    '2025-02-12',
    3,
    4
),
(
    3,
    '2025-02-18',
    2,
    3
);

-- InvoiceDetails
INSERT INTO InvoiceDetails(
    productID, 
    invoiceID, 
    quantity
) 
VALUES
(
    (SELECT productID FROM Products WHERE productName = "Steam Deck"),
    2,
    2
),
((SELECT productID FROM Products WHERE productName = "Xbox Controller"),
    2,
    4
),
((SELECT productID FROM Products WHERE productName = "1080p Monitor"),
    1, 
    2
),
((SELECT productID FROM Products WHERE productName = "Keyboard"),
    3, 
    2
),
((SELECT productID FROM Products WHERE productName = "Xbox Controller"),
    1, 
    3
);


SET FOREIGN_KEY_CHECKS=1;
COMMIT;