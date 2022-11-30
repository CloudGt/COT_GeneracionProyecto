/**********************************************************************/
/* InstallRoles.SQL                                                   */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting the aspnet feature of ASP.Net                           */
/*                                                                    */
/* InstallCommon.sql must be run before running this file.            */
/*
** Copyright Microsoft, Inc. 2002
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '--------------------------------------'
PRINT 'Starting execution of InstallRoles.SQL'
PRINT '--------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF -- We don't use quoted identifiers
SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO
SET ANSI_PADDING ON
GO
SET ANSI_NULL_DFLT_ON ON
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'aspnet_UsersInRoles')
                  AND (type = 'U')))
BEGIN
  PRINT 'Dropping the aspnet_UsersInRoles table...'
  DROP TABLE dbo.aspnet_UsersInRoles 
END


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'aspnet_Roles')
                  AND (type = 'U')))
BEGIN
  PRINT 'Dropping the aspnet_Roles table...'
  DROP TABLE dbo.aspnet_Roles 
END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_UsersInRoles_IsUserInRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_IsUserInRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_UsersInRoles_GetRolesForUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_GetRolesForUser
GO


/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Roles_CreateRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_CreateRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Roles_DeleteRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_DeleteRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Roles_RoleExists')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_RoleExists
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_UsersInRoles_AddUsersToRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_AddUsersToRoles
GO
IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_UsersInRoles_RemoveUsersFromRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_RemoveUsersFromRoles
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_UsersInRoles_GetUsersInRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_GetUsersInRoles
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_UsersInRoles_FindUsersInRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_FindUsersInRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Roles_GetAllRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_GetAllRoles
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'vw_aspnet_Roles')
                  AND (type = 'V')))
BEGIN
  PRINT 'Dropping the vw_aspnet_Roles view...'
  EXEC(N'
  DROP VIEW [dbo].[vw_aspnet_Roles]
  ')
END
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'vw_aspnet_UsersInRoles')
                  AND (type = 'V')))
BEGIN
  PRINT 'Dropping the vw_aspnet_UsersInRoles view...'
  EXEC(N'
  DROP VIEW [dbo].[vw_aspnet_UsersInRoles]
  ')
END
GO

/*************************************************************/
/*************************************************************/

--
--Create Role Manager roles
--

IF ( EXISTS ( SELECT name
                  FROM sys.database_principals
                  WHERE [type] = 'R'
                  AND name = N'aspnet_Roles_FullAccess'  ) )
DROP ROLE aspnet_Roles_FullAccess

IF ( EXISTS ( SELECT name
                  FROM sys.database_principals
                  WHERE [type] = 'R'
                  AND name = N'aspnet_Roles_BasicAccess'  ) )
DROP ROLE aspnet_Roles_BasicAccess

IF ( EXISTS ( SELECT name
                  FROM sys.database_principals
                  WHERE [type] = 'R'
                  AND name = N'aspnet_Roles_ReportingAccess'  ) )
DROP ROLE aspnet_Roles_ReportingAccess 
GO


PRINT '---------------------------------------'
PRINT 'Completed execution of InstallRoles.SQL'
PRINT '---------------------------------------'
