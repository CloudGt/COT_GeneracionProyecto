<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsClassLibrary" select="'false'"/>
  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <xsl:param name="Theme" select="'Aquarium'"/>
  <xsl:param name="IsPremium"/>
  <xsl:param name="IsUnlimited"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <!--<namespaceImport name="System.Data"/>
        <namespaceImport name="System.Collections.Generic"/>-->
        <namespaceImport name="System.ComponentModel"/>
        <!--<namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>-->
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <!--<namespaceImport name="System.Web.UI.WebControls"/>
        <namespaceImport name="System.Web.UI.WebControls.WebParts"/>-->
        <!--<namespaceImport name="{$Namespace}.Data"/>-->
        <!--<namespaceImport name="AjaxControlToolkit"/>-->
      </imports>
      <types>
        <!-- class MembershipBarExtender -->
        <typeDeclaration name="MembershipBarExtender" isPartial="true">
          <baseTypes>
            <typeReference type="MembershipBarExtenderBase"/>
          </baseTypes>
        </typeDeclaration>
        <!-- class MembershipBarExtenderBase -->
        <typeDeclaration name="MembershipBarExtenderBase">
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
                  --><!--<primitiveExpression value="{$Namespace}.Theme.Membership.css"/>--><!--
                  <primitiveExpression value="{$Namespace}.Theme.{$Theme}.css"/>
                </arguments>
              </customAttribute>
            </xsl:if>-->
          </customAttributes>
          <baseTypes>
            <typeReference type="AquariumExtenderBase"/>
          </baseTypes>
          <members>
            <!-- constructor MembershipBarExtender() -->
            <constructor>
              <attributes public="true"/>
              <baseConstructorArgs>
                <primitiveExpression value="Web.Membership"/>
              </baseConstructorArgs>
            </constructor>
            <!-- method ConfigureDescriptor(ScriptBehavirDescriptor) -->
            <memberMethod name="ConfigureDescriptor">
              <attributes override="true" family="true"/>
              <parameters>
                <parameter type="ScriptBehaviorDescriptor" name="descriptor"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <argumentReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="displayRememberMe"/>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="DisplayRememberMe"/>
                      </indices>
                    </arrayIndexerExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <argumentReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="rememberMeSet"/>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="RememberMeSet"/>
                      </indices>
                    </arrayIndexerExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <argumentReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="displaySignUp"/>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="DisplaySignUp"/>
                      </indices>
                    </arrayIndexerExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <argumentReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="displayPasswordRecovery"/>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="DisplayPasswordRecovery"/>
                      </indices>
                    </arrayIndexerExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <argumentReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="displayMyAccount"/>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="DisplayMyAccount"/>
                      </indices>
                    </arrayIndexerExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="System.String" name="s">
                  <init>
                    <castExpression targetType="System.String">
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Properties"/>
                        </target>
                        <indices>
                          <primitiveExpression value="Welcome"/>
                        </indices>
                      </arrayIndexerExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="s"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="welcome"/>
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Properties"/>
                          </target>
                          <indices>
                            <primitiveExpression value="Welcome"/>
                          </indices>
                        </arrayIndexerExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <variableReferenceExpression name="s"/>
                  <castExpression targetType="System.String">
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="User"/>
                      </indices>
                    </arrayIndexerExpression>
                  </castExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="s"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="user"/>
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Properties"/>
                          </target>
                          <indices>
                            <primitiveExpression value="User"/>
                          </indices>
                        </arrayIndexerExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <argumentReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="displayHelp"/>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="DisplayHelp"/>
                      </indices>
                    </arrayIndexerExpression>
                  </parameters>
                </methodInvokeExpression>
                <xsl:if test="$IsPremium='true'">
                  <methodInvokeExpression methodName="AddProperty">
                    <target>
                      <argumentReferenceExpression name="descriptor"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="enableHistory"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Properties"/>
                        </target>
                        <indices>
                          <primitiveExpression value="EnableHistory"/>
                        </indices>
                      </arrayIndexerExpression>
                    </parameters>
                  </methodInvokeExpression>
                  <methodInvokeExpression methodName="AddProperty">
                    <target>
                      <argumentReferenceExpression name="descriptor"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="enablePermalinks"/>
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Properties"/>
                        </target>
                        <indices>
                          <primitiveExpression value="EnablePermalinks"/>
                        </indices>
                      </arrayIndexerExpression>
                    </parameters>
                  </methodInvokeExpression>
                </xsl:if>
                <methodInvokeExpression methodName="AddProperty">
                  <target>
                    <argumentReferenceExpression name="descriptor"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="displayLogin"/>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Properties"/>
                      </target>
                      <indices>
                        <primitiveExpression value="DisplayLogin"/>
                      </indices>
                    </arrayIndexerExpression>
                  </parameters>
                </methodInvokeExpression>
                <xsl:if test="$IsPremium='true'">
                  <conditionStatement>
                    <condition>
                      <methodInvokeExpression methodName="ContainsKey">
                        <target>
                          <propertyReferenceExpression name="Properties"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="IdleUserTimeout"/>
                        </parameters>
                      </methodInvokeExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AddProperty">
                        <target>
                          <argumentReferenceExpression name="descriptor"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="idleTimeout"/>
                          <arrayIndexerExpression>
                            <target>
                              <propertyReferenceExpression name="Properties"/>
                            </target>
                            <indices>
                              <primitiveExpression value="IdleUserTimeout"/>
                            </indices>
                          </arrayIndexerExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </xsl:if>
                <xsl:if test="$IsUnlimited='true'">
                  <variableDeclarationStatement type="System.String" name="cultures">
                    <init>
                      <castExpression targetType="System.String">
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Properties"/>
                          </target>
                          <indices>
                            <primitiveExpression value="Cultures"/>
                          </indices>
                        </arrayIndexerExpression>
                      </castExpression>
                    </init>
                  </variableDeclarationStatement>
                  <conditionStatement>
                    <condition>
                      <binaryOperatorExpression operator="GreaterThan">
                        <propertyReferenceExpression name="Length">
                          <methodInvokeExpression methodName="Split">
                            <target>
                              <variableReferenceExpression name="cultures"/>
                            </target>
                            <parameters>
                              <arrayCreateExpression>
                                <createType type="System.Char"/>
                                <initializers>
                                  <primitiveExpression value=";" convertTo="Char"/>
                                </initializers>
                              </arrayCreateExpression>
                              <propertyReferenceExpression name="RemoveEmptyEntries">
                                <typeReferenceExpression type="StringSplitOptions"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </propertyReferenceExpression>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </condition>
                    <trueStatements>
                      <methodInvokeExpression methodName="AddProperty">
                        <target>
                          <variableReferenceExpression name="descriptor"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="cultures"/>
                          <variableReferenceExpression name="cultures"/>
                        </parameters>
                      </methodInvokeExpression>
                    </trueStatements>
                  </conditionStatement>
                </xsl:if>
                <!--<variableDeclarationStatement type="System.String" name="link">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Request">
                          <propertyReferenceExpression name="Page"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="_link"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsNullOrEmpty">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="link"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String[]" name="permalink">
                      <init>
                        <methodInvokeExpression methodName="Split">
                          <target>
                            <methodInvokeExpression methodName="GetString">
                              <target>
                                <propertyReferenceExpression name="Default">
                                  <typeReferenceExpression type="Encoding"/>
                                </propertyReferenceExpression>
                              </target>
                              <parameters>
                                <methodInvokeExpression methodName="FromBase64String">
                                  <target>
                                    <typeReferenceExpression type="Convert"/>
                                  </target>
                                  <parameters>
                                    <arrayIndexerExpression>
                                      <target>
                                        <methodInvokeExpression methodName="Split">
                                          <target>
                                            <variableReferenceExpression name="link"/>
                                          </target>
                                          <parameters>
                                            <primitiveExpression value="," convertTo="Char"/>
                                          </parameters>
                                        </methodInvokeExpression>
                                      </target>
                                      <indices>
                                        <primitiveExpression value="0"/>
                                      </indices>
                                    </arrayIndexerExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="?" convertTo="Char"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <methodInvokeExpression methodName="AddProperty">
                      <target>
                        <argumentReferenceExpression name="descriptor"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="commandLine"/>
                        <arrayIndexerExpression>
                          <target>
                            <variableReferenceExpression name="permalink"/>
                          </target>
                          <indices>
                            <primitiveExpression value="1"/>
                          </indices>
                        </arrayIndexerExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>-->
              </statements>
            </memberMethod>
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
              </statements>
            </memberMethod>-->
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
