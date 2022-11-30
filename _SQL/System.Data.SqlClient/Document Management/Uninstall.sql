/* ------------------------------------------------------------------------------------ */
/* Script by	: DeZign for Databases v4.1.2                     			*/
/* Target DBMS	: MS SQL Server 2005                              			*/
/* Project file	: Document_Management.dez                         			*/
/* Project name	: Document Management                             			*/
/* Author	: Barry Williams                                  			*/
/* Script type	: Database drop script                            			*/
/* Created on	: 5.00 pm 18th. November 2006   		 			*/
/* Notes	: UNIQUEIDENTIFIER replaced BY INTEGER PRIMARY KEY NOT NULL IDENTITY	*/
/*		: This results commenting out some DROP CONSTRAINTS that don't exist	*/
/* ------------------------------------------------------------------------------------ */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */
/*
** ALTER TABLE [Document_Structures] DROP CONSTRAINT [Document_Structures_Document_Structures]
** GO
*/

ALTER TABLE [Documents] DROP CONSTRAINT [Document_Structures_Documents]
GO

ALTER TABLE [Documents] DROP CONSTRAINT [Ref_Document_Types_Documents]
GO

ALTER TABLE [Functional_Areas] DROP CONSTRAINT [Functional_Areas_Functional_Areas]
GO

ALTER TABLE [Document_Functional_Areas] DROP CONSTRAINT [Functional_Areas_Document_Functional_Areas]
GO

ALTER TABLE [Document_Functional_Areas] DROP CONSTRAINT [Documents_Document_Functional_Areas]
GO

ALTER TABLE [Users] DROP CONSTRAINT [Roles_Users]
GO

ALTER TABLE [Role_Documents_Access_Rights] DROP CONSTRAINT [Roles_Role_Documents_Access_Rights]
GO

ALTER TABLE [Role_Documents_Access_Rights] DROP CONSTRAINT [Documents_Role_Documents_Access_Rights]
GO

ALTER TABLE [Document_Sections] DROP CONSTRAINT [Documents_Document_Sections]
GO

ALTER TABLE [Document_Sections_Images] DROP CONSTRAINT [Document_Sections_Document_Sections_Images]
GO

ALTER TABLE [Document_Sections_Images] DROP CONSTRAINT [Images_Document_Sections_Images]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Document_Structures"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */
/*
ALTER TABLE [Document_Structures] DROP CONSTRAINT [PK_Document_Structures]
--GO
*/

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Document_Structures'))
DROP TABLE [Document_Structures]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Document_Types"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Document_Types] DROP CONSTRAINT [PK_Ref_Document_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Document_Types'))
	DROP TABLE [Ref_Document_Types]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Documents"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Documents] DROP CONSTRAINT [PK_Documents]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Documents'))
DROP TABLE [Documents]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Functional_Areas"                                          */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Functional_Areas] DROP CONSTRAINT [PK_Functional_Areas]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Functional_Areas'))
DROP TABLE [Functional_Areas]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Document_Functional_Areas"                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Document_Functional_Areas] DROP CONSTRAINT [PK_Document_Functional_Areas]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Document_Functional_Areas'))
DROP TABLE [Document_Functional_Areas]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Users"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */
/*
ALTER TABLE [Users] DROP CONSTRAINT [PK_Users]
--GO
*/


/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Users'))
DROP TABLE [Users]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Roles"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Roles] DROP CONSTRAINT [PK_Roles]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Roles'))
DROP TABLE [Roles]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Role_Documents_Access_Rights"                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Role_Documents_Access_Rights] DROP CONSTRAINT [PK_Role_Documents_Access_Rights]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Role_Documents_Access_Rights'))
DROP TABLE [Role_Documents_Access_Rights]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Document_Sections"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */
/*
ALTER TABLE [Document_Sections] DROP CONSTRAINT [PK_Document_Sections]
--GO
*/

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Document_Sections'))
DROP TABLE [Document_Sections]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Images"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */
/*
ALTER TABLE [Images] DROP CONSTRAINT [PK_Images]
--GO
*/

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Images'))
DROP TABLE [Images]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Document_Sections_Images"                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Document_Sections_Images] DROP CONSTRAINT [PK_Document_Sections_Images]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Document_Sections_Images'))
DROP TABLE [Document_Sections_Images]
GO
