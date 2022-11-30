<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease" exclude-result-prefixes="msxsl a codeontime"
>
  <xsl:import href="../../Data Aquarium/_App_Code/Services/ApplicationServices.codedom.xslt"/>

  <!-- 
  Sample Role Provider and MembershipProvider configuration
  
    <roleManager enabled="true" defaultProvider="MyCompanyApplicationRoleProvider">
      <providers>
        <clear/>
        <add name="MyCompanyApplicationRoleProvider" type="MyCompany.Security.ApplicationRoleProvider" connectionStringName="MyCompany"/>
      </providers>
    </roleManager>
    <membership defaultProvider="MyCompanyApplicationMembershipProvider">
      <providers>
        <clear/>
        <add name="MyCompanyApplicationMembershipProvider" type="MyCompany.Security.ApplicationMembershipProvider" connectionStringName="MyCompany"/>
      </providers>
    </membership>
    
  -->

  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="DebugCustomMembershipMappingMin">
    <![CDATA[
///// Users /////
table Users=MyUsers
column [int|uiid] UserID = MyUsers_UserId
column [text] UserName = MyUsers_UserName
column [text] Password = MyUsers_UserPwd
****************************************************
column [text] ApplicationName = MyUsers_Application

///// Roles /////
table Roles = dbo.[My Roles]
column [int|uiid] RoleID = MyRoles_RoleID
column [text] RoleName = MyRoles_RoleName
****************************************************
column [text] ApplicationName = MyRoles_AppName
 
///// UserRoles /////
table UserRoles = MyUserRoles
column [int|uiid] UserID = MyUserRoles_UserID
column [int|uiid] RoleID =  MyUserRoles_RoleID
****************************************************
column [text] ApplicationName = MyUserRoles_ApplicationName


----------------------------------------------------------------
SQL - minimal
----------------------------------------------------------------

drop table MyUsers
go
drop table "My Roles"
go
drop table "MyUserRoles"
go

create table MyUsers (
    MyUsers_UserID int identity primary key,
    MyUsers_UserName nvarchar(50) not null,
    MyUsers_UserPwd nvarchar(50) not null,
    MyUsers_Application nvarchar(100)
)
go

create table "My Roles"
(
   MyRoles_RoleID uniqueidentifier not null primary key default newid(),
   MyRoles_RoleName nvarchar(50),
   MyRoles_AppName nvarchar(100)
)
go

create table MyUserRoles
(
    MyUserRoles_UserID int not null,
    MyUserRoles_RoleID uniqueidentifier not null,
    MyUserRoles_ApplicationName nvarchar(100) not null,
    primary key(MyUserRoles_UserID, MyUserRoles_RoleID)
)
go
]]>
  </xsl:variable>

  <xsl:variable name="DebugCustomMembershipMappingMinWithEmail">
    <![CDATA[
///// Users /////
table Users=MyUsers
column [int|uiid] UserID = MyUsers_UserId
column [text] UserName = MyUsers_UserName
column [text] Password = MyUsers_UserPwd
column [text] Email = MyUsers_UserName
****************************************************
column [text] ApplicationName = MyUsers_Application

///// Roles /////
table Roles = dbo.[My Roles]
column [int|uiid] RoleID = MyRoles_RoleID
column [text] RoleName = MyRoles_RoleName
****************************************************
column [text] ApplicationName = MyRoles_AppName
 
///// UserRoles /////
table UserRoles = MyUserRoles
column [int|uiid] UserID = MyUserRoles_UserID
column [int|uiid] RoleID =  MyUserRoles_RoleID
****************************************************
column [text] ApplicationName = MyUserRoles_ApplicationName


----------------------------------------------------------------
SQL - minimal
----------------------------------------------------------------

drop table MyUsers
go
drop table "My Roles"
go
drop table "MyUserRoles"
go

create table MyUsers (
    MyUsers_UserID int identity primary key,
    MyUsers_UserName nvarchar(50) not null,
    MyUser_UserPwd nvarchar(50) not null,
    MyUsers_Application nvarchar(100)
)
go

create table "My Roles"
(
   MyRoles_RoleID uniqueidentifier not null primary key default newid(),
   MyRoles_RoleName nvarchar(50),
   MyRoles_AppName nvarchar(100)
)
go

create table MyUserRoles
(
    MyUserRoles_UserID int not null,
    MyUserRoles_RoleID uniqueidentifier not null,
    MyUserRoles_ApplicationName nvarchar(100) not null,
    primary key(MyUserRoles_UserID, MyUserRoles_RoleID)
)
go

]]>
  </xsl:variable>

  <xsl:variable name="DebugCustomMembershipMapping">
    <![CDATA[
///// Users /////
table Users=MyUsers
column [int|uiid] UserID = MyUsers_UserId
column [text] UserName = MyUsers_UserName
column [text] Password = MyUsers_UserPwd
****************************************************
column [text] ApplicationName = MyUsers_Application
column [text] Email = MyUsers_Email
column [text] Comment = MyUsers_Comment
column [text] PasswordQuestion = MyUsers_PasswordQuestion
column [text] PasswordAnswer = MyUsers_PasswordAnswer
column [bool] IsApproved = MyUsers_IsApproved
column [date] LastActivityDate = MyUsers_LastActivityDate
column [date] LastLoginDate = MyUsers_LastLoginDate
column [date] LastPasswordChangedDate = MyUsers_LastPasswordChangedDate
column [date] CreationDate = MyUsers_CreationDate
column [bool] IsOnLine = MyUsers_IsOnline
column [bool] IsLockedOut = MyUsers_IsLockedOut
column [date] LastLockedOutDate = MyUsers_LastLockedOutDate
column [int]  FailedPasswordAttemptCount = MyUsers_FailedPasswordAttemptCount
column [date] FailedPasswordAttemptWindowStart = MyUsers_FailedPasswordAttemptWindowStart
column [int]  FailedPasswordAnswerAttemptCount = MyUsers_FailedPasswordAnswerAttemptCount
column [date] FailedPasswordAnswerAttemptWindowStart = MyUsers_FailedPasswordAnswerAttemptWindowStart

///// Roles /////
table Roles = dbo.[My Roles]
column [int|uiid] RoleID = MyRoles_RoleID
column [text] RoleName = MyRoles_RoleName
****************************************************
column [text] ApplicationName = MyRoles_AppName
 
///// UserRoles /////
table UserRoles = MyUserRoles
column [int|uiid] UserID = MyUserRoles_UserID
column [int|uiid] RoleID =  MyUserRoles_RoleID
****************************************************
column [text] ApplicationName = MyUserRoles_ApplicationName


----------------------------------------------------------------
SQL - minimal
----------------------------------------------------------------

create table MyUsers (
    MyUsers_UserID int identity primary key,
    MyUsers_UserName nvarchar(50) not null,
    MyUser_UserPwd nvarchar(50) not null,
    MyUsers_Application nvarchar(100)
)
go

create table "My Roles"
(
   MyRoles_RoleID uniqueidentifier not null primary key default newid(),
   MyRoles_RoleName nvarchar(50),
   MyRoles_AppName nvarchar(100)
)
go

create table MyUserRoles
(
    MyUserRoles_UserID int not null,
    MyUserRoles_RoleID uniqueidentifier not null,
    MyUserRoles_ApplicationName nvarchar(100) not null,
    primary key(MyUserRoles_UserID, MyUserRoles_RoleID)
)
go
]]>
  </xsl:variable>


  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <!--<xsl:param name="CustomMembershipMapping" select="$DebugCustomMembershipMappingMin"/>-->
  <xsl:param name="CustomMembershipMapping" select="a:project/a:membership/a:config"/>


  <!-- 
This provider works with the following schema for the tables of role data.

    CREATE TABLE Roles
    (
      RoleID uniqueidentifier not null default newid(),
      Rolename varchar (255) NOT NULL,
      ApplicationName varchar (255) NOT NULL,
        CONSTRAINT PKRoles PRIMARY KEY (Rolename, ApplicationName)
    )

    CREATE TABLE UserRoles
    (
      UserID uniqueidentifier not null,
      /*Username varchar (255) NOT NULL,
      Rolename varchar (255) NOT NULL,*/
      RoleID uniqueidentifier not null,
      ApplicationName varchar (255) NOT NULL,
        CONSTRAINT PKUserRoles PRIMARY KEY (UserID, RoleID, ApplicationName)
    )
 
 * 
 *  Minimal Role and UsersInRole implementation
 * 
 
     CREATE TABLE Roles
    (
      RoleID uniqueidentifier not null default newid(),
      Rolename varchar (255) NOT NULL
        CONSTRAINT PKRoles PRIMARY KEY (Rolename)
    )

    CREATE TABLE UserRoles
    (
      UserID uniqueidentifier not null,
      RoleID uniqueidentifier not null,
        CONSTRAINT PKUserRoles PRIMARY KEY (UserID, RoleID)
    )
   -->

  <xsl:variable name="InitializeMapping" select="codeontime:Initialize($CustomMembershipMapping)"/>
  <xsl:variable name="DynamicRoles">
    <xsl:choose>
      <xsl:when test="codeontime:TableColumnIsDefined('Roles', 'RoleName')">
        <xsl:text>true</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>false</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Security">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Configuration.Provider"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Collections.Specialized"/>
        <namespaceImport name="System.Data.Common"/>
        <namespaceImport name="System.Diagnostics"/>
        <namespaceImport name="System.Globalization"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Xml.XPath"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="{$Namespace}.Data"/>
      </imports>
      <types>
        <!-- class ApplicationRoleProvider -->
        <typeDeclaration name="ApplicationRoleProvider" isPartial="true">
          <baseTypes>
            <typeReference type="ApplicationRoleProviderBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- enum RoleProviderSqlStatement-->
        <xsl:if test="$DynamicRoles='true'">
          <typeDeclaration name="RoleProviderSqlStatement" isEnum="true">
            <attributes public="true"/>
            <members>
              <memberField name="AddUserToRole">
                <attributes public="true"/>
              </memberField>
              <memberField name="CreateRole">
                <attributes public="true"/>
              </memberField>
              <memberField name="DeleteRole">
                <attributes public="true"/>
              </memberField>
              <memberField name="DeleteRoleUsers">
                <attributes public="true"/>
              </memberField>
              <memberField name="GetAllRoles">
                <attributes public="true"/>
              </memberField>
              <memberField name="GetRolesForUser">
                <attributes public="true"/>
              </memberField>
              <memberField name="GetUsersInRole">
                <attributes public="true"/>
              </memberField>
              <memberField name="IsUserInRole">
                <attributes public="true"/>
              </memberField>
              <memberField name="RemoveUserFromRole">
                <attributes public="true"/>
              </memberField>
              <memberField name="RoleExists">
                <attributes public="true"/>
              </memberField>
              <memberField name="FindUsersInRole">
                <attributes public="true"/>
              </memberField>
            </members>
          </typeDeclaration>
        </xsl:if>
        <!-- class ApplicationRoleProviderBase -->
        <typeDeclaration name="ApplicationRoleProviderBase">
          <baseTypes>
            <typeReference type="RoleProvider"/>
          </baseTypes>
          <members>
            <!-- property Commands -->
            <xsl:if test="$DynamicRoles='true'">
              <memberField type="SortedDictionary" name="Statements">
                <typeArguments>
                  <typeReference type="RoleProviderSqlStatement"/>
                  <typeReference type="System.String"/>
                </typeArguments>
                <attributes family="true" static="true"/>
                <init>
                  <objectCreateExpression type="SortedDictionary">
                    <typeArguments>
                      <typeReference type="RoleProviderSqlStatement"/>
                      <typeReference type="System.String"/>
                    </typeArguments>
                  </objectCreateExpression>
                </init>
              </memberField>
              <!-- public ApplicationRoleProviderBase() -->
              <typeConstructor>
                <statements>
                  <!-- AddUserToRole -->
                  <xsl:variable name="AddUserToRole" xml:space="preserve">
                      <![CDATA[
insert into [UserRoles]([UserRoles.UserID], [UserRoles.RoleID]??, [UserRoles.ApplicationName]^UserRoles.ApplicationName??) 
values (
     (select [Users.UserID] from [Users] where [Users.UserName]=@UserName?? and [Users.ApplicationName]=@ApplicationName^Users.ApplicationName??) 
    ,(select [Roles.RoleID] from [Roles] where [Roles.RoleName]=@RoleName?? and [Roles.ApplicationName]=@ApplicationName^Roles.ApplicationName??)
    ??, @ApplicationName^UserRoles.ApplicationName??
)]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="AddUserToRole">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($AddUserToRole)}"/>
                  </assignStatement>
                  <!-- CreateRole -->
                  <xsl:variable name="CreateRole" xml:space="preserve">
                      <![CDATA[insert into [Roles] ([Roles.RoleName]??, [Roles.ApplicationName]^Roles.ApplicationName??) values (@RoleName??, @ApplicationName^Roles.ApplicationName??)]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="CreateRole">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($CreateRole)}"/>
                  </assignStatement>
                  <!-- DeleteRole -->
                  <xsl:variable name="DeleteRole" xml:space="preserve">
                      <![CDATA[delete from [Roles] where [Roles.RoleName] = @RoleName?? and [Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="DeleteRole">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($DeleteRole)}"/>
                  </assignStatement>
                  <!-- DeleteRoleUsers -->
                  <xsl:variable name="DeleteRoleUsers" xml:space="preserve">
                      <![CDATA[delete from [UserRoles] where [UserRoles.RoleID] in (select [Roles.RoleID] from [Roles] where [Roles.RoleName] = @RoleName?? and [Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??)?? and [UserRoles.ApplicationName] = @ApplicationName^UserRoles.ApplicationName??]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="DeleteRoleUsers">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($DeleteRoleUsers)}"/>
                  </assignStatement>
                  <!-- GetAllRoles -->
                  <xsl:variable name="GetAllRoles" xml:space="preserve">
                      <![CDATA[select [Roles.RoleName] RoleName from [Roles]?? where [Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="GetAllRoles">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($GetAllRoles)}"/>
                  </assignStatement>
                  <!-- GetRolesForUser -->
                  <xsl:variable name="GetRolesForUser" xml:space="preserve">
                      <![CDATA[select Roles.[Roles.RoleName] RoleName from [Roles] Roles 
inner join [UserRoles] UserRoles on Roles.[Roles.RoleID] = UserRoles.[UserRoles.RoleID] 
inner join [Users] Users on Users.[Users.UserID] = UserRoles.[UserRoles.UserID]
where Users.[Users.UserName] = @UserName?? and Users.[Users.ApplicationName] = @ApplicationName^Users.ApplicationName??]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="GetRolesForUser">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($GetRolesForUser)}"/>
                  </assignStatement>
                  <!-- GetUsersInRole -->
                  <xsl:variable name="GetUsersInRole" xml:space="preserve">
                      <![CDATA[select [Users.UserName] UserName from [Users] where [Users.UserId] in (select [UserRoles.UserID] from [UserRoles] where [UserRoles.RoleId] in (select [Roles.RoleID] from [Roles] where [Roles.RoleName] = @RoleName?? and [Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??))]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="GetUsersInRole">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($GetUsersInRole)}"/>
                  </assignStatement>
                  <!-- IsUserInRole -->
                  <xsl:variable name="IsUserInRole" xml:space="preserve">
                      <![CDATA[select count(*) from [UserRoles]
where
    [UserRoles.UserId] in (select [Users.UserID] from [Users] where [Users.Username] = @UserName?? and [Users.ApplicationName] = @ApplicationName^Users.ApplicationName??) and 
    [UserRoles.RoleId] in (select [Roles.RoleId] from [Roles] where [Roles.Rolename] = @RoleName?? and [Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??)]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="IsUserInRole">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($IsUserInRole)}"/>
                  </assignStatement>
                  <!-- IsUserInRole -->
                  <xsl:variable name="RemoveUserFromRole" xml:space="preserve">
                      <![CDATA[delete from [UserRoles]
where
   [UserRoles.UserId] in (select [Users.UserID] from [Users] where [Users.Username] = @UserName?? and [Users.ApplicationName] = @ApplicationName^Users.ApplicationName??) and
   [UserRoles.RoleId] in (select [Roles.RoleId] from [Roles] where [Roles.Rolename] = @RoleName?? and [Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??)]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="RemoveUserFromRole">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($RemoveUserFromRole)}"/>
                  </assignStatement>
                  <!-- IsUserInRole -->
                  <xsl:variable name="RoleExists" xml:space="preserve">
                      <![CDATA[select count(*) from [Roles] where [Roles.Rolename] = @RoleName?? and [Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="RoleExists">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($RoleExists)}"/>
                  </assignStatement>
                  <!-- FindUsersInRole -->
                  <xsl:variable name="FindUsersInRole" xml:space="preserve">
                      <![CDATA[select Users.[Users.Username] UserName from [Users] Users
inner join [UserRoles] UserRoles on Users.[Users.UserID]= UserRoles.[UserRoles.UserID] 
inner join [Roles] Roles on UserRoles.[UserRoles.RoleID] = Roles.[Roles.RoleID]
where 
	Users.[Users.Username] like @UserName?? and Users.[Users.ApplicationName] = @ApplicationName^Users.ApplicationName?? and 
	Roles.[Roles.Rolename] = @RoleName?? and Roles.[Roles.ApplicationName] = @ApplicationName^Roles.ApplicationName??]]></xsl:variable>
                  <assignStatement>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Statements"/>
                      </target>
                      <indices>
                        <propertyReferenceExpression name="FindUsersInRole">
                          <typeReferenceExpression type="RoleProviderSqlStatement"/>
                        </propertyReferenceExpression>
                      </indices>
                    </arrayIndexerExpression>
                    <primitiveExpression value="{codeontime:NormalizeLineEndings($FindUsersInRole)}"/>
                  </assignStatement>
                </statements>
              </typeConstructor>
            </xsl:if>
            <!-- method CreateSqlStatement -->
            <xsl:if test="$DynamicRoles='true'">
              <memberMethod returnType="SqlStatement" name="CreateSqlStatement">
                <attributes family="true"/>
                <parameters>
                  <parameter type="RoleProviderSqlStatement" name="command"/>
                </parameters>
                <statements>
                  <variableDeclarationStatement type="SqlText" name="sql">
                    <init>
                      <objectCreateExpression type="SqlText">
                        <parameters>
                          <arrayIndexerExpression>
                            <target>
                              <propertyReferenceExpression name="Statements"/>
                            </target>
                            <indices>
                              <argumentReferenceExpression name="command"/>
                            </indices>
                          </arrayIndexerExpression>
                          <propertyReferenceExpression name="Name">
                            <propertyReferenceExpression name="ConnectionStringSettings"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </objectCreateExpression>
                    </init>
                  </variableDeclarationStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="CommandText">
                      <propertyReferenceExpression name="Command">
                        <variableReferenceExpression name="sql"/>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                    <methodInvokeExpression methodName="Replace">
                      <target>
                        <propertyReferenceExpression name="CommandText">
                          <propertyReferenceExpression name="Command">
                            <variableReferenceExpression name="sql"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="@"/>
                        <propertyReferenceExpression name="ParameterMarker">
                          <variableReferenceExpression name="sql"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </assignStatement>
                  <conditionStatement>
                    <condition>
                      <methodInvokeExpression methodName="Contains">
                        <target>
                          <propertyReferenceExpression name="CommandText">
                            <propertyReferenceExpression name="Command">
                              <variableReferenceExpression name="sql"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <binaryOperatorExpression operator="Add">
                            <propertyReferenceExpression name="ParameterMarker">
                              <variableReferenceExpression name="sql"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="ApplicationName"/>
                          </binaryOperatorExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AssignParameter">
                        <target>
                          <variableReferenceExpression name="sql"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="ApplicationName"/>
                          <propertyReferenceExpression name="ApplicationName"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="Name">
                      <variableReferenceExpression name="sql"/>
                    </propertyReferenceExpression>
                    <binaryOperatorExpression operator="Add">
                      <primitiveExpression value="{$Namespace} Application Role Provider - "/>
                      <methodInvokeExpression methodName="ToString">
                        <target>
                          <argumentReferenceExpression name="command"/>
                        </target>
                      </methodInvokeExpression>
                    </binaryOperatorExpression>
                  </assignStatement>
                  <assignStatement>
                    <propertyReferenceExpression name="WriteExceptionsToEventLog">
                      <variableReferenceExpression name="sql"/>
                    </propertyReferenceExpression>
                    <propertyReferenceExpression name="WriteExceptionsToEventLog"/>
                  </assignStatement>
                  <methodReturnStatement>
                    <variableReferenceExpression name="sql"/>
                  </methodReturnStatement>
                </statements>
              </memberMethod>
            </xsl:if>
            <!-- property ConnectionStringSettings -->
            <memberField type="ConnectionStringSettings" name="connectionStringSettings"/>
            <memberProperty type="ConnectionStringSettings" name="ConnectionStringSettings">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="connectionStringSettings"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property WriteExceptionsToEventLog -->
            <memberField type="System.Boolean" name="writeExceptionsToEventLog"/>
            <memberProperty type="System.Boolean" name="WriteExceptionsToEventLog">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="writeExceptionsToEventLog"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method Initialize(string, NameValueCollection) -->
            <memberMethod name="Initialize">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
                <parameter type="NameValueCollection" name="config"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <argumentReferenceExpression name="config"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ArgumentNullException">
                        <parameters>
                          <primitiveExpression value="config"/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <argumentReferenceExpression name="name"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <argumentReferenceExpression name="name"/>
                      <primitiveExpression value="{$Namespace}ApplicationRoleProvider"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="config"/>
                        </target>
                        <indices>
                          <primitiveExpression value="description"/>
                        </indices>
                      </arrayIndexerExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Remove">
                      <target>
                        <argumentReferenceExpression name="config"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="description"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <argumentReferenceExpression name="config"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="description"/>
                        <primitiveExpression value="{$Namespace} application role provider"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="Initialize">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="name"/>
                    <argumentReferenceExpression name="config"/>
                  </parameters>
                </methodInvokeExpression>
                <assignStatement>
                  <fieldReferenceExpression name="applicationName"/>
                  <arrayIndexerExpression>
                    <target>
                      <argumentReferenceExpression name="config"/>
                    </target>
                    <indices>
                      <primitiveExpression value="applicationName"/>
                    </indices>
                  </arrayIndexerExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <fieldReferenceExpression name="applicationName"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="applicationName"/>
                      <propertyReferenceExpression name="ApplicationVirtualPath">
                        <typeReferenceExpression type="System.Web.Hosting.HostingEnvironment"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <fieldReferenceExpression name="writeExceptionsToEventLog"/>
                  <methodInvokeExpression methodName="Equals">
                    <target>
                      <primitiveExpression value="true" convertTo="String"/>
                    </target>
                    <parameters>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="config"/>
                        </target>
                        <indices>
                          <primitiveExpression value="writeExceptionsToEventLog"/>
                        </indices>
                      </arrayIndexerExpression>
                      <propertyReferenceExpression name="CurrentCulture">
                        <typeReferenceExpression type="StringComparison"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="connectionStringSettings"/>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="ConnectionStrings">
                        <typeReferenceExpression type="ConfigurationManager"/>
                      </propertyReferenceExpression>
                    </target>
                    <indices>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="config"/>
                        </target>
                        <indices>
                          <primitiveExpression value="connectionStringName"/>
                        </indices>
                      </arrayIndexerExpression>
                    </indices>
                  </arrayIndexerExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <binaryOperatorExpression operator="IdentityEquality">
                        <fieldReferenceExpression name="connectionStringSettings"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                      <unaryOperatorExpression operator="IsNullOrEmpty">
                        <propertyReferenceExpression name="ConnectionString">
                          <fieldReferenceExpression name="connectionStringSettings"/>
                        </propertyReferenceExpression>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="Connection string cannot be blank."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- property ApplicationName -->
            <memberProperty type="System.String" name="ApplicationName">
              <attributes public="true" override="true"/>
            </memberProperty>
            <!-- method AddUsersToRoles(string[], string[]) -->
            <memberMethod name="AddUsersToRoles">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String[]" name="usernames"/>
                <parameter type="System.String[]" name="rolenames"/>
              </parameters>
              <statements>
                <xsl:if test="$DynamicRoles='true'">
                  <foreachStatement>
                    <variable type="System.String" name="rolename"/>
                    <target>
                      <argumentReferenceExpression name="rolenames"/>
                    </target>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="RoleExists">
                              <parameters>
                                <variableReferenceExpression name="rolename"/>
                              </parameters>
                            </methodInvokeExpression>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <throwExceptionStatement>
                            <objectCreateExpression type="ProviderException">
                              <parameters>
                                <stringFormatExpression format="Role name '{{0}}' not found.">
                                  <variableReferenceExpression name="rolename"/>
                                </stringFormatExpression>
                              </parameters>
                            </objectCreateExpression>
                          </throwExceptionStatement>
                        </trueStatements>
                      </conditionStatement>
                    </statements>
                  </foreachStatement>
                  <foreachStatement>
                    <variable type="System.String" name="username"/>
                    <target>
                      <argumentReferenceExpression name="usernames"/>
                    </target>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <methodInvokeExpression methodName="Contains">
                            <target>
                              <variableReferenceExpression name="username"/>
                            </target>
                            <parameters>
                              <primitiveExpression value=","/>
                            </parameters>
                          </methodInvokeExpression>
                        </condition>
                        <trueStatements>
                          <throwExceptionStatement>
                            <objectCreateExpression type="ArgumentException">
                              <parameters>
                                <primitiveExpression value="User names cannot contain commas."/>
                              </parameters>
                            </objectCreateExpression>
                          </throwExceptionStatement>
                        </trueStatements>
                      </conditionStatement>
                      <foreachStatement>
                        <variable type="System.String" name="rolename"/>
                        <target>
                          <argumentReferenceExpression name="rolenames"/>
                        </target>
                        <statements>
                          <conditionStatement>
                            <condition>
                              <methodInvokeExpression methodName="IsUserInRole">
                                <parameters>
                                  <variableReferenceExpression name="username"/>
                                  <variableReferenceExpression name="rolename"/>
                                </parameters>
                              </methodInvokeExpression>
                            </condition>
                            <trueStatements>
                              <throwExceptionStatement>
                                <objectCreateExpression type="ProviderException">
                                  <parameters>
                                    <stringFormatExpression format="User '{{0}}' is already in role '{{1}}'.">
                                      <variableReferenceExpression name="username"/>
                                      <variableReferenceExpression name="rolename"/>
                                    </stringFormatExpression>
                                  </parameters>
                                </objectCreateExpression>
                              </throwExceptionStatement>
                            </trueStatements>
                          </conditionStatement>
                        </statements>
                      </foreachStatement>
                    </statements>
                  </foreachStatement>
                  <usingStatement>
                    <variable type="SqlStatement" name="sql">
                      <init>
                        <methodInvokeExpression methodName="CreateSqlStatement">
                          <parameters>
                            <propertyReferenceExpression name="AddUserToRole">
                              <typeReferenceExpression type="RoleProviderSqlStatement"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variable>
                    <statements>
                      <foreachStatement>
                        <variable type="System.String" name="username"/>
                        <target>
                          <argumentReferenceExpression name="usernames"/>
                        </target>
                        <statements>
                          <methodInvokeExpression methodName="ForgetUserRoles">
                            <parameters>
                              <variableReferenceExpression name="username"/>
                            </parameters>
                          </methodInvokeExpression>
                          <foreachStatement>
                            <variable type="System.String" name="rolename"/>
                            <target>
                              <argumentReferenceExpression name="rolenames"/>
                            </target>
                            <statements>
                              <methodInvokeExpression methodName="AssignParameter">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="UserName"/>
                                  <variableReferenceExpression name="username"/>
                                </parameters>
                              </methodInvokeExpression>
                              <methodInvokeExpression methodName="AssignParameter">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="RoleName"/>
                                  <variableReferenceExpression name="rolename"/>
                                </parameters>
                              </methodInvokeExpression>
                              <methodInvokeExpression methodName="ExecuteNonQuery">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                              </methodInvokeExpression>
                            </statements>
                          </foreachStatement>
                        </statements>
                      </foreachStatement>
                    </statements>
                  </usingStatement>
                </xsl:if>
              </statements>
            </memberMethod>
            <!-- method CreateRole(string) -->
            <memberMethod name="CreateRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
                <xsl:if test="$DynamicRoles='true'">
                  <conditionStatement>
                    <condition>
                      <methodInvokeExpression methodName="Contains">
                        <target>
                          <argumentReferenceExpression name="rolename"/>
                        </target>
                        <parameters>
                          <primitiveExpression value=","/>
                        </parameters>
                      </methodInvokeExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ArgumentException">
                          <parameters>
                            <primitiveExpression value="Role names cannot contain commas."/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <conditionStatement>
                    <condition>
                      <methodInvokeExpression methodName="RoleExists">
                        <parameters>
                          <argumentReferenceExpression name="rolename"/>
                        </parameters>
                      </methodInvokeExpression>
                    </condition>
                    <trueStatements>
                      <throwExceptionStatement>
                        <objectCreateExpression type="ProviderException">
                          <parameters>
                            <primitiveExpression value="Role already exists."/>
                          </parameters>
                        </objectCreateExpression>
                      </throwExceptionStatement>
                    </trueStatements>
                  </conditionStatement>
                  <usingStatement>
                    <variable type="SqlStatement" name="sql">
                      <init>
                        <methodInvokeExpression methodName="CreateSqlStatement">
                          <parameters>
                            <propertyReferenceExpression name="CreateRole">
                              <typeReferenceExpression type="RoleProviderSqlStatement"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variable>
                    <statements>
                      <methodInvokeExpression methodName="AssignParameter">
                        <target>
                          <variableReferenceExpression name="sql"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="RoleName"/>
                          <argumentReferenceExpression name="rolename"/>
                        </parameters>
                      </methodInvokeExpression>
                      <methodInvokeExpression methodName="ExecuteNonQuery">
                        <target>
                          <variableReferenceExpression name="sql"/>
                        </target>
                      </methodInvokeExpression>
                    </statements>
                  </usingStatement>
                </xsl:if>
              </statements>
            </memberMethod>
            <!-- method DeleteRole(string, bool) -->
            <memberMethod returnType="System.Boolean" name="DeleteRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
                <parameter type="System.Boolean" name="throwOnPopulatedRole"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="$DynamicRoles='false'">
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="RoleExists">
                            <parameters>
                              <argumentReferenceExpression name="rolename"/>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="ProviderException">
                            <parameters>
                              <primitiveExpression value="Role does not exist."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <argumentReferenceExpression name="throwOnPopulatedRole"/>
                          <binaryOperatorExpression operator="GreaterThan">
                            <propertyReferenceExpression name="Length">
                              <methodInvokeExpression methodName="GetUsersInRole">
                                <parameters>
                                  <argumentReferenceExpression name="rolename"/>
                                </parameters>
                              </methodInvokeExpression>
                            </propertyReferenceExpression>
                            <primitiveExpression value="0"/>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="ProviderException">
                            <parameters>
                              <primitiveExpression value="Cannot delete a pouplated role."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="DeleteRole">
                                <typeReferenceExpression type="RoleProviderSqlStatement"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variable>
                      <statements>
                        <usingStatement>
                          <variable type="SqlStatement" name="sql2">
                            <init>
                              <methodInvokeExpression methodName="CreateSqlStatement">
                                <parameters>
                                  <propertyReferenceExpression name="DeleteRoleUsers">
                                    <typeReferenceExpression type="RoleProviderSqlStatement"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </init>
                          </variable>
                          <statements>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql2"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="RoleName"/>
                                <argumentReferenceExpression name="rolename"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="ExecuteNonQuery">
                              <target>
                                <variableReferenceExpression name="sql2"/>
                              </target>
                            </methodInvokeExpression>
                          </statements>
                        </usingStatement>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="RoleName"/>
                            <variableReferenceExpression name="rolename"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="ExecuteNonQuery">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </statements>
                    </usingStatement>
                    <methodReturnStatement>
                      <primitiveExpression value="true"/>
                    </methodReturnStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
            <!-- method GetAllRoles() -->
            <memberMethod returnType="System.String[]" name="GetAllRoles">
              <attributes public="true" override="true"/>
              <statements>
                <xsl:choose>
                  <xsl:when test="$DynamicRoles='false'">
                    <methodReturnStatement>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <initializers>
                          <xsl:for-each select="codeontime:Roles()/role">
                            <primitiveExpression value="{@name}"/>
                          </xsl:for-each>
                        </initializers>
                      </arrayCreateExpression>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <variableDeclarationStatement type="List" name="roles">
                      <typeArguments>
                        <typeReference type="System.String"/>
                      </typeArguments>
                      <init>
                        <objectCreateExpression type="List">
                          <typeArguments>
                            <typeReference type="System.String"/>
                          </typeArguments>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="GetAllRoles">
                                <typeReferenceExpression type="RoleProviderSqlStatement"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variable>
                      <statements>
                        <whileStatement>
                          <test>
                            <methodInvokeExpression methodName="Read">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                            </methodInvokeExpression>
                          </test>
                          <statements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="roles"/>
                              </target>
                              <parameters>
                                <convertExpression to="String">
                                  <arrayIndexerExpression>
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                    <indices>
                                      <primitiveExpression value="RoleName"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                </convertExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </statements>
                        </whileStatement>
                      </statements>
                    </usingStatement>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="ToArray">
                        <target>
                          <variableReferenceExpression name="roles"/>
                        </target>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
            <!-- method GetRolesForUser(string) -->
            <memberMethod returnType="System.String[]" name="GetRolesForUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="$DynamicRoles='false'">
                    <xsl:for-each select="codeontime:Users()/user[@name!='*']">
                      <xsl:variable name="UserRoles" select="codeontime:UserRoles(@name)/role"/>
                      <xsl:if test="$UserRoles">
                        <assignStatement>
                          <argumentReferenceExpression name="username"/>
                          <methodInvokeExpression methodName="ToLower">
                            <target>
                              <argumentReferenceExpression name="username"/>
                            </target>
                          </methodInvokeExpression>
                        </assignStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <argumentReferenceExpression name="username"/>
                              <primitiveExpression value="{@loweredName}"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodReturnStatement>
                              <arrayCreateExpression>
                                <createType type="System.String"/>
                                <initializers>
                                  <xsl:for-each select="$UserRoles">
                                    <primitiveExpression value="{@name}"/>
                                  </xsl:for-each>
                                </initializers>
                              </arrayCreateExpression>
                            </methodReturnStatement>
                          </trueStatements>
                        </conditionStatement>
                      </xsl:if>
                    </xsl:for-each>
                    <methodReturnStatement>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <initializers>
                          <xsl:for-each select="codeontime:UserRoles('*')/role">
                            <primitiveExpression value="{@name}"/>
                          </xsl:for-each>
                        </initializers>
                      </arrayCreateExpression>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <variableDeclarationStatement type="List" name="roles">
                      <typeArguments>
                        <typeReference type="System.String"/>
                      </typeArguments>
                      <init>
                        <primitiveExpression value="null"/>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.String" name="userRolesKey">
                      <init>
                        <stringFormatExpression format="ApplicationRoleProvider_{{0}}_Roles">
                          <argumentReferenceExpression name="username"/>
                        </stringFormatExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Boolean" name="contextIsAvailable">
                      <init>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="Current">
                            <typeReferenceExpression type="HttpContext"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <variableReferenceExpression name="contextIsAvailable"/>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="roles"/>
                          <castExpression targetType="List">
                            <typeArguments>
                              <typeReference type="System.String"/>
                            </typeArguments>
                            <arrayIndexerExpression>
                              <target>
                                <propertyReferenceExpression name="Items">
                                  <propertyReferenceExpression name="Current">
                                    <typeReferenceExpression type="HttpContext"/>
                                  </propertyReferenceExpression>
                                </propertyReferenceExpression>
                              </target>
                              <indices>
                                <variableReferenceExpression name="userRolesKey"/>
                              </indices>
                            </arrayIndexerExpression>
                          </castExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityEquality">
                          <variableReferenceExpression name="roles"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="roles"/>
                          <objectCreateExpression type="List">
                            <typeArguments>
                              <typeReference type="System.String"/>
                            </typeArguments>
                          </objectCreateExpression>
                        </assignStatement>
                        <usingStatement>
                          <variable type="SqlStatement" name="sql">
                            <init>
                              <methodInvokeExpression methodName="CreateSqlStatement">
                                <parameters>
                                  <propertyReferenceExpression name="GetRolesForUser">
                                    <typeReferenceExpression type="RoleProviderSqlStatement"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </init>
                          </variable>
                          <statements>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="UserName"/>
                                <argumentReferenceExpression name="username"/>
                              </parameters>
                            </methodInvokeExpression>
                            <whileStatement>
                              <test>
                                <methodInvokeExpression methodName="Read">
                                  <target>
                                    <variableReferenceExpression name="sql"/>
                                  </target>
                                </methodInvokeExpression>
                              </test>
                              <statements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="roles"/>
                                  </target>
                                  <parameters>
                                    <convertExpression to="String">
                                      <arrayIndexerExpression>
                                        <target>
                                          <variableReferenceExpression name="sql"/>
                                        </target>
                                        <indices>
                                          <primitiveExpression value="RoleName"/>
                                        </indices>
                                      </arrayIndexerExpression>
                                    </convertExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </statements>
                            </whileStatement>
                            <conditionStatement>
                              <condition>
                                <variableReferenceExpression name="contextIsAvailable"/>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <arrayIndexerExpression>
                                    <target>
                                      <propertyReferenceExpression name="Items">
                                        <propertyReferenceExpression name="Current">
                                          <typeReferenceExpression type="HttpContext"/>
                                        </propertyReferenceExpression>
                                      </propertyReferenceExpression>
                                    </target>
                                    <indices>
                                      <variableReferenceExpression name="userRolesKey"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                  <variableReferenceExpression name="roles"/>
                                </assignStatement>
                              </trueStatements>
                            </conditionStatement>
                          </statements>
                        </usingStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="ToArray">
                        <target>
                          <variableReferenceExpression name="roles"/>
                        </target>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
            <!-- method ForgetUserRoles-->
            <xsl:if test="$DynamicRoles='true'">
              <memberMethod name="ForgetUserRoles">
                <attributes public="true"/>
                <parameters>
                  <parameter type="System.String" name="username"/>
                </parameters>
                <statements>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="IdentityInequality">
                        <propertyReferenceExpression name="Current">
                          <typeReferenceExpression type="HttpContext"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="Remove">
                        <target>
                          <propertyReferenceExpression name="Items">
                            <propertyReferenceExpression name="Current">
                              <typeReferenceExpression type="HttpContext"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <stringFormatExpression format="ApplicationRoleProvider_{{0}}_Roles">
                            <argumentReferenceExpression name="username"/>
                          </stringFormatExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </statements>
              </memberMethod>
            </xsl:if>
            <!-- method GetUsersInRole(string) -->
            <memberMethod returnType="System.String[]" name="GetUsersInRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="$DynamicRoles='false'">
                    <xsl:for-each select="codeontime:Roles()/role[not(user/@name='*')]">
                      <assignStatement>
                        <argumentReferenceExpression name="rolename"/>
                        <methodInvokeExpression methodName="ToLower">
                          <target>
                            <argumentReferenceExpression name="rolename"/>
                          </target>
                        </methodInvokeExpression>
                      </assignStatement>
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <argumentReferenceExpression name="rolename"/>
                            <primitiveExpression value="{@loweredName}"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <arrayCreateExpression>
                              <createType type="System.String"/>
                              <initializers>
                                <xsl:for-each select="user">
                                  <primitiveExpression value="{@name}"/>
                                </xsl:for-each>
                              </initializers>
                            </arrayCreateExpression>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                    </xsl:for-each>
                    <xsl:for-each select="codeontime:Roles()/role[user/@name='*']">
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <argumentReferenceExpression name="rolename"/>
                            <primitiveExpression value="{@loweredName}"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <arrayCreateExpression>
                              <createType type="System.String"/>
                              <initializers>
                                <xsl:for-each select="codeontime:Users()/user[@name!='*']">
                                  <primitiveExpression value="{@name}"/>
                                </xsl:for-each>
                              </initializers>
                            </arrayCreateExpression>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                    </xsl:for-each>
                    <methodReturnStatement>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <sizeExpression>
                          <primitiveExpression value="0"/>
                        </sizeExpression>
                      </arrayCreateExpression>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <variableDeclarationStatement type="List" name="users">
                      <typeArguments>
                        <typeReference type="System.String"/>
                      </typeArguments>
                      <init>
                        <objectCreateExpression type="List">
                          <typeArguments>
                            <typeReference type="System.String"/>
                          </typeArguments>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="GetUsersInRole">
                                <typeReferenceExpression type="RoleProviderSqlStatement"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variable>
                      <statements>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="RoleName"/>
                            <variableReferenceExpression name="rolename"/>
                          </parameters>
                        </methodInvokeExpression>
                        <whileStatement>
                          <test>
                            <methodInvokeExpression methodName="Read">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                            </methodInvokeExpression>
                          </test>
                          <statements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="users"/>
                              </target>
                              <parameters>
                                <convertExpression to="String">
                                  <arrayIndexerExpression>
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                    <indices>
                                      <primitiveExpression value="UserName"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                </convertExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </statements>
                        </whileStatement>
                      </statements>
                    </usingStatement>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="ToArray">
                        <target>
                          <variableReferenceExpression name="users"/>
                        </target>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
            <!-- method IsUserInRole(string, string) -->
            <memberMethod returnType="System.Boolean" name="IsUserInRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="$DynamicRoles='false'">
                    <assignStatement>
                      <argumentReferenceExpression name="rolename"/>
                      <methodInvokeExpression methodName="ToLower">
                        <target>
                          <argumentReferenceExpression name="rolename"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                    <assignStatement>
                      <argumentReferenceExpression name="username"/>
                      <methodInvokeExpression methodName="ToLower">
                        <target>
                          <argumentReferenceExpression name="username"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                    <xsl:for-each select="codeontime:Roles()/role[not(user/@name='*')]">
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <argumentReferenceExpression name="rolename"/>
                            <primitiveExpression value="{@loweredName}"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <binaryOperatorExpression operator="ValueInequality">
                              <methodInvokeExpression methodName="IndexOf">
                                <target>
                                  <typeReferenceExpression type="Array"/>
                                </target>
                                <parameters>
                                  <arrayCreateExpression>
                                    <createType type="System.String"/>
                                    <initializers>
                                      <xsl:for-each select="user">
                                        <primitiveExpression value="{@loweredName}"/>
                                      </xsl:for-each>
                                    </initializers>
                                  </arrayCreateExpression>
                                  <argumentReferenceExpression name="username"/>
                                </parameters>
                              </methodInvokeExpression>
                              <primitiveExpression value="-1"/>
                            </binaryOperatorExpression>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                    </xsl:for-each>
                    <xsl:for-each select="codeontime:Roles()/role[user/@name='*']">
                      <conditionStatement>
                        <condition>
                          <binaryOperatorExpression operator="ValueEquality">
                            <argumentReferenceExpression name="rolename"/>
                            <primitiveExpression value="{@loweredName}"/>
                          </binaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <methodReturnStatement>
                            <primitiveExpression value="true"/>
                          </methodReturnStatement>
                        </trueStatements>
                      </conditionStatement>
                    </xsl:for-each>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression  methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="IsUserInRole">
                                <typeReferenceExpression type="RoleProviderSqlStatement"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variable>
                      <statements>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="UserName"/>
                            <argumentReferenceExpression name="username"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="RoleName"/>
                            <argumentReferenceExpression name="rolename"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodReturnStatement>
                          <binaryOperatorExpression operator="GreaterThan">
                            <convertExpression to="Int32">
                              <methodInvokeExpression methodName="ExecuteScalar">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                              </methodInvokeExpression>
                            </convertExpression>
                            <primitiveExpression value="0"/>
                          </binaryOperatorExpression>
                        </methodReturnStatement>
                      </statements>
                    </usingStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
            <!-- method RemoveUsersFromRoles(sting[], string[]) -->
            <memberMethod name="RemoveUsersFromRoles">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String[]" name="usernames"/>
                <parameter type="System.String[]" name="rolenames"/>
              </parameters>
              <statements>
                <xsl:if test="$DynamicRoles='true'">
                  <foreachStatement>
                    <variable type="System.String" name="rolename"/>
                    <target>
                      <argumentReferenceExpression name="rolenames"/>
                    </target>
                    <statements>
                      <conditionStatement>
                        <condition>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="RoleExists">
                              <parameters>
                                <variableReferenceExpression name="rolename"/>
                              </parameters>
                            </methodInvokeExpression>
                          </unaryOperatorExpression>
                        </condition>
                        <trueStatements>
                          <throwExceptionStatement>
                            <objectCreateExpression type="ProviderException">
                              <parameters>
                                <stringFormatExpression format="Role '{{0}}' not found.">
                                  <variableReferenceExpression name="rolename"/>
                                </stringFormatExpression>
                              </parameters>
                            </objectCreateExpression>
                          </throwExceptionStatement>
                        </trueStatements>
                      </conditionStatement>
                    </statements>
                  </foreachStatement>
                  <foreachStatement>
                    <variable type="System.String" name="username"/>
                    <target>
                      <argumentReferenceExpression name="usernames"/>
                    </target>
                    <statements>
                      <foreachStatement>
                        <variable type="System.String" name="rolename"/>
                        <target>
                          <argumentReferenceExpression name="rolenames"/>
                        </target>
                        <statements>
                          <conditionStatement>
                            <condition>
                              <unaryOperatorExpression operator="Not">
                                <methodInvokeExpression methodName="IsUserInRole">
                                  <parameters>
                                    <variableReferenceExpression name="username"/>
                                    <variableReferenceExpression name="rolename"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </unaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <throwExceptionStatement>
                                <objectCreateExpression type="ProviderException">
                                  <parameters>
                                    <stringFormatExpression format="User '{{0}}' is not in role '{{1}}'.">
                                      <variableReferenceExpression name="username"/>
                                      <variableReferenceExpression name="rolename"/>
                                    </stringFormatExpression>
                                  </parameters>
                                </objectCreateExpression>
                              </throwExceptionStatement>
                            </trueStatements>
                          </conditionStatement>
                        </statements>
                      </foreachStatement>
                    </statements>
                  </foreachStatement>
                  <foreachStatement>
                    <variable type="System.String" name="username"/>
                    <target>
                      <argumentReferenceExpression name="usernames"/>
                    </target>
                    <statements>
                      <methodInvokeExpression methodName="ForgetUserRoles">
                        <parameters>
                          <variableReferenceExpression name="username"/>
                        </parameters>
                      </methodInvokeExpression>
                      <foreachStatement>
                        <variable type="System.String" name="rolename"/>
                        <target>
                          <argumentReferenceExpression name="rolenames"/>
                        </target>
                        <statements>
                          <usingStatement>
                            <variable type="SqlStatement" name="sql">
                              <init>
                                <methodInvokeExpression methodName="CreateSqlStatement">
                                  <parameters>
                                    <propertyReferenceExpression name="RemoveUserFromRole">
                                      <typeReferenceExpression type="RoleProviderSqlStatement"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </init>
                            </variable>
                            <statements>
                              <methodInvokeExpression methodName="AssignParameter">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="UserName"/>
                                  <variableReferenceExpression name="username"/>
                                </parameters>
                              </methodInvokeExpression>
                              <methodInvokeExpression methodName="AssignParameter">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="RoleName"/>
                                  <variableReferenceExpression name="rolename"/>
                                </parameters>
                              </methodInvokeExpression>
                              <methodInvokeExpression methodName="ExecuteNonQuery">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                              </methodInvokeExpression>
                            </statements>
                          </usingStatement>
                        </statements>
                      </foreachStatement>
                    </statements>
                  </foreachStatement>
                </xsl:if>
              </statements>
            </memberMethod>
            <!-- method RoleExists(sting) -->
            <memberMethod returnType="System.Boolean" name="RoleExists">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="$DynamicRoles='false'">
                    <methodReturnStatement>
                      <binaryOperatorExpression operator="ValueInequality">
                        <methodInvokeExpression methodName="IndexOf">
                          <target>
                            <typeReferenceExpression type="Array"/>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="GetAllRoles"/>
                            <argumentReferenceExpression name="rolename"/>
                          </parameters>
                        </methodInvokeExpression>
                        <primitiveExpression value="-1"/>
                      </binaryOperatorExpression>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="RoleExists">
                                <typeReferenceExpression type="RoleProviderSqlStatement"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variable>
                      <statements>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="RoleName"/>
                            <argumentReferenceExpression name="rolename"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodReturnStatement>
                          <binaryOperatorExpression operator="GreaterThan">
                            <convertExpression to="Int32">
                              <methodInvokeExpression methodName="ExecuteScalar">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                              </methodInvokeExpression>
                            </convertExpression>
                            <primitiveExpression value="0"/>
                          </binaryOperatorExpression>
                        </methodReturnStatement>
                      </statements>
                    </usingStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
            <!-- method FindUsersInRole(string, string) -->
            <memberMethod returnType="System.String[]" name="FindUsersInRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
                <parameter type="System.String" name="usernameToMatch"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="$DynamicRoles='false'">
                    <methodReturnStatement>
                      <arrayCreateExpression>
                        <createType type="System.String"/>
                        <sizeExpression>
                          <primitiveExpression value="0"/>
                        </sizeExpression>
                      </arrayCreateExpression>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <variableDeclarationStatement type="List" name="users">
                      <typeArguments>
                        <typeReference type="System.String"/>
                      </typeArguments>
                      <init>
                        <objectCreateExpression type="List">
                          <typeArguments>
                            <typeReference type="System.String"/>
                          </typeArguments>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="FindUsersInRole">
                                <typeReferenceExpression type="RoleProviderSqlStatement"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </init>
                      </variable>
                      <statements>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="UserName"/>
                            <argumentReferenceExpression name="usernameToMatch"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="RoleName"/>
                            <argumentReferenceExpression name="rolename"/>
                          </parameters>
                        </methodInvokeExpression>
                        <whileStatement>
                          <test>
                            <methodInvokeExpression methodName="Read">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                            </methodInvokeExpression>
                          </test>
                          <statements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="users"/>
                              </target>
                              <parameters>
                                <convertExpression to="String">
                                  <arrayIndexerExpression>
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                    <indices>
                                      <primitiveExpression value="UserName"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                </convertExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </statements>
                        </whileStatement>
                      </statements>
                    </usingStatement>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="ToArray">
                        <target>
                          <variableReferenceExpression name="users"/>
                        </target>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
