/**********************************************************************/
/* InstallCommon.SQL                                                  */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting some features of ASP.Net                                */
/*
** Copyright Microsoft, Inc. 2003
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '---------------------------------------'
PRINT 'Starting execution of InstallCommon.SQL'
PRINT '---------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO
SET ANSI_PADDING ON
GO
SET ANSI_NULL_DFLT_ON ON
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Setup_RemoveAllRoleMembers')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_Setup_RemoveAllRoleMembers
GO



/*************************************************************/
/*************************************************************/
/*************************************************************/
-- Create the aspnet_Users table
IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'aspnet_Users')
                  AND (type = 'U')))
BEGIN
  PRINT 'Dropping the aspnet_Users table...'
  DROP TABLE [dbo].aspnet_Users 
END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
-- Create the aspnet_Applications table.

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'aspnet_Applications')
                  AND (type = 'U')))
BEGIN
  PRINT 'Dropping the aspnet_Applications table...'
  DROP TABLE [dbo].aspnet_Applications
END
GO



/*************************************************************/
/*************************************************************/
/*************************************************************/
-- Create the aspnet_SchemaVersions table
IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'aspnet_SchemaVersions')
                  AND (type = 'U')))
BEGIN
  PRINT 'Dropping the aspnet_SchemaVersions table...'
  DROP TABLE [dbo].aspnet_SchemaVersions 
END
GO

/*************************************************************/
/*************************************************************/
------------- Create Stored Procedures
/*************************************************************/
/*************************************************************/
-- RegisterSchemaVersion SP

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'aspnet_RegisterSchemaVersion')
                AND (type = 'P')))
    EXEC('DROP PROCEDURE aspnet_RegisterSchemaVersion')
GO


/*************************************************************/
/*************************************************************/
-- CheckSchemaVersion SP

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_CheckSchemaVersion')
               AND (type = 'P')))
   EXEC('DROP PROCEDURE [dbo].aspnet_CheckSchemaVersion')
GO

/*************************************************************/
/*************************************************************/
-- CreateApplication SP

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Applications_CreateApplication')
               AND (type = 'P')))
EXEC('DROP PROCEDURE [dbo].aspnet_Applications_CreateApplication ')
GO

/*************************************************************/
/*************************************************************/
-- UnRegisterSchemaVersion SP

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_UnRegisterSchemaVersion')
               AND (type = 'P')))
EXEC('DROP PROCEDURE [dbo].aspnet_UnRegisterSchemaVersion')
GO

/*************************************************************/
/*************************************************************/
-- CreateUser SP

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Users_CreateUser')
               AND (type = 'P')))
EXEC('DROP PROCEDURE [dbo].aspnet_Users_CreateUser')
GO

/*************************************************************/
/*************************************************************/
--- DeleteUser SP

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Users_DeleteUser')
               AND (type = 'P')))
EXEC('DROP PROCEDURE [dbo].aspnet_Users_DeleteUser')
GO

/*************************************************************/
/*************************************************************/
--- aspnet_AnyDataInTables SP

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_AnyDataInTables')
               AND (type = 'P')))
EXEC('DROP PROCEDURE [dbo].aspnet_AnyDataInTables')
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'vw_aspnet_Applications')
                  AND (type = 'V')))
BEGIN
  PRINT 'Dropping the vw_aspnet_Applications view...'
  EXEC('
  DROP VIEW [dbo].[vw_aspnet_Applications]
  ')
END

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'vw_aspnet_Users')
                  AND (type = 'V')))
BEGIN
  PRINT 'Dropping the vw_aspnet_Users view...'
  EXEC('
  DROP VIEW [dbo].[vw_aspnet_Users]
  ')
END

/*************************************************************/
/*************************************************************/

PRINT '----------------------------------------'
PRINT 'Completed execution of InstallCommon.SQL'
PRINT '----------------------------------------'
