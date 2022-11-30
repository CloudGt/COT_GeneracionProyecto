<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease" exclude-result-prefixes="msxsl a codeontime"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="Namespace" select="a:project/a:namespace"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Security">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Configuration.Provider"/>
        <namespaceImport name="System.Collections.Specialized"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="System.Collections"/>
        <namespaceImport name="System.DirectoryServices"/>
        <namespaceImport name="System.DirectoryServices.AccountManagement"/>
        <namespaceImport name="System.Web.Hosting"/>
        <namespaceImport name="System.Web.Caching"/>
        <namespaceImport name="System.Web.Configuration"/>
        <namespaceImport name="System.ComponentModel"/>
      </imports>
      <types>
        <!-- class ApplicationRoleProvider -->
        <typeDeclaration isPartial="true" name="ApplicationRoleProvider">
          <baseTypes>
            <typeReference type="ApplicationRoleProviderBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- class ApplicationRoleProviderBase-->
        <typeDeclaration name="ApplicationRoleProviderBase">
          <baseTypes>
            <typeReference type="RoleProvider"/>
          </baseTypes>
          <members>
            <memberField type="System.String" name="ApplicationName"/>
            <memberField type="System.String" name="ActiveDirectoryConnectionString"/>
            <memberField type="System.String" name="Server"/>
            <memberField type="System.String" name="Username"/>
            <memberField type="System.String" name="Password"/>
            <memberField type="System.Boolean" name="IsRoleWhiteListMode"/>
            <memberProperty type="ArrayList" name="RoleWhiteList">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="RoleWhiteList"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="RoleWhiteList"/>
                  <argumentReferenceExpression name="value"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <memberField type="ArrayList" name="roleWhiteList">
              <init>
                <objectCreateExpression type="ArrayList"/>
              </init>
            </memberField>
            <memberProperty type="ArrayList" name="RoleBlackList">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="RoleBlackList"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="RoleBlackList"/>
                  <argumentReferenceExpression name="value"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <memberField type="ArrayList" name="RoleBlackList">
              <init>
                <objectCreateExpression type="ArrayList"/>
              </init>
            </memberField>
            <memberProperty type="ArrayList" name="UserBlackList">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="UserBlackList"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="UserBlackList"/>
                  <argumentReferenceExpression name="value"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <memberField type="ArrayList" name="UserBlackList">
              <init>
                <objectCreateExpression type="ArrayList"/>
              </init>
            </memberField>
            <memberField type="System.Boolean" name="EnableCache"/>
            <memberField type="System.Int32" name="CacheTimeoutInMinutes">
              <init>
                <primitiveExpression value="10"/>
              </init>
            </memberField>
            <memberField type="System.String[]" name="DefaultUserBlackList">
              <init>
                <arrayCreateExpression>
                  <createType type="System.String"/>
                  <initializers>
                    <primitiveExpression value="Administrator"/>
                    <primitiveExpression value="TsInternetUser"/>
                    <primitiveExpression value="Guest"/>
                    <primitiveExpression value="krbtgt"/>
                    <primitiveExpression value="Replicate"/>
                    <primitiveExpression value="SERVICE"/>
                    <primitiveExpression value="SMSService"/>
                  </initializers>
                </arrayCreateExpression>
              </init>
            </memberField>
            <memberField type="System.String[]" name="DefaultRoleBlackList">
              <init>
                <arrayCreateExpression>
                  <createType type="System.String"/>
                  <initializers>
                    <primitiveExpression value="Domain Guests"/>
                    <primitiveExpression value="Domain Computers"/>
                    <primitiveExpression value="Group Policy Creator Owners"/>
                    <primitiveExpression value="Guests"/>
                    <!--<primitiveExpression value="Users"/>-->
                    <primitiveExpression value="Domain Users"/>
                    <primitiveExpression value="Pre-Windows 200 Compatible Access"/>
                    <primitiveExpression value="Exchange Domain Servers"/>
                    <primitiveExpression value="Schema Admins"/>
                    <primitiveExpression value="Enterprise Admins"/>
                    <primitiveExpression value="Domain Admins"/>
                    <primitiveExpression value="Cert Publishers"/>
                    <primitiveExpression value="Backup Operators"/>
                    <primitiveExpression value="WINS Users"/>
                    <primitiveExpression value="DnsAdmins"/>
                    <primitiveExpression value="DnsUpdateProxy"/>
                    <primitiveExpression value="DHCP Users"/>
                    <primitiveExpression value="DHCP Administrators"/>
                    <primitiveExpression value="Exchange Services"/>
                    <primitiveExpression value="Exchange Enterprise Servers"/>
                    <primitiveExpression value="Remote Desktop Users"/>
                    <primitiveExpression value="Network Configuration Operators"/>
                    <primitiveExpression value="Incoming Forest Trust Builders"/>
                    <primitiveExpression value="Performance Monitor Users"/>
                    <primitiveExpression value="Performance Log Users"/>
                    <primitiveExpression value="Windows Authorization Access Group"/>
                    <primitiveExpression value="Terminal Server License Servers"/>
                    <primitiveExpression value="Distributed COM Users"/>
                    <!--<primitiveExpression value="Administrators"/>-->
                    <primitiveExpression value="MTS Impersonators"/>
                    <primitiveExpression value="Everyone"/>
                    <primitiveExpression value="LOCAL"/>
                    <primitiveExpression value="Authenticated Users"/>
                  </initializers>
                </arrayCreateExpression>
              </init>
            </memberField>
            <!-- property ApplicationName-->
            <memberProperty type="System.String" name="ApplicationName">
              <attributes public="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="ApplicationName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="ApplicationName"/>
                  <argumentReferenceExpression name="value"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property ContextType-->
            <memberField type="ContextType" name="ADContextType">
              <init>
                <propertyReferenceExpression name="Machine">
                  <typeReferenceExpression type="ContextType"/>
                </propertyReferenceExpression>
              </init>
            </memberField>
            <memberProperty type="ContextType" name="ADContextType">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="ADContextType"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="ADContextType"/>
                  <argumentReferenceExpression name="value"/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- method Initialize(String, NameValueCollection)-->
            <memberMethod name="Initialize">
              <attributes override="true" public="true"/>
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
                      <primitiveExpression value="ADRoleProvider"/>
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
                        <primitiveExpression value="Active Directory Role Provider"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="Initialize">
                  <target>
                    <baseReferenceExpression />
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="name"/>
                    <argumentReferenceExpression name="config"/>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="System.String" name="contextType">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <argumentReferenceExpression name="config"/>
                      </target>
                      <indices>
                        <primitiveExpression value="contextType"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="contextType"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="ADContextType"/>
                      <castExpression targetType="ContextType">
                        <methodInvokeExpression methodName="ConvertFromString">
                          <target>
                            <methodInvokeExpression methodName="GetConverter">
                              <target>
                                <typeReferenceExpression type="TypeDescriptor"/>
                              </target>
                              <parameters>
                                <typeofExpression type="ContextType"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="contextType"/>
                          </parameters>
                        </methodInvokeExpression>
                      </castExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.String" name="temp">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <argumentReferenceExpression name="config"/>
                      </target>
                      <indices>
                        <primitiveExpression value="activeDirectoryConnectionString"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <variableReferenceExpression name="temp"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="The attribute 'activeDirectoryConnectionString' is missing or empty."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ConnectionStringSettings" name="connObj">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="ConnectionStrings">
                          <typeReferenceExpression type="ConfigurationManager"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <variableReferenceExpression name="temp"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="connObj"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="ActiveDirectoryConnectionString"/>
                      <propertyReferenceExpression name="ConnectionString">
                        <variableReferenceExpression name="connObj"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <fieldReferenceExpression name="ActiveDirectoryConnectionString"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="The connection name 'activeDirectoryConnectionString' was not found in the applications configuration or the connection string is empty."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <methodInvokeExpression methodName="Substring">
                        <target>
                          <fieldReferenceExpression name="ActiveDirectoryConnectionString"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="0"/>
                          <primitiveExpression value="7"/>
                        </parameters>
                      </methodInvokeExpression>
                      <primitiveExpression value="LDAP://"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="Server"/>
                      <methodInvokeExpression methodName="Substring">
                        <target>
                          <fieldReferenceExpression name="ActiveDirectoryConnectionString"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="7"/>
                          <binaryOperatorExpression operator="Subtract">
                            <propertyReferenceExpression name="Length">
                              <fieldReferenceExpression name="ActiveDirectoryConnectionString"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="7"/>
                          </binaryOperatorExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <variableDeclarationStatement type="MembershipSection" name="membershipSection">
                      <init>
                        <castExpression targetType="MembershipSection">
                          <methodInvokeExpression methodName="GetSection">
                            <target>
                              <typeReferenceExpression type="WebConfigurationManager"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="system.web/membership"/>
                            </parameters>
                          </methodInvokeExpression>
                        </castExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.String" name="defaultProvider">
                      <init>
                        <propertyReferenceExpression name="DefaultProvider">
                          <variableReferenceExpression name="membershipSection"/>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="ProviderSettings" name="providerSettings">
                      <init>
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Providers">
                              <variableReferenceExpression name="membershipSection"/>
                            </propertyReferenceExpression>
                          </target>
                          <indices>
                            <variableReferenceExpression name="defaultProvider"/>
                          </indices>
                        </arrayIndexerExpression>
                      </init>
                    </variableDeclarationStatement>
                    <assignStatement>
                      <fieldReferenceExpression name="Username"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Parameters">
                            <variableReferenceExpression name="providerSettings"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="connectionUsername"/>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                    <assignStatement>
                      <fieldReferenceExpression name="Password"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Parameters">
                            <variableReferenceExpression name="providerSettings"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="connectionPassword"/>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="The connection string specified in 'activeDirectoryConnectionString' does not appear to be a valid LDAP connection string."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </falseStatements>
                </conditionStatement>
                <assignStatement>
                  <fieldReferenceExpression name="ApplicationName"/>
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
                      <fieldReferenceExpression name="ApplicationName"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="ApplicationName"/>
                      <propertyReferenceExpression name="ApplicationVirtualPath">
                        <typeReferenceExpression type="HostingEnvironment"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <propertyReferenceExpression name="Length">
                        <fieldReferenceExpression name="ApplicationName"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="256"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="The application name is too long."/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <variableReferenceExpression name="temp"/>
                  <arrayIndexerExpression>
                    <target>
                      <argumentReferenceExpression name="config"/>
                    </target>
                    <indices>
                      <primitiveExpression value="roleWhitelist"/>
                    </indices>
                  </arrayIndexerExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="temp"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="IsRoleWhiteListMode"/>
                      <primitiveExpression value="true"/>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="IsRoleWhiteListMode"/>
                      <primitiveExpression value="false"/>
                    </assignStatement>
                  </falseStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="IsRoleWhiteListMode"/>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNotNullOrEmpty">
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="config"/>
                            </target>
                            <indices>
                              <primitiveExpression value="roleWhitelist"/>
                            </indices>
                          </arrayIndexerExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <foreachStatement>
                          <variable type="System.String" name="group"/>
                          <target>
                            <methodInvokeExpression methodName="Split">
                              <target>
                                <methodInvokeExpression methodName="Trim">
                                  <target>
                                    <arrayIndexerExpression>
                                      <target>
                                        <argumentReferenceExpression name="config"/>
                                      </target>
                                      <indices>
                                        <primitiveExpression value="roleWhitelist"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                  </target>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <primitiveExpression convertTo="Char" value=","/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <statements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <fieldReferenceExpression name="RoleWhiteList"/>
                              </target>
                              <parameters>
                                <methodInvokeExpression methodName="Trim">
                                  <target>
                                    <variableReferenceExpression name="group"/>
                                  </target>
                                </methodInvokeExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </statements>
                        </foreachStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <foreachStatement>
                  <variable type="System.String" name="group"/>
                  <target>
                    <fieldReferenceExpression name="DefaultRoleBlackList"/>
                  </target>
                  <statements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <fieldReferenceExpression name="RoleBlackList"/>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="Trim">
                          <target>
                            <variableReferenceExpression name="group"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="config"/>
                        </target>
                        <indices>
                          <primitiveExpression value="roleBlacklist"/>
                        </indices>
                      </arrayIndexerExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <foreachStatement>
                      <variable type="System.String" name="group"/>
                      <target>
                        <methodInvokeExpression methodName="Split">
                          <target>
                            <methodInvokeExpression methodName="Trim">
                              <target>
                                <arrayIndexerExpression>
                                  <target>
                                    <argumentReferenceExpression name="config"/>
                                  </target>
                                  <indices>
                                    <primitiveExpression value="roleBlacklist"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </target>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <primitiveExpression convertTo="Char" value=","/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <statements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <fieldReferenceExpression name="RoleBlackList"/>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="Trim">
                              <target>
                                <variableReferenceExpression name="group"/>
                              </target>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </statements>
                    </foreachStatement>
                  </trueStatements>
                </conditionStatement>
                <foreachStatement>
                  <variable type="System.String" name="user"/>
                  <target>
                    <fieldReferenceExpression name="DefaultUserBlackList"/>
                  </target>
                  <statements>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <fieldReferenceExpression name="UserBlackList"/>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="Trim">
                          <target>
                            <variableReferenceExpression name="user"/>
                          </target>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="config"/>
                        </target>
                        <indices>
                          <primitiveExpression value="userBlacklist"/>
                        </indices>
                      </arrayIndexerExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <foreachStatement>
                      <variable type="System.String" name="user"/>
                      <target>
                        <methodInvokeExpression methodName="Split">
                          <target>
                            <methodInvokeExpression methodName="Trim">
                              <target>
                                <arrayIndexerExpression>
                                  <target>
                                    <argumentReferenceExpression name="config"/>
                                  </target>
                                  <indices>
                                    <primitiveExpression value="userBlacklist"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </target>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <primitiveExpression convertTo="Char" value=","/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <statements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <fieldReferenceExpression name="UserBlackList"/>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="Trim">
                              <target>
                                <variableReferenceExpression name="user"/>
                              </target>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </statements>
                    </foreachStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="config"/>
                        </target>
                        <indices>
                          <primitiveExpression value="enableCache"/>
                        </indices>
                      </arrayIndexerExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="config"/>
                            </target>
                            <indices>
                              <primitiveExpression value="enableCache"/>
                            </indices>
                          </arrayIndexerExpression>
                          <primitiveExpression convertTo="String" value="True"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <fieldReferenceExpression name="EnableCache"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <arrayIndexerExpression>
                                <target>
                                  <argumentReferenceExpression name="config"/>
                                </target>
                                <indices>
                                  <primitiveExpression value="enableCache"/>
                                </indices>
                              </arrayIndexerExpression>
                              <primitiveExpression convertTo="String" value="False"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <fieldReferenceExpression name="EnableCache"/>
                              <primitiveExpression value="false"/>
                            </assignStatement>
                          </trueStatements>
                          <falseStatements>
                            <throwExceptionStatement>
                              <objectCreateExpression type="ProviderException">
                                <parameters>
                                  <primitiveExpression value="The attribute 'enableCache' is specified as an invalid value. Must be 'True' or 'False'."/>
                                </parameters>
                              </objectCreateExpression>
                            </throwExceptionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="EnableCache"/>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="temp"/>
                      <arrayIndexerExpression>
                        <target>
                          <argumentReferenceExpression name="config"/>
                        </target>
                        <indices>
                          <primitiveExpression value="cacheTimeInMinutes"/>
                        </indices>
                      </arrayIndexerExpression>
                    </assignStatement>
                    <tryStatement>
                      <statements>
                        <assignStatement>
                          <fieldReferenceExpression name="CacheTimeoutInMinutes"/>
                          <convertExpression to="Int32">
                            <variableReferenceExpression name="temp"/>
                          </convertExpression>
                        </assignStatement>
                      </statements>
                      <catch></catch>
                    </tryStatement>
                  </trueStatements>
                </conditionStatement>
                <comment>
                  <xsl:text>This code is based on http://www.codeproject.com/Articles/28546/Active-Directory-Roles-Provider.</xsl:text>
                </comment>
              </statements>
            </memberMethod>
            <!-- method GetRolesForUser(string)-->
            <memberMethod returnType="System.String[]" name="GetRolesForUser">
              <attributes override="true" public="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="EnableCache"/>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="CachedValue"/>
                    <assignStatement>
                      <variableReferenceExpression name="CachedValue"/>
                      <methodInvokeExpression methodName="GetCacheItem">
                        <parameters>
                          <primitiveExpression convertTo="Char" value="U"/>
                          <argumentReferenceExpression name="username"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="CachedValue"/>
                          <primitiveExpression value="*NotCached"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <methodInvokeExpression methodName="Split">
                            <target>
                              <variableReferenceExpression name="CachedValue"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="," convertTo="Char"/>
                            </parameters>
                          </methodInvokeExpression>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ArrayList" name="results">
                  <init>
                    <objectCreateExpression type="ArrayList"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="PrincipalContext" name="context">
                    <init>
                      <objectCreateExpression type="PrincipalContext">
                        <parameters>
                          <propertyReferenceExpression name="ADContextType"/>
                          <fieldReferenceExpression name="Server"/>
                          <fieldReferenceExpression name="Username"/>
                          <fieldReferenceExpression name="Password"/>
                        </parameters>
                      </objectCreateExpression>
                    </init>
                  </variable>
                  <statements>
                    <tryStatement>
                      <statements>
                        <variableDeclarationStatement type="UserPrincipal" name="p">
                          <init>
                            <methodInvokeExpression methodName="FindByIdentity">
                              <target>
                                <typeReferenceExpression type="UserPrincipal"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="context"/>
                                <propertyReferenceExpression name="SamAccountName">
                                  <typeReferenceExpression type="IdentityType"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="username"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <methodInvokeExpression methodName="EnumerateGroups">
                          <parameters>
                            <methodInvokeExpression methodName="GetGroups">
                              <target>
                                <variableReferenceExpression name="p"/>
                              </target>
                            </methodInvokeExpression>
                            <variableReferenceExpression name="results"/>
                          </parameters>
                        </methodInvokeExpression>
                      </statements>
                      <catch exceptionType="Exception" localName="ex">
                        <throwExceptionStatement>
                          <objectCreateExpression type="ProviderException">
                            <parameters>
                              <primitiveExpression value="Unable to query Active Directory."/>
                              <variableReferenceExpression name="ex"/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </catch>
                    </tryStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="EnableCache"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="SetCacheItem">
                      <parameters>
                        <primitiveExpression value="U" convertTo="Char"/>
                        <argumentReferenceExpression name="username"/>
                        <methodInvokeExpression methodName="Join">
                          <target>
                            <typeReferenceExpression type="String"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=","/>
                            <castExpression targetType="System.String[]">
                              <methodInvokeExpression methodName="ToArray">
                                <target>
                                  <variableReferenceExpression name="results"/>
                                </target>
                                <parameters>
                                  <typeofExpression type="System.String"/>
                                </parameters>
                              </methodInvokeExpression>
                            </castExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <castExpression targetType="System.String[]">
                    <methodInvokeExpression methodName="ToArray">
                      <target>
                        <variableReferenceExpression name="results"/>
                      </target>
                      <parameters>
                        <typeofExpression type="System.String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- EnumerateGroups(PcincipalSearchResult<Principal>, ArrayList)  -->
            <memberMethod name="EnumerateGroups">
              <attributes family="true"/>
              <parameters>
                <parameter type="PrincipalSearchResult" name="groups">
                  <typeArguments>
                    <typeReference type="Principal"/>
                  </typeArguments>
                </parameter>
                <parameter type="ArrayList" name="results"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="GroupPrincipal" name="group"/>
                  <target>
                    <variableReferenceExpression name="groups"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="Contains">
                            <target>
                              <fieldReferenceExpression name="RoleBlackList"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="SamAccountName">
                                <variableReferenceExpression name="group"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <fieldReferenceExpression name="IsRoleWhiteListMode"/>
                          </condition>
                          <trueStatements>
                            <conditionStatement>
                              <condition>
                                <methodInvokeExpression methodName="Contains">
                                  <target>
                                    <fieldReferenceExpression name="RoleWhiteList"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="SamAccountName">
                                      <variableReferenceExpression name="group"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="results"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="SamAccountName">
                                      <variableReferenceExpression name="group"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                                <methodInvokeExpression methodName="EnumerateGroups">
                                  <parameters>
                                    <methodInvokeExpression methodName="GetGroups">
                                      <target>
                                        <variableReferenceExpression name="group"/>
                                      </target>
                                    </methodInvokeExpression>
                                    <argumentReferenceExpression name="results"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                          </trueStatements>
                          <falseStatements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="results"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="SamAccountName">
                                  <variableReferenceExpression name="group"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="EnumerateGroups">
                              <parameters>
                                <methodInvokeExpression methodName="GetGroups">
                                  <target>
                                    <variableReferenceExpression name="group"/>
                                  </target>
                                </methodInvokeExpression>
                                <argumentReferenceExpression name="results"/>
                              </parameters>
                            </methodInvokeExpression>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
              </statements>
            </memberMethod>
            <!-- method GetUsersInRole(String)-->
            <memberMethod returnType="System.String[]" name="GetUsersInRole">
              <attributes override="true" public="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
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
                          <methodInvokeExpression methodName="Format">
                            <target>
                              <typeReferenceExpression type="System.String"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="The role '{0}' was not found."/>
                              <argumentReferenceExpression name="rolename"/>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="EnableCache"/>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="CachedValue"/>
                    <assignStatement>
                      <variableReferenceExpression name="CachedValue"/>
                      <methodInvokeExpression methodName="GetCacheItem">
                        <parameters>
                          <primitiveExpression convertTo="Char" value="R"/>
                          <argumentReferenceExpression name="rolename"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="CachedValue"/>
                          <primitiveExpression value="*NotCached"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <methodInvokeExpression methodName="Split">
                            <target>
                              <variableReferenceExpression name="CachedValue"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="," convertTo="Char"/>
                            </parameters>
                          </methodInvokeExpression>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ArrayList" name="results">
                  <init>
                    <objectCreateExpression type="ArrayList"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="PrincipalContext" name="context">
                    <init>
                      <objectCreateExpression type="PrincipalContext">
                        <parameters>
                          <propertyReferenceExpression name="ADContextType"/>
                          <fieldReferenceExpression name="Server"/>
                          <fieldReferenceExpression name="Username"/>
                          <fieldReferenceExpression name="Password"/>
                        </parameters>
                      </objectCreateExpression>
                    </init>
                  </variable>
                  <statements>
                    <tryStatement>
                      <statements>
                        <variableDeclarationStatement type="GroupPrincipal" name="p">
                          <init>
                            <methodInvokeExpression methodName="FindByIdentity">
                              <target>
                                <typeReferenceExpression type="GroupPrincipal"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="context"/>
                                <propertyReferenceExpression name="SamAccountName">
                                  <typeReferenceExpression type="IdentityType"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="rolename"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <variableDeclarationStatement type="PrincipalSearchResult" name="users">
                          <typeArguments>
                            <typeReference type="Principal"/>
                          </typeArguments>
                          <init>
                            <methodInvokeExpression methodName="GetMembers">
                              <target>
                                <variableReferenceExpression name="p"/>
                              </target>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <foreachStatement>
                          <variable type="UserPrincipal" name="user"/>
                          <target>
                            <variableReferenceExpression name="users"/>
                          </target>
                          <statements>
                            <conditionStatement>
                              <condition>
                                <unaryOperatorExpression operator="Not">
                                  <methodInvokeExpression methodName="Contains">
                                    <target>
                                      <fieldReferenceExpression name="UserBlackList"/>
                                    </target>
                                    <parameters>
                                      <propertyReferenceExpression name="SamAccountName">
                                        <variableReferenceExpression name="user"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </unaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="results"/>
                                  </target>
                                  <parameters>
                                    <propertyReferenceExpression name="SamAccountName">
                                      <variableReferenceExpression name="user"/>
                                    </propertyReferenceExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                          </statements>
                        </foreachStatement>
                      </statements>
                      <catch exceptionType="Exception" localName="ex">
                        <throwExceptionStatement>
                          <objectCreateExpression type="ProviderException">
                            <parameters>
                              <primitiveExpression value="Unable to query Active Directory."/>
                              <variableReferenceExpression name="ex"/>
                            </parameters>
                          </objectCreateExpression>
                        </throwExceptionStatement>
                      </catch>
                    </tryStatement>
                  </statements>
                </usingStatement>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="EnableCache"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="SetCacheItem">
                      <parameters>
                        <primitiveExpression value="R" convertTo="Char"/>
                        <argumentReferenceExpression name="rolename"/>
                        <methodInvokeExpression methodName="Join">
                          <target>
                            <typeReferenceExpression type="String"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=","/>
                            <castExpression targetType="System.String[]">
                              <methodInvokeExpression methodName="ToArray">
                                <target>
                                  <variableReferenceExpression name="results"/>
                                </target>
                                <parameters>
                                  <typeofExpression type="System.String"/>
                                </parameters>
                              </methodInvokeExpression>
                            </castExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <castExpression targetType="System.String[]">
                    <methodInvokeExpression methodName="ToArray">
                      <target>
                        <variableReferenceExpression name="results"/>
                      </target>
                      <parameters>
                        <typeofExpression type="System.String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method IsUserInRole(String, String)-->
            <memberMethod returnType="System.Boolean" name="IsUserInRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="username"/>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="System.String" name="strUser"/>
                  <target>
                    <methodInvokeExpression methodName="GetUsersInRole">
                      <parameters>
                        <argumentReferenceExpression name="username"/>
                      </parameters>
                    </methodInvokeExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <argumentReferenceExpression name="username"/>
                          <variableReferenceExpression name="strUser"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <primitiveExpression value="true"/>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <primitiveExpression value="false"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method GetAllRoles-->
            <memberMethod returnType="System.String[]" name="GetAllRoles">
              <attributes public="true" override="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="EnableCache"/>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="CachedValue"/>
                    <assignStatement>
                      <variableReferenceExpression name="CachedValue"/>
                      <methodInvokeExpression methodName="GetCacheItem">
                        <parameters>
                          <primitiveExpression convertTo="Char" value="L"/>
                          <primitiveExpression value="AllRoles"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="CachedValue"/>
                          <primitiveExpression value="*NotCached"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <methodInvokeExpression methodName="Split">
                            <target>
                              <variableReferenceExpression name="CachedValue"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="," convertTo="Char"/>
                            </parameters>
                          </methodInvokeExpression>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ArrayList" name="results">
                  <init>
                    <objectCreateExpression type="ArrayList"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String[]" name="roles">
                  <init>
                    <methodInvokeExpression methodName="ADSearch">
                      <parameters>
                        <fieldReferenceExpression name="ActiveDirectoryConnectionString"/>
                        <primitiveExpression value="(&amp;(objectCategory=group)(|(groupType=-2147483646)(groupType=-2147483644)(groupType=-2147483640)))"/>
                        <primitiveExpression value="samAccountName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="System.String" name="strRole"/>
                  <target>
                    <variableReferenceExpression name="roles"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="Contains">
                            <target>
                              <fieldReferenceExpression name="RoleBlackList"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="strRole"/>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <fieldReferenceExpression name="IsRoleWhiteListMode"/>
                          </condition>
                          <trueStatements>
                            <conditionStatement>
                              <condition>
                                <methodInvokeExpression methodName="Contains">
                                  <target>
                                    <fieldReferenceExpression name="RoleWhiteList"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="strRole"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="results"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="strRole"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                          </trueStatements>
                          <falseStatements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="results"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="strRole"/>
                              </parameters>
                            </methodInvokeExpression>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <conditionStatement>
                  <condition>
                    <fieldReferenceExpression name="EnableCache"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="SetCacheItem">
                      <parameters>
                        <primitiveExpression value="R" convertTo="Char"/>
                        <primitiveExpression value="AllRoles"/>
                        <methodInvokeExpression methodName="Join">
                          <target>
                            <typeReferenceExpression type="String"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=","/>
                            <castExpression targetType="System.String[]">
                              <methodInvokeExpression methodName="ToArray">
                                <target>
                                  <variableReferenceExpression name="results"/>
                                </target>
                                <parameters>
                                  <typeofExpression type="System.String"/>
                                </parameters>
                              </methodInvokeExpression>
                            </castExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <castExpression targetType="System.String[]">
                    <methodInvokeExpression methodName="ToArray">
                      <target>
                        <variableReferenceExpression name="results"/>
                      </target>
                      <parameters>
                        <typeofExpression type="System.String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method RoleExists(string)-->
            <memberMethod returnType="System.Boolean" name="RoleExists">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="System.String" name="strRole"/>
                  <target>
                    <methodInvokeExpression methodName="GetAllRoles"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <argumentReferenceExpression name="rolename"/>
                          <variableReferenceExpression name="strRole"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <primitiveExpression value="true"/>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <primitiveExpression value="false"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method FindUsersInRole(string, string)-->
            <memberMethod returnType="System.String[]" name="FindUsersInRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
                <parameter type="System.String" name="usernameToMatch"/>
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
                          <methodInvokeExpression methodName="Format">
                            <target>
                              <typeReferenceExpression type="System.String"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="The role '{0}' was not found."/>
                              <argumentReferenceExpression name="rolename"/>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ArrayList" name="results">
                  <init>
                    <objectCreateExpression type="ArrayList"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String[]" name="roles">
                  <init>
                    <methodInvokeExpression methodName="GetAllRoles"/>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="System.String" name="role"/>
                  <target>
                    <variableReferenceExpression name="roles"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Contains">
                          <target>
                            <methodInvokeExpression methodName="ToLower">
                              <target>
                                <variableReferenceExpression name="role"/>
                              </target>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="ToLower">
                              <target>
                                <argumentReferenceExpression name="usernameToMatch"/>
                              </target>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <variableReferenceExpression name="results"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="role"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodInvokeExpression methodName="Sort">
                  <target>
                    <variableReferenceExpression name="results"/>
                  </target>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <castExpression targetType="System.String[]">
                    <methodInvokeExpression methodName="ToArray">
                      <target>
                        <variableReferenceExpression name="results"/>
                      </target>
                      <parameters>
                        <typeofExpression type="System.String"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method AddUsersToRoles(string[], string[])-->
            <memberMethod name="AddUsersToRoles">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String[]" name="usernames"/>
                <parameter type="System.String[]" name="rolenames"/>
              </parameters>
              <statements>
                <throwExceptionStatement>
                  <objectCreateExpression type="NotSupportedException">
                    <parameters>
                      <primitiveExpression value="Unable to add users to roles.  For security and management purposes, ADRoleProvider only supports read operations against Active Directory."/>
                    </parameters>
                  </objectCreateExpression>
                </throwExceptionStatement>
              </statements>
            </memberMethod>
            <!-- method CreateRole(string)-->
            <memberMethod name="CreateRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
              </parameters>
              <statements>
                <throwExceptionStatement>
                  <objectCreateExpression type="NotSupportedException">
                    <parameters>
                      <primitiveExpression value="Unable to create new role.  For security and management purposes, ADRoleProvider only supports read operations against Active Directory."/>
                    </parameters>
                  </objectCreateExpression>
                </throwExceptionStatement>
              </statements>
            </memberMethod>
            <!-- method DeleteRole(string, bool)-->
            <memberMethod returnType="System.Boolean" name="DeleteRole">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String" name="rolename"/>
                <parameter type="System.Boolean" name="throwOnPopulatedRole"/>
              </parameters>
              <statements>
                <throwExceptionStatement>
                  <objectCreateExpression type="NotSupportedException">
                    <parameters>
                      <primitiveExpression value="Unable to delete role. For security and management purposes, ADRoleProvider only supports read operations against Active Directory."/>
                    </parameters>
                  </objectCreateExpression>
                </throwExceptionStatement>
              </statements>
            </memberMethod>
            <!-- method RemoveUsersFromRoles(string[], string[])-->
            <memberMethod name="RemoveUsersFromRoles">
              <attributes public="true" override="true"/>
              <parameters>
                <parameter type="System.String[]" name="usernames"/>
                <parameter type="System.String[]" name="rolenames"/>
              </parameters>
              <statements>
                <throwExceptionStatement>
                  <objectCreateExpression type="NotSupportedException">
                    <parameters>
                      <primitiveExpression value="Unable to remove users from roles. For security and management purposes, ADRoleProvider only supports read operations against Active Directory."/>
                    </parameters>
                  </objectCreateExpression>
                </throwExceptionStatement>
              </statements>
            </memberMethod>
            <!-- method ADSearch(string, string, string)-->
            <memberMethod returnType="System.String[]" name="ADSearch">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.String" name="connectionString"/>
                <parameter type="System.String" name="filter"/>
                <parameter type="System.String" name="field"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="strResults">
                  <init>
                    <primitiveExpression value=""/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="DirectorySearcher" name="searcher">
                  <init>
                    <objectCreateExpression type="DirectorySearcher"/>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="SearchRoot">
                    <variableReferenceExpression name="searcher"/>
                  </propertyReferenceExpression>
                  <objectCreateExpression type="DirectoryEntry">
                    <parameters>
                      <argumentReferenceExpression name="connectionString"/>
                    </parameters>
                  </objectCreateExpression>
                </assignStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Filter">
                    <variableReferenceExpression name="searcher"/>
                  </propertyReferenceExpression>
                  <variableReferenceExpression name="filter"/>
                </assignStatement>
                <methodInvokeExpression methodName="Clear">
                  <target>
                    <propertyReferenceExpression name="PropertiesToLoad">
                      <variableReferenceExpression name="searcher"/>
                    </propertyReferenceExpression>
                  </target>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="PropertiesToLoad">
                      <variableReferenceExpression name="searcher"/>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="field"/>
                  </parameters>
                </methodInvokeExpression>
                <assignStatement>
                  <propertyReferenceExpression name="PageSize">
                    <variableReferenceExpression name="searcher"/>
                  </propertyReferenceExpression>
                  <primitiveExpression value="500"/>
                </assignStatement>
                <variableDeclarationStatement type="SearchResultCollection" name="results"/>
                <tryStatement>
                  <statements>
                    <assignStatement>
                      <variableReferenceExpression name="results"/>
                      <methodInvokeExpression methodName="FindAll">
                        <target>
                          <variableReferenceExpression name="searcher"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                  </statements>
                  <catch exceptionType="Exception" localName="ex">
                    <throwExceptionStatement>
                      <objectCreateExpression type="ProviderException">
                        <parameters>
                          <primitiveExpression value="Unable to query Active Directory."/>
                          <variableReferenceExpression name="ex"/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </catch>
                </tryStatement>
                <foreachStatement>
                  <variable type="SearchResult" name="result" var="false"/>
                  <target>
                    <variableReferenceExpression name="results"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="System.Int32" name="resultCount">
                      <init>
                        <propertyReferenceExpression name="Count">
                          <arrayIndexerExpression>
                            <target>
                              <propertyReferenceExpression name="Properties">
                                <variableReferenceExpression name="result"/>
                              </propertyReferenceExpression>
                            </target>
                            <indices>
                              <argumentReferenceExpression name="field"/>
                            </indices>
                          </arrayIndexerExpression>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <forStatement>
                      <variable type="System.Int32" name="c">
                        <init>
                          <primitiveExpression value="0"/>
                        </init>
                      </variable>
                      <test>
                        <binaryOperatorExpression operator="LessThan">
                          <variableReferenceExpression name="c"/>
                          <variableReferenceExpression name="resultCount"/>
                        </binaryOperatorExpression>
                      </test>
                      <increment>
                        <variableReferenceExpression name="c"/>
                      </increment>
                      <statements>
                        <variableDeclarationStatement type="System.String" name="temp">
                          <init>
                            <methodInvokeExpression methodName="ToString">
                              <target>
                                <arrayIndexerExpression>
                                  <target>
                                    <arrayIndexerExpression>
                                      <target>
                                        <propertyReferenceExpression name="Properties">
                                          <variableReferenceExpression name="result"/>
                                        </propertyReferenceExpression>
                                      </target>
                                      <indices>
                                        <argumentReferenceExpression name="field"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                  </target>
                                  <indices>
                                    <variableReferenceExpression name="c"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </target>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <assignStatement>
                          <variableReferenceExpression name="strResults"/>
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="strResults"/>
                            <binaryOperatorExpression operator="Add">
                              <variableReferenceExpression name="temp"/>
                              <primitiveExpression value="|"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </statements>
                    </forStatement>
                  </statements>
                </foreachStatement>
                <methodInvokeExpression methodName="Dispose">
                  <target>
                    <variableReferenceExpression name="results"/>
                  </target>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <propertyReferenceExpression name="Length">
                        <variableReferenceExpression name="strResults"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="strResults"/>
                      <methodInvokeExpression methodName="Substring">
                        <target>
                          <variableReferenceExpression name="strResults"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="0"/>
                          <binaryOperatorExpression operator="Subtract">
                            <propertyReferenceExpression name="Length">
                              <variableReferenceExpression name="strResults"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="1"/>
                          </binaryOperatorExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Split">
                        <target>
                          <variableReferenceExpression name="strResults"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="|" convertTo="Char"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <arrayCreateExpression>
                    <createType type="System.String"/>
                    <sizeExpression>
                      <primitiveExpression value="0"/>
                    </sizeExpression>
                  </arrayCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetCacheItem(Char, String, String)-->
            <memberMethod name="SetCacheItem">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.Char" name="itemType"/>
                <parameter type="System.String" name="itemKey"/>
                <parameter type="System.String" name="itemValue"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Cache">
                      <propertyReferenceExpression name="Current">
                        <typeReferenceExpression type="HttpContext"/>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                  </target>
                  <parameters>
                    <binaryOperatorExpression operator="Add">
                      <argumentReferenceExpression name="itemType"/>
                      <binaryOperatorExpression operator="Add">
                        <primitiveExpression value="-"/>
                        <argumentReferenceExpression name="itemKey"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                    <argumentReferenceExpression name="itemValue"/>
                    <primitiveExpression value="null"/>
                    <propertyReferenceExpression name="NoAbsoluteExpiration">
                      <typeReferenceExpression type="Cache"/>
                    </propertyReferenceExpression>
                    <methodInvokeExpression methodName="FromMinutes">
                      <target>
                        <typeReferenceExpression type="TimeSpan"/>
                      </target>
                      <parameters>
                        <convertExpression to="Double">
                          <fieldReferenceExpression name="CacheTimeoutInMinutes"/>
                        </convertExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <propertyReferenceExpression name="Default">
                      <typeReferenceExpression type="CacheItemPriority"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="null"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method GetCacheItem(Char, String)-->
            <memberMethod returnType="System.String" name="GetCacheItem">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.Char" name="itemType"/>
                <parameter type="System.String" name="itemKey"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="value">
                  <init>
                    <castExpression targetType="System.String">
                      <methodInvokeExpression methodName="Get">
                        <target>
                          <propertyReferenceExpression name="Cache">
                            <propertyReferenceExpression name="Current">
                              <typeReferenceExpression type="HttpContext"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <binaryOperatorExpression operator="Add">
                            <argumentReferenceExpression name="itemType"/>
                            <binaryOperatorExpression operator="Add">
                              <primitiveExpression value="-"/>
                              <argumentReferenceExpression name="itemKey"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <variableReferenceExpression name="value"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="value"/>
                      <primitiveExpression value="*NotCached"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="value"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ArrayListToCSString(ArrayList)-->
            <!--<memberMethod returnType="System.String" name="ArrayListToCSString">
              <attributes private="true"/>
              <parameters>
                <parameter type="ArrayList" name="inArray"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="result">
                  <init>
                    <primitiveExpression value=""/>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="System.String" name="item"/>
                  <target>
                    <argumentReferenceExpression name="inArray"/>
                  </target>
                  <statements>
                    <assignStatement>
                      <variableReferenceExpression name="result"/>
                      <binaryOperatorExpression operator="Add">
                        <variableReferenceExpression name="result"/>
                        <binaryOperatorExpression operator="Add">
                          <variableReferenceExpression name="item"/>
                          <primitiveExpression value=","/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </statements>
                </foreachStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="result"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="result"/>
                      <methodInvokeExpression methodName="Substring">
                        <target>
                          <variableReferenceExpression name="result"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="0"/>
                          <binaryOperatorExpression operator="Subtract">
                            <propertyReferenceExpression name="Length">
                              <variableReferenceExpression name="result"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="1"/>
                          </binaryOperatorExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="result"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>-->
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
