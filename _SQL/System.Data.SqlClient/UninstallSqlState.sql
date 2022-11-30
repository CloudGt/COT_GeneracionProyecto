/*********************************************************************
  InstallSqlState.SQL                                                
                                                                    
  Installs the tables, and stored procedures necessary for           
  supporting ASP.NET session state on SQL Azure.                                  

  Copyright Microsoft, Inc.
  All Rights Reserved.

 *********************************************************************/

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ASPStateTempSessions]') AND type in (N'U'))
DROP TABLE [dbo].[ASPStateTempSessions]
GO   

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ASPStateTempApplications]') AND type in (N'U'))
DROP TABLE [dbo].[ASPStateTempApplications]
GO   

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetMajorVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetMajorVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'CreateTempTables') AND (type = 'P')))
    DROP PROCEDURE [dbo].CreateTempTables
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetHashCode') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetHashCode
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetAppID') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetAppID
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempReleaseStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempReleaseStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertUninitializedItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertUninitializedItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShortNullLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShortNullLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLongNullShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLongNullShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempRemoveStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempRemoveStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempResetTimeout') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempResetTimeout
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'DeleteExpiredSessions') AND (type = 'P')))
    DROP PROCEDURE [dbo].DeleteExpiredSessions
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'ASPStateTempSessions') AND (type = 'P')))
    DROP PROCEDURE [dbo].DeleteExpiredSessions
GO



/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

PRINT ''
PRINT '------------------------------------------'
PRINT 'Completed execution of InstallSqlState.SQL'
PRINT '------------------------------------------'

