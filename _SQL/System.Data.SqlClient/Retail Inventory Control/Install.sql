/* ---------------------------------------------------------------------- */
/* Target DBMS:    	MS SQL Server 2005 Express Edition                */
/* Database Schema:	inventory_control_for_retail_dezign.dez           */
/* Project name:        Inventory Control for Retail Stores               */
/* Author:          	Barry Williams                                    */
/* Script type:       	Database creation script                          */
/* Created on:        	2006-10-14 17:16                                  */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Suppliers"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Suppliers] (
    [supplier_id] INTEGER IDENTITY(1,1) NOT NULL,
    [supplier_name] NVARCHAR(80),
    [supplier_email] NVARCHAR(255),
    [supplier_phone] NVARCHAR(80),
    [supplier_cell_phone] NVARCHAR(80),
    [other_supplier_details] NVARCHAR(255),
    CONSTRAINT [PK_Suppliers] PRIMARY KEY ([supplier_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Inventory_Items"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Inventory_Items] (
    [item_id] INTEGER IDENTITY(1,1) NOT NULL,
    [brand_id] INTEGER NOT NULL,
    [item_category_code] NVARCHAR(15) NOT NULL,
    [item_description] NVARCHAR(50),
    [average_monthly_usage] NVARCHAR(80),
    [reorder_level] NVARCHAR(20),
    [reorder_quantity] NVARCHAR(20),
    [other_item_details] NVARCHAR(255),
    CONSTRAINT [PK_Inventory_Items] PRIMARY KEY ([item_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Item_Suppliers"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Item_Suppliers] (
    [item_id] INTEGER NOT NULL,
    [supplier_id] INTEGER NOT NULL,
    [value_supplied_to_date] MONEY,
    [total_quantity_supplied_to_date] NVARCHAR(10),
    [first_item_supplied_date] DATETIME,
    [last_item_supplied_date] DATETIME,
    [delivery_lead_time] NVARCHAR(10),
    [standard_price] MONEY,
    [percentage_discount] NVARCHAR(5),
    [minimum_order_quantity] NVARCHAR(20),
    [maximum_order_quantity] NVARCHAR(20),
    [other_item_suppliers_details] NVARCHAR(255),
    CONSTRAINT [PK_Item_Suppliers] PRIMARY KEY ([item_id], [supplier_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Item_Categories"                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Item_Categories] (
    [item_category_code] NVARCHAR(15) NOT NULL,
    [item_category_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Item_Categories] PRIMARY KEY ([item_category_code])
)
GO

/* eg Digital Camera. */


/* ---------------------------------------------------------------------- */
/* Add table "Brands"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Brands] (
    [brand_id] INTEGER IDENTITY(1,1) NOT NULL,
    [brand_short_name] NVARCHAR(15),
    [brand_full_name] NVARCHAR(255),
    CONSTRAINT [PK_Brands] PRIMARY KEY ([brand_id])
)
GO

/* eg Nikon, Olympus */

/* ---------------------------------------------------------------------- */
/* Add table "Addresses"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Addresses] (
    [address_id] INTEGER IDENTITY(1,1) NOT NULL,
    [line_1] NVARCHAR(80),
    [line_2] NVARCHAR(80),
    [line_3] NVARCHAR(80),
    [city] NVARCHAR(50),
    [zip_or_postcode] NVARCHAR(20),
    [state_province_county] NVARCHAR(50),
    [country] NVARCHAR(50),
    [other_address_details] NVARCHAR(255),
    CONSTRAINT [PK_Addresses] PRIMARY KEY ([address_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "supplier_Addresses"                                           */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Supplier_Addresses] (
    [supplier_address_id] INTEGER IDENTITY(1,1) NOT NULL,
    [address_id] INTEGER NOT NULL,
    [supplier_id] INTEGER NOT NULL,
    [address_type_code] NVARCHAR(10) NOT NULL,
    [date_address_from] DATETIME,
    [date_address_to] DATETIME,
    CONSTRAINT [PK_Supplier_Addresses] PRIMARY KEY ([supplier_address_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Address_Types"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Address_Types] (
    [address_type_code] NVARCHAR(10) NOT NULL,
    [address_type_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Address_Types] PRIMARY KEY ([address_type_code])
)
GO

/* Sample Data - General, Unknown, Headquarters, Warehouse */



/* ---------------------------------------------------------------------- */
/* Add table "Item_Stock_Levels"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Item_Stock_Levels] (
    [item_id] INTEGER NOT NULL,
    [stock_taking_date] DATETIME NOT NULL,
    [quantity_in_stock] NVARCHAR(20),
    CONSTRAINT [PK_Item_Stock_Levels] PRIMARY KEY ([item_id], [stock_taking_date])
)
GO

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Inventory_Items] ADD CONSTRAINT [Reference_Brands_Inventory_Items] 
    FOREIGN KEY ([brand_id]) REFERENCES [Brands] ([brand_id])
GO

ALTER TABLE [Inventory_Items] ADD CONSTRAINT [Reference_Item_Categories_Inventory_Items] 
    FOREIGN KEY ([item_category_code]) REFERENCES [Ref_Item_Categories] ([item_category_code])
GO

ALTER TABLE [Item_Suppliers] ADD CONSTRAINT [Items_Item_Suppliers] 
    FOREIGN KEY ([item_id]) REFERENCES [Inventory_Items] ([item_id])
GO

ALTER TABLE [Item_Suppliers] ADD CONSTRAINT [Suppliers_Item_Suppliers] 
    FOREIGN KEY ([supplier_id]) REFERENCES [Suppliers] ([supplier_id])
GO

ALTER TABLE [Supplier_Addresses] ADD CONSTRAINT [Ref_Address_Types_Supplier_Addresses] 
    FOREIGN KEY ([address_type_code]) REFERENCES [Ref_Address_Types] ([address_type_code])
GO

ALTER TABLE [Supplier_Addresses] ADD CONSTRAINT [Addresses_Supplier_Addresses] 
    FOREIGN KEY ([address_id]) REFERENCES [Addresses] ([address_id])
GO

ALTER TABLE [Supplier_Addresses] ADD CONSTRAINT [Suppliers_Supplier_Addresses] 
    FOREIGN KEY ([supplier_id]) REFERENCES [Suppliers] ([supplier_id])
GO

ALTER TABLE [Item_Stock_Levels] ADD CONSTRAINT [Inventory_Items_Items_Stock_Level] 
    FOREIGN KEY ([item_id]) REFERENCES [Inventory_Items] ([item_id])
GO

/* Load sample data */
INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('DEL','Delivery')
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('GEN','General')
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('HQ','Headquarters')
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('RES','Residence')
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('UN','Unknown')
GO

INSERT INTO Ref_Address_Types (address_type_code,address_type_description)
VALUES                        ('WARH','Warehouse')
GO

SELECT 'Ref_Address_Types' As Table_Name, * FROM Ref_Address_Types
GO


INSERT INTO Ref_Item_Categories (item_category_code,item_category_description)
VALUES                          ('CAMCORD','Camcorder')
GO

INSERT INTO Ref_Item_Categories (item_category_code,item_category_description)
VALUES                          ('DIGICAM','Digital Camera')
GO

SELECT 'Ref_Item_Categories' As Table_Name,* FROM Ref_Item_Categories
GO

/* 1) Addresses */
INSERT INTO Addresses (line_1,line_2,line_3,city,zip_or_postcode
                      ,state_province_county,country,other_address_details)
VALUES                ('1500 E MAIN AVE STE 201','SPRINGFIELD VA 22162-1010','','',''
                      ,'','USA','This conforms to the US Postal Service 2-line address standard (see http://pe.usps.com/)')
GO


INSERT INTO Addresses (line_1,line_2,line_3,city,zip_or_postcode
                      ,state_province_county,country,other_address_details)
VALUES                ('123 MAGNOLIA ST','HEMPSTEAD NY 11550-1234','','',''
                      ,'','USA','This conforms to the US Postal Service 2-line address standard')
GO

SELECT 'Addresses' As Table_Name,*
FROM   Addresses
GO



/* 2) Brands */
INSERT INTO Brands (brand_short_name, brand_full_name      )
VALUES             ('NIKON'         ,'Nikon Camera Company')
GO

INSERT INTO Brands (brand_short_name, brand_full_name      )
VALUES             ('OLYMPUS'       ,'Olympus Cameras'     )
GO

SELECT 'Brands' As Table_Name, *
FROM    Brands
GO

INSERT INTO Suppliers (supplier_name               ,supplier_email             ,supplier_phone,supplier_cell_phone,other_supplier_details   )
VALUES                ('Cosmic Camera Distributors','cosmic.cameras@coldmail.com',NULL          ,NULL               ,'Reliable and Affordable')
GO

SELECT 'Suppliers' As Table_Name,*
FROM    Suppliers
GO

/* Supplier Addresses */
INSERT INTO Supplier_Addresses (address_id,supplier_id,address_type_code,date_address_from,date_address_to)
VALUES                         (1         ,1          ,'HQ'             ,'01/01/1999',NULL)
GO

SELECT 'Supplier_Addresses' As Table_Name,*
FROM    Supplier_Addresses
GO

INSERT INTO Inventory_Items (brand_id,item_category_code,item_description  ,average_monthly_usage,reorder_level,reorder_quantity,other_item_details)
VALUES                      (1       ,'DIGICAM'         ,'Nikon Coolpix L4', 45                  , 100         ,45              ,'Best Seller'     )
GO

SELECT 'Inventory_Items' As Table_Name,*
FROM    Inventory_Items
GO


/* Load sample data into Item_Suppliers */
INSERT INTO Item_Suppliers (item_id,supplier_id,value_supplied_to_date
                           ,total_quantity_supplied_to_date,first_item_supplied_date,last_item_supplied_date
                           ,delivery_lead_time,standard_price,percentage_discount,minimum_order_quantity,maximum_order_quantity,other_item_suppliers_details)
VALUES                     (1      ,1          , 1000.00
                           ,100                            ,'02/02/2002'            ,'03/03/2006'
                           ,'10 days'         ,100.00        ,5.00               ,5                     ,1000              ,NULL)
GO

SELECT 'Item_Suppliers' As Table_Name,*
FROM    Item_Suppliers
GO

/* Load sample data into Item_Stock_Levels */
INSERT INTO Item_Stock_Levels (item_id,stock_taking_date,quantity_in_stock)
VALUES                         (1     ,'02/02/2002'     ,1                )
GO

SELECT 'Item_Stock_Levels' As Table_Name,*
FROM    Item_Stock_Levels
GO







