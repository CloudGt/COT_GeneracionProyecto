/* ---------------------------------------------------------------------- */
/* Target DBMS:       	MS SQL Server 2005                                */
/* Database Schema:	inventory_control_for_retail_dezign               */                                                  
/* Author:             	Barry Williams                                    */
/* Script type:       	Database drop script                              */
/* Created on:        	2006-10-14 17:16                                  */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Inventory_Items] DROP CONSTRAINT [Reference_Brands_Inventory_Items]
GO

ALTER TABLE [Inventory_Items] DROP CONSTRAINT [Reference_Item_Categories_Inventory_Items]
GO

ALTER TABLE [Item_Suppliers] DROP CONSTRAINT [Items_Item_Suppliers]
GO

ALTER TABLE [Item_Suppliers] DROP CONSTRAINT [Suppliers_Item_Suppliers]
GO

ALTER TABLE [Supplier_Addresses] DROP CONSTRAINT [Ref_Address_Types_Supplier_Addresses]
GO

ALTER TABLE [Supplier_Addresses] DROP CONSTRAINT [Addresses_Supplier_Addresses]
GO

ALTER TABLE [Supplier_Addresses] DROP CONSTRAINT [Suppliers_Supplier_Addresses]
GO

ALTER TABLE [Item_Stock_Levels] DROP CONSTRAINT [Inventory_Items_Items_Stock_Level]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Suppliers"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Suppliers] DROP CONSTRAINT [PK_Suppliers]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Suppliers'))
DROP TABLE [Suppliers]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Inventory_Items"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Inventory_Items] DROP CONSTRAINT [PK_Inventory_Items]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Inventory_Items'))
DROP TABLE [Inventory_Items]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Item_Suppliers"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Item_Suppliers] DROP CONSTRAINT [PK_Item_Suppliers]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Item_Suppliers'))
DROP TABLE [Item_Suppliers]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Item_Categories"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Item_Categories] DROP CONSTRAINT [PK_Ref_Item_Categories]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Item_Categories'))
DROP TABLE [Ref_Item_Categories]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Brands"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Brands] DROP CONSTRAINT [PK_Brands]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Brands'))
DROP TABLE [Brands]
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
/* Drop table "Supplier_Addresses"                                          */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Supplier_Addresses] DROP CONSTRAINT [PK_Supplier_Addresses]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Supplier_Addresses'))
DROP TABLE [Supplier_Addresses]
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
/* Drop table "Item_Stock_Levels"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Item_Stock_Levels] DROP CONSTRAINT [PK_Item_Stock_Levels]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Item_Stock_Levels'))
DROP TABLE [Item_Stock_Levels]
GO
