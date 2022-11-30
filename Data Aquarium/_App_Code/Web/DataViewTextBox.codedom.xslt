<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsClassLibrary" select="'false'"/>
  <xsl:param name="ScriptOnly" select="'false'"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.ComponentModel"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
        <xsl:if test="$ScriptOnly='false'">
          <namespaceImport name="AjaxControlToolkit"/>
        </xsl:if>
      </imports>
      <types>
        <!-- class DataControllerService -->
        <typeDeclaration name="DataViewTextBox">
          <baseTypes>
            <typeReference type="TextBox"/>
            <typeReference type="IScriptControl"/>
          </baseTypes>
          <members>
            <!-- property DataController -->
            <memberField type="System.String" name="dataController"/>
            <memberProperty type="System.String" name="DataController">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="Category">
                  <arguments>
                    <primitiveExpression value="Auto Complete"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="dataController"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="dataController"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property DataView -->
            <memberField type="System.String" name="dataView"/>
            <memberProperty type="System.String" name="DataView">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="Category">
                  <arguments>
                    <primitiveExpression value="Auto Complete"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="dataView"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="dataView"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property DistinctValueFieldName -->
            <memberField type="System.String" name="distinctValueFieldName"/>
            <memberProperty type="System.String" name="DistinctValueFieldName">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="Category">
                  <arguments>
                    <primitiveExpression value="Auto Complete"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="distinctValueFieldName"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="distinctValueFieldName"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property MinimumPrefixLength -->
            <memberField type="System.Int32" name="minimumPrefixLength"/>
            <memberProperty type="System.Int32" name="MinimumPrefixLength">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="Category">
                  <arguments>
                    <primitiveExpression value="Auto Complete"/>
                  </arguments>
                </customAttribute>
                <customAttribute name="DefaultValue">
                  <arguments>
                    <primitiveExpression value="1"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="minimumPrefixLength"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="minimumPrefixLength"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property CompletionInterval -->
            <memberField type="System.Int32" name="completionInterval"/>
            <memberProperty type="System.Int32" name="CompletionInterval">
              <attributes public="true" final="true"/>
              <customAttributes>
                <customAttribute name="Category">
                  <arguments>
                    <primitiveExpression value="Auto Complete"/>
                  </arguments>
                </customAttribute>
                <customAttribute name="DefaultValue">
                  <arguments>
                    <primitiveExpression value="500"/>
                  </arguments>
                </customAttribute>
              </customAttributes>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="completionInterval"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="completionInterval"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- consructor() -->
            <constructor>
              <attributes public="true"/>
              <baseConstructorArgs/>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="completionInterval"/>
                  <primitiveExpression value="500"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="minimumPrefixLength"/>
                  <primitiveExpression value="1"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- OnPreRender(EventArgs) -->
            <memberMethod name="OnPreRender">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="OnPreRender">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="e"/>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="ScriptManager" name="sm">
                  <init>
                    <methodInvokeExpression methodName="GetCurrent">
                      <target>
                        <typeReferenceExpression type="ScriptManager"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Page"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="sm"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="RegisterScriptControl">
                      <target>
                        <variableReferenceExpression name="sm"/>
                      </target>
                      <parameters>
                        <thisReferenceExpression/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="RegisterScriptDescriptors">
                      <target>
                        <variableReferenceExpression name="sm"/>
                      </target>
                      <parameters>
                        <thisReferenceExpression/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method IScriptControl.GetScriptDescriptors() -->
            <memberMethod returnType="IEnumerable" name="GetScriptDescriptors" privateImplementationType="IScriptControl">
              <typeArguments>
                <typeReference type="ScriptDescriptor"/>
              </typeArguments>
              <attributes/>
              <statements>
                <variableDeclarationStatement type="ScriptBehaviorDescriptor" name="descriptor">
                  <init>
                    <objectCreateExpression type="ScriptBehaviorDescriptor">
                      <parameters>
                        <primitiveExpression value="Sys.Extended.UI.AutoCompleteBehavior"/>
                        <propertyReferenceExpression name="ClientID"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="id"/>
                    <propertyReferenceExpression name="ClientID"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="completionInterval"/>
                    <propertyReferenceExpression name="CompletionInterval"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="contextKey"/>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}},{{1}},{{2}}"/>
                        <propertyReferenceExpression name="DataController"/>
                        <propertyReferenceExpression name="DataView"/>
                        <propertyReferenceExpression name="DistinctValueFieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="delimiterCharacters"/>
                    <primitiveExpression value=",;"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="minimumPrefixLength"/>
                    <propertyReferenceExpression name="MinimumPrefixLength"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="serviceMethod"/>
                    <primitiveExpression value="GetCompletionList"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="servicePath"/>
                    <methodInvokeExpression methodName="ResolveClientUrl">
                      <parameters>
                        <xsl:choose>
                          <xsl:when test="$IsClassLibrary='true'">
                            <primitiveExpression value="~/DAF/Service.asmx"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <primitiveExpression value="~/Services/DataControllerService.asmx"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </parameters>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <variableReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="useContextKey"/>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <arrayCreateExpression>
                    <createType type="ScriptBehaviorDescriptor"/>
                    <initializers>
                      <variableReferenceExpression name="descriptor"/>
                    </initializers>
                  </arrayCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method IScriptControl.GetScriptReferences() -->
            <memberMethod returnType="IEnumerable" name="GetScriptReferences" privateImplementationType="IScriptControl">
              <typeArguments>
                <typeReference type="ScriptReference"/>
              </typeArguments>
              <attributes/>
              <statements>
                <variableDeclarationStatement type="List" name="scripts">
                  <typeArguments>
                    <typeReference type="ScriptReference"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="ScriptReference"/>
                      </typeArguments>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <xsl:if test="$ScriptOnly='false'">
                  <methodInvokeExpression methodName="AddRange">
                    <target>
                      <variableReferenceExpression name="scripts"/>
                    </target>
                    <parameters>
                      <methodInvokeExpression methodName="GetScriptReferences">
                        <target>
                          <typeReferenceExpression type="ScriptObjectBuilder"/>
                        </target>
                        <parameters>
                          <typeofExpression type="AutoCompleteExtender"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </xsl:if>
                <methodReturnStatement>
                  <variableReferenceExpression name="scripts"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
