
if exists (select * from sysobjects where id = object_id('dbo.Events_People'))
DROP TABLE Events_People
GO

if exists (select * from sysobjects where id = object_id('dbo.Events'))
DROP TABLE Events
GO

if exists (select * from sysobjects where id = object_id('dbo.Event_Types'))
DROP TABLE Event_Types
GO

if exists (select * from sysobjects where id = object_id('dbo.People_Skills'))
DROP TABLE People_Skills
go

if exists (select * from sysobjects where id = object_id('dbo.People'))
DROP TABLE People
go

if exists (select * from sysobjects where id = object_id('dbo.Appeals'))
DROP TABLE Appeals
go

if exists (select * from sysobjects where id = object_id('dbo.Partner_Relationships'))
DROP TABLE Partner_Relationships
go

if exists (select * from sysobjects where id = object_id('dbo.Organisations'))
DROP TABLE Organisations
go

if exists (select * from sysobjects where id = object_id('dbo.Organisation_Categories'))
DROP TABLE Organisation_Categories
go

if exists (select * from sysobjects where id = object_id('dbo.Addresses'))
DROP TABLE Addresses
go

if exists (select * from sysobjects where id = object_id('dbo.Skills'))
DROP TABLE Skills
go

if exists (select * from sysobjects where id = object_id('dbo.Roles'))
DROP TABLE Roles
go

