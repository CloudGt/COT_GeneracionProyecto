/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          product_catalogs.dez                            */
/* Project name:          Product Catalogs                                */
/* Author:                Barry Williams                                  */
/* Script type:           Database drop script                            */
/* Created on:            2006-11-05 00:22                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Drop table "Catalog_Contents_Additional_Attributes"                    */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Catalog_Contents_Additional_Attributes] DROP CONSTRAINT [Catalog_Contents_Additional_Attributes_Catalog_Contents] 
GO

ALTER TABLE [Catalog_Structure] DROP CONSTRAINT [Catalogs_Catalog_Structure]
GO

ALTER TABLE [Catalog_Entry_Definitions] DROP CONSTRAINT [Catalog_Structure_Catalog_Entry_Definitions]
GO

ALTER TABLE [Catalog_Entry_Definitions] DROP CONSTRAINT [Attribute_Definitions_Catalog_Entry_Definitions]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Catalog_Contents"                                          */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Catalog_Contents] DROP CONSTRAINT [PK_Catalog_Contents]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Catalog_Contents'))
DROP TABLE [Catalog_Contents]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Catalog_Structure"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Catalog_Structure] DROP CONSTRAINT [PK_Catalog_Structure]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Catalog_Structure'))
DROP TABLE [Catalog_Structure]
GO



/* ---------------------------------------------------------------------- */
/* Drop table "Catalogs"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Catalogs] DROP CONSTRAINT [PK_Catalogs]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Catalogs'))
DROP TABLE [Catalogs]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Catalog_Entry_Definitions"                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Catalog_Entry_Definitions] DROP CONSTRAINT [PK_Catalog_Entry_Definitions]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Catalog_Entry_Definitions'))
DROP TABLE [Catalog_Entry_Definitions]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Attribute_Definitions"                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Attribute_Definitions] DROP CONSTRAINT [PK_Attribute_Definitions]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Attribute_Definitions'))
DROP TABLE [Attribute_Definitions]
GO



/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Catalog_Contents_Additional_Attributes'))
DROP TABLE Catalog_Contents_Additional_Attributes
GO
