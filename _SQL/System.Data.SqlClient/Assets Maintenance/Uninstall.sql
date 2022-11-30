/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          assets_dezign.dez                               */
/* Project name:          Assets Maintenance                              */
/* Author:                Barry Williams                                  */
/* Script type:           Database drop script                            */
/* Created on:            2006-11-04 23:29                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Maintenance_Engineers] DROP CONSTRAINT [Suppliers_and_Maintenance_Companies_Maintenance_Engineers]
GO

ALTER TABLE [Assets] DROP CONSTRAINT [Suppliers_and_Maintenance_Companies_Machines]
GO

ALTER TABLE [Assets] DROP CONSTRAINT [Maintenance_Contracts_Machines]
GO

ALTER TABLE [Maintenance_Contracts] DROP CONSTRAINT [Maintenance_Contract_Companies_Maintenance_Contracts]
GO

ALTER TABLE [Fault_Log] DROP CONSTRAINT [Staff_Fault_Log]
GO

ALTER TABLE [Fault_Log] DROP CONSTRAINT [Machines_Fault_Log]
GO

ALTER TABLE [Engineer_Visits] DROP CONSTRAINT [Maintenance_Engineers_Engineer_Visits]
GO

ALTER TABLE [Engineer_Visits] DROP CONSTRAINT [Staff_Engineer_Visits]
GO

ALTER TABLE [Engineer_Visits] DROP CONSTRAINT [Fault_Log_Engineer_Visits]
GO

ALTER TABLE [Engineer_Visits] DROP CONSTRAINT [Ref_Fault_Status_Engineer_Visits]
GO

ALTER TABLE [Fault_Log_Parts] DROP CONSTRAINT [Component_Part_Faults_Fault_Log_Components]
GO

ALTER TABLE [Fault_Log_Parts] DROP CONSTRAINT [Fault_Log_Fault_Log_Components]
GO

ALTER TABLE [Fault_Log_Parts] DROP CONSTRAINT [Ref_Fault_Status_Fault_Log_Components]
GO

ALTER TABLE [Part_Faults] DROP CONSTRAINT [Component_Parts_Component_Part_Faults]
GO

ALTER TABLE [Third_Party_Companies] DROP CONSTRAINT [Ref_Company_Types_Third_Party_Companies]
GO

ALTER TABLE [Asset_Parts] DROP CONSTRAINT [Machines_Machine_Parts]
GO

ALTER TABLE [Asset_Parts] DROP CONSTRAINT [Component_Parts_Machine_Parts]
GO

ALTER TABLE [Skills_Required_To_Fix] DROP CONSTRAINT [Skills_Skills_Required_To_Fix]
GO

ALTER TABLE [Skills_Required_To_Fix] DROP CONSTRAINT [Part_Faults_Skills_Required_To_Fix]
GO

ALTER TABLE [Engineer_Skills] DROP CONSTRAINT [Skills_Engineer_Skills]
GO

ALTER TABLE [Engineer_Skills] DROP CONSTRAINT [Maintenance_Engineers_Engineer_Skills]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Maintenance_Engineers"                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Maintenance_Engineers] DROP CONSTRAINT [PK_Maintenance_Engineers]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Maintenance_Engineers'))
DROP TABLE [Maintenance_Engineers]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Assets"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Assets] DROP CONSTRAINT [PK_Assets]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Assets'))
DROP TABLE [Assets]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Maintenance_Contracts"                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Maintenance_Contracts] DROP CONSTRAINT [PK_Maintenance_Contracts]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Maintenance_Contracts'))
DROP TABLE [Maintenance_Contracts]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Fault_Log"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Fault_Log] DROP CONSTRAINT [PK_Fault_Log]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Fault_Log'))
DROP TABLE [Fault_Log]
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
/* Drop table "Parts"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Parts] DROP CONSTRAINT [PK_Parts]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Parts'))
DROP TABLE [Parts]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Engineer_Visits"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Engineer_Visits] DROP CONSTRAINT [PK_Engineer_Visits]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Engineer_Visits'))
DROP TABLE [Engineer_Visits]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Fault_Log_Parts"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Fault_Log_Parts] DROP CONSTRAINT [PK_Fault_Log_Parts]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Fault_Log_Parts'))
DROP TABLE [Fault_Log_Parts]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Part_Faults"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Part_Faults] DROP CONSTRAINT [PK_Part_Faults]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Part_Faults'))
DROP TABLE [Part_Faults]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Third_Party_Companies"                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Third_Party_Companies] DROP CONSTRAINT [PK_Third_Party_Companies]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Third_Party_Companies'))
DROP TABLE [Third_Party_Companies]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Company_Types"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Company_Types] DROP CONSTRAINT [PK_Ref_Company_Types]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Company_Types'))
DROP TABLE [Ref_Company_Types]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Ref_Fault_Status"                                          */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Ref_Fault_Status] DROP CONSTRAINT [PK_Ref_Fault_Status]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Ref_Fault_Status'))
DROP TABLE [Ref_Fault_Status]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Asset_Parts"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Asset_Parts] DROP CONSTRAINT [PK_Asset_Parts]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Asset_Parts'))
DROP TABLE [Asset_Parts]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Skills"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Skills] DROP CONSTRAINT [PK_Skills]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Skills'))
DROP TABLE [Skills]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Skills_Required_To_Fix"                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Skills_Required_To_Fix] DROP CONSTRAINT [PK_Skills_Required_To_Fix]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Skills_Required_To_Fix'))
DROP TABLE [Skills_Required_To_Fix]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Engineer_Skills"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

--ALTER TABLE [Engineer_Skills] DROP CONSTRAINT [PK_Engineer_Skills]
--GO

/* Drop table */

if exists (select * from sysobjects where id = object_id('dbo.Engineer_Skills'))
DROP TABLE [Engineer_Skills]
GO
