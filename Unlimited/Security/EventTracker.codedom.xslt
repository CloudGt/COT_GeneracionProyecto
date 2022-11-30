<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:codeontime="urn:schemas-codeontime-com:ease" exclude-result-prefixes="msxsl a codeontime"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <!--<xsl:param name="Auditing">
    <![CDATA[
Modified By User Name = ModifiedBy|updated_by
Modified By User ID      = ModifiedByUserId
Modified On Date          = ModifiedOn|updated|update_date
Created By User Name  =     CreatedBy
Created By User ID       = CreatedByUserId|CreatedById2
Created On Date           =CreatedOn|create_date]]>
  </xsl:param>-->
  <xsl:param name="Auditing" select="a:project/a:features/a:ease/a:auditing"/>

  <msxsl:script language="C#" implements-prefix="codeontime">
    <![CDATA[
    public string GetPattern(string patternName, string auditPatterns) 
    {
      try {
        Match m = Regex.Match(auditPatterns, String.Format(@"^\s*{0}\s*=(?'Pattern'.*?)$", patternName), RegexOptions.IgnoreCase | RegexOptions.Multiline);
        if (!m.Success)
          return String.Empty;
        string pattern = m.Groups["Pattern"].Value.Trim();
        if (String.IsNullOrEmpty(pattern))
          return String.Empty;
        Regex dummy = new Regex(pattern);
        return pattern;
      }
      catch (Exception) {
        return String.Empty;
      }
    }
    ]]>
  </msxsl:script>

  <xsl:variable name="ModifiedByUserName" select="codeontime:GetPattern('Modified By User Name', $Auditing)"/>
  <xsl:variable name="ModifiedByUserID" select="codeontime:GetPattern('Modified By User ID', $Auditing)"/>
  <xsl:variable name="ModifiedOnDate" select="codeontime:GetPattern('Modified On Date', $Auditing)"/>
  <xsl:variable name="CreatedByUserName" select="codeontime:GetPattern('Created By User Name', $Auditing)"/>
  <xsl:variable name="CreatedByUserID" select="codeontime:GetPattern('Created By User ID', $Auditing)"/>
  <xsl:variable name="CreatedOnDate" select="codeontime:GetPattern('Created On Date', $Auditing)"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Security">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Xml.XPath"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="{$Namespace}.Data"/>
        <namespaceImport name="{$Namespace}.Services"/>
      </imports>
      <types>
        <!-- class EventTracker -->
        <typeDeclaration name="EventTracker" isPartial="true">
          <baseTypes>
            <typeReference type="EventTrackerBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- class EventTrackerBase -->
        <typeDeclaration name="EventTrackerBase">
          <members>
            <!-- field modifiedByUserNameRegex -->
            <memberField type="Regex" name="modifiedByUserNameRegex">
              <attributes static="true" private="true"/>
              <init>
                <xsl:choose>
                  <xsl:when test="$ModifiedByUserName = ''">
                    <primitiveExpression value="null"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <objectCreateExpression type="Regex">
                      <parameters>
                        <primitiveExpression value="{$ModifiedByUserName}"/>
                        <propertyReferenceExpression name="IgnoreCase">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </xsl:otherwise>
                </xsl:choose>
              </init>
            </memberField>
            <!-- field modifiedByUserIdRegex -->
            <memberField type="Regex" name="modifiedByUserIdRegex">
              <attributes static="true" private="true"/>
              <init>
                <xsl:choose>
                  <xsl:when test="$ModifiedByUserID = ''">
                    <primitiveExpression value="null"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <objectCreateExpression type="Regex">
                      <parameters>
                        <primitiveExpression value="{$ModifiedByUserID}"/>
                        <propertyReferenceExpression name="IgnoreCase">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </xsl:otherwise>
                </xsl:choose>
              </init>
            </memberField>
            <!-- field modifiedOnRegex -->
            <memberField type="Regex" name="modifiedOnRegex">
              <attributes static="true" private="true"/>
              <init>
                <xsl:choose>
                  <xsl:when test="$ModifiedOnDate = ''">
                    <primitiveExpression value="null"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <objectCreateExpression type="Regex">
                      <parameters>
                        <primitiveExpression value="{$ModifiedOnDate}"/>
                        <propertyReferenceExpression name="IgnoreCase">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </xsl:otherwise>
                </xsl:choose>
              </init>
            </memberField>
            <!-- field createdByUserNameRegex -->
            <memberField type="Regex" name="createdByUserNameRegex">
              <attributes static="true" private="true"/>
              <init>
                <xsl:choose>
                  <xsl:when test="$CreatedByUserName = ''">
                    <primitiveExpression value="null"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <objectCreateExpression type="Regex">
                      <parameters>
                        <primitiveExpression value="{$CreatedByUserName}"/>
                        <propertyReferenceExpression name="IgnoreCase">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </xsl:otherwise>
                </xsl:choose>
              </init>
            </memberField>
            <!-- field createdByUserIdRegex -->
            <memberField type="Regex" name="createdByUserIdRegex">
              <attributes static="true" private="true"/>
              <init>
                <xsl:choose>
                  <xsl:when test="$CreatedByUserID = ''">
                    <primitiveExpression value="null"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <objectCreateExpression type="Regex">
                      <parameters>
                        <primitiveExpression value="{$CreatedByUserID}"/>
                        <propertyReferenceExpression name="IgnoreCase">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </xsl:otherwise>
                </xsl:choose>
              </init>
            </memberField>
            <!-- field createdOnRegex -->
            <memberField type="Regex" name="createdOnRegex">
              <attributes static="true" private="true"/>
              <init>
                <xsl:choose>
                  <xsl:when test="$CreatedOnDate = ''">
                    <primitiveExpression value="null"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <objectCreateExpression type="Regex">
                      <parameters>
                        <primitiveExpression value="{$CreatedOnDate}"/>
                        <propertyReferenceExpression name="IgnoreCase">
                          <typeReferenceExpression type="RegexOptions"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </xsl:otherwise>
                </xsl:choose>
              </init>
            </memberField>
            <!-- constructor EventTrackerBase() -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- IsModifiedByUserNamePattern(string) -->
            <memberMethod returnType="System.Boolean" name="IsModifiedByUserNamePattern">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanAnd">
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="modifiedByUserNameRegex"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="IsMatch">
                      <target>
                        <fieldReferenceExpression name="modifiedByUserNameRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- IsModifiedByUserIdPattern(string) -->
            <memberMethod returnType="System.Boolean" name="IsModifiedByUserIdPattern">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanAnd">
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="modifiedByUserIdRegex"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="IsMatch">
                      <target>
                        <fieldReferenceExpression name="modifiedByUserIdRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- IsModifiedOnPattern(string) -->
            <memberMethod returnType="System.Boolean" name="IsModifiedOnPattern">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanAnd">
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="modifiedOnRegex"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="IsMatch">
                      <target>
                        <fieldReferenceExpression name="modifiedOnRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- IsCreatedByUserNamePattern(string) -->
            <memberMethod returnType="System.Boolean" name="IsCreatedByUserNamePattern">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanAnd">
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="createdByUserNameRegex"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="IsMatch">
                      <target>
                        <fieldReferenceExpression name="createdByUserNameRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- IsCreatedByUserIdPattern(string) -->
            <memberMethod returnType="System.Boolean" name="IsCreatedByUserIdPattern">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanAnd">
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="createdByUserIdRegex"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="IsMatch">
                      <target>
                        <fieldReferenceExpression name="createdByUserIdRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- IsCreatedOnPattern(string) -->
            <memberMethod returnType="System.Boolean" name="IsCreatedOnPattern">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="BooleanAnd">
                    <binaryOperatorExpression operator="IdentityInequality">
                      <fieldReferenceExpression name="createdOnRegex"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                    <methodInvokeExpression methodName="IsMatch">
                      <target>
                        <fieldReferenceExpression name="createdOnRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Process(ViewPage, PageRequest) -->
            <memberMethod name="Process">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="ViewPage" name="page"/>
                <parameter type="PageRequest" name="request"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="EventTracker" name="tracker">
                  <init>
                    <objectCreateExpression type="EventTracker"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="InternalProcess">
                  <target>
                    <variableReferenceExpression name="tracker"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="page"/>
                    <argumentReferenceExpression name="request"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method IsNewRow(ViewPage, PageRequest) -->
            <memberMethod returnType="System.Boolean" name="IsNewRow">
              <attributes family="true"/>
              <parameters>
                <parameter type="ViewPage" name="page"/>
                <parameter type="PageRequest" name="request"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <propertyReferenceExpression name="Inserting">
                        <argumentReferenceExpression name="request"/>
                      </propertyReferenceExpression>
                      <binaryOperatorExpression operator="IdentityEquality">
                        <propertyReferenceExpression name="NewRow">
                          <argumentReferenceExpression name="page"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <propertyReferenceExpression name="NewRow">
                        <argumentReferenceExpression name="page"/>
                      </propertyReferenceExpression>
                      <arrayCreateExpression>
                        <createType type="System.Object"/>
                        <sizeExpression>
                          <propertyReferenceExpression name="Count">
                            <propertyReferenceExpression name="Fields">
                              <argumentReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                        </sizeExpression>
                      </arrayCreateExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Inserting">
                    <argumentReferenceExpression name="request"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method InternalProcess(ViewPage, PageRequest) -->
            <memberMethod name="InternalProcess">
              <attributes family="true"/>
              <parameters>
                <parameter type="ViewPage" name="page"/>
                <parameter type="PageRequest" name="request"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Int32" name="index">
                  <init>
                    <primitiveExpression value="0"/>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="DataField" name="field"/>
                  <target>
                    <propertyReferenceExpression name="Fields">
                      <argumentReferenceExpression name="page"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <propertyReferenceExpression name="ReadOnly">
                            <variableReferenceExpression name="field"/>
                          </propertyReferenceExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanOr">
                              <methodInvokeExpression methodName="IsCreatedByUserIdPattern">
                                <parameters>
                                  <propertyReferenceExpression name="Name">
                                    <variableReferenceExpression name="field"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                              <methodInvokeExpression methodName="IsModifiedByUserIdPattern">
                                <parameters>
                                  <propertyReferenceExpression name="Name">
                                    <variableReferenceExpression name="field"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <propertyReferenceExpression name="TextMode">
                                <variableReferenceExpression name="field"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Static">
                                <typeReferenceExpression type="TextInputMode"/>
                              </propertyReferenceExpression>
                            </assignStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanOr">
                                  <unaryOperatorExpression operator="IsNullOrEmpty">
                                    <propertyReferenceExpression name="ItemsDataController">
                                      <variableReferenceExpression name="field"/>
                                    </propertyReferenceExpression>
                                  </unaryOperatorExpression>
                                  <propertyReferenceExpression name="Inserting">
                                    <variableReferenceExpression name="request"/>
                                  </propertyReferenceExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <propertyReferenceExpression name="Hidden">
                                    <variableReferenceExpression name="field"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                              </trueStatements>
                              <falseStatements>
                                <conditionStatement>
                                  <condition>
                                    <unaryOperatorExpression operator="Not">
                                      <propertyReferenceExpression name="IsSuperUser">
                                        <typeReferenceExpression type="ApplicationServicesBase"/>
                                      </propertyReferenceExpression>
                                    </unaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <assignStatement>
                                      <propertyReferenceExpression name="Tag">
                                        <variableReferenceExpression name="field"/>
                                      </propertyReferenceExpression>
                                      <binaryOperatorExpression operator="Add">
                                        <propertyReferenceExpression name="Tag">
                                          <variableReferenceExpression name="field"/>
                                        </propertyReferenceExpression>
                                        <primitiveExpression value=" lookup-details-hidden"/>
                                      </binaryOperatorExpression>
                                    </assignStatement>
                                    <!--<conditionStatement>
                                      <condition>
                                        <unaryOperatorExpression operator="IsNotNullOrEmpty">
                                          <propertyReferenceExpression name="Email"/>
                                        </unaryOperatorExpression>
                                      </condition>
                                      <trueStatements>
                                        <variableDeclarationStatement name="emailField">
                                          <init>
                                            <variableReferenceExpression name="field"/>
                                          </init>
                                        </variableDeclarationStatement>
                                        <conditionStatement>
                                          <condition>
                                            <unaryOperatorExpression operator="IsNotNullOrEmpty">
                                              <propertyReferenceExpression name="AliasName">
                                                <variableReferenceExpression name="field"/>
                                              </propertyReferenceExpression>
                                            </unaryOperatorExpression>
                                          </condition>
                                          <trueStatements>
                                            <assignStatement>
                                              <variableReferenceExpression name="emailField"/>
                                              <methodInvokeExpression methodName="FindField">
                                                <target>
                                                  <argumentReferenceExpression name="page"/>
                                                </target>
                                                <parameters>
                                                  <propertyReferenceExpression name="AliasName">
                                                    <variableReferenceExpression name="field"/>
                                                  </propertyReferenceExpression>
                                                </parameters>
                                              </methodInvokeExpression>
                                            </assignStatement>
                                          </trueStatements>
                                        </conditionStatement>
                                        <conditionStatement>
                                          <condition>
                                            <unaryOperatorExpression operator="IsNullOrEmpty">
                                              <propertyReferenceExpression name="HyperlinkFormatString">
                                                <variableReferenceExpression name="emailField"/>
                                              </propertyReferenceExpression>
                                            </unaryOperatorExpression>
                                          </condition>
                                          <trueStatements>
                                            <assignStatement>
                                              <propertyReferenceExpression name="HyperlinkFormatString">
                                                <variableReferenceExpression name="emailField"/>
                                              </propertyReferenceExpression>
                                              <stringFormatExpression format="mailto:{{0}}">
                                                <propertyReferenceExpression name="Email"/>
                                              </stringFormatExpression>
                                            </assignStatement>
                                          </trueStatements>
                                        </conditionStatement>
                                      </trueStatements>
                                    </conditionStatement>-->
                                  </trueStatements>
                                </conditionStatement>
                              </falseStatements>
                            </conditionStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanAnd">
                                  <methodInvokeExpression methodName="IsNewRow">
                                    <parameters>
                                      <argumentReferenceExpression name="page"/>
                                      <argumentReferenceExpression name="request"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                  <binaryOperatorExpression operator="IdentityEquality">
                                    <arrayIndexerExpression>
                                      <target>
                                        <propertyReferenceExpression name="NewRow">
                                          <argumentReferenceExpression name="page"/>
                                        </propertyReferenceExpression>
                                      </target>
                                      <indices>
                                        <variableReferenceExpression name="index"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                    <primitiveExpression value="null"/>
                                  </binaryOperatorExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <arrayIndexerExpression>
                                    <target>
                                      <propertyReferenceExpression name="NewRow">
                                        <argumentReferenceExpression name="page"/>
                                      </propertyReferenceExpression>
                                    </target>
                                    <indices>
                                      <variableReferenceExpression name="index"/>
                                    </indices>
                                  </arrayIndexerExpression>
                                  <propertyReferenceExpression name="UserId"/>
                                </assignStatement>
                              </trueStatements>
                            </conditionStatement>
                          </trueStatements>
                          <falseStatements>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanOr">
                                  <methodInvokeExpression methodName="IsCreatedByUserNamePattern">
                                    <parameters>
                                      <propertyReferenceExpression name="Name">
                                        <variableReferenceExpression name="field"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                  <methodInvokeExpression methodName="IsModifiedByUserNamePattern">
                                    <parameters>
                                      <propertyReferenceExpression name="Name">
                                        <variableReferenceExpression name="field"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <propertyReferenceExpression name="TextMode">
                                    <variableReferenceExpression name="field"/>
                                  </propertyReferenceExpression>
                                  <propertyReferenceExpression name="Static">
                                    <typeReferenceExpression type="TextInputMode"/>
                                  </propertyReferenceExpression>
                                </assignStatement>
                                <!--<conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="BooleanAnd">
                                      <unaryOperatorExpression operator="IsNotNullOrEmpty">
                                        <propertyReferenceExpression name="Email"/>
                                      </unaryOperatorExpression>
                                      <unaryOperatorExpression operator="IsNullOrEmpty">
                                        <propertyReferenceExpression name="HyperlinkFormatString">
                                          <variableReferenceExpression name="field"/>
                                        </propertyReferenceExpression>
                                      </unaryOperatorExpression>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <assignStatement>
                                      <propertyReferenceExpression name="HyperlinkFormatString">
                                        <variableReferenceExpression name="field"/>
                                      </propertyReferenceExpression>
                                      <stringFormatExpression format="mailto:{{0}}">
                                        <propertyReferenceExpression name="Email"/>
                                      </stringFormatExpression>
                                    </assignStatement>
                                  </trueStatements>
                                </conditionStatement>-->
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="BooleanAnd">
                                      <methodInvokeExpression methodName="IsNewRow">
                                        <parameters>
                                          <argumentReferenceExpression name="page"/>
                                          <argumentReferenceExpression name="request"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                      <binaryOperatorExpression operator="IdentityEquality">
                                        <arrayIndexerExpression>
                                          <target>
                                            <propertyReferenceExpression name="NewRow">
                                              <argumentReferenceExpression name="page"/>
                                            </propertyReferenceExpression>
                                          </target>
                                          <indices>
                                            <variableReferenceExpression name="index"/>
                                          </indices>
                                        </arrayIndexerExpression>
                                        <primitiveExpression value="null"/>
                                      </binaryOperatorExpression>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <assignStatement>
                                      <arrayIndexerExpression>
                                        <target>
                                          <propertyReferenceExpression name="NewRow">
                                            <argumentReferenceExpression name="page"/>
                                          </propertyReferenceExpression>
                                        </target>
                                        <indices>
                                          <variableReferenceExpression name="index"/>
                                        </indices>
                                      </arrayIndexerExpression>
                                      <propertyReferenceExpression name="UserName"/>
                                    </assignStatement>
                                  </trueStatements>
                                </conditionStatement>
                              </trueStatements>
                              <falseStatements>
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="BooleanOr">
                                      <methodInvokeExpression methodName="IsCreatedOnPattern">
                                        <parameters>
                                          <propertyReferenceExpression name="Name">
                                            <variableReferenceExpression name="field"/>
                                          </propertyReferenceExpression>
                                        </parameters>
                                      </methodInvokeExpression>
                                      <methodInvokeExpression methodName="IsModifiedOnPattern">
                                        <parameters>
                                          <propertyReferenceExpression name="Name">
                                            <variableReferenceExpression name="field"/>
                                          </propertyReferenceExpression>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <assignStatement>
                                      <propertyReferenceExpression name="TextMode">
                                        <variableReferenceExpression name="field"/>
                                      </propertyReferenceExpression>
                                      <propertyReferenceExpression name="Static">
                                        <typeReferenceExpression type="TextInputMode"/>
                                      </propertyReferenceExpression>
                                    </assignStatement>
                                    <assignStatement>
                                      <propertyReferenceExpression name="DataFormatString">
                                        <variableReferenceExpression name="field"/>
                                      </propertyReferenceExpression>
                                      <propertyReferenceExpression name="DateTimeFormatString"/>
                                    </assignStatement>
                                    <conditionStatement>
                                      <condition>
                                        <propertyReferenceExpression name="Inserting">
                                          <argumentReferenceExpression name="request"/>
                                        </propertyReferenceExpression>
                                      </condition>
                                      <trueStatements>
                                        <assignStatement>
                                          <propertyReferenceExpression name="Hidden">
                                            <variableReferenceExpression name="field"/>
                                          </propertyReferenceExpression>
                                          <primitiveExpression value="true"/>
                                        </assignStatement>
                                      </trueStatements>
                                    </conditionStatement>
                                    <conditionStatement>
                                      <condition>
                                        <binaryOperatorExpression operator="BooleanAnd">
                                          <methodInvokeExpression methodName="IsNewRow">
                                            <parameters>
                                              <argumentReferenceExpression name="page"/>
                                              <argumentReferenceExpression name="request"/>
                                            </parameters>
                                          </methodInvokeExpression>
                                          <binaryOperatorExpression operator="IdentityEquality">
                                            <arrayIndexerExpression>
                                              <target>
                                                <propertyReferenceExpression name="NewRow">
                                                  <argumentReferenceExpression name="page"/>
                                                </propertyReferenceExpression>
                                              </target>
                                              <indices>
                                                <variableReferenceExpression name="index"/>
                                              </indices>
                                            </arrayIndexerExpression>
                                            <primitiveExpression value="null"/>
                                          </binaryOperatorExpression>
                                        </binaryOperatorExpression>
                                      </condition>
                                      <trueStatements>
                                        <assignStatement>
                                          <arrayIndexerExpression>
                                            <target>
                                              <propertyReferenceExpression name="NewRow">
                                                <argumentReferenceExpression name="page"/>
                                              </propertyReferenceExpression>
                                            </target>
                                            <indices>
                                              <variableReferenceExpression name="index"/>
                                            </indices>
                                          </arrayIndexerExpression>
                                          <propertyReferenceExpression name="Now">
                                            <typeReferenceExpression type="DateTime"/>
                                          </propertyReferenceExpression>
                                        </assignStatement>
                                      </trueStatements>
                                    </conditionStatement>
                                  </trueStatements>
                                </conditionStatement>
                              </falseStatements>
                            </conditionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <assignStatement>
                      <variableReferenceExpression name="index"/>
                      <binaryOperatorExpression operator="Add">
                        <variableReferenceExpression name="index"/>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </statements>
                </foreachStatement>
              </statements>
            </memberMethod>
            <!-- method Process(ActionArgs, ControllerConfiguration) -->
            <memberMethod name="Process">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="ActionArgs" name="args"/>
                <parameter type="ControllerConfiguration" name="config"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="CommandName">
                          <argumentReferenceExpression name="args"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="Update"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="CommandName">
                          <argumentReferenceExpression name="args"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="Insert"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="EventTracker" name="tracker">
                      <init>
                        <objectCreateExpression type="EventTracker"/>
                      </init>
                    </variableDeclarationStatement>
                    <methodInvokeExpression methodName="InternalProcess">
                      <target>
                        <variableReferenceExpression name="tracker"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="args"/>
                        <argumentReferenceExpression name="config"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method InternalProcess(ActionArgs, ControllerConfiguration) -->
            <memberMethod name="InternalProcess">
              <attributes family="true"/>
              <parameters>
                <parameter type="ActionArgs" name="args"/>
                <parameter type="ControllerConfiguration" name="config"/>
              </parameters>
              <statements>
                <variableDeclarationStatement  name="updating">
                  <init>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="CommandName">
                        <argumentReferenceExpression name="args"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="Update"/>
                    </binaryOperatorExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement  type="System.Boolean" name="hasCreatedByUserId">
                  <init>
                    <variableReferenceExpression name="updating"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasCreatedByUserName">
                  <init>
                    <variableReferenceExpression name="updating"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasCreatedOn">
                  <init>
                    <variableReferenceExpression name="updating"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasModifiedByUserId">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasModifiedByUserName">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasModifiedOn">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <comment>assign tracking values to field values passed from the client</comment>
                <foreachStatement>
                  <variable type="FieldValue" name="v"/>
                  <target>
                    <propertyReferenceExpression name="Values">
                      <argumentReferenceExpression name="args"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <propertyReferenceExpression name="ReadOnly">
                            <variableReferenceExpression name="v"/>
                          </propertyReferenceExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <unaryOperatorExpression operator="Not">
                                <variableReferenceExpression name="hasCreatedByUserId"/>
                              </unaryOperatorExpression>
                              <methodInvokeExpression methodName="IsCreatedByUserIdPattern">
                                <parameters>
                                  <propertyReferenceExpression name="Name">
                                    <variableReferenceExpression name="v"/>
                                  </propertyReferenceExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasCreatedByUserId"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="IdentityEquality">
                                  <propertyReferenceExpression name="Value">
                                    <variableReferenceExpression name="v"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="null"/>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <propertyReferenceExpression name="NewValue">
                                    <variableReferenceExpression name="v"/>
                                  </propertyReferenceExpression>
                                  <propertyReferenceExpression name="UserId"/>
                                </assignStatement>
                                <assignStatement>
                                  <propertyReferenceExpression name="Modified">
                                    <variableReferenceExpression name="v"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                              </trueStatements>
                            </conditionStatement>
                          </trueStatements>
                          <falseStatements>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanAnd">
                                  <unaryOperatorExpression operator="Not">
                                    <variableReferenceExpression name="hasCreatedByUserName"/>
                                  </unaryOperatorExpression>
                                  <methodInvokeExpression methodName="IsCreatedByUserNamePattern">
                                    <parameters>
                                      <propertyReferenceExpression name="Name">
                                        <variableReferenceExpression name="v"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="hasCreatedByUserName"/>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="IdentityEquality">
                                      <propertyReferenceExpression name="Value">
                                        <variableReferenceExpression name="v"/>
                                      </propertyReferenceExpression>
                                      <primitiveExpression value="null"/>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <assignStatement>
                                      <propertyReferenceExpression name="NewValue">
                                        <variableReferenceExpression name="v"/>
                                      </propertyReferenceExpression>
                                      <propertyReferenceExpression name="UserName"/>
                                    </assignStatement>
                                    <assignStatement>
                                      <propertyReferenceExpression name="Modified">
                                        <variableReferenceExpression name="v"/>
                                      </propertyReferenceExpression>
                                      <primitiveExpression value="true"/>
                                    </assignStatement>
                                  </trueStatements>
                                </conditionStatement>
                              </trueStatements>
                              <falseStatements>
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="BooleanAnd">
                                      <unaryOperatorExpression operator="Not">
                                        <variableReferenceExpression name="hasCreatedOn"/>
                                      </unaryOperatorExpression>
                                      <methodInvokeExpression methodName="IsCreatedOnPattern">
                                        <parameters>
                                          <propertyReferenceExpression name="Name">
                                            <variableReferenceExpression name="v"/>
                                          </propertyReferenceExpression>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <assignStatement>
                                      <variableReferenceExpression name="hasCreatedOn"/>
                                      <primitiveExpression value="true"/>
                                    </assignStatement>
                                    <conditionStatement>
                                      <condition>
                                        <binaryOperatorExpression operator="IdentityEquality">
                                          <propertyReferenceExpression name="Value">
                                            <variableReferenceExpression name="v"/>
                                          </propertyReferenceExpression>
                                          <primitiveExpression value="null"/>
                                        </binaryOperatorExpression>
                                      </condition>
                                      <trueStatements>
                                        <assignStatement>
                                          <propertyReferenceExpression name="NewValue">
                                            <variableReferenceExpression name="v"/>
                                          </propertyReferenceExpression>
                                          <propertyReferenceExpression name="Now">
                                            <typeReferenceExpression type="DateTime"/>
                                          </propertyReferenceExpression>
                                        </assignStatement>
                                        <assignStatement>
                                          <propertyReferenceExpression name="Modified">
                                            <variableReferenceExpression name="v"/>
                                          </propertyReferenceExpression>
                                          <primitiveExpression value="true"/>
                                        </assignStatement>
                                      </trueStatements>
                                    </conditionStatement>
                                  </trueStatements>
                                  <falseStatements>
                                    <conditionStatement>
                                      <condition>
                                        <binaryOperatorExpression operator="BooleanAnd">
                                          <unaryOperatorExpression operator="Not">
                                            <variableReferenceExpression name="hasModifiedByUserId"/>
                                          </unaryOperatorExpression>
                                          <methodInvokeExpression methodName="IsModifiedByUserIdPattern">
                                            <parameters>
                                              <propertyReferenceExpression name="Name">
                                                <variableReferenceExpression name="v"/>
                                              </propertyReferenceExpression>
                                            </parameters>
                                          </methodInvokeExpression>
                                        </binaryOperatorExpression>
                                      </condition>
                                      <trueStatements>
                                        <assignStatement>
                                          <variableReferenceExpression name="hasModifiedByUserId"/>
                                          <primitiveExpression value="true"/>
                                        </assignStatement>
                                        <assignStatement>
                                          <propertyReferenceExpression name="NewValue">
                                            <variableReferenceExpression name="v"/>
                                          </propertyReferenceExpression>
                                          <propertyReferenceExpression name="UserId"/>
                                        </assignStatement>
                                        <assignStatement>
                                          <propertyReferenceExpression name="Modified">
                                            <variableReferenceExpression name="v"/>
                                          </propertyReferenceExpression>
                                          <primitiveExpression value="true"/>
                                        </assignStatement>
                                      </trueStatements>
                                      <falseStatements>
                                        <conditionStatement>
                                          <condition>
                                            <binaryOperatorExpression operator="BooleanAnd">
                                              <unaryOperatorExpression operator="Not">
                                                <variableReferenceExpression name="hasModifiedByUserName"/>
                                              </unaryOperatorExpression>
                                              <methodInvokeExpression methodName="IsModifiedByUserNamePattern">
                                                <parameters>
                                                  <propertyReferenceExpression name="Name">
                                                    <variableReferenceExpression name="v"/>
                                                  </propertyReferenceExpression>
                                                </parameters>
                                              </methodInvokeExpression>
                                            </binaryOperatorExpression>
                                          </condition>
                                          <trueStatements>
                                            <assignStatement>
                                              <variableReferenceExpression name="hasModifiedByUserName"/>
                                              <primitiveExpression value="true"/>
                                            </assignStatement>
                                            <assignStatement>
                                              <propertyReferenceExpression name="NewValue">
                                                <variableReferenceExpression name="v"/>
                                              </propertyReferenceExpression>
                                              <propertyReferenceExpression name="UserName"/>
                                            </assignStatement>
                                            <assignStatement>
                                              <propertyReferenceExpression name="Modified">
                                                <variableReferenceExpression name="v"/>
                                              </propertyReferenceExpression>
                                              <primitiveExpression value="true"/>
                                            </assignStatement>
                                          </trueStatements>
                                          <falseStatements>
                                            <conditionStatement>
                                              <condition>
                                                <binaryOperatorExpression operator="BooleanAnd">
                                                  <unaryOperatorExpression operator="Not">
                                                    <variableReferenceExpression name="hasModifiedOn"/>
                                                  </unaryOperatorExpression>
                                                  <methodInvokeExpression methodName="IsModifiedOnPattern">
                                                    <parameters>
                                                      <propertyReferenceExpression name="Name">
                                                        <variableReferenceExpression name="v"/>
                                                      </propertyReferenceExpression>
                                                    </parameters>
                                                  </methodInvokeExpression>
                                                </binaryOperatorExpression>
                                              </condition>
                                              <trueStatements>
                                                <assignStatement>
                                                  <variableReferenceExpression name="hasModifiedOn"/>
                                                  <primitiveExpression value="true"/>
                                                </assignStatement>
                                                <assignStatement>
                                                  <propertyReferenceExpression name="NewValue">
                                                    <variableReferenceExpression name="v"/>
                                                  </propertyReferenceExpression>
                                                  <propertyReferenceExpression name="Now">
                                                    <typeReferenceExpression type="DateTime"/>
                                                  </propertyReferenceExpression>
                                                </assignStatement>
                                                <assignStatement>
                                                  <propertyReferenceExpression name="Modified">
                                                    <variableReferenceExpression name="v"/>
                                                  </propertyReferenceExpression>
                                                  <primitiveExpression value="true"/>
                                                </assignStatement>
                                              </trueStatements>
                                            </conditionStatement>
                                          </falseStatements>
                                        </conditionStatement>
                                      </falseStatements>
                                    </conditionStatement>
                                  </falseStatements>
                                </conditionStatement>
                              </falseStatements>
                            </conditionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <comment>assign missing tracking values</comment>
                <variableDeclarationStatement type="List" name="values">
                  <typeArguments>
                    <typeReference type="FieldValue"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="FieldValue"/>
                      </typeArguments>
                      <parameters>
                        <propertyReferenceExpression name="Values">
                          <argumentReferenceExpression name="args"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="XPathNodeIterator" name="fieldIterator">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <target>
                        <argumentReferenceExpression name="config"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="/c:dataController/c:fields/c:field[not(@readOnly='true')]"/>
                        <!--<propertyReferenceExpression name="Resolver">
                          <argumentReferenceExpression name="config"/>
                        </propertyReferenceExpression>-->
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <whileStatement>
                  <test>
                    <methodInvokeExpression methodName="MoveNext">
                      <target>
                        <variableReferenceExpression name="fieldIterator"/>
                      </target>
                    </methodInvokeExpression>
                  </test>
                  <statements>
                    <variableDeclarationStatement type="System.String" name="fieldName">
                      <init>
                        <methodInvokeExpression methodName="GetAttribute">
                          <target>
                            <propertyReferenceExpression name="Current">
                              <argumentReferenceExpression name="fieldIterator"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="name"/>
                            <propertyReferenceExpression name="Empty">
                              <typeReferenceExpression type="String"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <comment>ensure that missing "created" values are provided</comment>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="CommandName">
                            <argumentReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="Insert"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <unaryOperatorExpression operator="Not">
                                <variableReferenceExpression name="hasCreatedByUserId"/>
                              </unaryOperatorExpression>
                              <methodInvokeExpression methodName="IsCreatedByUserIdPattern">
                                <parameters>
                                  <variableReferenceExpression name="fieldName"/>
                                </parameters>
                              </methodInvokeExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasCreatedByUserId"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                            <variableDeclarationStatement type="FieldValue" name="v">
                              <init>
                                <objectCreateExpression type="FieldValue">
                                  <parameters>
                                    <variableReferenceExpression name="fieldName"/>
                                    <propertyReferenceExpression name="UserId"/>
                                  </parameters>
                                </objectCreateExpression>
                              </init>
                            </variableDeclarationStatement>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="values"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="v"/>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                          <falseStatements>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanAnd">
                                  <unaryOperatorExpression operator="Not">
                                    <variableReferenceExpression name="hasCreatedByUserName"/>
                                  </unaryOperatorExpression>
                                  <methodInvokeExpression methodName="IsCreatedByUserNamePattern">
                                    <parameters>
                                      <variableReferenceExpression name="fieldName"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="hasCreatedByUserName"/>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                                <variableDeclarationStatement type="FieldValue" name="v">
                                  <init>
                                    <objectCreateExpression type="FieldValue">
                                      <parameters>
                                        <variableReferenceExpression name="fieldName"/>
                                        <propertyReferenceExpression name="UserName"/>
                                      </parameters>
                                    </objectCreateExpression>
                                  </init>
                                </variableDeclarationStatement>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="values"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="v"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                              <falseStatements>
                                <conditionStatement>
                                  <condition>
                                    <binaryOperatorExpression operator="BooleanAnd">
                                      <unaryOperatorExpression operator="Not">
                                        <variableReferenceExpression name="hasCreatedOn"/>
                                      </unaryOperatorExpression>
                                      <methodInvokeExpression methodName="IsCreatedOnPattern">
                                        <parameters>
                                          <variableReferenceExpression name="fieldName"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </binaryOperatorExpression>
                                  </condition>
                                  <trueStatements>
                                    <assignStatement>
                                      <variableReferenceExpression name="hasCreatedOn"/>
                                      <primitiveExpression value="true"/>
                                    </assignStatement>
                                    <variableDeclarationStatement type="FieldValue" name="v">
                                      <init>
                                        <objectCreateExpression type="FieldValue">
                                          <parameters>
                                            <variableReferenceExpression name="fieldName"/>
                                            <propertyReferenceExpression name="Now">
                                              <typeReferenceExpression type="DateTime"/>
                                            </propertyReferenceExpression>
                                          </parameters>
                                        </objectCreateExpression>
                                      </init>
                                    </variableDeclarationStatement>
                                    <methodInvokeExpression methodName="Add">
                                      <target>
                                        <variableReferenceExpression name="values"/>
                                      </target>
                                      <parameters>
                                        <variableReferenceExpression name="v"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </trueStatements>
                                </conditionStatement>
                              </falseStatements>
                            </conditionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <comment>ensure that missing "modified" values are provided</comment>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <variableReferenceExpression name="hasModifiedByUserId"/>
                          </unaryOperatorExpression>
                          <methodInvokeExpression methodName="IsModifiedByUserIdPattern">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="hasModifiedByUserId"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                        <variableDeclarationStatement type="FieldValue" name="v">
                          <init>
                            <objectCreateExpression type="FieldValue">
                              <parameters>
                                <variableReferenceExpression name="fieldName"/>
                                <propertyReferenceExpression name="UserId"/>
                              </parameters>
                            </objectCreateExpression>
                          </init>
                        </variableDeclarationStatement>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <variableReferenceExpression name="values"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="v"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <unaryOperatorExpression operator="Not">
                                <variableReferenceExpression name="hasModifiedByUserName"/>
                              </unaryOperatorExpression>
                              <methodInvokeExpression methodName="IsModifiedByUserNamePattern">
                                <parameters>
                                  <variableReferenceExpression name="fieldName"/>
                                </parameters>
                              </methodInvokeExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasModifiedByUserName"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                            <variableDeclarationStatement type="FieldValue" name="v">
                              <init>
                                <objectCreateExpression type="FieldValue">
                                  <parameters>
                                    <variableReferenceExpression name="fieldName"/>
                                    <propertyReferenceExpression name="UserName"/>
                                  </parameters>
                                </objectCreateExpression>
                              </init>
                            </variableDeclarationStatement>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="values"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="v"/>
                              </parameters>
                            </methodInvokeExpression>
                          </trueStatements>
                          <falseStatements>
                            <conditionStatement>
                              <condition>
                                <binaryOperatorExpression operator="BooleanAnd">
                                  <unaryOperatorExpression operator="Not">
                                    <variableReferenceExpression name="hasModifiedOn"/>
                                  </unaryOperatorExpression>
                                  <methodInvokeExpression methodName="IsModifiedOnPattern">
                                    <parameters>
                                      <variableReferenceExpression name="fieldName"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </binaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <assignStatement>
                                  <variableReferenceExpression name="hasModifiedOn"/>
                                  <primitiveExpression value="true"/>
                                </assignStatement>
                                <variableDeclarationStatement type="FieldValue" name="v">
                                  <init>
                                    <objectCreateExpression type="FieldValue">
                                      <parameters>
                                        <variableReferenceExpression name="fieldName"/>
                                        <propertyReferenceExpression name="Now">
                                          <typeReferenceExpression type="DateTime"/>
                                        </propertyReferenceExpression>
                                      </parameters>
                                    </objectCreateExpression>
                                  </init>
                                </variableDeclarationStatement>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="values"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="v"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                          </falseStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </whileStatement>
                <assignStatement>
                  <propertyReferenceExpression name="Values">
                    <argumentReferenceExpression name="args"/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="ToArray">
                    <target>
                      <variableReferenceExpression name="values"/>
                    </target>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </memberMethod>
            <!-- method EnsureTrackingFields(ViewPage, ControllerConfiguration) -->
            <memberMethod name="EnsureTrackingFields">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="ViewPage" name="page"/>
                <parameter type="ControllerConfiguration" name="config"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="EventTracker" name="tracker">
                  <init>
                    <objectCreateExpression type="EventTracker"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="InternalEnsureTrackingFields">
                  <target>
                    <variableReferenceExpression name="tracker"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="page"/>
                    <argumentReferenceExpression name="config"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
            <!-- method InternalEnsureTrackingFields(ViewPage, ControllerConfiguration) -->
            <memberMethod name="InternalEnsureTrackingFields">
              <attributes family="true"/>
              <parameters>
                <parameter type="ViewPage" name="page"/>
                <parameter type="ControllerConfiguration" name="config"/>
              </parameters>
              <statements>
                <variableDeclarationStatement  type="System.Boolean" name="hasCreatedByUserId">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasCreatedByUserName">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasCreatedOn">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasModifiedByUserId">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasModifiedByUserName">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="hasModifiedOn">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <comment>detect missing tracking fields</comment>
                <foreachStatement>
                  <variable type="DataField" name="field"/>
                  <target>
                    <propertyReferenceExpression name="Fields">
                      <argumentReferenceExpression name="page"/>
                    </propertyReferenceExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <propertyReferenceExpression name="ReadOnly">
                            <variableReferenceExpression name="field"/>
                          </propertyReferenceExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="IsCreatedByUserIdPattern">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasCreatedByUserId"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="IsCreatedByUserNamePattern">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasCreatedByUserName"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="IsCreatedOnPattern">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasCreatedOn"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="IsModifiedByUserIdPattern">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasModifiedByUserId"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="IsModifiedByUserNamePattern">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasModifiedByUserName"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <methodInvokeExpression methodName="IsModifiedOnPattern">
                              <parameters>
                                <propertyReferenceExpression name="Name">
                                  <variableReferenceExpression name="field"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="hasModifiedOn"/>
                              <primitiveExpression value="true"/>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <comment>Create DataField instances for missing tracking fields</comment>
                <variableDeclarationStatement type="XPathNodeIterator" name="fieldIterator">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <target>
                        <argumentReferenceExpression name="config"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="/c:dataController/c:fields/c:field[not(@readOnly='true')]"/>
                        <!--<propertyReferenceExpression name="Resolver">
                          <argumentReferenceExpression name="config"/>
                        </propertyReferenceExpression>-->
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <whileStatement>
                  <test>
                    <methodInvokeExpression methodName="MoveNext">
                      <target>
                        <variableReferenceExpression name="fieldIterator"/>
                      </target>
                    </methodInvokeExpression>
                  </test>
                  <statements>
                    <variableDeclarationStatement type="System.String" name="fieldName">
                      <init>
                        <methodInvokeExpression methodName="GetAttribute">
                          <target>
                            <propertyReferenceExpression name="Current">
                              <argumentReferenceExpression name="fieldIterator"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="name"/>
                            <propertyReferenceExpression name="Empty">
                              <typeReferenceExpression type="String"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <comment>ensure that missing "created" data fields are declared</comment>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <variableReferenceExpression name="hasCreatedByUserId"/>
                          </unaryOperatorExpression>
                          <methodInvokeExpression methodName="IsCreatedByUserIdPattern">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <propertyReferenceExpression name="Fields">
                              <argumentReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <objectCreateExpression type="DataField">
                              <parameters>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="fieldIterator"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Resolver">
                                  <argumentReferenceExpression name="config"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="hasCreatedByUserId"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <variableReferenceExpression name="hasCreatedByUserName"/>
                          </unaryOperatorExpression>
                          <methodInvokeExpression methodName="IsCreatedByUserNamePattern">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <propertyReferenceExpression name="Fields">
                              <argumentReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <objectCreateExpression type="DataField">
                              <parameters>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="fieldIterator"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Resolver">
                                  <argumentReferenceExpression name="config"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="hasCreatedByUserName"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <variableReferenceExpression name="hasCreatedOn"/>
                          </unaryOperatorExpression>
                          <methodInvokeExpression methodName="IsCreatedOnPattern">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <propertyReferenceExpression name="Fields">
                              <argumentReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <objectCreateExpression type="DataField">
                              <parameters>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="fieldIterator"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Resolver">
                                  <argumentReferenceExpression name="config"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="hasCreatedOn"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <comment>ensure that missing "modified" data fields are declared</comment>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <variableReferenceExpression name="hasModifiedByUserId"/>
                          </unaryOperatorExpression>
                          <methodInvokeExpression methodName="IsModifiedByUserIdPattern">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <propertyReferenceExpression name="Fields">
                              <argumentReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <objectCreateExpression type="DataField">
                              <parameters>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="fieldIterator"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Resolver">
                                  <argumentReferenceExpression name="config"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="hasModifiedByUserId"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <variableReferenceExpression name="hasModifiedByUserName"/>
                          </unaryOperatorExpression>
                          <methodInvokeExpression methodName="IsModifiedByUserNamePattern">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <propertyReferenceExpression name="Fields">
                              <argumentReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <objectCreateExpression type="DataField">
                              <parameters>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="fieldIterator"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Resolver">
                                  <argumentReferenceExpression name="config"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="hasModifiedByUserName"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <unaryOperatorExpression operator="Not">
                            <variableReferenceExpression name="hasModifiedOn"/>
                          </unaryOperatorExpression>
                          <methodInvokeExpression methodName="IsModifiedOnPattern">
                            <parameters>
                              <variableReferenceExpression name="fieldName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Add">
                          <target>
                            <propertyReferenceExpression name="Fields">
                              <argumentReferenceExpression name="page"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <objectCreateExpression type="DataField">
                              <parameters>
                                <propertyReferenceExpression name="Current">
                                  <variableReferenceExpression name="fieldIterator"/>
                                </propertyReferenceExpression>
                                <propertyReferenceExpression name="Resolver">
                                  <argumentReferenceExpression name="config"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </objectCreateExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="hasModifiedOn"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </whileStatement>
              </statements>
            </memberMethod>
            <!-- property Email -->
            <memberField type="System.String" name="email"/>
            <memberProperty type="System.String" name="Email">
              <attributes public="true"/>
              <getStatements>
                <methodInvokeExpression methodName="EnsureMembershipUserProperties"/>
                <methodReturnStatement>
                  <fieldReferenceExpression name="email"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property UserId -->
            <memberField type="System.Object" name="userId"/>
            <memberProperty type="System.Object" name="UserId">
              <attributes public="true"/>
              <getStatements>
                <methodInvokeExpression methodName="EnsureMembershipUserProperties"/>
                <methodReturnStatement>
                  <fieldReferenceExpression name="userId"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method EnsureMembershipUserProperties -->
            <memberMethod name="EnsureMembershipUserProperties">
              <attributes family="true" final="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <fieldReferenceExpression name="userId"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="userId"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="Guid"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <propertyReferenceExpression name="IsAuthenticated">
                            <propertyReferenceExpression name="Identity">
                              <propertyReferenceExpression name="User">
                                <propertyReferenceExpression name="Current">
                                  <typeReferenceExpression type="HttpContext"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="Equals">
                              <target>
                                <methodInvokeExpression methodName="GetType">
                                  <target>
                                    <propertyReferenceExpression name="Identity">
                                      <propertyReferenceExpression name="User">
                                        <propertyReferenceExpression name="Current">
                                          <typeReferenceExpression type="HttpContext"/>
                                        </propertyReferenceExpression>
                                      </propertyReferenceExpression>
                                    </propertyReferenceExpression>
                                  </target>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <typeofExpression type="System.Security.Principal.WindowsIdentity"/>
                              </parameters>
                            </methodInvokeExpression>
                          </unaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="MembershipUser" name="user">
                          <init>
                            <methodInvokeExpression methodName="GetUser">
                              <target>
                                <typeReferenceExpression type="Membership"/>
                              </target>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <assignStatement>
                          <fieldReferenceExpression name="userId"/>
                          <methodInvokeExpression methodName="ToString">
                            <target>
                              <typeReferenceExpression type="Convert"/>
                            </target>
                            <parameters>
                              <propertyReferenceExpression name="ProviderUserKey">
                                <variableReferenceExpression name="user"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <assignStatement>
                          <fieldReferenceExpression name="email"/>
                          <propertyReferenceExpression name="Email">
                            <variableReferenceExpression name="user"/>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- property UserName -->
            <memberProperty type="System.String" name="UserName">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Name">
                    <propertyReferenceExpression name="Identity">
                      <propertyReferenceExpression name="User">
                        <propertyReferenceExpression name="Current">
                          <typeReferenceExpression type="HttpContext"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property DateTimeFormatString -->
            <memberProperty type="System.String" name="DateTimeFormatString">
              <attributes public="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="{{0:g}}"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
