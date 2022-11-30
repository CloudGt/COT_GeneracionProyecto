/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          help_desk_dezign.dez                            */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2006-12-01 21:38                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Users] DROP CONSTRAINT [Ref_User_Types_Users]
GO

/*
ALTER TABLE [User_Equipment_History] DROP CONSTRAINT [Users_IT_Equipment]
--GO

ALTER TABLE [User_Equipment_History] DROP CONSTRAINT [Equipment_User_Equipment_History]
--GO
*/

ALTER TABLE [Problems] DROP CONSTRAINT [Equipment_Problems]
GO

ALTER TABLE [Problems] DROP CONSTRAINT [Users_Problems]
GO

ALTER TABLE [Equipment] DROP CONSTRAINT [Ref_Equipment_Types_IT_Equipment]
GO

ALTER TABLE [Problem_History] DROP CONSTRAINT [Ref_Problem_Status_Codes_Equipment_Problem_History]
GO

ALTER TABLE [Problem_History] DROP CONSTRAINT [Equipment_Problem_Reports_Equipment_Problem_History]
GO

ALTER TABLE [Problem_History] DROP CONSTRAINT [Support_Staff_Equipment_Problem_History]
GO

ALTER TABLE [Problem_History] DROP CONSTRAINT [Ref_Priority_Levels_Problem_History]
GO

ALTER TABLE [Resolutions] DROP CONSTRAINT [Equipment_Problem_History_Resolutions]
GO

ALTER TABLE [Staff_Skills] DROP CONSTRAINT [Support_Staff_Staff_Skills]
GO

ALTER TABLE [Staff_Skills] DROP CONSTRAINT [Ref_Skill_Codes_Staff_Skills]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Priority_Levels"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Priority_Levels] DROP CONSTRAINT [PK_Ref_Priority_Levels]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Priority_Levels'))
DROP TABLE [Ref_Priority_Levels]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Users"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Users] DROP CONSTRAINT [PK_Users]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Users'))
DROP TABLE [Users]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "User_Equipment_History"                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */
/*
ALTER TABLE [User_Equipment_History] DROP CONSTRAINT [PK_User_Equipment_History]
--GO

DROP TABLE [User_Equipment_History]
--GO
*/

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_User_Types"                                            */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_User_Types] DROP CONSTRAINT [PK_Ref_User_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_User_Types'))
DROP TABLE [Ref_User_Types]
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
/* Drop table "Ref_Problem_Status_Codes"                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Problem_Status_Codes] DROP CONSTRAINT [PK_Ref_Problem_Status_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Problem_Status_Codes'))
DROP TABLE [Ref_Problem_Status_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Support_Staff"                                             */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Support_Staff] DROP CONSTRAINT [PK_Support_Staff]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Support_Staff'))
DROP TABLE [Support_Staff]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Skill_Codes"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Skill_Codes] DROP CONSTRAINT [PK_Ref_Skill_Codes]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Skill_Codes'))
DROP TABLE [Ref_Skill_Codes]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Equipment_Types"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Equipment_Types] DROP CONSTRAINT [PK_Ref_Equipment_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Equipment_Types'))
DROP TABLE [Ref_Equipment_Types]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Equipment"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Equipment] DROP CONSTRAINT [PK_Equipment]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Equipment'))
DROP TABLE [Equipment]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Problem_History"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Problem_History] DROP CONSTRAINT [PK_Problem_History]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Problem_History'))
DROP TABLE [Problem_History]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Resolutions"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Resolutions] DROP CONSTRAINT [PK_Resolutions]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Resolutions'))
DROP TABLE [Resolutions]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Staff_Skills"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Staff_Skills] DROP CONSTRAINT [PK_Staff_Skills]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Staff_Skills'))
DROP TABLE [Staff_Skills]
GO
