<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease" exclude-result-prefixes="msxsl a codeontime"
>

  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <xsl:variable name="CustomMembershipMapping">
    <![CDATA[
table Users = aspnet_users 
column [int|uiid] UserID = user_id 
column [text] UserName = user_name 
column [text] Password = password 
column [text] Email = email 
column [text] Comment = comments 
column [text] PasswordQuestion = password_question 
column [text] PasswordAnswer = password_answer 
column [bool] IsApproved = is_approved 
column [date] LastActivityDate = last_activity_date 
column [date] LastLoginDate = last_login_date 
column [date] LastPasswordChangedDate = last_password_changed_date 
column [date] CreationDate = creation_date 
column [bool] IsLockedOut = is_locked_out 
column [date] LastLockedOutDate = last_locked_out_date 
column [int] FailedPasswordAttemptCount = pwd_attempt_count 
column [date] FailedPasswordAttemptWindowStart = pwd_attempt_window_start 
column [int] FailedPasswordAnswerAttemptCount = pwd_ans_attempt_count 
column [date] FailedPasswordAnswerAttemptWindowStart = pwd_ans_attempt_window_start

table Roles = aspnet_roles 
column [int|uiid] RoleID = role_id 
column [text] RoleName = role_name

table UserRoles = aspnet_user_roles 
column [int|uiid] UserID = user_id 
column [int|uiid] RoleID = role_id
]]>
  </xsl:variable>
  <!--<xsl:param name="CustomMembershipMapping" select="$DebugCustomMembershipMappingMin"/>-->
  <xsl:param name="MembershipValidationKey" select="a:project/a:membership/@validationKey"/>
  <xsl:variable name="ValidationKey">
    <xsl:choose>
      <xsl:when test="$MembershipValidationKey!=''">
        <xsl:value-of select="$MembershipValidationKey"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>14B0948800CF423A4A0ECE0090826C8AD326387A53E89E9D181E23C60D605CEB3D403ECAEE62888574E04E7106425A2C5C379B76FCDF00026A3F00C5ED8B0C0D</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <msxsl:script language="C#" implements-prefix="codeontime">
    <![CDATA[
  public string NormalizeLineEndings(string s) {
    return s.Replace("\n", "\r\n");
  }
  ]]>
  </msxsl:script>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Security">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Configuration.Provider"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Collections.Specialized"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Data.Common"/>
        <namespaceImport name="System.Diagnostics"/>
        <namespaceImport name="System.Globalization"/>
        <namespaceImport name="System.Security.Cryptography"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Xml.XPath"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Configuration"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="{$Namespace}.Data"/>
      </imports>
      <types>
        <!-- enum MembershipProviderSqlStatement-->
        <typeDeclaration name="MembershipProviderSqlStatement" isEnum="true">
          <attributes public="true"/>
          <members>
            <memberField name="ChangePassword">
              <attributes public="true"/>
            </memberField>
            <memberField name="ChangePasswordQuestionAndAnswer">
              <attributes public="true"/>
            </memberField>
            <memberField name="CreateUser">
              <attributes public="true"/>
            </memberField>
            <memberField name="DeleteUser">
              <attributes public="true"/>
            </memberField>
            <memberField name="CountAllUsers">
              <attributes public="true"/>
            </memberField>
            <memberField name="GetAllUsers">
              <attributes public="true"/>
            </memberField>
            <memberField name="GetNumberOfUsersOnline">
              <attributes public="true"/>
            </memberField>
            <memberField name="GetPassword">
              <attributes public="true"/>
            </memberField>
            <memberField name="GetUser">
              <attributes public="true"/>
            </memberField>
            <memberField name="UpdateLastUserActivity">
              <attributes public="true"/>
            </memberField>
            <memberField name="GetUserByProviderKey">
              <attributes public="true"/>
            </memberField>
            <memberField name="UpdateUserLockStatus">
              <attributes public="true"/>
            </memberField>
            <memberField name="GetUserNameByEmail">
              <attributes public="true"/>
            </memberField>
            <memberField name="ResetPassword">
              <attributes public="true"/>
            </memberField>
            <memberField name="UpdateUser">
              <attributes public="true"/>
            </memberField>
            <memberField name="UpdateLastLoginDate">
              <attributes public="true"/>
            </memberField>
            <memberField name="UpdateFailedPasswordAttempt">
              <attributes public="true"/>
            </memberField>
            <memberField name="UpdateFailedPasswordAnswerAttempt">
              <attributes public="true"/>
            </memberField>
            <memberField name="LockUser">
              <attributes public="true"/>
            </memberField>
            <memberField name="CountUsersByName">
              <attributes public="true"/>
            </memberField>
            <memberField name="FindUsersByName">
              <attributes public="true"/>
            </memberField>
            <memberField name="CountUsersByEmail">
              <attributes public="true"/>
            </memberField>
            <memberField name="FindUsersByEmail">
              <attributes public="true"/>
            </memberField>
          </members>
        </typeDeclaration>
        <!-- class OracleMembershipProvider -->
        <typeDeclaration name="OracleMembershipProvider">
          <attributes sealed="true"/>
          <baseTypes>
            <typeReference type="MembershipProvider"/>
          </baseTypes>
          <members>
            <!-- property Statements -->
            <memberField type="SortedDictionary" name="Statements">
              <attributes public="true" static="true"/>
              <typeArguments>
                <typeReference type="MembershipProviderSqlStatement"/>
                <typeReference type="System.String"/>
              </typeArguments>
              <init>
                <objectCreateExpression type="SortedDictionary">
                  <typeArguments>
                    <typeReference type="MembershipProviderSqlStatement"/>
                    <typeReference type="System.String"/>
                  </typeArguments>
                </objectCreateExpression>
              </init>
            </memberField>
            <!-- public OracleRoleProvider() -->
            <typeConstructor>
              <statements>
                <!-- ChangePassword -->
                <xsl:variable name="ChangePassword" xml:space="preserve"><![CDATA[update aspnet_users set password = @Password, last_password_changed_date = @LastPasswordChangedDate where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="ChangePassword">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($ChangePassword)}"/>
                </assignStatement>
                <!-- ChangePassword -->
                <xsl:variable name="ChangePasswordQuestionAndAnswer" xml:space="preserve"><![CDATA[update aspnet_users set password_question = @PasswordQuestion, password_answer = @PasswordAnswer where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="ChangePasswordQuestionAndAnswer">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($ChangePasswordQuestionAndAnswer)}"/>
                </assignStatement>
                <!-- CreateUser -->
                <xsl:variable name="CreateUser" xml:space="preserve"><![CDATA[insert into aspnet_users
(
   user_name
  ,password
  ,email
  ,password_question
  ,password_answer
  ,is_approved
  ,comments
  ,creation_date
  ,last_password_changed_date
  ,last_activity_date
  ,last_login_date
  ,is_locked_out
  ,last_locked_out_date
  ,pwd_attempt_count
  ,pwd_attempt_window_start
  ,pwd_ans_attempt_count
  ,pwd_ans_attempt_window_start
)
values(
   @UserName
  ,@Password
  ,@Email
  ,@PasswordQuestion
  ,@PasswordAnswer
  ,@IsApproved
  ,@Comments
  ,@CreationDate
  ,@LastPasswordChangedDate
  ,@LastActivityDate
  ,@LastLoginDate
  ,@IsLockedOut
  ,@LastLockedOutDate
  ,@FailedPwdAttemptCount
  ,@FailedPwdAttemptWindowStart
  ,@FailedPwdAnsAttemptCount
  ,@FailedPwdAnsAttemptWindowStart
)]]>
</xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="CreateUser">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($CreateUser)}"/>
                </assignStatement>
                <!-- DeleteUser -->
                <xsl:variable name="DeleteUser" xml:space="preserve"><![CDATA[delete from aspnet_users where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="DeleteUser">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($DeleteUser)}"/>
                </assignStatement>
                <!-- CountAllUsers -->
                <xsl:variable name="CountAllUsers" xml:space="preserve"><![CDATA[select count(*) from aspnet_users]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="CountAllUsers">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($CountAllUsers)}"/>
                </assignStatement>
                <!-- GetAllUsers -->
                <xsl:variable name="GetAllUsers" xml:space="preserve"><![CDATA[select 
   user_id UserID
  ,user_name UserName
  ,email Email
  ,password_question PasswordQuestion
  ,comments Comments
  ,is_approved IsApproved
  ,is_locked_out IsLockedOut
  ,creation_date CreationDate
  ,last_login_date LastLoginDate
  ,last_activity_date LastActivityDate
  ,last_password_changed_date LastPasswordChangedDate
  ,last_locked_out_date LastLockedOutDate
from aspnet_users 
order by user_name asc]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="GetAllUsers">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($GetAllUsers)}"/>
                </assignStatement>
                <!-- GetNumberOfUsersOnline -->
                <xsl:variable name="GetNumberOfUsersOnline" xml:space="preserve"><![CDATA[select count(*) from aspnet_users where last_activity_date >= @CompareDate]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="GetNumberOfUsersOnline">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($GetNumberOfUsersOnline)}"/>
                </assignStatement>
                <!-- GetPassword -->
                <xsl:variable name="GetPassword" xml:space="preserve"><![CDATA[select password Password, password_answer PasswordAnswer, is_locked_out IsLockedOut, is_approved IsApproved, is_locked_out IsLockedOut, pwd_attempt_window_start FailedPwdAttemptWindowStart, pwd_ans_attempt_window_start FailedPwdAnsAttemptWindowStart from aspnet_users where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="GetPassword">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($GetPassword)}"/>
                </assignStatement>
                <!-- GetUser -->
                <xsl:variable name="GetUser" xml:space="preserve"><![CDATA[select 
   user_id UserID
  ,user_name UserName
  ,email Email
  ,password_question PasswordQuestion
  ,comments Comments
  ,is_approved IsApproved
  ,is_locked_out IsLockedOut
  ,creation_date CreationDate
  ,last_login_date LastLoginDate
  ,last_activity_date LastActivityDate
  ,last_password_changed_date LastPasswordChangedDate
  ,last_locked_out_date LastLockedOutDate
  ,pwd_attempt_count FailedPwdAttemptCount
  ,pwd_attempt_window_start FailedPwdAttemptWindowStart
  ,pwd_ans_attempt_count FailedPwdAnsAttemptCount
  ,pwd_ans_attempt_window_start FailedPwdAnsAttemptWindowStart
from aspnet_users 
where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="GetUser">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($GetUser)}"/>
                </assignStatement>
                <!-- UpdateLastUserActivity -->
                <xsl:variable name="UpdateLastUserActivity" xml:space="preserve"><![CDATA[update aspnet_users set last_activity_date = @LastActivityDate where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="UpdateLastUserActivity">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($UpdateLastUserActivity)}"/>
                </assignStatement>
                <!-- GetUserByProviderKey -->
                <xsl:variable name="GetUserByProviderKey" xml:space="preserve"><![CDATA[select 
   user_id UserID
  ,user_name Username
  ,email Email
  ,password_question PasswordQuestion
  ,comments Comments
  ,is_approved IsApproved
  ,is_locked_out IsLockedOut
  ,creation_date CreationDate
  ,last_login_date LastLoginDate
  ,last_activity_date LastActivityDate
  ,last_password_changed_date LastPasswordChangedDate
  ,last_locked_out_date LastLockedOutDate
from aspnet_users 
where user_id = @UserID
]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="GetUserByProviderKey">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($GetUserByProviderKey)}"/>
                </assignStatement>
                <!-- UpdateUserLockStatus -->
                <xsl:variable name="UpdateUserLockStatus" xml:space="preserve"><![CDATA[update aspnet_users set is_locked_out = @IsLockedOut, last_locked_out_date = @LastLockedOutDate where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="UpdateUserLockStatus">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($UpdateUserLockStatus)}"/>
                </assignStatement>
                <!-- GetUserNameByEmail -->
                <xsl:variable name="GetUserNameByEmail" xml:space="preserve"><![CDATA[select user_name Username from aspnet_users where email = @Email]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="GetUserNameByEmail">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($GetUserNameByEmail)}"/>
                </assignStatement>
                <!-- ResetPassword -->
                <xsl:variable name="ResetPassword" xml:space="preserve"><![CDATA[update aspnet_users set password = @Password, last_password_changed_date = @LastPasswordChangedDate where user_name = @UserName and is_locked_out = @IsLockedOut]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="ResetPassword">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($ResetPassword)}"/>
                </assignStatement>
                <!-- UpdateUser -->
                <xsl:variable name="UpdateUser" xml:space="preserve"><![CDATA[update aspnet_users set email = @Email, comments = @Comments, is_approved = @IsApproved where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="UpdateUser">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($UpdateUser)}"/>
                </assignStatement>
                <!-- UpdateUser -->
                <xsl:variable name="UpdateLastLoginDate" xml:space="preserve"><![CDATA[update aspnet_users set last_login_date = @LastLoginDate, is_locked_out = @IsLockedOut where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="UpdateLastLoginDate">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($UpdateLastLoginDate)}"/>
                </assignStatement>
                <!-- UpdateFailedPasswordAttempt -->
                <xsl:variable name="UpdateFailedPasswordAttempt" xml:space="preserve"><![CDATA[update aspnet_users set pwd_attempt_count = @FailedPwdAttemptCount, pwd_attempt_window_start = @FailedPwdAttemptWindowStart where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="UpdateFailedPasswordAttempt">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($UpdateFailedPasswordAttempt)}"/>
                </assignStatement>
                <!-- UpdateFailedPasswordAnswerAttempt -->
                <xsl:variable name="UpdateFailedPasswordAnswerAttempt" xml:space="preserve"><![CDATA[update aspnet_users set pwd_ans_attempt_count = @FailedPwdAnsAttemptCount where user_name = @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="UpdateFailedPasswordAnswerAttempt">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($UpdateFailedPasswordAnswerAttempt)}"/>
                </assignStatement>
                <!-- CountUsersByName -->
                <xsl:variable name="CountUsersByName" xml:space="preserve"><![CDATA[select count(*) from aspnet_users where user_name like @UserName]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="CountUsersByName">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($CountUsersByName)}"/>
                </assignStatement>
                <!-- FindUsersByName -->
                <xsl:variable name="FindUsersByName" xml:space="preserve"><![CDATA[select 
   user_id UserID
  ,user_name Username
  ,email Email
  ,password_question PasswordQuestion
  ,comments Comments
  ,is_approved IsApproved
  ,is_locked_out IsLockedOut
  ,creation_date CreationDate
  ,last_login_date LastLoginDate
  ,last_activity_date LastActivityDate
  ,last_password_changed_date LastPasswordChangedDate
  ,last_locked_out_date LastLockedOutDate
from aspnet_users 
where user_name like @UserName
order by user_name asc                     
]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="FindUsersByName">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($FindUsersByName)}"/>
                </assignStatement>
                <!-- CountUsersByEmail -->
                <xsl:variable name="CountUsersByEmail" xml:space="preserve"><![CDATA[select count(*) from aspnet_users where email like @Email]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="CountUsersByEmail">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($CountUsersByEmail)}"/>
                </assignStatement>
                <!-- FindUsersByEmail -->
                <xsl:variable name="FindUsersByEmail" xml:space="preserve"><![CDATA[select 
   user_id UserID
  ,user_name Username
  ,email Email
  ,password_question PasswordQuestion
  ,comments Comments
  ,is_approved IsApproved
  ,is_locked_out IsLockedOut
  ,creation_date CreationDate
  ,last_login_date LastLoginDate
  ,last_activity_date LastActivityDate
  ,last_password_changed_date LastPasswordChangedDate
  ,last_locked_out_date LastLockedOutDate
from aspnet_users 
where email like @Email
order by user_name asc]]></xsl:variable>
                <assignStatement>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="Statements"/>
                    </target>
                    <indices>
                      <propertyReferenceExpression name="FindUsersByEmail">
                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                      </propertyReferenceExpression>
                    </indices>
                  </arrayIndexerExpression>
                  <primitiveExpression value="{codeontime:NormalizeLineEndings($FindUsersByEmail)}"/>
                </assignStatement>
              </statements>
            </typeConstructor>
            <!-- method CreateSqlStatement -->
            <memberMethod returnType="SqlStatement" name="CreateSqlStatement">
              <attributes private="true" final="true"/>
              <parameters>
                <parameter type="MembershipProviderSqlStatement" name="command"/>
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
                    <primitiveExpression value="{$Namespace} Application Membership Provider - "/>
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
            <!-- field newPasswordLength -->
            <memberField type="System.Int32" name="newPasswordLength">
              <attributes private="true"/>
              <init>
                <primitiveExpression value="8"/>
              </init>
            </memberField>
            <!-- field validationKey -->
            <memberField type="System.String" name="validationKey">
              <attributes private="true"/>
            </memberField>
            <!-- property ConnectionStringSettings -->
            <memberField type="ConnectionStringSettings" name="connectionStringSettings"/>
            <memberProperty type="ConnectionStringSettings" name="ConnectionStringSettings">
              <attributes public="true" final="true"/>
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
            <!-- property ApplicationName -->
            <memberProperty type="System.String" name="ApplicationName">
              <attributes public="true" override="true"/>
            </memberProperty>
            <!-- property EnablePasswordReset -->
            <memberField type="System.Boolean" name="enablePasswordReset"/>
            <memberProperty type="System.Boolean" name="EnablePasswordReset">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="enablePasswordReset"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property EnablePasswordRetrieval -->
            <memberField type="System.Boolean" name="enablePasswordRetrieval"/>
            <memberProperty type="System.Boolean" name="EnablePasswordRetrieval">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="enablePasswordRetrieval"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property RequiresQuestionAndAnswer -->
            <memberField type="System.Boolean" name="requiresQuestionAndAnswer"/>
            <memberProperty type="System.Boolean" name="RequiresQuestionAndAnswer">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="requiresQuestionAndAnswer"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property RequiresUniqueEmail -->
            <memberField type="System.Boolean" name="requiresUniqueEmail"/>
            <memberProperty type="System.Boolean" name="RequiresUniqueEmail">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="requiresUniqueEmail"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property MaxInvalidPasswordAttempts -->
            <memberField type="System.Int32" name="maxInvalidPasswordAttempts"/>
            <memberProperty type="System.Int32" name="MaxInvalidPasswordAttempts">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="maxInvalidPasswordAttempts"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property PasswordAttemptWindow -->
            <memberField type="System.Int32" name="passwordAttemptWindow"/>
            <memberProperty type="System.Int32" name="PasswordAttemptWindow">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="passwordAttemptWindow"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property PasswordFormat -->
            <memberField type="MembershipPasswordFormat" name="passwordFormat"/>
            <memberProperty type="MembershipPasswordFormat" name="PasswordFormat">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="passwordFormat"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property MinRequiredNonAlphanumericCharacters -->
            <memberField type="System.Int32" name="minRequiredNonAlphanumericCharacters"/>
            <memberProperty type="System.Int32" name="MinRequiredNonAlphanumericCharacters">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="minRequiredNonAlphanumericCharacters"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property MinRequiredPasswordLength -->
            <memberField type="System.Int32" name="minRequiredPasswordLength"/>
            <memberProperty type="System.Int32" name="MinRequiredPasswordLength">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="minRequiredPasswordLength"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property PasswordStrengthRegularExpression -->
            <memberField type="System.String" name="passwordStrengthRegularExpression"/>
            <memberProperty type="System.String" name="PasswordStrengthRegularExpression">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="passwordStrengthRegularExpression"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method GetConfigValue(string, string) -->
            <memberMethod returnType="System.String" name="GetConfigValue">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.String" name="configValue"/>
                <parameter type="System.String" name="defaultValue"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <argumentReferenceExpression name="configValue"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <argumentReferenceExpression name="defaultValue"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <argumentReferenceExpression name="configValue"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!--  property DefaultPasswordFormat -->
            <memberProperty type="MembershipPasswordFormat" name="DefaultPasswordFormat">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Hashed">
                    <typeReferenceExpression type="MembershipPasswordFormat"/>
                  </propertyReferenceExpression>
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
                      <variableReferenceExpression name="name"/>
                      <primitiveExpression value="OracleMembershipProvider"/>
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
                        <primitiveExpression value="{$Namespace} application membership provider"/>
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
                  <fieldReferenceExpression name="maxInvalidPasswordAttempts"/>
                  <convertExpression to="Int32">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="maxInvalidPasswordAttempts"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="5" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="passwordAttemptWindow"/>
                  <convertExpression to="Int32">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="passwordAttemptWindow"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="10" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="minRequiredNonAlphanumericCharacters"/>
                  <convertExpression to="Int32">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="minRequiredNonAlphanumericCharacters"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="1" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="minRequiredPasswordLength"/>
                  <convertExpression to="Int32">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="minRequiredPasswordLength"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="7" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="passwordStrengthRegularExpression"/>
                  <convertExpression to="String">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="passwordStrengthRegularExpression"/>
                          </indices>
                        </arrayIndexerExpression>
                        <stringEmptyExpression/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="enablePasswordReset"/>
                  <convertExpression to="Boolean">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="enablePasswordReset"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="true" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="enablePasswordRetrieval"/>
                  <convertExpression to="Boolean">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="enablePasswordRetrieval"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="true" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="requiresQuestionAndAnswer"/>
                  <convertExpression to="Boolean">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="requiresQuestionAndAnswer"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="false" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="requiresUniqueEmail"/>
                  <convertExpression to="Boolean">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="requiresUniqueEmail"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="true" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="writeExceptionsToEventLog"/>
                  <convertExpression to="Boolean">
                    <methodInvokeExpression methodName="GetConfigValue">
                      <parameters>
                        <arrayIndexerExpression>
                          <target>
                            <argumentReferenceExpression name="config"/>
                          </target>
                          <indices>
                            <primitiveExpression value="writeExceptionsToEventLog"/>
                          </indices>
                        </arrayIndexerExpression>
                        <primitiveExpression value="false" convertTo="String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </convertExpression>
                </assignStatement>
                <variableDeclarationStatement type="System.String" name="pwdFormat">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <argumentReferenceExpression name="config"/>
                      </target>
                      <indices>
                        <primitiveExpression value="passwordFormat"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <variableReferenceExpression name="pwdFormat"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="pwdFormat"/>
                      <methodInvokeExpression methodName="ToString">
                        <target>
                          <propertyReferenceExpression name="DefaultPasswordFormat"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <variableReferenceExpression name="pwdFormat"/>
                      <primitiveExpression value="Hashed"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="passwordFormat"/>
                      <propertyReferenceExpression name="Hashed">
                        <typeReferenceExpression type="MembershipPasswordFormat"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <variableReferenceExpression name="pwdFormat"/>
                          <primitiveExpression value="Encrypted"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <fieldReferenceExpression name="passwordFormat"/>
                          <propertyReferenceExpression name="Encrypted">
                            <typeReferenceExpression type="MembershipPasswordFormat"/>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <variableReferenceExpression name="pwdFormat"/>
                              <primitiveExpression value="Clear"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <fieldReferenceExpression name="passwordFormat"/>
                              <propertyReferenceExpression name="Clear">
                                <typeReferenceExpression type="MembershipPasswordFormat"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                          </trueStatements>
                          <falseStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="ProviderException">
                                <parameters>
                                  <primitiveExpression value="Password format is not supported."/>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
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
                <assignStatement>
                  <fieldReferenceExpression name="validationKey"/>
                  <arrayIndexerExpression>
                    <target>
                      <propertyReferenceExpression name="AppSettings">
                        <typeReferenceExpression type="ConfigurationManager"/>
                      </propertyReferenceExpression>
                    </target>
                    <indices>
                      <primitiveExpression value="MembershipProviderValidationKey"/>
                    </indices>
                  </arrayIndexerExpression>
                </assignStatement>
                <!--<conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <fieldReferenceExpression name="validationKey"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="Configuration" name="cfg">
                      <init>
                        <primitiveExpression value="null"/>
                      </init>
                    </variableDeclarationStatement>
                    <tryStatement>
                      <statements>
                        <assignStatement>
                          <variableReferenceExpression name="cfg"/>
                          <methodInvokeExpression methodName="OpenWebConfiguration">
                            <target>
                              <typeReferenceExpression type="WebConfigurationManager"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="ApplicationVirtualPath">
                                <typeReferenceExpression type="System.Web.Hosting.HostingEnvironment"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityInequality">
                              <variableReferenceExpression name="cfg"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <variableDeclarationStatement type="MachineKeySection" name="machineKey">
                              <init>
                                <castExpression targetType="MachineKeySection">
                                  <methodInvokeExpression methodName="GetSection">
                                    <target>
                                      <argumentReferenceExpression name="cfg"/>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="system.web/machineKey"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </castExpression>
                              </init>
                            </variableDeclarationStatement>
                            <assignStatement>
                              <fieldReferenceExpression name="validationKey"/>
                              <propertyReferenceExpression name="ValidationKey">
                                <variableReferenceExpression name="machineKey"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                      <catch exceptionType="Exception"></catch>
                    </tryStatement>
                  </trueStatements>
                </conditionStatement>-->
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <unaryOperatorExpression operator="IsNullOrEmpty">
                        <fieldReferenceExpression name="validationKey"/>
                      </unaryOperatorExpression>
                      <methodInvokeExpression methodName="Contains">
                        <target>
                          <fieldReferenceExpression name="validationKey"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="AutoGenerate"/>
                        </parameters>
                      </methodInvokeExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="validationKey"/>
                      <primitiveExpression value="{$ValidationKey}"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method ChangePassword(string, string, string) -->
            <memberMethod returnType="System.Boolean" name="ChangePassword">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="oldPwd"/>
                <parameter type="System.String" name="newPwd"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="ValidateUser">
                        <parameters>
                          <argumentReferenceExpression name="username"/>
                          <argumentReferenceExpression name="oldPwd"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ValidatePasswordEventArgs" name="args">
                  <init>
                    <objectCreateExpression type="ValidatePasswordEventArgs">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <argumentReferenceExpression name="newPwd"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="OnValidatingPassword">
                  <parameters>
                    <variableReferenceExpression name="args"/>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Cancel">
                      <variableReferenceExpression name="args"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="FailureInformation">
                            <variableReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <propertyReferenceExpression name="FailureInformation">
                            <variableReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                      <falseStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="MembershipPasswordException">
                            <parameters>
                              <primitiveExpression value="Change of password canceled due to new password validation failure."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="ChangePassword">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="Password"/>
                        <methodInvokeExpression methodName="EncodePassword">
                          <parameters>
                            <argumentReferenceExpression name="newPwd"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="LastPasswordChangedDate"/>
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="UserName"/>
                        <argumentReferenceExpression name="username"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <binaryOperatorExpression operator="ValueEquality">
                        <methodInvokeExpression methodName="ExecuteNonQuery">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </methodReturnStatement>
                  </statements>
                </usingStatement>
              </statements>
            </memberMethod>
            <!-- method ChangePasswordQuestionAndAnswer(string, string, string, string) -->
            <memberMethod returnType="System.Boolean" name="ChangePasswordQuestionAndAnswer">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="password"/>
                <parameter type="System.String" name="newPwdQuestion"/>
                <parameter type="System.String" name="newPwdAnswer"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="ValidateUser">
                        <parameters>
                          <argumentReferenceExpression name="username"/>
                          <argumentReferenceExpression name="password"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="ChangePasswordQuestionAndAnswer">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="PasswordQuestion"/>
                        <argumentReferenceExpression name="newPwdQuestion"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="PasswordAnswer"/>
                        <methodInvokeExpression methodName="EncodePassword">
                          <parameters>
                            <argumentReferenceExpression name="newPwdAnswer"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="UserName"/>
                        <argumentReferenceExpression name="username"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <binaryOperatorExpression operator="ValueEquality">
                        <methodInvokeExpression methodName="ExecuteNonQuery">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </methodReturnStatement>
                  </statements>
                </usingStatement>
              </statements>
            </memberMethod>
            <!-- method EncodeUserPassword -->
            <memberMethod returnType="System.String" name="EncodeUserPassword">
              <attributes public="true" static="true" />
              <parameters>
                <parameter type="System.String" name="password"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="EncodePassword">
                    <target>
                      <castExpression targetType="OracleMembershipProvider">
                        <propertyReferenceExpression name="Provider">
                          <typeReferenceExpression type="Membership"/>
                        </propertyReferenceExpression>
                      </castExpression>
                    </target>
                    <parameters>
                      <argumentReferenceExpression name="password"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ValidateUserPassword -->
            <memberMethod name="ValidateUserPassword">
              <attributes public="true" static="true" />
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="password"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="ValidateUserPassword">
                  <parameters>
                    <argumentReferenceExpression name="username"/>
                    <argumentReferenceExpression name="password"/>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method ValidateUserPassword -->
            <memberMethod name="ValidateUserPassword">
              <attributes public="true" static="true" />
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="password"/>
                <parameter type="System.Boolean" name="isNewUser"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ValidatePasswordEventArgs" name="args">
                  <init>
                    <objectCreateExpression type="ValidatePasswordEventArgs">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <argumentReferenceExpression name="password"/>
                        <argumentReferenceExpression name="isNewUser"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="OnValidatingPassword">
                  <target>
                    <castExpression targetType="OracleMembershipProvider">
                      <propertyReferenceExpression name="Provider">
                        <typeReferenceExpression type="Membership"/>
                      </propertyReferenceExpression>
                    </castExpression>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="args"/>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Cancel">
                      <variableReferenceExpression name="args"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="FailureInformation">
                            <variableReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <propertyReferenceExpression name="FailureInformation">
                            <variableReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method CreateUser(string, string, string, string, string, bool, object, out MembershipCreateStatus) -->
            <memberMethod returnType="MembershipUser" name="CreateUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="password"/>
                <parameter type="System.String" name="email"/>
                <parameter type="System.String" name="passwordQuestion"/>
                <parameter type="System.String" name="passwordAnswer"/>
                <parameter type="System.Boolean" name="isApproved"/>
                <parameter type="System.Object" name="providerUserKey"/>
                <parameter type="MembershipCreateStatus" name="status" direction="Out"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ValidatePasswordEventArgs" name="args">
                  <init>
                    <objectCreateExpression type="ValidatePasswordEventArgs">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <argumentReferenceExpression name="password"/>
                        <primitiveExpression value="true"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="OnValidatingPassword">
                  <parameters>
                    <variableReferenceExpression name="args"/>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Cancel">
                      <variableReferenceExpression name="args"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <argumentReferenceExpression name="status"/>
                      <propertyReferenceExpression name="InvalidPassword">
                        <typeReferenceExpression type="MembershipCreateStatus"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <propertyReferenceExpression name="RequiresUniqueEmail"/>
                      <unaryOperatorExpression operator="IsNotNullOrEmpty">
                        <methodInvokeExpression methodName="GetUserNameByEmail">
                          <parameters>
                            <argumentReferenceExpression name="email"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <argumentReferenceExpression name="status"/>
                      <propertyReferenceExpression name="DuplicateEmail">
                        <typeReferenceExpression type="MembershipCreateStatus"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <methodInvokeExpression methodName="GetUser">
                        <parameters>
                          <argumentReferenceExpression name="username"/>
                          <primitiveExpression value="false"/>
                        </parameters>
                      </methodInvokeExpression>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="status"/>
                      <propertyReferenceExpression name="DuplicateUserName">
                        <typeReferenceExpression type="MembershipCreateStatus"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <variableDeclarationStatement type="DateTime" name="creationDate">
                      <init>
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="CreateUser">
                                <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                            <primitiveExpression value="Password"/>
                            <methodInvokeExpression methodName="EncodePassword">
                              <parameters>
                                <argumentReferenceExpression name="password"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="Email"/>
                            <argumentReferenceExpression name="email"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="PasswordQuestion"/>
                            <argumentReferenceExpression name="passwordQuestion"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="PasswordAnswer"/>
                            <methodInvokeExpression methodName="EncodePassword">
                              <parameters>
                                <argumentReferenceExpression name="passwordAnswer"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="IsApproved"/>
                            <argumentReferenceExpression name="isApproved"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="Comments"/>
                            <stringEmptyExpression/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="CreationDate"/>
                            <variableReferenceExpression name="creationDate"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="LastPasswordChangedDate"/>
                            <variableReferenceExpression name="creationDate"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="LastActivityDate"/>
                            <variableReferenceExpression name="creationDate"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="LastLoginDate"/>
                            <variableReferenceExpression name="creationDate"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="IsLockedOut"/>
                            <primitiveExpression value="false"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="LastLockedOutDate"/>
                            <variableReferenceExpression name="creationDate"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="FailedPwdAttemptCount"/>
                            <primitiveExpression value="0"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="FailedPwdAttemptWindowStart"/>
                            <variableReferenceExpression name="creationDate"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="FailedPwdAnsAttemptCount"/>
                            <primitiveExpression value="0"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="FailedPwdAnsAttemptWindowStart"/>
                            <variableReferenceExpression name="creationDate"/>
                          </parameters>
                        </methodInvokeExpression>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="GreaterThan">
                              <methodInvokeExpression methodName="ExecuteNonQuery">
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                              </methodInvokeExpression>
                              <primitiveExpression value="0"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <argumentReferenceExpression name="status"/>
                              <propertyReferenceExpression name="Success">
                                <typeReferenceExpression type="MembershipCreateStatus"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <methodReturnStatement>
                              <methodInvokeExpression methodName="GetUser">
                                <parameters>
                                  <argumentReferenceExpression name="username"/>
                                  <primitiveExpression value="false"/>
                                </parameters>
                              </methodInvokeExpression>
                            </methodReturnStatement>
                          </trueStatements>
                          <falseStatements>
                            <assignStatement>
                              <argumentReferenceExpression name="status"/>
                              <propertyReferenceExpression name="UserRejected">
                                <typeReferenceExpression type="MembershipCreateStatus"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                          </falseStatements>
                        </conditionStatement>
                      </statements>
                    </usingStatement>
                  </falseStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <primitiveExpression value="null"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method DeleteUser(string, bool) -->
            <memberMethod returnType="System.Boolean" name="DeleteUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.Boolean" name="deleteAllRelatedData"/>
              </parameters>
              <statements>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="DeleteUser">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                    <methodReturnStatement>
                      <binaryOperatorExpression operator="GreaterThan">
                        <methodInvokeExpression methodName="ExecuteNonQuery">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </methodReturnStatement>
                  </statements>
                </usingStatement>
              </statements>
            </memberMethod>
            <!-- method GetAllUsers(int, int, int) -->
            <memberMethod returnType="MembershipUserCollection" name="GetAllUsers">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.Int32" name="pageIndex"/>
                <parameter type="System.Int32" name="pageSize"/>
                <parameter type="System.Int32" name="totalRecords" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="totalRecords"/>
                  <primitiveExpression value="0"/>
                </assignStatement>
                <variableDeclarationStatement type="MembershipUserCollection" name="users">
                  <init>
                    <objectCreateExpression type="MembershipUserCollection"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="CountAllUsers">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </init>
                  </variable>
                  <statements>
                    <assignStatement>
                      <argumentReferenceExpression name="totalRecords"/>
                      <convertExpression to="Int32">
                        <methodInvokeExpression methodName="ExecuteScalar">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </convertExpression>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="LessThanOrEqual">
                          <argumentReferenceExpression name="totalRecords"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <variableReferenceExpression name="users"/>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetAllUsers">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </init>
                  </variable>
                  <statements>
                    <variableDeclarationStatement type="System.Int32" name="counter">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="startIndex">
                      <init>
                        <binaryOperatorExpression operator="Multiply">
                          <argumentReferenceExpression name="pageSize"/>
                          <argumentReferenceExpression name="pageIndex"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="endIndex">
                      <init>
                        <binaryOperatorExpression operator="Subtract">
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="startIndex"/>
                            <argumentReferenceExpression name="pageSize"/>
                          </binaryOperatorExpression>
                          <primitiveExpression value="1"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <whileStatement>
                      <test>
                        <methodInvokeExpression methodName="Read">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </test>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="GreaterThanOrEqual">
                              <variableReferenceExpression name="counter"/>
                              <variableReferenceExpression name="startIndex"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="users"/>
                              </target>
                              <parameters>
                                <methodInvokeExpression methodName="GetUser">
                                  <parameters>
                                    <variableReferenceExpression name="sql"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="GreaterThanOrEqual">
                              <variableReferenceExpression name="counter"/>
                              <variableReferenceExpression name="endIndex"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <breakStatement/>
                          </trueStatements>
                        </conditionStatement>
                        <assignStatement>
                          <variableReferenceExpression name="counter"/>
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="counter"/>
                            <primitiveExpression value="1"/>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </statements>
                    </whileStatement>
                  </statements>
                </usingStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="users"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method GetNumberOfUsersOnline() -->
            <memberMethod returnType="System.Int32" name="GetNumberOfUsersOnline">
              <attributes public="true" override="true"/>
              <statements>
                <variableDeclarationStatement type="TimeSpan" name="onlineSpan">
                  <init>
                    <objectCreateExpression type="TimeSpan">
                      <parameters>
                        <primitiveExpression value="0"/>
                        <propertyReferenceExpression name="UserIsOnlineTimeWindow">
                          <typeReferenceExpression type="Membership"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="0"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DateTime" name="compareDate">
                  <init>
                    <methodInvokeExpression methodName="Subtract">
                      <target>
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="onlineSpan"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetNumberOfUsersOnline">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="CompareDate"/>
                        <variableReferenceExpression name="compareDate"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <convertExpression to="Int32">
                        <methodInvokeExpression methodName="ExecuteScalar">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </convertExpression>
                    </methodReturnStatement>
                  </statements>
                </usingStatement>
              </statements>
            </memberMethod>
            <!-- method GetPassword(string, string) -->
            <memberMethod returnType="System.String" name="GetPassword">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="answer"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="EnablePasswordRetrieval"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="Password retrieval is not enabled."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="PasswordFormat" />
                      <propertyReferenceExpression name="Hashed">
                        <typeReferenceExpression type="MembershipPasswordFormat"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="Cannot retrieve hashed passwords."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.String" name="password">
                  <init>
                    <stringEmptyExpression/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="passwordAnswer">
                  <init>
                    <stringEmptyExpression/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetPassword">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Read">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <convertExpression to="Boolean">
                              <arrayIndexerExpression>
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                                <indices>
                                  <primitiveExpression value="IsLockedOut"/>
                                </indices>
                              </arrayIndexerExpression>
                            </convertExpression>
                          </condition>
                          <trueStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="MembershipPasswordException">
                                <parameters>
                                  <primitiveExpression value="User is locked out."/>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </trueStatements>
                        </conditionStatement>
                        <assignStatement>
                          <variableReferenceExpression name="password"/>
                          <convertExpression to="String">
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <indices>
                                <primitiveExpression value="Password"/>
                              </indices>
                            </arrayIndexerExpression>
                          </convertExpression>
                        </assignStatement>
                        <assignStatement>
                          <variableReferenceExpression name="passwordAnswer"/>
                          <convertExpression to="String">
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <indices>
                                <primitiveExpression value="PasswordAnswer"/>
                              </indices>
                            </arrayIndexerExpression>
                          </convertExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="MembershipPasswordException">
                            <parameters>
                              <primitiveExpression value="User name is not found."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <propertyReferenceExpression name="RequiresQuestionAndAnswer"/>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="CheckPassword">
                          <parameters>
                            <argumentReferenceExpression name="answer"/>
                            <variableReferenceExpression name="passwordAnswer"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="UpdateFailureCount">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <primitiveExpression value="PasswordAnswer"/>
                      </parameters>
                    </methodInvokeExpression>
                    <throwExceptionStatement>
                      <objectCreateExpression type="MembershipPasswordException">
                        <parameters>
                          <primitiveExpression value="Incorrect password answer."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="PasswordFormat"/>
                      <propertyReferenceExpression name="Encrypted">
                        <typeReferenceExpression type="MembershipPasswordFormat"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="password"/>
                      <methodInvokeExpression methodName="DecodePassword">
                        <parameters>
                          <variableReferenceExpression name="password"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="password"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method GetUser(string, bool) -->
            <memberMethod returnType="MembershipUser" name="GetUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.Boolean" name="userIsOnline"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="MembershipUser" name="u">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetUser">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Read">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="u"/>
                          <methodInvokeExpression methodName="GetUser">
                            <parameters>
                              <variableReferenceExpression name="sql"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <argumentReferenceExpression name="userIsOnline"/>
                      <binaryOperatorExpression operator="IdentityInequality">
                        <variableReferenceExpression name="u"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="UpdateLastUserActivity">
                                <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                            <primitiveExpression value="LastActivityDate"/>
                            <propertyReferenceExpression name="Now">
                              <typeReferenceExpression type="DateTime"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="UserName"/>
                            <argumentReferenceExpression name="username"/>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="ExecuteNonQuery">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </statements>
                    </usingStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="u"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method GetUser(object, bool) -->
            <memberMethod returnType="MembershipUser" name="GetUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.Object" name="providerUserKey"/>
                <parameter type="System.Boolean" name="userIsOnline"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="MembershipUser" name="u">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetUserByProviderKey">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="UserID"/>
                        <argumentReferenceExpression name="providerUserKey"/>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Read">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="u"/>
                          <methodInvokeExpression methodName="GetUser">
                            <parameters>
                              <variableReferenceExpression name="sql"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <argumentReferenceExpression name="userIsOnline"/>
                      <binaryOperatorExpression operator="IdentityInequality">
                        <variableReferenceExpression name="u"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="UpdateLastUserActivity">
                                <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                            <primitiveExpression value="LastActivityDate"/>
                            <propertyReferenceExpression name="Now">
                              <typeReferenceExpression type="DateTime"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="AssignParameter">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="UserName"/>
                            <propertyReferenceExpression name="UserName">
                              <variableReferenceExpression name="u"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="ExecuteNonQuery">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </statements>
                    </usingStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="u"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method GetUser(SqlStatement) -->
            <memberMethod returnType="MembershipUser" name="GetUser">
              <attributes private="true"/>
              <parameters>
                <parameter type="SqlStatement" name="sql"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Object" name="providerUserKey">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <argumentReferenceExpression name="sql"/>
                      </target>
                      <indices>
                        <primitiveExpression value="UserID"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="username">
                  <init>
                    <convertExpression to="String">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="UserName"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="email">
                  <init>
                    <convertExpression to="String">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="Email"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="passwordQuestion">
                  <init>
                    <convertExpression to="String">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="PasswordQuestion"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="comment">
                  <init>
                    <convertExpression to="String">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="Comments"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="isApproved">
                  <init>
                    <convertExpression to="Boolean">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="IsApproved"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="isLockedOut">
                  <init>
                    <convertExpression to="Boolean">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="IsLockedOut"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DateTime" name="creationDate">
                  <init>
                    <convertExpression to="DateTime">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="CreationDate"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DateTime" name="lastLoginDate">
                  <init>
                    <convertExpression to="DateTime">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="LastLoginDate"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DateTime" name="lastActivityDate">
                  <init>
                    <convertExpression to="DateTime">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="LastActivityDate"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DateTime" name="lastPasswordChangedDate">
                  <init>
                    <convertExpression to="DateTime">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="LastPasswordChangedDate"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DateTime" name="lastLockedOutDate">
                  <init>
                    <convertExpression to="DateTime">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="sql"/>
                        </target>
                        <indices>
                          <primitiveExpression value="LastLockedOutDate"/>
                        </indices>
                      </arrayIndexerExpression>
                    </convertExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="MembershipUser">
                    <parameters>
                      <propertyReferenceExpression name="Name">
                        <thisReferenceExpression/>
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="username"/>
                      <variableReferenceExpression name="providerUserKey"/>
                      <variableReferenceExpression name="email"/>
                      <variableReferenceExpression name="passwordQuestion"/>
                      <variableReferenceExpression name="comment"/>
                      <variableReferenceExpression name="isApproved"/>
                      <variableReferenceExpression name="isLockedOut"/>
                      <variableReferenceExpression name="creationDate"/>
                      <variableReferenceExpression name="lastLoginDate"/>
                      <variableReferenceExpression name="lastActivityDate"/>
                      <variableReferenceExpression name="lastPasswordChangedDate"/>
                      <variableReferenceExpression name="lastLockedOutDate"/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method UnlockUser(string) -->
            <memberMethod returnType="System.Boolean" name="UnlockUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
              </parameters>
              <statements>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="UpdateUserLockStatus">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="IsLockedOut"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="LastLockedOutDate"/>
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="UserName"/>
                        <argumentReferenceExpression name="username"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <binaryOperatorExpression operator="GreaterThan">
                        <methodInvokeExpression methodName="ExecuteNonQuery">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                    </methodReturnStatement>
                  </statements>
                </usingStatement>
              </statements>
            </memberMethod>
            <!-- method GetUserNameByEmail(string) -->
            <memberMethod returnType="System.String" name="GetUserNameByEmail">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="email"/>
              </parameters>
              <statements>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetUserNameByEmail">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="Email"/>
                        <argumentReferenceExpression name="email"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <convertExpression to="String">
                        <methodInvokeExpression methodName="ExecuteScalar">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </convertExpression>
                    </methodReturnStatement>
                  </statements>
                </usingStatement>
              </statements>
            </memberMethod>
            <!-- method ResetPassword(string, string) -->
            <memberMethod returnType="System.String" name="ResetPassword">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="answer"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="EnablePasswordReset"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="NotSupportedException">
                        <parameters>
                          <primitiveExpression value="Password reset is not enabled."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <unaryOperatorExpression operator="IsNullOrEmpty">
                        <argumentReferenceExpression name="answer"/>
                      </unaryOperatorExpression>
                      <propertyReferenceExpression name="RequiresQuestionAndAnswer"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="UpdateFailureCount">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <primitiveExpression value="PasswordAnswer"/>
                      </parameters>
                    </methodInvokeExpression>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="Password answer required for password reset."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.String" name="newPassword">
                  <init>
                    <methodInvokeExpression methodName="GeneratePassword">
                      <target>
                        <typeReferenceExpression type="Membership"/>
                      </target>
                      <parameters>
                        <fieldReferenceExpression name="newPasswordLength">
                          <thisReferenceExpression/>
                        </fieldReferenceExpression>
                        <propertyReferenceExpression name="MinRequiredNonAlphanumericCharacters"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="ValidatePasswordEventArgs" name="args">
                  <init>
                    <objectCreateExpression type="ValidatePasswordEventArgs">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <variableReferenceExpression name="newPassword"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="OnValidatingPassword">
                  <parameters>
                    <variableReferenceExpression name="args"/>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Cancel">
                      <variableReferenceExpression name="args"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <propertyReferenceExpression name="FailureInformation">
                            <variableReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <propertyReferenceExpression name="FailureInformation">
                            <variableReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                      <falseStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="MembershipPasswordException">
                            <parameters>
                              <primitiveExpression value="Reset password canceled due to password validation failure."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.String" name="passwordAnswer">
                  <init>
                    <stringEmptyExpression/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetPassword">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Read">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <convertExpression to="Boolean">
                              <arrayIndexerExpression>
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                                <indices>
                                  <primitiveExpression value="IsLockedOut"/>
                                </indices>
                              </arrayIndexerExpression>
                            </convertExpression>
                          </condition>
                          <trueStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="MembershipPasswordException">
                                <parameters>
                                  <primitiveExpression value="User is locked out."/>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="GreaterThan">
                              <methodInvokeExpression methodName="AddMinutes">
                                <target>
                                  <castExpression targetType="DateTime">
                                    <arrayIndexerExpression>
                                      <target>
                                        <variableReferenceExpression name="sql"/>
                                      </target>
                                      <indices>
                                        <primitiveExpression value="FailedPwdAnsAttemptWindowStart"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                  </castExpression>
                                </target>
                                <parameters>
                                  <propertyReferenceExpression name="PasswordAttemptWindow"/>
                                </parameters>
                              </methodInvokeExpression>
                              <propertyReferenceExpression name="Now">
                                <typeReferenceExpression type="DateTime"/>
                              </propertyReferenceExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="MembershipPasswordException">
                                <parameters>
                                  <primitiveExpression value="Password answer attempt is not yet allowed."/>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </trueStatements>
                        </conditionStatement>
                        <assignStatement>
                          <variableReferenceExpression name="passwordAnswer"/>
                          <convertExpression to="String">
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <indices>
                                <primitiveExpression value="PasswordAnswer"/>
                              </indices>
                            </arrayIndexerExpression>
                          </convertExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="MembershipPasswordException">
                            <parameters>
                              <primitiveExpression value="User is not found."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <propertyReferenceExpression name="RequiresQuestionAndAnswer"/>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="CheckPassword">
                          <parameters>
                            <argumentReferenceExpression name="answer"/>
                            <variableReferenceExpression name="passwordAnswer"/>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="UpdateFailureCount">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <primitiveExpression value="PasswordAnswer"/>
                      </parameters>
                    </methodInvokeExpression>
                    <throwExceptionStatement>
                      <objectCreateExpression type="MembershipPasswordException">
                        <parameters>
                          <primitiveExpression value="Incorrect password answer."/>
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
                          <propertyReferenceExpression name="ResetPassword">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="Password"/>
                        <methodInvokeExpression methodName="EncodePassword">
                          <parameters>
                            <variableReferenceExpression name="newPassword"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="LastPasswordChangedDate"/>
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
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
                        <primitiveExpression value="IsLockedOut"/>
                        <primitiveExpression value="false"/>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="GreaterThan">
                          <methodInvokeExpression methodName="ExecuteNonQuery">
                            <target>
                              <variableReferenceExpression name="sql"/>
                            </target>
                          </methodInvokeExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <variableReferenceExpression name="newPassword"/>
                        </methodReturnStatement>
                      </trueStatements>
                      <falseStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="MembershipPasswordException">
                            <parameters>
                              <primitiveExpression value="User is not found or locked out. Password has not been reset."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
              </statements>
            </memberMethod>
            <!-- method UpdateUser(MembershipUser) -->
            <memberMethod name="UpdateUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="MembershipUser" name="user"/>
              </parameters>
              <statements>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="UpdateUser">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <primitiveExpression value="Email"/>
                        <propertyReferenceExpression name="Email">
                          <argumentReferenceExpression name="user"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Comments"/>
                        <propertyReferenceExpression name="Comment">
                          <argumentReferenceExpression name="user"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="IsApproved"/>
                        <propertyReferenceExpression name="IsApproved">
                          <argumentReferenceExpression name="user"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="AssignParameter">
                      <target>
                        <variableReferenceExpression name="sql"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="UserName"/>
                        <propertyReferenceExpression name="UserName">
                          <argumentReferenceExpression name="user"/>
                        </propertyReferenceExpression>
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
            </memberMethod>
            <!-- method ValidateUser(string, string) -->
            <memberMethod returnType="System.Boolean" name="ValidateUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="password"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Boolean" name="isValid">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="pwd">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="isApproved">
                  <init>
                    <primitiveExpression value="true"/>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <argumentReferenceExpression name="username"/>
                  <methodInvokeExpression methodName="Trim">
                    <target>
                      <argumentReferenceExpression name="username"/>
                    </target>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="password"/>
                  <methodInvokeExpression methodName="Trim">
                    <target>
                      <argumentReferenceExpression name="password"/>
                    </target>
                  </methodInvokeExpression>
                </assignStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetPassword">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Read">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <convertExpression to="Boolean">
                              <arrayIndexerExpression>
                                <target>
                                  <variableReferenceExpression name="sql"/>
                                </target>
                                <indices>
                                  <primitiveExpression value="IsLockedOut"/>
                                </indices>
                              </arrayIndexerExpression>
                            </convertExpression>
                          </condition>
                          <trueStatements>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="GreaterThan">
                                  <methodInvokeExpression methodName="AddMinutes">
                                    <target>
                                      <castExpression targetType="DateTime">
                                        <arrayIndexerExpression>
                                          <target>
                                            <variableReferenceExpression name="sql"/>
                                          </target>
                                          <indices>
                                            <primitiveExpression value="FailedPwdAttemptWindowStart"/>
                                          </indices>
                                        </arrayIndexerExpression>
                                      </castExpression>
                                    </target>
                                    <parameters>
                                      <propertyReferenceExpression name="PasswordAttemptWindow"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                  <propertyReferenceExpression name="Now">
                                    <typeReferenceExpression type="DateTime"/>
                                  </propertyReferenceExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <methodReturnStatement>
                                  <primitiveExpression value="false"/>
                                </methodReturnStatement>
                              </trueStatements>
                            </conditionStatement>
                          </trueStatements>
                        </conditionStatement>
                        <assignStatement>
                          <variableReferenceExpression name="pwd"/>
                          <convertExpression to="String">
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <indices>
                                <primitiveExpression value="Password"/>
                              </indices>
                            </arrayIndexerExpression>
                          </convertExpression>
                        </assignStatement>
                        <assignStatement>
                          <variableReferenceExpression name="isApproved"/>
                          <convertExpression to="Boolean">
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <indices>
                                <primitiveExpression value="IsApproved"/>
                              </indices>
                            </arrayIndexerExpression>
                          </convertExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <methodReturnStatement>
                          <primitiveExpression value="false"/>
                        </methodReturnStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="CheckPassword">
                      <parameters>
                        <argumentReferenceExpression name="password"/>
                        <variableReferenceExpression name="pwd"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <variableReferenceExpression name="isApproved"/>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="isValid"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                        <usingStatement>
                          <variable type="SqlStatement" name="sql">
                            <init>
                              <methodInvokeExpression methodName="CreateSqlStatement">
                                <parameters>
                                  <propertyReferenceExpression name="UpdateLastLoginDate">
                                    <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                                <primitiveExpression value="LastLoginDate"/>
                                <propertyReferenceExpression name="Now">
                                  <typeReferenceExpression type="DateTime"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="IsLockedOut"/>
                                <primitiveExpression value="false"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="UserName"/>
                                <argumentReferenceExpression name="username"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="ExecuteNonQuery">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                            </methodInvokeExpression>
                          </statements>
                        </usingStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodInvokeExpression methodName="UpdateFailureCount">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                        <primitiveExpression value="Password"/>
                      </parameters>
                    </methodInvokeExpression>
                  </falseStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="isValid"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method UpdateFailureCount(string, string) -->
            <memberMethod name="UpdateFailureCount">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="failureType"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Int32" name="failureCount">
                  <init>
                    <primitiveExpression value="0"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DateTime" name="windowStart">
                  <init>
                    <propertyReferenceExpression name="Now">
                      <typeReferenceExpression type="DateTime"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="GetUser">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="Read">
                            <target>
                              <variableReferenceExpression name="sql"/>
                            </target>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement/>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <argumentReferenceExpression name="failureType"/>
                          <primitiveExpression value="Password"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="failureCount"/>
                          <convertExpression to="Int32">
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <indices>
                                <primitiveExpression value="FailedPwdAttemptCount"/>
                              </indices>
                            </arrayIndexerExpression>
                          </convertExpression>
                        </assignStatement>
                        <conditionStatement>
                          <condition>
                            <unaryOperatorExpression operator="Not">
                              <methodInvokeExpression methodName="Equals">
                                <target>
                                  <propertyReferenceExpression name="Value">
                                    <typeReferenceExpression type="DBNull"/>
                                  </propertyReferenceExpression>
                                </target>
                                <parameters>
                                  <arrayIndexerExpression>
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                    <indices>
                                      <primitiveExpression value="FailedPwdAttemptWindowStart"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </unaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="windowStart"/>
                              <convertExpression to="DateTime">
                                <arrayIndexerExpression>
                                  <target>
                                    <variableReferenceExpression name="sql"/>
                                  </target>
                                  <indices>
                                    <primitiveExpression value="FailedPwdAttemptWindowStart"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </convertExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <argumentReferenceExpression name="failureType"/>
                          <primitiveExpression value="PasswordAnswer"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="failureCount"/>
                          <convertExpression to="Int32">
                            <arrayIndexerExpression>
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <indices>
                                <primitiveExpression value="FailedPwdAnsAttemptCount"/>
                              </indices>
                            </arrayIndexerExpression>
                          </convertExpression>
                        </assignStatement>
                        <conditionStatement>
                          <condition>
                            <unaryOperatorExpression operator="Not">
                              <methodInvokeExpression methodName="Equals">
                                <target>
                                  <propertyReferenceExpression name="Value">
                                    <typeReferenceExpression type="DBNull"/>
                                  </propertyReferenceExpression>
                                </target>
                                <parameters>
                                  <arrayIndexerExpression>
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                    <indices>
                                      <primitiveExpression value="FailedPwdAnsAttemptWindowStart"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </unaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="windowStart"/>
                              <convertExpression to="DateTime">
                                <arrayIndexerExpression>
                                  <target>
                                    <variableReferenceExpression name="sql"/>
                                  </target>
                                  <indices>
                                    <primitiveExpression value="FailedPwdAnsAttemptWindowStart"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </convertExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </usingStatement>
                <variableDeclarationStatement type="DateTime" name="windowEnd">
                  <init>
                    <methodInvokeExpression methodName="AddMinutes">
                      <target>
                        <variableReferenceExpression name="windowStart"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="PasswordAttemptWindow"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <binaryOperatorExpression operator="ValueEquality">
                        <variableReferenceExpression name="failureCount"/>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="GreaterThan">
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="DateTime"/>
                        </propertyReferenceExpression>
                        <variableReferenceExpression name="windowEnd"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <argumentReferenceExpression name="failureType"/>
                          <primitiveExpression value="Password"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <usingStatement>
                          <variable type="SqlStatement" name="sql">
                            <init>
                              <methodInvokeExpression methodName="CreateSqlStatement">
                                <parameters>
                                  <propertyReferenceExpression name="UpdateFailedPasswordAttempt">
                                    <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                                <primitiveExpression value="FailedPwdAttemptCount"/>
                                <primitiveExpression value="1"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="FailedPwdAttemptWindowStart"/>
                                <propertyReferenceExpression name="Now">
                                  <typeReferenceExpression type="DateTime"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="UserName"/>
                                <argumentReferenceExpression name="username"/>
                              </parameters>
                            </methodInvokeExpression>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="ValueEquality">
                                  <methodInvokeExpression methodName="ExecuteNonQuery">
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                  </methodInvokeExpression>
                                  <primitiveExpression value="0"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <throwExceptionStatement>
                                  <objectCreateExpression type="ProviderException">
                                    <parameters>
                                      <primitiveExpression value="Unable to update password failure count and window start."/>
                                    </parameters>
                                  </objectCreateExpression>
                                </throwExceptionStatement>
                              </trueStatements>
                            </conditionStatement>
                          </statements>
                        </usingStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <argumentReferenceExpression name="failureType"/>
                          <primitiveExpression value="PasswordAnswer"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <usingStatement>
                          <variable type="SqlStatement" name="sql">
                            <init>
                              <methodInvokeExpression methodName="CreateSqlStatement">
                                <parameters>
                                  <propertyReferenceExpression name="UpdateFailedPasswordAnswerAttempt">
                                    <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                                <primitiveExpression value="FailedPwdAnsAttemptCount"/>
                                <primitiveExpression value="1"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="FailedPwdAnsAttemptWindowStart"/>
                                <propertyReferenceExpression name="Now">
                                  <typeReferenceExpression type="DateTime"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="UserName"/>
                                <argumentReferenceExpression name="username"/>
                              </parameters>
                            </methodInvokeExpression>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="ValueEquality">
                                  <methodInvokeExpression methodName="ExecuteNonQuery">
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                  </methodInvokeExpression>
                                  <primitiveExpression value="0"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <throwExceptionStatement>
                                  <objectCreateExpression type="ProviderException">
                                    <parameters>
                                      <primitiveExpression value="Unable to update password answer failure count and window start."/>
                                    </parameters>
                                  </objectCreateExpression>
                                </throwExceptionStatement>
                              </trueStatements>
                            </conditionStatement>
                          </statements>
                        </usingStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                  <falseStatements>
                    <assignStatement>
                      <variableReferenceExpression name="failureCount"/>
                      <binaryOperatorExpression operator="Add">
                        <variableReferenceExpression name="failureCount"/>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="GreaterThan">
                          <variableReferenceExpression name="failureCount"/>
                          <propertyReferenceExpression name="MaxInvalidPasswordAttempts"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <usingStatement>
                          <variable type="SqlStatement" name="sql">
                            <init>
                              <methodInvokeExpression methodName="CreateSqlStatement">
                                <parameters>
                                  <propertyReferenceExpression name="UpdateUserLockStatus">
                                    <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                                <primitiveExpression value="IsLockedOut"/>
                                <primitiveExpression value="true"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="LastLockedOutDate"/>
                                <propertyReferenceExpression name="Now">
                                  <typeReferenceExpression type="DateTime"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="AssignParameter">
                              <target>
                                <variableReferenceExpression name="sql"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="UserName"/>
                                <argumentReferenceExpression name="username"/>
                              </parameters>
                            </methodInvokeExpression>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="LessThan">
                                  <methodInvokeExpression methodName="ExecuteNonQuery">
                                    <target>
                                      <variableReferenceExpression name="sql"/>
                                    </target>
                                  </methodInvokeExpression>
                                  <primitiveExpression value="1"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <throwExceptionStatement>
                                  <objectCreateExpression type="ProviderException">
                                    <parameters>
                                      <primitiveExpression value="Unable to lock out user."/>
                                    </parameters>
                                  </objectCreateExpression>
                                </throwExceptionStatement>
                              </trueStatements>
                            </conditionStatement>
                          </statements>
                        </usingStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <argumentReferenceExpression name="failureType"/>
                              <primitiveExpression value="Password"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <usingStatement>
                              <variable type="SqlStatement" name="sql">
                                <init>
                                  <methodInvokeExpression methodName="CreateSqlStatement">
                                    <parameters>
                                      <propertyReferenceExpression name="UpdateFailedPasswordAttempt">
                                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                                    <primitiveExpression value="FailedPwdAttemptCount"/>
                                    <variableReferenceExpression name="failureCount"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <methodInvokeExpression methodName="AssignParameter">
                                  <target>
                                    <variableReferenceExpression name="sql"/>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="FailedPwdAttemptWindowStart"/>
                                    <variableReferenceExpression name="windowStart"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <methodInvokeExpression methodName="AssignParameter">
                                  <target>
                                    <variableReferenceExpression name="sql"/>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="UserName"/>
                                    <argumentReferenceExpression name="username"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="ValueEquality">
                                      <methodInvokeExpression methodName="ExecuteNonQuery">
                                        <target>
                                          <variableReferenceExpression name="sql"/>
                                        </target>
                                      </methodInvokeExpression>
                                      <primitiveExpression value="0"/>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <throwExceptionStatement>
                                      <objectCreateExpression type="ProviderException">
                                        <parameters>
                                          <primitiveExpression value="Unable to update password failure count and window start."/>
                                        </parameters>
                                      </objectCreateExpression>
                                    </throwExceptionStatement>
                                  </trueStatements>
                                </conditionStatement>
                              </statements>
                            </usingStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <argumentReferenceExpression name="failureType"/>
                              <primitiveExpression value="PasswordAnswer"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <usingStatement>
                              <variable type="SqlStatement" name="sql">
                                <init>
                                  <methodInvokeExpression methodName="CreateSqlStatement">
                                    <parameters>
                                      <propertyReferenceExpression name="UpdateFailedPasswordAnswerAttempt">
                                        <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                                    <primitiveExpression value="FailedPwdAnsAttemptCount"/>
                                    <variableReferenceExpression name="failureCount"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <methodInvokeExpression methodName="AssignParameter">
                                  <target>
                                    <variableReferenceExpression name="sql"/>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="FailedPwdAnsAttemptWindowStart"/>
                                    <variableReferenceExpression name="windowStart"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <methodInvokeExpression methodName="AssignParameter">
                                  <target>
                                    <variableReferenceExpression name="sql"/>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="UserName"/>
                                    <argumentReferenceExpression name="username"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="ValueEquality">
                                      <methodInvokeExpression methodName="ExecuteNonQuery">
                                        <target>
                                          <variableReferenceExpression name="sql"/>
                                        </target>
                                      </methodInvokeExpression>
                                      <primitiveExpression value="0"/>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <throwExceptionStatement>
                                      <objectCreateExpression type="ProviderException">
                                        <parameters>
                                          <primitiveExpression value="Unable to update password answer failure count and window start."/>
                                        </parameters>
                                      </objectCreateExpression>
                                    </throwExceptionStatement>
                                  </trueStatements>
                                </conditionStatement>
                              </statements>
                            </usingStatement>
                          </trueStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method CheckPassword(string, string) -->
            <memberMethod returnType="System.Boolean" name="CheckPassword">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.String" name="password"/>
                <parameter type="System.String" name="currentPassword"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="pass1">
                  <init>
                    <argumentReferenceExpression name="password"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="pass2">
                  <init>
                    <argumentReferenceExpression name="currentPassword"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="PasswordFormat"/>
                      <propertyReferenceExpression name="Encrypted">
                        <typeReferenceExpression type="MembershipPasswordFormat"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="pass2"/>
                      <methodInvokeExpression methodName="DecodePassword">
                        <parameters>
                          <argumentReferenceExpression name="currentPassword"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="PasswordFormat"/>
                          <propertyReferenceExpression name="Hashed">
                            <typeReferenceExpression type="MembershipPasswordFormat"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="pass1"/>
                          <methodInvokeExpression methodName="EncodePassword">
                            <parameters>
                              <argumentReferenceExpression name="password"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="ValueEquality">
                    <variableReferenceExpression name="pass1"/>
                    <variableReferenceExpression name="pass2"/>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method EncodePassword(string) -->
            <memberMethod returnType="System.String" name="EncodePassword">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="password"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="encodedPassword">
                  <init>
                    <argumentReferenceExpression name="password"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="PasswordFormat"/>
                      <propertyReferenceExpression name="Encrypted">
                        <typeReferenceExpression type="MembershipPasswordFormat"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="encodedPassword"/>
                      <methodInvokeExpression methodName="ToBase64String">
                        <target>
                          <typeReferenceExpression type="Convert"/>
                        </target>
                        <parameters>
                          <methodInvokeExpression methodName="EncryptPassword">
                            <parameters>
                              <methodInvokeExpression methodName="GetBytes">
                                <target>
                                  <propertyReferenceExpression name="Unicode">
                                    <typeReferenceExpression type="Encoding"/>
                                  </propertyReferenceExpression>
                                </target>
                                <parameters>
                                  <argumentReferenceExpression name="password"/>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="PasswordFormat"/>
                          <propertyReferenceExpression name="Hashed">
                            <typeReferenceExpression type="MembershipPasswordFormat"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="HMACSHA1" name="hash">
                          <init>
                            <objectCreateExpression type="HMACSHA1"/>
                          </init>
                        </variableDeclarationStatement>
                        <assignStatement>
                          <propertyReferenceExpression name="Key">
                            <variableReferenceExpression name="hash"/>
                          </propertyReferenceExpression>
                          <methodInvokeExpression methodName="HexToByte">
                            <parameters>
                              <fieldReferenceExpression name="validationKey"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <assignStatement>
                          <variableReferenceExpression name="encodedPassword"/>
                          <methodInvokeExpression methodName="ToBase64String">
                            <target>
                              <typeReferenceExpression type="Convert"/>
                            </target>
                            <parameters>
                              <methodInvokeExpression methodName="ComputeHash">
                                <target>
                                  <variableReferenceExpression name="hash"/>
                                </target>
                                <parameters>
                                  <methodInvokeExpression methodName="GetBytes">
                                    <target>
                                      <propertyReferenceExpression name="Unicode">
                                        <typeReferenceExpression type="Encoding"/>
                                      </propertyReferenceExpression>
                                    </target>
                                    <parameters>
                                      <argumentReferenceExpression name="password"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="encodedPassword"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method DecodePassword(string) -->
            <memberMethod returnType="System.String" name="DecodePassword">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="encodedPassword"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="password">
                  <init>
                    <argumentReferenceExpression name="encodedPassword"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="PasswordFormat"/>
                      <propertyReferenceExpression name="Encrypted">
                        <typeReferenceExpression type="MembershipPasswordFormat"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="password"/>
                      <methodInvokeExpression methodName="GetString">
                        <target>
                          <propertyReferenceExpression name="Unicode">
                            <typeReferenceExpression type="Encoding"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <methodInvokeExpression methodName="DecryptPassword">
                            <parameters>
                              <methodInvokeExpression methodName="FromBase64String">
                                <target>
                                  <typeReferenceExpression type="Convert"/>
                                </target>
                                <parameters>
                                  <argumentReferenceExpression name="encodedPassword"/>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="PasswordFormat"/>
                          <propertyReferenceExpression name="Hashed">
                            <typeReferenceExpression type="MembershipPasswordFormat"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="ProviderException">
                            <parameters>
                              <primitiveExpression value="Cannot decode a hashed password."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="password"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method HexToByte(string) -->
            <memberMethod returnType="System.Byte[]" name="HexToByte">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="System.String" name="hexString"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Byte[]" name="returnBytes">
                  <init>
                    <arrayCreateExpression>
                      <createType type="System.Byte"/>
                      <sizeExpression>
                        <binaryOperatorExpression operator="Divide">
                          <propertyReferenceExpression name="Length">
                            <argumentReferenceExpression name="hexString"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="2"/>
                        </binaryOperatorExpression>
                      </sizeExpression>
                    </arrayCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <forStatement>
                  <variable type="System.Int32" name="i">
                    <init>
                      <primitiveExpression value="0"/>
                    </init>
                  </variable>
                  <test>
                    <binaryOperatorExpression operator="LessThan">
                      <variableReferenceExpression name="i"/>
                      <propertyReferenceExpression name="Length">
                        <variableReferenceExpression name="returnBytes"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </test>
                  <increment>
                    <variableReferenceExpression name="i"/>
                  </increment>
                  <statements>
                    <assignStatement>
                      <arrayIndexerExpression>
                        <target>
                          <variableReferenceExpression name="returnBytes"/>
                        </target>
                        <indices>
                          <variableReferenceExpression name="i"/>
                        </indices>
                      </arrayIndexerExpression>
                      <methodInvokeExpression methodName="ToByte">
                        <target>
                          <typeReferenceExpression type="Convert"/>
                        </target>
                        <parameters>
                          <methodInvokeExpression methodName="Substring">
                            <target>
                              <argumentReferenceExpression name="hexString"/>
                            </target>
                            <parameters>
                              <binaryOperatorExpression operator="Multiply">
                                <variableReferenceExpression name="i"/>
                                <primitiveExpression value="2"/>
                              </binaryOperatorExpression>
                              <primitiveExpression value="2"/>
                            </parameters>
                          </methodInvokeExpression>
                          <primitiveExpression value="16"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </statements>
                </forStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="returnBytes"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method FindUsersByName(string, int, int, out int) -->
            <memberMethod returnType="MembershipUserCollection" name="FindUsersByName">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="usernameToMatch"/>
                <parameter type="System.Int32" name="pageIndex"/>
                <parameter type="System.Int32" name="pageSize"/>
                <parameter type="System.Int32" name="totalRecords" direction="Out"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="MembershipUserCollection" name="users">
                  <init>
                    <objectCreateExpression type="MembershipUserCollection"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="CountUsersByName">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                    <assignStatement>
                      <argumentReferenceExpression name="totalRecords"/>
                      <convertExpression to="Int32">
                        <methodInvokeExpression methodName="ExecuteScalar">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </convertExpression>
                    </assignStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <argumentReferenceExpression name="totalRecords"/>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.Int32" name="counter">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="startIndex">
                      <init>
                        <binaryOperatorExpression operator="Multiply">
                          <argumentReferenceExpression name="pageSize"/>
                          <argumentReferenceExpression name="pageIndex"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="endIndex">
                      <init>
                        <binaryOperatorExpression operator="Subtract">
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="startIndex"/>
                            <argumentReferenceExpression name="pageSize"/>
                          </binaryOperatorExpression>
                          <primitiveExpression value="1"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="FindUsersByName">
                                <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                            <variableReferenceExpression name="usernameToMatch"/>
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
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="GreaterThanOrEqual">
                                  <variableReferenceExpression name="counter"/>
                                  <variableReferenceExpression name="startIndex"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="users"/>
                                  </target>
                                  <parameters>
                                    <methodInvokeExpression methodName="GetUser">
                                      <parameters>
                                        <variableReferenceExpression name="sql"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="GreaterThanOrEqual">
                                  <variableReferenceExpression name="counter"/>
                                  <variableReferenceExpression name="endIndex"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <breakStatement/>
                              </trueStatements>
                            </conditionStatement>
                            <assignStatement>
                              <variableReferenceExpression name="counter"/>
                              <binaryOperatorExpression operator="Add">
                                <variableReferenceExpression name="counter"/>
                                <primitiveExpression value="1"/>
                              </binaryOperatorExpression>
                            </assignStatement>
                          </statements>
                        </whileStatement>
                      </statements>
                    </usingStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="users"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method FindUsersByEmail(string, int, int, out int) -->
            <memberMethod returnType="MembershipUserCollection" name="FindUsersByEmail">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="emailToMatch"/>
                <parameter type="System.Int32" name="pageIndex"/>
                <parameter type="System.Int32" name="pageSize"/>
                <parameter type="System.Int32" name="totalRecords" direction="Out"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="MembershipUserCollection" name="users">
                  <init>
                    <objectCreateExpression type="MembershipUserCollection"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="SqlStatement" name="sql">
                    <init>
                      <methodInvokeExpression methodName="CreateSqlStatement">
                        <parameters>
                          <propertyReferenceExpression name="CountUsersByEmail">
                            <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                        <argumentReferenceExpression name="emailToMatch"/>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <argumentReferenceExpression name="totalRecords"/>
                      <convertExpression to="Int32">
                        <methodInvokeExpression methodName="ExecuteScalar">
                          <target>
                            <variableReferenceExpression name="sql"/>
                          </target>
                        </methodInvokeExpression>
                      </convertExpression>
                    </assignStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <argumentReferenceExpression name="totalRecords"/>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.Int32" name="counter">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="startIndex">
                      <init>
                        <binaryOperatorExpression operator="Multiply">
                          <argumentReferenceExpression name="pageSize"/>
                          <argumentReferenceExpression name="pageIndex"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="endIndex">
                      <init>
                        <binaryOperatorExpression operator="Subtract">
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="startIndex"/>
                            <argumentReferenceExpression name="pageSize"/>
                          </binaryOperatorExpression>
                          <primitiveExpression value="1"/>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <usingStatement>
                      <variable type="SqlStatement" name="sql">
                        <init>
                          <methodInvokeExpression methodName="CreateSqlStatement">
                            <parameters>
                              <propertyReferenceExpression name="FindUsersByEmail">
                                <typeReferenceExpression type="MembershipProviderSqlStatement"/>
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
                            <primitiveExpression value="Email"/>
                            <variableReferenceExpression name="emailToMatch"/>
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
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="GreaterThanOrEqual">
                                  <variableReferenceExpression name="counter"/>
                                  <variableReferenceExpression name="startIndex"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="users"/>
                                  </target>
                                  <parameters>
                                    <methodInvokeExpression methodName="GetUser">
                                      <parameters>
                                        <variableReferenceExpression name="sql"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="GreaterThanOrEqual">
                                  <variableReferenceExpression name="counter"/>
                                  <variableReferenceExpression name="endIndex"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <breakStatement/>
                              </trueStatements>
                            </conditionStatement>
                            <assignStatement>
                              <variableReferenceExpression name="counter"/>
                              <binaryOperatorExpression operator="Add">
                                <variableReferenceExpression name="counter"/>
                                <primitiveExpression value="1"/>
                              </binaryOperatorExpression>
                            </assignStatement>
                          </statements>
                        </whileStatement>
                      </statements>
                    </usingStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="users"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method OnValidatingPassword(ValidatePasswordEventArgs) -->
            <memberMethod name="OnValidatingPassword">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="ValidatePasswordEventArgs" name="e"/>
              </parameters>
              <statements>
                <tryStatement>
                  <statements>
                    <variableDeclarationStatement type="System.String" name="password">
                      <init>
                        <propertyReferenceExpression name="Password">
                          <variableReferenceExpression name="e"/>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="LessThan">
                          <propertyReferenceExpression name="Length">
                            <variableReferenceExpression name="password"/>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="MinRequiredPasswordLength"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="ArgumentException">
                            <parameters>
                              <primitiveExpression value="Invalid password length."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <variableDeclarationStatement type="System.Int32" name="count">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variableDeclarationStatement>
                    <forStatement>
                      <variable type="System.Int32" name="i">
                        <init>
                          <primitiveExpression value="0"/>
                        </init>
                      </variable>
                      <test>
                        <binaryOperatorExpression operator="LessThan">
                          <variableReferenceExpression name="i"/>
                          <propertyReferenceExpression name="Length">
                            <variableReferenceExpression name="password"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </test>
                      <increment>
                        <variableReferenceExpression name="i"/>
                      </increment>
                      <statements>
                        <conditionStatement>
                          <condition>
                            <unaryOperatorExpression operator="Not">
                              <methodInvokeExpression methodName="IsLetterOrDigit">
                                <target>
                                  <typeReferenceExpression type="Char"/>
                                </target>
                                <parameters>
                                  <variableReferenceExpression name="password"/>
                                  <variableReferenceExpression name="i"/>
                                </parameters>
                              </methodInvokeExpression>
                            </unaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="count"/>
                              <binaryOperatorExpression operator="Add">
                                <variableReferenceExpression name="count"/>
                                <primitiveExpression value="1"/>
                              </binaryOperatorExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </forStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="LessThan">
                          <variableReferenceExpression name="count"/>
                          <propertyReferenceExpression name="MinRequiredNonAlphanumericCharacters"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <throwExceptionStatement>
                          <objectCreateExpression type="ArgumentException">
                            <parameters>
                              <primitiveExpression value="Password needs more non-alphanumeric characters."/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNotNullOrEmpty">
                          <propertyReferenceExpression name="PasswordStrengthRegularExpression"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <unaryOperatorExpression operator="Not">
                              <methodInvokeExpression methodName="IsMatch">
                                <target>
                                  <typeReferenceExpression type="Regex"/>
                                </target>
                                <parameters>
                                  <variableReferenceExpression name="password"/>
                                  <propertyReferenceExpression name="PasswordStrengthRegularExpression"/>
                                </parameters>
                              </methodInvokeExpression>
                            </unaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="ArgumentException">
                                <parameters>
                                  <primitiveExpression value="Password does not match regular expression."/>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="OnValidatingPassword">
                      <target>
                        <baseReferenceExpression/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="e"/>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <propertyReferenceExpression name="Cancel">
                          <variableReferenceExpression name="e"/>
                        </propertyReferenceExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityInequality">
                              <propertyReferenceExpression name="FailureInformation">
                                <variableReferenceExpression name="e"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <throwExceptionStatement>
                              <propertyReferenceExpression name="FailureInformation">
                                <argumentReferenceExpression name="e"/>
                              </propertyReferenceExpression>
                            </throwExceptionStatement>
                          </trueStatements>
                          <falseStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="ArgumentException">
                                <parameters>
                                  <primitiveExpression value="Custom password validation failure."/>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                  <catch exceptionType="Exception" localName="ex">
                    <assignStatement>
                      <propertyReferenceExpression name="FailureInformation">
                        <argumentReferenceExpression name="e"/>
                      </propertyReferenceExpression>
                      <variableReferenceExpression name="ex"/>
                    </assignStatement>
                    <assignStatement>
                      <propertyReferenceExpression name="Cancel">
                        <argumentReferenceExpression name="e"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="true"/>
                    </assignStatement>
                  </catch>
                </tryStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- enum RoleProviderSqlStatement-->
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
        <!-- class OracleRoleProvider -->
        <typeDeclaration name="OracleRoleProvider">
          <attributes sealed="true"/>
          <baseTypes>
            <typeReference type="RoleProvider"/>
          </baseTypes>
          <members>
            <!-- property Commands -->
            <memberField type="SortedDictionary" name="Statements">
              <attributes public="true" static="true"/>
              <typeArguments>
                <typeReference type="RoleProviderSqlStatement"/>
                <typeReference type="System.String"/>
              </typeArguments>
              <init>
                <objectCreateExpression type="SortedDictionary">
                  <typeArguments>
                    <typeReference type="RoleProviderSqlStatement"/>
                    <typeReference type="System.String"/>
                  </typeArguments>
                </objectCreateExpression>
              </init>
            </memberField>
            <!-- public OracleRoleProvider() -->
            <typeConstructor>
              <statements>
                <!-- AddUserToRole -->
                <xsl:variable name="AddUserToRole" xml:space="preserve"><![CDATA[insert into aspnet_user_roles(user_id, role_id)  values ((select user_id from aspnet_users where user_name=@UserName), (select role_id from aspnet_roles where role_name=@RoleName))]]></xsl:variable>
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
                <xsl:variable name="CreateRole" xml:space="preserve"><![CDATA[insert into aspnet_roles (role_name) values (@RoleName)]]></xsl:variable>
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
                <xsl:variable name="DeleteRole" xml:space="preserve"><![CDATA[delete from aspnet_roles where role_name = @RoleName]]></xsl:variable>
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
                <xsl:variable name="DeleteRoleUsers" xml:space="preserve"><![CDATA[delete from aspnet_user_roles where role_id in (select role_id from aspnet_roles where role_name = @RoleName)]]></xsl:variable>
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
                <xsl:variable name="GetAllRoles" xml:space="preserve"><![CDATA[select role_name RoleName from aspnet_roles]]></xsl:variable>
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
                <xsl:variable name="GetRolesForUser" xml:space="preserve"><![CDATA[select Roles.role_name RoleName from aspnet_roles Roles  inner join aspnet_user_roles UserRoles on Roles.role_id = UserRoles.role_id  inner join aspnet_users Users on Users.user_id = UserRoles.user_id where Users.user_name = @UserName]]></xsl:variable>
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
                <xsl:variable name="GetUsersInRole" xml:space="preserve"><![CDATA[select user_name UserName from aspnet_users where user_id in (select user_id from aspnet_user_roles where role_id in (select role_id from aspnet_roles where role_name = @RoleName))]]></xsl:variable>
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
                <xsl:variable name="IsUserInRole" xml:space="preserve"><![CDATA[select count(*) from aspnet_user_roles where     user_id in (select user_id from aspnet_users where user_name = @UserName) and role_id in (select role_id from aspnet_roles where role_name = @RoleName)]]></xsl:variable>
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
                <xsl:variable name="RemoveUserFromRole" xml:space="preserve"><![CDATA[delete from aspnet_user_roles where    user_id in (select user_id from aspnet_users where user_name = @UserName) and    role_id in (select role_id from aspnet_roles where role_name = @RoleName)]]></xsl:variable>
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
                <xsl:variable name="RoleExists" xml:space="preserve"><![CDATA[select count(*) from aspnet_roles where role_name = @RoleName]]></xsl:variable>
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
                <xsl:variable name="FindUsersInRole" xml:space="preserve"><![CDATA[select Users.user_name UserName from aspnet_users Users
inner join aspnet_user_roles UserRoles on Users.user_id= UserRoles.user_id 
inner join aspnet_roles Roles on UserRoles.role_id = Roles.role_id
where 
	Users.user_name like @UserName and 
	Roles.role_name = @RoleName]]></xsl:variable>
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
            <!-- method CreateSqlStatement -->
            <memberMethod returnType="SqlStatement" name="CreateSqlStatement">
              <attributes private="true" final="true"/>
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
            <!-- property ConnectionStringSettings -->
            <memberField type="ConnectionStringSettings" name="connectionStringSettings"/>
            <memberProperty type="ConnectionStringSettings" name="ConnectionStringSettings">
              <attributes public="true" final="true"/>
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
                      <primitiveExpression value="OracleRoleProvider"/>
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
              </statements>
            </memberMethod>
            <!-- method CreateRole(string) -->
            <memberMethod name="CreateRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
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
              </statements>
            </memberMethod>
            <!-- method GetAllRoles() -->
            <memberMethod returnType="System.String[]" name="GetAllRoles">
              <attributes public="true" override="true"/>
              <statements>
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
              </statements>
            </memberMethod>
            <!-- method GetRolesForUser(string) -->
            <memberMethod returnType="System.String[]" name="GetRolesForUser">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
              </parameters>
              <statements>
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
                    <stringFormatExpression format="OracleRoleProvider_{{0}}_Roles">
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
              </statements>
            </memberMethod>
            <!-- method ForgetUserRoles-->
            <memberMethod name="ForgetUserRoles">
              <attributes public="true" final="true"/>
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
                        <stringFormatExpression format="OracleRoleProvider_{{0}}_Roles">
                          <argumentReferenceExpression name="username"/>
                        </stringFormatExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method GetUsersInRole(string) -->
            <memberMethod returnType="System.String[]" name="GetUsersInRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
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
              </statements>
            </memberMethod>
            <!-- method RoleExists(sting) -->
            <memberMethod returnType="System.Boolean" name="RoleExists">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
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
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
