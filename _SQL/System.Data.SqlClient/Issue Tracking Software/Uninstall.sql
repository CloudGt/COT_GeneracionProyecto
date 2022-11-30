/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          tracking_software_problems.dez                  */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2006-11-15 20:56                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Problems] DROP CONSTRAINT [Products_Problems]
GO

ALTER TABLE [Problems] DROP CONSTRAINT [%relname_2%]
GO

ALTER TABLE [Problems] DROP CONSTRAINT [Staff_Problems]
GO

ALTER TABLE [Problem_Log] DROP CONSTRAINT [Staff_Problem_Log]
GO

ALTER TABLE [Problem_Log] DROP CONSTRAINT [Problem_Category_Codes_Problem_Log]
GO

ALTER TABLE [Problem_Log] DROP CONSTRAINT [Problem_Status_Codes_Problem_Log]
GO

ALTER TABLE [Problem_Log] DROP CONSTRAINT [Problems_Problem_Log]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Problems"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Problems] DROP CONSTRAINT [PK_Problems]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Problems'))
DROP TABLE [Problems]
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
/* Drop table "Problem_Category_Codes"                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Problem_Category_Codes] DROP CONSTRAINT [PK_Problem_Category_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Problem_Category_Codes'))
DROP TABLE [Problem_Category_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Staff"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Staff] DROP CONSTRAINT [PK_Staff]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Staff'))
DROP TABLE [Staff]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Problem_Status_Codes"                                      */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Problem_Status_Codes] DROP CONSTRAINT [PK_Problem_Status_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Problem_Status_Codes'))
DROP TABLE [Problem_Status_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Problem_Log"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Problem_Log] DROP CONSTRAINT [PK_Problem_Log]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Problem_Log'))
DROP TABLE [Problem_Log]
GO
