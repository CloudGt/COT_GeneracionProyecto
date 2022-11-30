<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsClassLibrary" select="'false'"/>
  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <xsl:param name="ScriptOnly" select="'false'"/>
  <xsl:param name="Theme" select="'Aquarium'"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <!--<namespaceImport name="System.Data"/>
        <namespaceImport name="System.Collections.Generic"/>-->
        <namespaceImport name="System.ComponentModel"/>
        <!--<namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>-->
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <!--<namespaceImport name="System.Web.UI.WebControls"/>
        <namespaceImport name="System.Web.UI.WebControls.WebParts"/>-->
        <!--<namespaceImport name="{$Namespace}.Data"/>-->
        <xsl:if test="$ScriptOnly='false'">
          <namespaceImport name="AjaxControlToolkit"/>
        </xsl:if>
      </imports>
      <types>
        <!-- class MembershipManagerExtender -->
        <typeDeclaration name="MembershipManagerExtender">
          <customAttributes>
            <customAttribute name="TargetControlType">
              <arguments>
                <typeofExpression type="HtmlGenericControl"/>
              </arguments>
            </customAttribute>
            <customAttribute name="ToolboxItem">
              <arguments>
                <primitiveExpression value="false"/>
              </arguments>
            </customAttribute>
            <!--<xsl:if test="$IsClassLibrary='true'">
              <customAttribute name="ClientCssResource">
                <arguments>
                  -->
            <!--<primitiveExpression value="{$Namespace}.Theme.Membership.css"/>-->
            <!--
                  <primitiveExpression value="{$Namespace}.Theme.{$Theme}.css"/>
                </arguments>
              </customAttribute>
            </xsl:if>-->
          </customAttributes>
          <baseTypes>
            <typeReference type="AquariumExtenderBase"/>
          </baseTypes>
          <members>
            <!-- constructor MembershipManagerExtender() -->
            <constructor>
              <attributes public="true"/>
              <baseConstructorArgs>
                <primitiveExpression value="Web.MembershipManager"/>
              </baseConstructorArgs>
            </constructor>
            <!-- method ConfigureDescriptor(ScriptBehavirDescriptor) -->
            <!--<memberMethod name="ConfigureDescriptor">
              <attributes override="true" family="true"/>
              <parameters>
                <parameter type="ScriptBehaviorDescriptor" name="descriptor"/>
              </parameters>
            </memberMethod>-->
            <!-- property RequiresMembershipScripts -->
            <memberProperty type="System.Boolean" name="RequiresMembershipScripts">
              <attributes family="true" override="true"/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method ConfigureScripts(List<ScriptReference>) -->
            <!--<memberMethod name="ConfigureScripts">
              <attributes override="true" family="true"/>
              <parameters>
                <parameter type="List" name="scripts">
                  <typeArguments>
                    <typeReference type="ScriptReference"/>
                  </typeArguments>
                </parameter>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="EnableCombinedScript"/>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement/>
                  </trueStatements>
                </conditionStatement>
                <xsl:choose>
                  <xsl:when test="$IsClassLibrary='true'">
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="scripts"/>
                      </target>
                      <parameters>
                        <objectCreateExpression type="ScriptReference">
                          <parameters>
                            <methodInvokeExpression methodName="ResolveEmbeddedResourceName">
                              <target>
                                <typeReferenceExpression type="CultureManager"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="{$Namespace}.Scripts.daf-resources.js"/>
                              </parameters>
                            </methodInvokeExpression>
                            <propertyReferenceExpression name="FullName">
                              <propertyReferenceExpression name="Assembly">
                                <methodInvokeExpression methodName="GetType"/>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="scripts"/>
                      </target>
                      <parameters>
                        <objectCreateExpression type="ScriptReference">
                          <parameters>
                            <primitiveExpression value="{$Namespace}.Scripts.daf-membership.js"/>
                            <propertyReferenceExpression name="FullName">
                              <propertyReferenceExpression name="Assembly">
                                <methodInvokeExpression methodName="GetType"/>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </parameters>
                        </objectCreateExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </xsl:when>
                  <xsl:otherwise>
                    <variableDeclarationStatement type="System.String" name="fileType">
                      <init>
                        <primitiveExpression value=".min.js"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <propertyReferenceExpression name="EnableMinifiedScript">
                            <typeReferenceExpression type="AquariumExtenderBase"/>
                          </propertyReferenceExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="fileType"/>
                          <primitiveExpression value=".js"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <argumentReferenceExpression name="scripts"/>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="CreateScriptReference">
                          <parameters>
                            <binaryOperatorExpression operator="Add">
                              <primitiveExpression value="~/js/daf/daf-resources"/>
                              <variableReferenceExpression name="fileType"/>
                            </binaryOperatorExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <argumentReferenceExpression name="scripts"/>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="CreateScriptReference">
                          <parameters>
                            <binaryOperatorExpression operator="Add">
                              <primitiveExpression value="~/js/daf/daf-membership"/>
                              <variableReferenceExpression name="fileType"/>
                            </binaryOperatorExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$ScriptOnly='false'">
                  <methodInvokeExpression methodName="AddRange">
                    <target>
                      <argumentReferenceExpression name="scripts"/>
                    </target>
                    <parameters>
                      <methodInvokeExpression methodName="GetScriptReferences">
                        <target>
                          <typeReferenceExpression type="ScriptObjectBuilder"/>
                        </target>
                        <parameters>
                          <typeofExpression type="TabContainer"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </xsl:if>
              </statements>
            </memberMethod>-->
            <!-- method Load(EventArgs) -->
            <!--<memberMethod name="OnLoad">
              <attributes override="true" family="true"/>
              <parameters>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="OnLoad">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="e"/>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="TabContainer" name="tc">
                  <init>
                    <objectCreateExpression type="TabContainer"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="tc"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="RegisterCssReferences">
                  <target>
                    <typeReferenceExpression type="ScriptObjectBuilder"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="tc"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Clear">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                </methodInvokeExpression>
              </statements>
            </memberMethod>-->
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
