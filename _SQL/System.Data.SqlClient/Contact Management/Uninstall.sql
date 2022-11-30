/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          contact_mgt_dezign.dez                          */
/* Project name:          Contact Management                              */
/* Author:                Barry Williams                                  */
/* Script type:           Database drop script                            */
/* Created on:            2006-11-17 22:35                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Customer_Addresses] DROP CONSTRAINT [Customers_Customer_Addresses]
GO

ALTER TABLE [Customer_Addresses] DROP CONSTRAINT [Addresses_Customer_Addresses]
GO

ALTER TABLE [Contacts] DROP CONSTRAINT [Ref_Contact_Status_Contacts]
GO

ALTER TABLE [Contacts] DROP CONSTRAINT [Customers_Contacts]
GO

ALTER TABLE [Contact_Activities] DROP CONSTRAINT [Ref_Activity_Types_Contact_Activities]
GO

ALTER TABLE [Contact_Activities] DROP CONSTRAINT [Contacts_Contact_Activities]
GO

ALTER TABLE [Contact_Activities] DROP CONSTRAINT [Ref_Activity_Outcomes_Contact_Activities]
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
/* Drop table "Contacts"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Contacts] DROP CONSTRAINT [PK_Contacts]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Contacts'))
DROP TABLE [Contacts]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Contact_Status"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Contact_Status] DROP CONSTRAINT [PK_Ref_Contact_Status]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Contact_Status'))
DROP TABLE [Ref_Contact_Status]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Activity_Types"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Activity_Types] DROP CONSTRAINT [PK_Ref_Activity_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Activity_Types'))
DROP TABLE [Ref_Activity_Types]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Contact_Activities"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Contact_Activities] DROP CONSTRAINT [PK_Contact_Activities]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Contact_Activities'))
DROP TABLE [Contact_Activities]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Activity_Outcomes"                                      */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Activity_Outcomes] DROP CONSTRAINT [PK_Ref_Activity_Outcomes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Activity_Outcomes'))
DROP TABLE [Ref_Activity_Outcomes]
GO
