/**********************************************************************/
/* InstallMembership.SQL                                              */
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

PRINT '-------------------------------------------'
PRINT 'Starting execution of InstallMembership.SQL'
PRINT '-------------------------------------------'
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
IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'aspnet_Membership')
                  AND (type = 'U')))
BEGIN
  PRINT 'Dropping the aspnet_Membership table...'
  DROP TABLE dbo.aspnet_Membership 
END
GO


/*************************************************************/

--IF (@ver >= 8)
--    EXEC sp_tableoption N'aspnet_Membership', 'text in row', 3000

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_CreateUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_CreateUser
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_GetUserByName')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetUserByName
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_GetUserByUserId')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetUserByUserId
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_GetUserByEmail')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetUserByEmail
GO


/*************************************************************/
/*************************************************************/

IF ( EXISTS( SELECT name
             FROM sys.objects
             WHERE ( name = N'aspnet_Membership_GetPasswordWithFormat' )
                   AND ( type = 'P' ) ) )
DROP PROCEDURE dbo.aspnet_Membership_GetPasswordWithFormat
GO

/*************************************************************/
/*************************************************************/

IF ( EXISTS( SELECT name
             FROM sys.objects
             WHERE ( name = N'aspnet_Membership_UpdateUserInfo' )
                   AND ( type = 'P' ) ) )
DROP PROCEDURE dbo.aspnet_Membership_UpdateUserInfo
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_GetPassword')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetPassword
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_SetPassword')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_SetPassword
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_ResetPassword')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_ResetPassword
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_UnlockUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_UnlockUser
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_UpdateUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_UpdateUser
GO


/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_ChangePasswordQuestionAndAnswer')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_ChangePasswordQuestionAndAnswer
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_GetAllUsers')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetAllUsers
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_GetNumberOfUsersOnline')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetNumberOfUsersOnline
GO



/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_FindUsersByName')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_FindUsersByName
GO

/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sys.objects
             WHERE (name = N'aspnet_Membership_FindUsersByEmail')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_FindUsersByEmail
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
                FROM sys.objects
                WHERE (name = N'vw_aspnet_MembershipUsers')
                  AND (type = 'V')))
BEGIN
  PRINT 'Dropping the vw_aspnet_MembershipUsers view...'
  EXEC('
  DROP VIEW [dbo].[vw_aspnet_MembershipUsers]
  ')
END
GO

/*************************************************************/
/*************************************************************/

--
--Create Membership roles
--

IF ( EXISTS ( SELECT name
                  FROM sys.database_principals
                  WHERE [type] = 'R'
                  AND name = N'aspnet_Membership_FullAccess'  ) )
DROP ROLE aspnet_Membership_FullAccess

IF ( EXISTS ( SELECT name
                  FROM sys.database_principals
                  WHERE [type] = 'R'
                  AND name = N'aspnet_Membership_BasicAccess'  ) )
DROP ROLE aspnet_Membership_BasicAccess

IF ( EXISTS ( SELECT name
                  FROM sys.database_principals
                  WHERE [type] = 'R'
                  AND name = N'aspnet_Membership_ReportingAccess'  ) )
DROP ROLE aspnet_Membership_ReportingAccess
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

PRINT '--------------------------------------------'
PRINT 'Completed execution of InstallMembership.SQL'
PRINT '--------------------------------------------'
