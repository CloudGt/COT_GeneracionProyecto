/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          customers_and_orders.dez                        */
/* Project name:          Customers and Orders                            */
/* Author:                Barry Williams                                  */
/* Script type:           Database creation script                        */
/* Created on:            2006-11-25 23:16                                */
/* ---------------------------------------------------------------------- */

/* THIS BEGINS THE TABLE CREATION AND DATA LOADING SCRIPT */

/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Products"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Products] (
    [product_id] INTEGER IDENTITY(1,1) NOT NULL,
    [product_type_code] NVARCHAR(15) NOT NULL,
    [supplier_code] NVARCHAR(15) NOT NULL,
    [product_price] MONEY,
    [book_isbn] NVARCHAR(15),
    [book_author] NVARCHAR(40),
    [book_publication_date] DATETIME,
    [book_title] NVARCHAR(255),
    [book_price] SMALLMONEY,
    [food_contains_yn] NVARCHAR(1),
    [food_name] NVARCHAR(80),
    [food_description] NVARCHAR(255),
    [food_flavor] NVARCHAR(80),
    [food_ingredients] NVARCHAR(255),
    [other_product_details] NVARCHAR(255),
    CONSTRAINT [PK_Products] PRIMARY KEY ([product_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Product_Types"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Product_Types] (
    [product_type_code] NVARCHAR(15) NOT NULL,
    [level_number] INTEGER,
    [parent_product_type_code] NVARCHAR(15),
    [product_type_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Product_Types] PRIMARY KEY ([product_type_code])
)
GO


/* ---------------------------------------------------------------------- */
/* Add table "Customers"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customers] (
    [customer_id] INTEGER IDENTITY(1,1) NOT NULL,
    [first_name]     NVARCHAR(80),
    [middle_name]    NVARCHAR(80),
    [last_name]      NVARCHAR(80),
    [customer_phone] NVARCHAR(80),
    [customer_email] NVARCHAR(80),
    [other_customer_details] NVARCHAR(255),
    CONSTRAINT [PK_Customers] PRIMARY KEY ([customer_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Customer_Orders"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customer_Orders] (
    [order_id] INTEGER IDENTITY(1,1) NOT NULL,
    [customer_id] INTEGER NOT NULL,
    [customer_payment_method_id] INTEGER NOT NULL,
    [order_status_code] NVARCHAR(15) NOT NULL,
    [date_order_placed] DATETIME NOT NULL,
    [date_order_paid] DATETIME,
    [der_total_order_price] SMALLMONEY,
    [other_order_details] NVARCHAR(255),
    CONSTRAINT [PK_Customer_Orders] PRIMARY KEY ([order_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Payment_Methods"                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Payment_Methods] (
    [payment_method_code] NVARCHAR(15) NOT NULL,
    [payment_method_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Payment_Methods] PRIMARY KEY ([payment_method_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Order_Status_Codes"                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Order_Status_Codes] (
    [order_status_code] NVARCHAR(15) NOT NULL,
    [order_status_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Order_Status_Codes] PRIMARY KEY ([order_status_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Addresses"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Addresses] (
    [address_id] INTEGER IDENTITY(1,1) NOT NULL,
    [line_1] NVARCHAR(80),
    [line_2] NVARCHAR(80),
    [line_3] NVARCHAR(80),
    [city] NVARCHAR(50),
    [zip_postcode] NVARCHAR(20),
    [state_province_county] NVARCHAR(50),
    [iso_country_code] NVARCHAR(50),
    [other_address_details] NVARCHAR(255),
    CONSTRAINT [PK_Addresses] PRIMARY KEY ([address_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Customer_Addresses"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customer_Addresses] (
    [customer_id] INTEGER NOT NULL,
    [address_id] INTEGER NOT NULL,
    [date_from] DATETIME NOT NULL,
    [address_type_code] NVARCHAR(15) NOT NULL,
    [date_to] DATETIME,
    CONSTRAINT [PK_Customer_Addresses] PRIMARY KEY ([customer_id], [address_id], [date_from])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Address_Types"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Address_Types] (
    [address_type_code] NVARCHAR(15) NOT NULL,
    [address_type_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Address_Types] PRIMARY KEY ([address_type_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Customer_Orders_Products"                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customer_Orders_Products] (
    [order_id] INTEGER NOT NULL,
    [product_id] INTEGER NOT NULL,
    [quantity] NVARCHAR(40),
    [comments] NVARCHAR(40),
    CONSTRAINT [PK_Customer_Orders_Products] PRIMARY KEY ([order_id], [product_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Customers_Payment_Methods"                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customers_Payment_Methods] (
    [customer_payment_method_id] INTEGER IDENTITY(1,1) NOT NULL,
    [customer_id] INTEGER NOT NULL,
    [payment_method_code] NVARCHAR(15) NOT NULL,
    [card_number] NVARCHAR(40),
    [date_from] DATETIME,
    [date_to] DATETIME,
    [other_details] NVARCHAR(40),
    CONSTRAINT [PK_Customers_Payment_Methods] PRIMARY KEY ([customer_payment_method_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Suppliers"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Suppliers] (
    [supplier_code] NVARCHAR(15) NOT NULL,
    [supplier_name] NVARCHAR(80),
    [other_supplier_details] NVARCHAR(255),
    CONSTRAINT [PK_Suppliers] PRIMARY KEY ([supplier_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Delivery_Status_Codes"                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Delivery_Status_Codes] (
    [delivery_status_code] NVARCHAR(15) NOT NULL,
    [delivery_status_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Delivery_Status_Codes] PRIMARY KEY ([delivery_status_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Customer_Orders_Delivery"                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customer_Orders_Delivery] (
    [order_id] INTEGER NOT NULL,
    [date_reported] DATETIME NOT NULL,
    [delivery_status_code] NVARCHAR(15) NOT NULL,
    CONSTRAINT [PK_Customer_Orders_Delivery] PRIMARY KEY ([order_id], [date_reported])
)
GO

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Products] ADD CONSTRAINT [Ref_Product_Types_Products] 
    FOREIGN KEY ([product_type_code]) REFERENCES [Ref_Product_Types] ([product_type_code])
GO

ALTER TABLE [Products] ADD CONSTRAINT [Suppliers_Products] 
    FOREIGN KEY ([supplier_code]) REFERENCES [Suppliers] ([supplier_code])
GO

/* This won't work for a recursive relationship 
** ALTER TABLE [Ref_Product_Types] ADD CONSTRAINT [Ref_Product_Types_Ref_Product_Types] 
** FOREIGN KEY ([parent_product_type_code]) REFERENCES [Ref_Product_Types] ([product_type_code])
** GO
*/


ALTER TABLE [Customer_Orders] ADD CONSTRAINT [Ref_Order_Status_Codes_Customer_Orders] 
    FOREIGN KEY ([order_status_code]) REFERENCES [Ref_Order_Status_Codes] ([order_status_code])
GO

ALTER TABLE [Customer_Orders] ADD CONSTRAINT [Customers_Payment_Methods_Customer_Orders] 
    FOREIGN KEY ([customer_payment_method_id]) REFERENCES [Customers_Payment_Methods] ([customer_payment_method_id])
GO

ALTER TABLE [Customer_Orders] ADD CONSTRAINT [Customers_Customer_Orders] 
    FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id])
GO

ALTER TABLE [Customer_Addresses] ADD CONSTRAINT [Customers_Customer_Address_History] 
    FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id])
GO

ALTER TABLE [Customer_Addresses] ADD CONSTRAINT [Addresses_Customer_Address_History] 
    FOREIGN KEY ([address_id]) REFERENCES [Addresses] ([address_id])
GO

ALTER TABLE [Customer_Addresses] ADD CONSTRAINT [Ref_Address_Types_Customer_Address_History] 
    FOREIGN KEY ([address_type_code]) REFERENCES [Ref_Address_Types] ([address_type_code])
GO

ALTER TABLE [Customer_Orders_Products] ADD CONSTRAINT [Products_Customer_Orders_Products] 
    FOREIGN KEY ([product_id]) REFERENCES [Products] ([product_id])
GO

ALTER TABLE [Customer_Orders_Products] ADD CONSTRAINT [Customer_Orders_Customer_Orders_Products] 
    FOREIGN KEY ([order_id]) REFERENCES [Customer_Orders] ([order_id])
GO

ALTER TABLE [Customers_Payment_Methods] ADD CONSTRAINT [Ref_Payment_Methods_Customers_Payment_Methods] 
    FOREIGN KEY ([payment_method_code]) REFERENCES [Ref_Payment_Methods] ([payment_method_code])
GO

ALTER TABLE [Customers_Payment_Methods] ADD CONSTRAINT [Customers_Customers_Payment_Methods] 
    FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id])
GO

ALTER TABLE [Customer_Orders_Delivery] ADD CONSTRAINT [Customer_Orders_Customer_Orders_Delivery] 
    FOREIGN KEY ([order_id]) REFERENCES [Customer_Orders] ([order_id])
GO

ALTER TABLE [Customer_Orders_Delivery] ADD CONSTRAINT [Ref_Delivery_Status_Codes_Customer_Orders_Delivery] 
    FOREIGN KEY ([delivery_status_code]) REFERENCES [Ref_Delivery_Status_Codes] ([delivery_status_code])
GO


/*  Load Sample Reference Data */

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('BILL'           ,'Billing'               )
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('DEL'           ,'Delivery'               )
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('RES'           ,'Residence'              )
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('WORK'          ,'Work'                   )
GO

SELECT 'Ref_Address_Types', *
FROM    Ref_Address_Types
GO


INSERT INTO Ref_Delivery_Status_Codes (delivery_status_code,delivery_status_description)
VALUES                                ('CUSTOMS'           ,'Cleared Customs'          )
GO

INSERT INTO Ref_Delivery_Status_Codes (delivery_status_code,delivery_status_description)
VALUES                                ('DEL'               ,'Delivered'                )
GO

INSERT INTO Ref_Delivery_Status_Codes (delivery_status_code,delivery_status_description)
VALUES                                ('WAREH'             ,'Left Warehouse'           )
GO

SELECT 'Ref_Delivery_Status_Codes' As Table_Name, *
FROM    Ref_Delivery_Status_Codes
GO

INSERT INTO Ref_Order_Status_Codes (order_status_code, order_status_description)
VALUES                             ('PAID'           ,'Paid in full'           )
GO

INSERT INTO Ref_Order_Status_Codes (order_status_code, order_status_description)
VALUES                             ('PART'           ,'Part-Filled'            )
GO

INSERT INTO Ref_Order_Status_Codes (order_status_code, order_status_description)
VALUES                             ('PLCD'           ,'Placed'                 )
GO

SELECT 'Ref_Order_Status_Codes' As Table_Name, *
FROM    Ref_Order_Status_Codes
GO


/* Ref_Payment_Methods */

INSERT INTO Ref_Payment_Methods (payment_method_code,payment_method_description)
VALUES                          ('AMEX'             ,'American Express'        )
GO

INSERT INTO Ref_Payment_Methods (payment_method_code,payment_method_description)
VALUES                          ('CASH'             ,'Cash'                    )
GO

INSERT INTO Ref_Payment_Methods (payment_method_code,payment_method_description)
VALUES                          ('MC'             ,'Master Cold'               )
GO

SELECT 'Ref_Payment_Methods' As Table_Name, *
FROM    Ref_Payment_Methods
GO

/* Ref_Product_Types */


INSERT INTO Ref_Product_Types (product_type_code,level_number,parent_product_type_code,product_type_description)
VALUES                        ('Book',                1      ,         ''             , 'Book'                 )
GO

INSERT INTO Ref_Product_Types (product_type_code,level_number,parent_product_type_code,product_type_description)
VALUES                        ('Coffee',              1      ,         ''             , 'Coffee'               )
GO

INSERT INTO Ref_Product_Types (product_type_code,level_number,parent_product_type_code,product_type_description)
VALUES                        ('Food',                1      ,         ''             , 'Food'                 )
GO

SELECT 'Ref_Product_Types' As Table_Name, *
FROM    Ref_Product_Types
GO

INSERT INTO Suppliers (supplier_code,supplier_name,other_supplier_details)
VALUES                ('AMZN'       ,'Amazon.com' ,''                    )
GO

INSERT INTO Suppliers (supplier_code,supplier_name,other_supplier_details)
VALUES                ('SBUX'       ,'Starbucks' ,''                    )
GO

SELECT 'Suppliers' As Table_Name, *
FROM    Suppliers
GO


/* LOad sample Product Data */
INSERT INTO Products (product_type_code,supplier_code,product_price
                     ,food_contains_yn,food_name,food_description,food_flavor,food_ingredients,other_product_details)
VALUES               ('Food','SBUX',1.00
                     ,   'N'          ,'Coffee' ,'Coffee'        ,''         ,''              ,''                   )
GO


INSERT INTO Products (product_type_code,supplier_code,product_price
                     ,book_isbn,book_author,book_publication_date,book_title,book_price,other_product_details)
VALUES               ('Book'           ,'AMZN',13.49
                     ,'0-596-00642-X','Will Iverson','2004','Real World Web Services',29.95,'Includes Specs for Amazon.com')
GO

SELECT 'Book Products' As Table_Name,product_id,product_type_code,supplier_code,product_price
                     ,book_isbn,book_author,book_publication_date,book_title,book_price,other_product_details
FROM    Products
WHERE   product_type_code = 'Book'
ORDER BY product_id
GO

SELECT 'Food Products' As Table_Name,product_id, product_type_code,supplier_code,product_price
                     ,food_contains_yn,food_name,food_description,food_flavor,food_ingredients,other_product_details
FROM  Products 
WHERE   product_type_code = 'Food'
ORDER BY product_id
GO


/* LOad sample Address Data */

/* Business Address ... */
INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,iso_country_code,other_address_details)
VALUES                ('1500 E MAIN AVE STE 201','SPRINGFIELD VA 22162-1010','','',''
                      ,'','USA','This conforms to the US Postal Service 2-line address standard (see http://pe.usps.com/)')
GO


INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,iso_country_code,other_address_details)
VALUES                ('123 MAGNOLIA ST','HEMPSTEAD NY 11550-1234','','',''
                      ,'','USA','This conforms to the US Postal Service 2-line address standard')
GO

INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,iso_country_code,other_address_details)
VALUES                ('Rural Route 1,Box 99999','Odessa,MN 12345','','',''
                      ,'','USA','This is a fictitious address but conforms to the US Postal Service 2-line standard')
GO

INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,iso_country_code,other_address_details)
VALUES                ('123 Woodland Street','','','New Haven','06512'
                      ,'Conn','USA','This does not conform to the US Postal Service 2-line address standard')
GO

INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,iso_country_code,other_address_details)
VALUES                (''                    ,'1776 New Cavendish Street','Marylebone','London','W11X5BY'
                      ,'Greater London','UK','')
GO

SELECT 'Addresses' As Table_Name,*
FROM   Addresses
GO

/* Load sample Customers Data */


INSERT INTO Customers (first_name,last_name,customer_phone,customer_email,other_customer_details)
VALUES                ('John'    ,'Doe'    ,'111-222'     ,'john.doe@fictitiousmail.com','')
GO

INSERT INTO Customers (first_name,last_name,customer_phone,customer_email,other_customer_details)
VALUES                ('Joseph'  ,'Bloggs' ,'01799-222333','joe.bloggs@fictitiousmail.com','')
GO

SELECT 'Customers' As Table_Name,*
FROM    Customers
GO

INSERT INTO Customer_Addresses (customer_id,address_id,date_from,address_type_code,date_to)
VALUES                         (1          ,1 ,'01/01/2003','RES',NULL)
GO

INSERT INTO Customer_Addresses (customer_id,address_id,date_from,address_type_code,date_to)
VALUES                         (2          ,2 ,'01/01/2006','RES',NULL)
GO

SELECT 'Customer_Addresses' As Table_Name,*
FROM    Customer_Addresses
GO

INSERT INTO Customers_Payment_Methods (customer_id,payment_method_code,card_number,date_from   ,date_to     ,other_details)
VALUES                                (1          ,'AMEX'             ,'123456'   ,'01/01/2004','01/01/2008',NULL)
GO

INSERT INTO Customers_Payment_Methods (customer_id,payment_method_code,card_number,date_from,date_to,other_details)
VALUES                                (2          ,'CASH'             ,''         ,NULL     ,NULL   ,'')
GO

SELECT 'Customers_Payment_Methods' As Table_Name,* 
FROM  Customers_Payment_Methods 
GO

INSERT INTO Customer_Orders (customer_id,customer_payment_method_id,order_status_code
                            ,date_order_placed,date_order_paid,der_total_order_price,other_order_details)
VALUES                      (1          ,1                         ,'PAID'
                            ,'10/10/2006'     ,'10/10/2006'   ,10.00                , '')
GO

INSERT INTO Customer_Orders (customer_id,customer_payment_method_id,order_status_code
                            ,date_order_placed,date_order_paid,der_total_order_price,other_order_details)
VALUES                      (2          ,2                         ,'PLCD'
                            ,'12/10/2006'     ,NULL           ,100.00               , '')
GO

SELECT 'Customer_Orders' As Table_Name,*
FROM    Customer_Orders
GO

/* LOad sample data into Customer_Orders_Products Table */

INSERT INTO Customer_Orders_Products (order_id,product_id,quantity,comments       )
VALUES                               (1       ,1         ,1       ,'Test Comments')
GO

INSERT INTO Customer_Orders_Products (order_id,product_id,quantity,comments       )
VALUES                               (2       ,2         ,200     ,'')
GO

SELECT 'Customer_Orders_Products' As Table_Name,*
FROM    Customer_Orders_Products
GO

INSERT INTO Customer_Orders_Delivery (order_id,date_reported,delivery_status_code)
VALUES                               (1       ,'11/11/2006' ,'CUSTOMS'           )
GO

INSERT INTO Customer_Orders_Delivery (order_id,date_reported,delivery_status_code)
VALUES                               (2       ,'12/11/2006' ,'DEL'               )
GO

SELECT 'Customer_Orders_Delivery' As Table_Name,*
FROM    Customer_Orders_Delivery
GO

/* THIS COMPLETES THE TABLE CREATION AND DATA LOADING SCRIPT */

