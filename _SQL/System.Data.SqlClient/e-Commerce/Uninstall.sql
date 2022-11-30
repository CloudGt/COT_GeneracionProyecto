/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          e_commerce.dez                                  */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2006-11-20 21:20                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Invoices] DROP CONSTRAINT [Invoice_Status_Codes_Invoices]
GO

ALTER TABLE [Invoices] DROP CONSTRAINT [Orders_Invoices]
GO

ALTER TABLE [Orders] DROP CONSTRAINT [Order_Status_Codes_Orders]
GO

ALTER TABLE [Orders] DROP CONSTRAINT [Customers_1_Orders]
GO

ALTER TABLE [Shipments] DROP CONSTRAINT [Orders_Shipments]
GO

ALTER TABLE [Shipments] DROP CONSTRAINT [Invoices_Shipments]
GO

ALTER TABLE [Shipment_Items] DROP CONSTRAINT [Shipments_Shipment_Items]
GO

ALTER TABLE [Shipment_Items] DROP CONSTRAINT [Order_Items_Shipment_Items]
GO

ALTER TABLE [Order_Items] DROP CONSTRAINT [Order_Item_Status_Order_Items]
GO

ALTER TABLE [Order_Items] DROP CONSTRAINT [Products_Order_Items]
GO

ALTER TABLE [Order_Items] DROP CONSTRAINT [Orders_Order_Items]
GO

ALTER TABLE [Products] DROP CONSTRAINT [Ref_Product_Types_Products]
GO

ALTER TABLE [Customer_Payment_Methods] DROP CONSTRAINT [Customers_Customer_Payment_Methods]
GO

ALTER TABLE [Customer_Payment_Methods] DROP CONSTRAINT [Ref_Payment_Methods_Customer_Payment_Methods]
GO

ALTER TABLE [Payments] DROP CONSTRAINT [Invoices_Payments]
GO

ALTER TABLE [Product_Prices] DROP CONSTRAINT [Products_Product_Prices]
GO

ALTER TABLE [Product_Prices] DROP CONSTRAINT [Ref_Art_Types_Product_Prices]
GO

ALTER TABLE [Ref_Product_Types] DROP CONSTRAINT [Ref_Product_Types_Ref_Product_Types]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Invoices"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Invoices] DROP CONSTRAINT [PK_Invoices]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Invoices'))
DROP TABLE [Invoices]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Orders"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Orders] DROP CONSTRAINT [PK_Orders]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Orders'))
DROP TABLE [Orders]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Order_Status_Codes"                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Order_Status_Codes] DROP CONSTRAINT [PK_Ref_Order_Status_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Order_Status_Codes'))
DROP TABLE [Ref_Order_Status_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Order_Item_Status_Codes"                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Order_Item_Status_Codes] DROP CONSTRAINT [PK_Ref_Order_Item_Status_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Order_Item_Status_Codes'))
DROP TABLE [Ref_Order_Item_Status_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Shipments"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Shipments] DROP CONSTRAINT [PK_Shipments]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Shipments'))
DROP TABLE [Shipments]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Shipment_Items"                                            */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Shipment_Items] DROP CONSTRAINT [PK_Shipment_Items]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Shipment_Items'))
DROP TABLE [Shipment_Items]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Order_Items"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Order_Items] DROP CONSTRAINT [PK_Order_Items]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Order_Items'))
DROP TABLE [Order_Items]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Products"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Products] DROP CONSTRAINT [PK_Products]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Products'))
DROP TABLE [Products]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customers"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Customers] DROP CONSTRAINT [PK_Customers]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Customers'))
DROP TABLE [Customers]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Gender_Codes"                                          */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Gender_Codes] DROP CONSTRAINT [PK_Ref_Gender_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Gender_Codes'))
DROP TABLE [Ref_Gender_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Payment_Methods"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Payment_Methods] DROP CONSTRAINT [PK_Ref_Payment_Methods]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Payment_Methods'))
DROP TABLE [Ref_Payment_Methods]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customer_Payment_Methods"                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Customer_Payment_Methods] DROP CONSTRAINT [PK_Customer_Payment_Methods]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Customer_Payment_Methods'))
DROP TABLE [Customer_Payment_Methods]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Invoice_Status_Codes"                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Invoice_Status_Codes] DROP CONSTRAINT [PK_Ref_Invoice_Status_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Invoice_Status_Codes'))
DROP TABLE [Ref_Invoice_Status_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Payments"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Payments] DROP CONSTRAINT [PK_Payments]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Payments'))
DROP TABLE [Payments]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Product_Prices"                                            */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Product_Prices] DROP CONSTRAINT [PK_Product_Prices]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Product_Prices'))
DROP TABLE [Product_Prices]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Product_Types"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Product_Types] DROP CONSTRAINT [PK_Ref_Product_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Product_Types'))
DROP TABLE [Ref_Product_Types]
GO
