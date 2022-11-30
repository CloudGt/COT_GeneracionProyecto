/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          customers_and_orders.dez                        */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2006-11-25 23:16                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Products] DROP CONSTRAINT [Ref_Product_Types_Products]
GO

ALTER TABLE [Products] DROP CONSTRAINT [Suppliers_Products]
GO

/*
** ALTER TABLE [Ref_Product_Types] DROP CONSTRAINT [Ref_Product_Types_Ref_Product_Types]
** GO
*/

ALTER TABLE [Customer_Orders] DROP CONSTRAINT [Ref_Order_Status_Codes_Customer_Orders]
GO

ALTER TABLE [Customer_Orders] DROP CONSTRAINT [Customers_Payment_Methods_Customer_Orders]
GO

ALTER TABLE [Customer_Orders] DROP CONSTRAINT [Customers_Customer_Orders]
GO

ALTER TABLE [Customer_Addresses] DROP CONSTRAINT [Customers_Customer_Address_History]
GO

ALTER TABLE [Customer_Addresses] DROP CONSTRAINT [Addresses_Customer_Address_History]
GO

ALTER TABLE [Customer_Addresses] DROP CONSTRAINT [Ref_Address_Types_Customer_Address_History]
GO

ALTER TABLE [Customer_Orders_Products] DROP CONSTRAINT [Products_Customer_Orders_Products]
GO

ALTER TABLE [Customer_Orders_Products] DROP CONSTRAINT [Customer_Orders_Customer_Orders_Products]
GO

ALTER TABLE [Customers_Payment_Methods] DROP CONSTRAINT [Ref_Payment_Methods_Customers_Payment_Methods]
GO

ALTER TABLE [Customers_Payment_Methods] DROP CONSTRAINT [Customers_Customers_Payment_Methods]
GO

ALTER TABLE [Customer_Orders_Delivery] DROP CONSTRAINT [Customer_Orders_Customer_Orders_Delivery]
GO

ALTER TABLE [Customer_Orders_Delivery] DROP CONSTRAINT [Ref_Delivery_Status_Codes_Customer_Orders_Delivery]
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
/* Drop table "Ref_Product_Types"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Product_Types] DROP CONSTRAINT [PK_Ref_Product_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Product_Types'))
DROP TABLE [Ref_Product_Types]
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
/* Drop table "Customer_Orders"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Customer_Orders] DROP CONSTRAINT [PK_Customer_Orders]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Customer_Orders'))
DROP TABLE [Customer_Orders]
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
/* Drop table "Addresses"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Addresses] DROP CONSTRAINT [PK_Addresses]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Addresses'))
DROP TABLE [Addresses]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customer_Addresses"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Customer_Addresses] DROP CONSTRAINT [PK_Customer_Addresses]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Customer_Addresses'))
DROP TABLE [Customer_Addresses]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Address_Types"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Address_Types] DROP CONSTRAINT [PK_Ref_Address_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Address_Types'))
DROP TABLE [Ref_Address_Types]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customer_Orders_Products"                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Customer_Orders_Products] DROP CONSTRAINT [PK_Customer_Orders_Products]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Customer_Orders_Products'))
DROP TABLE [Customer_Orders_Products]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customers_Payment_Methods"                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Customers_Payment_Methods] DROP CONSTRAINT [PK_Customers_Payment_Methods]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Customers_Payment_Methods'))
DROP TABLE [Customers_Payment_Methods]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Suppliers"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Suppliers] DROP CONSTRAINT [PK_Suppliers]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Suppliers'))
DROP TABLE [Suppliers]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Delivery_Status_Codes"                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Delivery_Status_Codes] DROP CONSTRAINT [PK_Ref_Delivery_Status_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Delivery_Status_Codes'))
DROP TABLE [Ref_Delivery_Status_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customer_Orders_Delivery"                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Customer_Orders_Delivery] DROP CONSTRAINT [PK_Customer_Orders_Delivery]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Customer_Orders_Delivery'))
DROP TABLE [Customer_Orders_Delivery]
GO
