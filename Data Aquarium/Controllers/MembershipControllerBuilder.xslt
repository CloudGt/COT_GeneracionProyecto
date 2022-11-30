<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl da"
    xmlns:da="urn:schemas-codeontime-com:data-aquarium"
>
  <!-- modified to force re-generation of membership manager for Touch UI 8.0.7.0 -->
  <xsl:output method="xml" indent="yes" cdata-section-elements="da:text da:description"/>

  <xsl:param name="Namespace" />
  <xsl:param name="ProviderName" />
  <xsl:param name="ConnectionString"/>
  <xsl:param name="MembershipConnectionString"/>
  <xsl:param name="UseSaveAndNew" select="'false'"/>

  <xsl:template match="@handler">
    <xsl:attribute name="handler">
      <xsl:value-of select="$Namespace"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="substring-after(., '.')"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="da:text">
    <text>
      <xsl:choose>
        <xsl:when test="contains($ProviderName, 'Oracle') and parent::da:command[@id='command1']/parent::da:commands/parent::da:dataController/@name='aspnet_Membership'">
          <![CDATA[
select
	"USERS"."USER_ID" "UserId"
	,"USERS"."USER_NAME" "UserName"
	,"USERS"."USER_NAME" "UserUserName"
	,"USERS"."PASSWORD" "Password"
	,"USERS"."EMAIL" "Email"
	,"USERS"."COMMENTS" "Comment"
	,"USERS"."PASSWORD" "Password"
	,"USERS"."PASSWORD_QUESTION" "PasswordQuestion"
	,"USERS"."PASSWORD_QUESTION" "PasswordQuestionReadOnly"
	,"USERS"."PASSWORD_ANSWER" "PasswordAnswer"
	,"USERS"."IS_APPROVED" "IsApproved"
	,"USERS"."LAST_ACTIVITY_DATE" "LastActivityDate"
	,"USERS"."LAST_LOGIN_DATE" "LastLoginDate"
	,"USERS"."LAST_PASSWORD_CHANGED_DATE" "LastPasswordChangedDate"
	,"USERS"."CREATION_DATE" "CreateDate"
	,"USERS"."IS_LOCKED_OUT" "IsLockedOut"
	,"USERS"."LAST_LOCKED_OUT_DATE" "LastLockoutDate"
	,"USERS"."PWD_ATTEMPT_COUNT" "PwdAttemptCount"
	,"USERS"."PWD_ATTEMPT_WINDOW_START" "PwdAttemptWindowStart"
	,"USERS"."PWD_ANS_ATTEMPT_COUNT" "PwdAnsAttemptCount"
	,"USERS"."PWD_ANS_ATTEMPT_WINDOW_START" "PwdAnsAttemptWindowStart"
from "ASPNET_USERS" "USERS"
order by
	"USERS"."USER_NAME"
  ]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'MySql') and parent::da:command[@id='command1']/parent::da:commands/parent::da:dataController/@name='aspnet_Membership'">
          <![CDATA[
select
	`User`.`ApplicationId` `ApplicationId`
	,`UserApplication`.`Name` `ApplicationApplicationName`
	,`User`.`Id` `UserId`
	,`User`.`Name` `UserName`
	,`User`.`Name` `UserUserName`
	,`UserApplication`.`Name` `UserApplicationApplicationName`
	,`aspnet_Membership`.`Password` `Password`
	,`aspnet_Membership`.`PasswordFormat` `PasswordFormat`
	,`aspnet_Membership`.`PasswordKey` `PasswordSalt`
	,/*`aspnet_Membership`.`MobilePIN`*/null `MobilePIN`
	,`aspnet_Membership`.`Email` `Email`
	,`aspnet_Membership`.`email` `LoweredEmail`
	,`aspnet_Membership`.`PasswordQuestion` `PasswordQuestion`
	,`aspnet_Membership`.`PasswordQuestion` `PasswordQuestionReadOnly`
	,`aspnet_Membership`.`PasswordAnswer` `PasswordAnswer`
	,`aspnet_Membership`.`IsApproved` `IsApproved`
	,`aspnet_Membership`.`IsLockedOut` `IsLockedOut`
	,`aspnet_Membership`.`CreationDate` `CreateDate`
	,`aspnet_Membership`.`LastLoginDate` `LastLoginDate`
	,`aspnet_Membership`.`LastPasswordChangedDate` `LastPasswordChangedDate`
	,`aspnet_Membership`.`LastLockedOutDate` `LastLockoutDate`
	,`aspnet_Membership`.`FailedPasswordAttemptCount` `FailedPasswordAttemptCount`
	,`aspnet_Membership`.`FailedPasswordAttemptWindowStart` `FailedPasswordAttemptWindowStart`
	,`aspnet_Membership`.`FailedPasswordAnswerAttemptCount` `FailedPasswordAnswerAttemptCount`
	,`aspnet_Membership`.`FailedPasswordAnswerAttemptWindowStart` `FailedPasswordAnswerAttemptWindowStart`
	,`aspnet_Membership`.`Comment` `Comment`
	,null `Roles`
	,null `RoleId`
	,null `ConfirmPassword`
	,null `OldPassword`
from `my_aspnet_membership` `aspnet_Membership`
	/*left join `my_aspnet_applications` `Application` on `aspnet_Membership`.`ApplicationId` = `Application`.`ApplicationId`*/
	left join `my_aspnet_users` `User` on `aspnet_Membership`.`UserId` = `User`.`Id`
	left join `my_aspnet_applications` `UserApplication` on `User`.`ApplicationId` = `UserApplication`.`Id`
order by
	`User`.`Name`
  ]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'SQLAnywhere') and parent::da:command[@id='command1']/parent::da:commands/parent::da:dataController/@name='aspnet_Membership'">
          <![CDATA[
select
	"aspnet_Membership"."ApplicationId" "ApplicationId"
	,"Application"."ApplicationName" "ApplicationApplicationName"
	,"aspnet_Membership"."UserId" "UserId"
	,"User"."UserName" "UserName"
	,"User"."UserName" "UserUserName"
	,"UserApplication"."ApplicationName" "UserApplicationApplicationName"
	,"aspnet_Membership"."Password" "Password"
	,"aspnet_Membership"."PasswordFormat" "PasswordFormat"
	,"aspnet_Membership"."PasswordSalt" "PasswordSalt"
	,"aspnet_Membership"."MobilePIN" "MobilePIN"
	,"aspnet_Membership"."Email" "Email"
	,"aspnet_Membership"."LoweredEmail" "LoweredEmail"
	,"aspnet_Membership"."PasswordQuestion" "PasswordQuestion"
	,"aspnet_Membership"."PasswordQuestion" "PasswordQuestionReadOnly"
	,"aspnet_Membership"."PasswordAnswer" "PasswordAnswer"
	,"aspnet_Membership"."IsApproved" "IsApproved"
	,"aspnet_Membership"."IsLockedOut" "IsLockedOut"
	,"aspnet_Membership"."CreateDate" "CreateDate"
	,"aspnet_Membership"."LastLoginDate" "LastLoginDate"
	,"aspnet_Membership"."LastPasswordChangedDate" "LastPasswordChangedDate"
	,"aspnet_Membership"."LastLockoutDate" "LastLockoutDate"
	,"aspnet_Membership"."FailedPasswordAttemptCount" "FailedPasswordAttemptCount"
	,"aspnet_Membership"."FailedPasswordAttemptWindowStart" "FailedPasswordAttemptWindowStart"
	,"aspnet_Membership"."FailedPasswordAnswerAttemptCount" "FailedPasswordAnswerAttemptCount"
	,"aspnet_Membership"."FailedPasswordAnswerAttemptWindowStart" "FailedPasswordAnswerAttemptWindowStart"
	,"aspnet_Membership"."Comment" "Comment"
	,null "Roles"
	,null "RoleId"
	,null "ConfirmPassword"
	,null "OldPassword"
from "aspnet_Membership" "aspnet_Membership"
	left join "aspnet_Applications" "Application" on "aspnet_Membership"."ApplicationId" = "Application"."ApplicationId"
	left join "aspnet_Users" "User" on "aspnet_Membership"."UserId" = "User"."UserId"
	left join "aspnet_Applications" "UserApplication" on "User"."ApplicationId" = "UserApplication"."ApplicationId"
order by
	"User"."UserName"
  ]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'Oracle') and parent::da:command[@id='command2']/parent::da:commands/parent::da:dataController/@name='aspnet_Membership'">
          <![CDATA[
select
	"USERS"."USER_ID" "UserId"
	,"USERS"."USER_NAME" "UserName"
	,"USERS"."USER_NAME" "UserUserName"
	,"USERS"."PASSWORD" "Password"
	,null "PasswordFormat"
	,null "PasswordSalt"
	,null "MobilePIN"
	,"USERS"."EMAIL" "Email"
	,"USERS"."EMAIL" "LoweredEmail"
	,"USERS"."PASSWORD_QUESTION" "PasswordQuestion"
	,"USERS"."PASSWORD_QUESTION" "PasswordQuestionReadOnly"
	,"USERS"."PASSWORD_ANSWER" "PasswordAnswer"
	,"USERS"."IS_APPROVED" "IsApproved"
	,"USERS"."IS_LOCKED_OUT" "IsLockedOut"
	,"USERS"."CREATION_DATE" "CreateDate"
	,"USERS"."LAST_LOGIN_DATE" "LastLoginDate"
	,"USERS"."LAST_PASSWORD_CHANGED_DATE" "LastPasswordChangedDate"
	,"USERS"."LAST_LOCKED_OUT_DATE" "LastLockoutDate"
	,"USERS"."PWD_ATTEMPT_COUNT" "PwdAttemptCount"
	,"USERS"."PWD_ATTEMPT_WINDOW_START" "PwdAttemptWindowStart"
	,"USERS"."PWD_ANS_ATTEMPT_COUNT" "PwdAnswerAttemptCount"
	,"USERS"."PWD_ANS_ATTEMPT_WINDOW_START" "PwdAnswerAttemptWindowStart"
	,"USERS"."COMMENTS" "Comment"
	,"USER_ROLES"."ROLE_ID" "RoleId"
	,null "ConfirmPassword"
	,null "OldPassword"
from  "ASPNET_USERS" "USERS"
	left join "ASPNET_USER_ROLES" "USER_ROLES" on "USERS"."USER_ID" = "USER_ROLES"."USER_ID"
order by
	"USERS"."USER_NAME"
]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'MySql') and parent::da:command[@id='command2']/parent::da:commands/parent::da:dataController/@name='aspnet_Membership'">
          <![CDATA[
select
	`User`.`ApplicationId` `ApplicationId`
	,`UserApplication`.`Name` `ApplicationApplicationName`
	,`aspnet_Membership`.`UserId` `UserId`
	,`User`.`Name` `UserName`
	,`User`.`Name` `UserUserName`
	,`UserApplication`.`Name` `UserApplicationApplicationName`
	,`aspnet_Membership`.`Password` `Password`
	,`aspnet_Membership`.`PasswordFormat` `PasswordFormat`
	,`aspnet_Membership`.`PasswordKey` `PasswordSalt`
	,/*`aspnet_Membership`.`MobilePIN`*/null `MobilePIN`
	,`aspnet_Membership`.`Email` `Email`
	,`aspnet_Membership`.`Email` `LoweredEmail`
	,`aspnet_Membership`.`PasswordQuestion` `PasswordQuestion`
	,`aspnet_Membership`.`PasswordQuestion` `PasswordQuestionReadOnly`
	,`aspnet_Membership`.`PasswordAnswer` `PasswordAnswer`
	,`aspnet_Membership`.`IsApproved` `IsApproved`
	,`aspnet_Membership`.`IsLockedOut` `IsLockedOut`
	,`aspnet_Membership`.`CreationDate` `CreateDate`
	,`aspnet_Membership`.`LastLoginDate` `LastLoginDate`
	,`aspnet_Membership`.`LastPasswordChangedDate` `LastPasswordChangedDate`
	,`aspnet_Membership`.`LastLockedOutDate` `LastLockoutDate`
	,`aspnet_Membership`.`FailedPasswordAttemptCount` `FailedPasswordAttemptCount`
	,`aspnet_Membership`.`FailedPasswordAttemptWindowStart` `FailedPasswordAttemptWindowStart`
	,`aspnet_Membership`.`FailedPasswordAnswerAttemptCount` `FailedPasswordAnswerAttemptCount`
	,`aspnet_Membership`.`FailedPasswordAnswerAttemptWindowStart` `FailedPasswordAnswerAttemptWindowStart`
	,`aspnet_Membership`.`Comment` `Comment`
	,null  `Roles`
	,`UsersInRoles`.`RoleId`  `RoleId`
	,null `ConfirmPassword`
	,null `OldPassword`
from `my_aspnet_membership` `aspnet_Membership`
	/*left join `aspnet_Applications` `Application` on `aspnet_Membership`.`ApplicationId` = `Application`.`ApplicationId`*/
	left join `my_aspnet_users` `User` on `aspnet_Membership`.`UserId` = `User`.`Id`
	left join `my_aspnet_applications` `UserApplication` on `User`.`ApplicationId` = `UserApplication`.`Id`
	left join `my_aspnet_usersinroles` `UsersInRoles` on `aspnet_Membership`.`UserId` = `UsersInRoles`.`UserId`
order by
	`User`.`Name`
]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'SQLAnywhere') and parent::da:command[@id='command2']/parent::da:commands/parent::da:dataController/@name='aspnet_Membership'">
          <![CDATA[
select
	"aspnet_Membership"."ApplicationId" "ApplicationId"
	,"Application"."ApplicationName" "ApplicationApplicationName"
	,"aspnet_Membership"."UserId" "UserId"
	,"User"."UserName" "UserName"
	,"User"."UserName" "UserUserName"
	,"UserApplication"."ApplicationName" "UserApplicationApplicationName"
	,"aspnet_Membership"."Password" "Password"
	,"aspnet_Membership"."PasswordFormat" "PasswordFormat"
	,"aspnet_Membership"."PasswordSalt" "PasswordSalt"
	,"aspnet_Membership"."MobilePIN" "MobilePIN"
	,"aspnet_Membership"."Email" "Email"
	,"aspnet_Membership"."LoweredEmail" "LoweredEmail"
	,"aspnet_Membership"."PasswordQuestion" "PasswordQuestion"
	,"aspnet_Membership"."PasswordQuestion" "PasswordQuestionReadOnly"
	,"aspnet_Membership"."PasswordAnswer" "PasswordAnswer"
	,"aspnet_Membership"."IsApproved" "IsApproved"
	,"aspnet_Membership"."IsLockedOut" "IsLockedOut"
	,"aspnet_Membership"."CreateDate" "CreateDate"
	,"aspnet_Membership"."LastLoginDate" "LastLoginDate"
	,"aspnet_Membership"."LastPasswordChangedDate" "LastPasswordChangedDate"
	,"aspnet_Membership"."LastLockoutDate" "LastLockoutDate"
	,"aspnet_Membership"."FailedPasswordAttemptCount" "FailedPasswordAttemptCount"
	,"aspnet_Membership"."FailedPasswordAttemptWindowStart" "FailedPasswordAttemptWindowStart"
	,"aspnet_Membership"."FailedPasswordAnswerAttemptCount" "FailedPasswordAnswerAttemptCount"
	,"aspnet_Membership"."FailedPasswordAnswerAttemptWindowStart" "FailedPasswordAnswerAttemptWindowStart"
	,"aspnet_Membership"."Comment" "Comment"
	,null  "Roles"
	,"UsersInRoles"."RoleId"  "RoleId"
	,null "ConfirmPassword"
	,null "OldPassword"
from "aspnet_Membership" "aspnet_Membership"
	left join "aspnet_Applications" "Application" on "aspnet_Membership"."ApplicationId" = "Application"."ApplicationId"
	left join "aspnet_Users" "User" on "aspnet_Membership"."UserId" = "User"."UserId"
	left join "aspnet_Applications" "UserApplication" on "User"."ApplicationId" = "UserApplication"."ApplicationId"
	left join "aspnet_UsersInRoles" "UsersInRoles" on "aspnet_Membership"."UserId" = "UsersInRoles"."UserId"
order by
	"User"."UserName"
]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'Oracle') and parent::da:command[@id='command1']/parent::da:commands/parent::da:dataController/@name='aspnet_Roles'">
          <![CDATA[
select
	"ROLES"."ROLE_ID" "RoleId"
	,"ROLES"."ROLE_NAME" "RoleName",
  ,null "Description",
from  "ASPNET_ROLES" "ROLES"
order by
	"ROLES"."ROLE_NAME"
]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'MySql') and parent::da:command[@id='command1']/parent::da:commands/parent::da:dataController/@name='aspnet_Roles'">
          <![CDATA[
select
	`aspnet_Roles`.`ApplicationId` `ApplicationId`
	,`Application`.`Name` `ApplicationApplicationName`
	,`aspnet_Roles`.`Id` `RoleId`
	,`aspnet_Roles`.`Name` `RoleName`
	,`aspnet_Roles`.`Name` `LoweredRoleName`
	,/*`aspnet_Roles`.`Description`*/null `Description`
from `my_aspnet_roles` `aspnet_Roles`
	left join `my_aspnet_applications` `Application` on `aspnet_Roles`.`ApplicationId` = `Application`.`Id`
order by
	`aspnet_Roles`.`Name`
]]>
        </xsl:when>
        <xsl:when test="contains($ProviderName, 'SQLAnywhere') and parent::da:command[@id='command1']/parent::da:commands/parent::da:dataController/@name='aspnet_Roles'">
          <![CDATA[
select
	"aspnet_Roles"."ApplicationId" "ApplicationId"
	,"Application"."ApplicationName" "ApplicationApplicationName"
	,"aspnet_Roles"."RoleId" "RoleId"
	,"aspnet_Roles"."RoleName" "RoleName"
	,"aspnet_Roles"."LoweredRoleName" "LoweredRoleName"
	,"aspnet_Roles"."Description" "Description"
from "aspnet_Roles" "aspnet_Roles"
	left join "aspnet_Applications" "Application" on "aspnet_Roles"."ApplicationId" = "Application"."ApplicationId"
order by
	"aspnet_Roles"."RoleName"
]]>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </text>
  </xsl:template>

  <xsl:template match="da:field/@name">
    <xsl:choose>
      <xsl:when test="contains($ProviderName, 'Oracle')">
        <xsl:choose>
          <xsl:when test=".='FailedPasswordAttemptCount'">
            <xsl:attribute name="name">
              <xsl:text>PwdAttemptCount</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test=".='FailedPasswordAttemptWindowStart'">
            <xsl:attribute name="name">
              <xsl:text>PwdAttemptWindowStart</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test=".='FailedPasswordAnswerAttemptCount'">
            <xsl:attribute name="name">
              <xsl:text>PwdAnsAttemptCount</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test=".='FailedPasswordAnswerAttemptWindowStart'">
            <xsl:attribute name="name">
              <xsl:text>PwdAnsAttemptWindowStart</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="da:dataField/@fieldName">
    <xsl:choose>
      <xsl:when test="contains($ProviderName, 'Oracle')">
        <xsl:choose>
          <xsl:when test=".='FailedPasswordAttemptCount'">
            <xsl:attribute name="fieldName">
              <xsl:text>PwdAttemptCount</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test=".='FailedPasswordAttemptWindowStart'">
            <xsl:attribute name="fieldName">
              <xsl:text>PwdAttemptWindowStart</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test=".='FailedPasswordAnswerAttemptCount'">
            <xsl:attribute name="fieldName">
              <xsl:text>PwdAnsAttemptCount</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test=".='FailedPasswordAnswerAttemptWindowStart'">
            <xsl:attribute name="fieldName">
              <xsl:text>PwdAnsAttemptWindowStart</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@type">
    <xsl:choose>
      <xsl:when test=".='Guid' and contains($ProviderName, 'MySql')">
        <xsl:attribute name="type">
          <xsl:text>Int32</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@connectionStringName">
    <xsl:choose>
      <xsl:when test="$ConnectionString=$MembershipConnectionString or $MembershipConnectionString=''">
        <!--nothing-->
      </xsl:when>
      <xsl:when test="contains($ProviderName, 'MySql')">
        <xsl:attribute name="connectionStringName">
          <xsl:text>LocalMySqlServer</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="contains($ProviderName, 'Oracle')">
        <xsl:attribute name="connectionStringName">
          <xsl:text>LocalOracleServer</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="contains($ProviderName, 'SQLAnywhere')">
        <xsl:attribute name="connectionStringName">
          <xsl:text>ApplicationServices</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="da:dataField">
    <xsl:choose>
      <xsl:when test="@fieldName='Description' and (contains($ProviderName, 'MySql') or contains($ProviderName, 'Oracle'))"/>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="da:actionGroup[@scope='Form']">
    <xsl:choose>
      <xsl:when test="$UseSaveAndNew='true' and /da:dataController[@name='aspnet_Membership']">
        <actionGroup scope="Form">
          <action commandName="Edit" commandArgument="editForm1" roles="Administrators"/>
          <action commandName="Delete" roles="Administrators"/>
          <action commandName="Cancel"  />
          <action whenLastCommandName="Edit" whenLastCommandArgument="editForm1" commandName="Update" commandArgument="Save" />
          <action whenLastCommandName="Edit" whenLastCommandArgument="editForm1" commandName="Cancel" />
          <action whenLastCommandName="New" whenLastCommandArgument="createForm1" commandName="Insert" commandArgument="Save"/>
          <action whenLastCommandName="New" whenLastCommandArgument="createForm1" commandName="Insert" commandArgument="SaveAndNew"/>
          <action whenLastCommandName="New" whenLastCommandArgument="createForm1" commandName="Cancel" />
          <action whenLastCommandName="New" whenLastCommandArgument="signUpForm" commandName="Insert" commandArgument="SignUp" headerText="^SignUp^Sign Up^SignUp^" />
          <action whenLastCommandName="New" whenLastCommandArgument="signUpForm" commandName="Cancel" />
          <action whenLastCommandName="Insert" whenLastCommandArgument="SignUp" commandName="Cancel" />
          <action whenLastCommandName="New" whenLastCommandArgument="passwordRequestForm" commandName="Cancel" />
          <action whenLastCommandName="New" whenLastCommandArgument="passwordRequestForm" commandName="Custom" commandArgument="RequestPassword" headerText="^RequestPasswordActionHeaderText^Next^RequestPasswordActionHeaderText^" />
          <action whenLastCommandName="Edit" whenLastCommandArgument="identityConfirmationForm" commandName="Custom" commandArgument="BackToRequestPassword" headerText="^BackToRequestPasswordActionHeaderText^Back^BackToRequestPasswordActionHeaderText^" causesValidation="false" />
          <action whenLastCommandName="Edit" whenLastCommandArgument="identityConfirmationForm" commandName="Custom" commandArgument="ConfirmIdentity" headerText="^ConfirmIdentityActionHeaderText^Finish^ConfirmIdentityActionHeaderText^" />
          <action whenLastCommandName="Edit" whenLastCommandArgument="myAccountForm" commandName="Update" headerText="^UpdateMyAccountActionHeaderText^Update My Account^UpdateMyAccountActionHeaderText^" causesValidation="false" />
          <action whenLastCommandName="Edit" whenLastCommandArgument="myAccountForm" commandName="Cancel" />
          <action whenLastCommandName="Insert" whenLastCommandArgument="SaveAndNew" commandName="New" commandArgument="createForm1"/>
        </actionGroup>
      </xsl:when>
      <xsl:when test="$UseSaveAndNew='true' and /da:dataController[@name='aspnet_Roles']">
        <actionGroup scope="Form">
          <action commandName="Edit" />
          <action commandName="Delete" />
          <action commandName="Cancel" headerText="Close" />
          <action whenLastCommandName="Edit" commandName="Update" commandArgument="Save" />
          <action whenLastCommandName="Edit" commandName="Delete" />
          <action whenLastCommandName="Edit" commandName="Cancel" />
          <action whenLastCommandName="New" commandName="Insert" commandArgument="Save" />
          <action whenLastCommandName="New" commandName="Insert" commandArgument="SaveAndNew"/>
          <action whenLastCommandName="New" commandName="Cancel" />
          <action whenLastCommandName="Insert" whenLastCommandArgument="SaveAndNew" commandName="New" commandArgument="createForm1" />
        </actionGroup>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
