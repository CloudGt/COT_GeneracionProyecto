<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Data">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.IO"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Threading"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Caching"/>
      </imports>
      <types>
        <!-- class LocalizationDictionary -->
        <typeDeclaration name="LocalizationDictionary">
          <baseTypes>
            <typeReference type="SortedDictionary">
              <typeArguments>
                <typeReference type="System.String"/>
                <typeReference type="System.String"/>
              </typeArguments>
            </typeReference>
          </baseTypes>
        </typeDeclaration>
        <!-- class Localizer -->
        <typeDeclaration name="Localizer">
          <members>
            <!-- property TokenRegex -->
            <memberField type="Regex" name="TokenRegex">
              <attributes static="true" public="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression value="\^(\w+)\^([\s\S]+?)\^(\w+)\^"/>
                    <propertyReferenceExpression name="Compiled">
                      <typeReferenceExpression type="RegexOptions"/>
                    </propertyReferenceExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <!-- property ScriptRegex -->
            <memberField type="Regex" name="ScriptRegex">
              <attributes static="true" public="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[<script.+?>([\s\S]*?)</script>]]></xsl:attribute>
                    </primitiveExpression>
                    <binaryOperatorExpression operator="BitwiseOr">
                      <propertyReferenceExpression name="Compiled">
                        <typeReferenceExpression type="RegexOptions"/>
                      </propertyReferenceExpression>
                      <propertyReferenceExpression name="IgnoreCase">
                        <typeReferenceExpression type="RegexOptions"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <!-- property StateRegex -->
            <memberField type="Regex" name="StateRegex">
              <attributes static="true" public="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[(<input.+?name=.__VIEWSTATE.+?/>)]]></xsl:attribute>
                    </primitiveExpression>
                    <binaryOperatorExpression operator="BitwiseOr">
                      <propertyReferenceExpression name="Compiled">
                        <typeReferenceExpression type="RegexOptions"/>
                      </propertyReferenceExpression>
                      <propertyReferenceExpression name="IgnoreCase">
                        <typeReferenceExpression type="RegexOptions"/>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <!-- const StateRegexReplce -->
            <memberField type="System.String" name="StateRegexReplace">
              <attributes public="true" const="true"/>
              <init>
                <primitiveExpression value="$1&#13;&#10;&lt;input type=&quot;text&quot; name=&quot;__COTSTATE&quot; id=&quot;__COTSTATE&quot; style=&quot;display:none&quot; /&gt;"/>
              </init>
            </memberField>
            <!-- const StateRegexReplceIE -->
            <memberField type="System.String" name="StateRegexReplaceIE">
              <attributes public="true" const="true"/>
              <init>
                <primitiveExpression value="$1&#13;&#10;&lt;input type=&quot;hidden&quot; name=&quot;__COTSTATE&quot; id=&quot;__COTSTATE&quot; /&gt;"/>
              </init>
            </memberField>
            <!-- method JavaScriptEncode(string) -->
            <!--<memberMethod returnType="System.String" name="JavaScriptStringEncode">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="System.String" name="text"/>
              </parameters>
              <statements>
                <xsl:choose>
                  <xsl:when test="a:project/@targetFramework='4.0'">
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="JavaScriptStringEncode">
                        <target>
                          <typeReferenceExpression type="HttpUtility"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="text"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </xsl:when>
                  <xsl:otherwise>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Replace">
                        <target>
                          <methodInvokeExpression methodName="Replace">
                            <target>
                              <methodInvokeExpression methodName="Replace">
                                <target>
                                  <argumentReferenceExpression name="text"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="&#13;&#10;"/>
                                  <primitiveExpression value="\r\n"/>
                                </parameters>
                              </methodInvokeExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="'"/>
                              <primitiveExpression value="\'"/>
                            </parameters>
                          </methodInvokeExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="&quot;"/>
                          <primitiveExpression value="\&quot;"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </xsl:otherwise>
                </xsl:choose>
              </statements>
            </memberMethod>-->
            <!-- method Replace(string, string) -->
            <memberMethod returnType="System.String" name="Replace">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="System.String" name="token"/>
                <parameter type="System.String" name="text"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Replace">
                    <parameters>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="Resources"/>
                      <argumentReferenceExpression name="token"/>
                      <argumentReferenceExpression name="text"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Replace(string, string, string, string) -->
            <memberMethod returnType="System.String" name="Replace">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="System.String" name="baseName"/>
                <parameter type="System.String" name="objectName"/>
                <parameter type="System.String" name="token"/>
                <parameter type="System.String" name="text"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Replace">
                    <parameters>
                      <argumentReferenceExpression name="baseName"/>
                      <argumentReferenceExpression name="objectName"/>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="^{{0}}^{{1}}^{{0}}^"/>
                          <argumentReferenceExpression name="token"/>
                          <argumentReferenceExpression name="text"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Replace(string, string, string) -->
            <memberMethod returnType="System.String" name="Replace">
              <attributes public="true" static="true"/>
              <parameters>
                <parameter type="System.String" name="baseName"/>
                <parameter type="System.String" name="objectName"/>
                <parameter type="System.String" name="text"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <methodInvokeExpression methodName="IsMatch">
                        <target>
                          <propertyReferenceExpression name="TokenRegex"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="text"/>
                        </parameters>
                      </methodInvokeExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <argumentReferenceExpression name="text"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="Localizer" name="l">
                  <init>
                    <objectCreateExpression type="Localizer">
                      <parameters>
                        <argumentReferenceExpression name="baseName"/>
                        <argumentReferenceExpression name="objectName"/>
                        <argumentReferenceExpression name="text"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Replace">
                    <target>
                      <variableReferenceExpression name="l"/>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- field baseName -->
            <memberField type="System.String" name="baseName"/>
            <!-- field objectName -->
            <memberField type="System.String" name="objectName"/>
            <!-- field text -->
            <memberField type="System.String" name="text"/>
            <!-- constructor (string, string, string)-->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="baseName"/>
                <parameter type="System.String" name="objectName"/>
                <parameter type="System.String" name="text"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="baseName"/>
                  <argumentReferenceExpression name="baseName"/>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="baseName"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="baseName"/>
                      <binaryOperatorExpression operator="Add">
                        <fieldReferenceExpression name="baseName"/>
                        <primitiveExpression value="."/>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <fieldReferenceExpression name="objectName"/>
                  <argumentReferenceExpression name="objectName"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="text"/>
                  <argumentReferenceExpression name="text"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- field dictionary -->
            <memberField type="LocalizationDictionary" name="dictionary"/>
            <!-- field sharedDictionary -->
            <memberField type="LocalizationDictionary" name="sharedDictionary"/>
            <!-- field scriptMode -->
            <memberField type="System.Boolean" name="scriptMode"/>
            <!-- method Replace() -->
            <memberMethod returnType="System.String" name="Replace">
              <attributes public="true"/>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="sharedDictionary"/>
                  <methodInvokeExpression methodName="CreateDictionary">
                    <parameters>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="CombinedSharedResources"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="dictionary"/>
                  <methodInvokeExpression methodName="CreateDictionary">
                    <parameters>
                      <fieldReferenceExpression name="baseName"/>
                      <fieldReferenceExpression name="objectName"/>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <fieldReferenceExpression name="baseName"/>
                      <primitiveExpression value="Pages."/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="scriptMode"/>
                      <primitiveExpression value="true"/>
                    </assignStatement>
                    <variableDeclarationStatement type="System.String" name="stateInput">
                      <init>
                        <propertyReferenceExpression name="StateRegexReplace"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <!--<binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Browser">
                            <propertyReferenceExpression name="Browser">
                              <propertyReferenceExpression name="Request">
                                <castExpression targetType="System.Web.UI.Page">
                                  <propertyReferenceExpression name="Handler">
                                    <propertyReferenceExpression name="Current">
                                      <typeReferenceExpression type="HttpContext"/>
                                    </propertyReferenceExpression>
                                  </propertyReferenceExpression>
                                </castExpression>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <primitiveExpression value="IE"/>
                        </binaryOperatorExpression>-->
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Browser">
                            <propertyReferenceExpression name="Browser">
                              <propertyReferenceExpression name="Request">
                                <propertyReferenceExpression name="Current">
                                  <typeReferenceExpression type="HttpContext"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <primitiveExpression value="IE"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="stateInput"/>
                          <propertyReferenceExpression name="StateRegexReplaceIE"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <variableDeclarationStatement type="System.String" name="output">
                      <init>
                        <methodInvokeExpression methodName="Replace">
                          <target>
                            <propertyReferenceExpression name="StateRegex"/>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="Replace">
                              <target>
                                <propertyReferenceExpression name="ScriptRegex"/>
                              </target>
                              <parameters>
                                <methodInvokeExpression methodName="Trim">
                                  <target>
                                    <fieldReferenceExpression name="text"/>
                                  </target>
                                </methodInvokeExpression>
                                <addressOfExpression>
                                  <methodReferenceExpression methodName="DoReplaceScript"/>
                                </addressOfExpression>
                              </parameters>
                            </methodInvokeExpression>
                            <variableReferenceExpression name="stateInput"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <assignStatement>
                      <fieldReferenceExpression name="scriptMode"/>
                      <primitiveExpression value="false"/>
                    </assignStatement>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Replace">
                        <target>
                          <propertyReferenceExpression name="TokenRegex"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="output"/>
                          <addressOfExpression>
                            <methodReferenceExpression methodName="DoReplaceToken"/>
                          </addressOfExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Replace">
                        <target>
                          <propertyReferenceExpression name="TokenRegex"/>
                        </target>
                        <parameters>
                          <fieldReferenceExpression name="text"/>
                          <addressOfExpression>
                            <methodReferenceExpression methodName="DoReplaceToken"/>
                          </addressOfExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method DoReplaceScript(Match) -->
            <memberMethod returnType="System.String" name="DoReplaceScript">
              <attributes private="true"/>
              <parameters>
                <parameter type="Match" name="m"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Replace">
                    <target>
                      <propertyReferenceExpression name="TokenRegex"/>
                    </target>
                    <parameters>
                      <propertyReferenceExpression name="Value">
                        <argumentReferenceExpression name="m"/>
                      </propertyReferenceExpression>
                      <addressOfExpression>
                        <methodReferenceExpression methodName="DoReplaceToken"/>
                      </addressOfExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method DoReplaceToken(Match) -->
            <memberMethod returnType="System.String" name="DoReplaceToken">
              <attributes private="true"/>
              <parameters>
                <parameter type="Match" name="m"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="token">
                  <init>
                    <propertyReferenceExpression name="Value">
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Groups">
                            <argumentReferenceExpression name="m"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="1"/>
                        </indices>
                      </arrayIndexerExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <variableReferenceExpression name="token"/>
                      <propertyReferenceExpression name="Value">
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Groups">
                              <argumentReferenceExpression name="m"/>
                            </propertyReferenceExpression>
                          </target>
                          <indices>
                            <primitiveExpression value="3"/>
                          </indices>
                        </arrayIndexerExpression>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.String" name="result">
                      <init>
                        <primitiveExpression value="null"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <methodInvokeExpression methodName="TryGetValue">
                            <target>
                              <fieldReferenceExpression name="dictionary"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="token"/>
                              <directionExpression direction="Out">
                                <variableReferenceExpression name="result"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <conditionStatement>
                          <condition>
                            <unaryOperatorExpression  operator="Not">
                              <methodInvokeExpression methodName="TryGetValue">
                                <target>
                                  <fieldReferenceExpression name="sharedDictionary"/>
                                </target>
                                <parameters>
                                  <variableReferenceExpression name="token"/>
                                  <directionExpression direction="Out">
                                    <variableReferenceExpression name="result"/>
                                  </directionExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </unaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="result"/>
                              <propertyReferenceExpression name="Value">
                                <arrayIndexerExpression>
                                  <target>
                                    <propertyReferenceExpression name="Groups">
                                      <argumentReferenceExpression name="m"/>
                                    </propertyReferenceExpression>
                                  </target>
                                  <indices>
                                    <primitiveExpression value="2"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </propertyReferenceExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <fieldReferenceExpression name="scriptMode"/>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="result"/>
                          <methodInvokeExpression methodName="JavaScriptString">
                            <target>
                              <typeReferenceExpression type="BusinessRules"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="result"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodReturnStatement>
                      <variableReferenceExpression name="result"/>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="Value">
                        <variableReferenceExpression name="m"/>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method CreateDictionaryStream(string, string, string, out string[] ) -->
            <memberMethod returnType="Stream" name="CreateDictionaryStream">
              <attributes static="true" public="true"/>
              <parameters>
                <parameter type="System.String" name="culture"/>
                <parameter type="System.String" name="baseName"/>
                <parameter type="System.String" name="objectName"/>
                <parameter type="System.String[]" name="files" direction="Out"/>
              </parameters>
              <statements>
                <assignStatement>
                  <argumentReferenceExpression name="files"/>
                  <primitiveExpression value="null"/>
                </assignStatement>
                <variableDeclarationStatement type="System.String" name="fileName">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{{0}}.txt"/>
                        <argumentReferenceExpression name="objectName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Type" name="t">
                  <init>
                    <typeofExpression type="Controller"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Stream" name="result">
                  <init>
                    <methodInvokeExpression methodName="GetManifestResourceStream">
                      <target>
                        <propertyReferenceExpression name="Assembly">
                          <variableReferenceExpression name="t"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="ResolveEmbeddedResourceName">
                          <target>
                            <typeReferenceExpression type="CultureManager"/>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="{a:project/a:namespace}.{{0}}{{1}}"/>
                                <argumentReferenceExpression name="baseName"/>
                                <argumentReferenceExpression name="fileName"/>
                              </parameters>
                            </methodInvokeExpression>
                            <argumentReferenceExpression name="culture"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <variableReferenceExpression name="result"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="result"/>
                      <methodInvokeExpression methodName="GetManifestResourceStream">
                        <target>
                          <propertyReferenceExpression name="Assembly">
                            <variableReferenceExpression name="t"/>
                          </propertyReferenceExpression>
                        </target>
                        <parameters>
                          <methodInvokeExpression methodName="ResolveEmbeddedResourceName">
                            <target>
                              <typeReferenceExpression type="CultureManager"/>
                            </target>
                            <parameters>
                              <methodInvokeExpression methodName="Format">
                                <target>
                                  <typeReferenceExpression type="String"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="{a:project/a:namespace}.{{0}}"/>
                                  <argumentReferenceExpression name="fileName"/>
                                </parameters>
                              </methodInvokeExpression>
                              <argumentReferenceExpression name="culture"/>
                            </parameters>
                          </methodInvokeExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <variableReferenceExpression name="result"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="fileName"/>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="{{0}}.{{1}}.txt"/>
                          <argumentReferenceExpression name="objectName"/>
                          <argumentReferenceExpression name="culture"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                    <variableDeclarationStatement type="System.String" name="objectPath">
                      <init>
                        <methodInvokeExpression methodName="Combine">
                          <target>
                            <typeReferenceExpression type="Path"/>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="Combine">
                              <target>
                                <typeReferenceExpression type="Path"/>
                              </target>
                              <parameters>
                                <propertyReferenceExpression name="AppDomainAppPath">
                                  <typeReferenceExpression type="HttpRuntime"/>
                                </propertyReferenceExpression>
                                <argumentReferenceExpression name="baseName"/>
                              </parameters>
                            </methodInvokeExpression>
                            <argumentReferenceExpression name="fileName"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <methodInvokeExpression methodName="Exists">
                          <target>
                            <typeReferenceExpression type="File"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="objectPath"/>
                          </parameters>
                        </methodInvokeExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <argumentReferenceExpression name="files"/>
                          <arrayCreateExpression>
                            <createType type="System.String"/>
                            <initializers>
                              <variableReferenceExpression name="objectPath"/>
                            </initializers>
                          </arrayCreateExpression>
                        </assignStatement>
                        <assignStatement>
                          <variableReferenceExpression name="result"/>
                          <objectCreateExpression type="FileStream">
                            <parameters>
                              <variableReferenceExpression name="objectPath"/>
                              <propertyReferenceExpression name="Open">
                                <typeReferenceExpression type="FileMode"/>
                              </propertyReferenceExpression>
                              <propertyReferenceExpression name="Read">
                                <typeReferenceExpression type="FileAccess"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </objectCreateExpression>
                        </assignStatement>
                      </trueStatements>
                      <falseStatements>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <unaryOperatorExpression operator="IsNullOrEmpty">
                                <argumentReferenceExpression name="baseName"/>
                              </unaryOperatorExpression>
                              <binaryOperatorExpression operator="ValueEquality">
                                <argumentReferenceExpression name="objectName"/>
                                <primitiveExpression value="CombinedSharedResources"/>
                              </binaryOperatorExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <variableDeclarationStatement type="List" name="dependencies">
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
                            <assignStatement>
                              <variableReferenceExpression name="result"/>
                              <objectCreateExpression type="MemoryStream"/>
                            </assignStatement>
                            <variableDeclarationStatement type="System.String" name="root">
                              <init>
                                <methodInvokeExpression methodName="MapPath">
                                  <target>
                                    <propertyReferenceExpression name="Server">
                                      <propertyReferenceExpression name="Current">
                                        <typeReferenceExpression type="HttpContext"/>
                                      </propertyReferenceExpression>
                                    </propertyReferenceExpression>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="~/"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </init>
                            </variableDeclarationStatement>
                            <variableDeclarationStatement type="System.String[]" name="list">
                              <init>
                                <primitiveExpression value="null"/>
                              </init>
                            </variableDeclarationStatement>
                            <comment>try loading "Resources.CULTURE-NAME.txt" files</comment>
                            <variableDeclarationStatement type="Stream" name="rs">
                              <init>
                                <methodInvokeExpression methodName="CreateDictionaryStream">
                                  <parameters>
                                    <argumentReferenceExpression name="culture"/>
                                    <propertyReferenceExpression name="Empty">
                                      <typeReferenceExpression type="String"/>
                                    </propertyReferenceExpression>
                                    <primitiveExpression value="Resources"/>
                                    <directionExpression direction="Out">
                                      <variableReferenceExpression name="list"/>
                                    </directionExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </init>
                            </variableDeclarationStatement>
                            <methodInvokeExpression methodName="MergeStreams">
                              <parameters>
                                <variableReferenceExpression name="result"/>
                                <variableReferenceExpression name="rs"/>
                                <variableReferenceExpression name="dependencies"/>
                                <variableReferenceExpression name="list"/>
                              </parameters>
                            </methodInvokeExpression>
                            <comment> try loading "Web.Sitemap.CULTURE_NAME" files</comment>
                            <assignStatement>
                              <variableReferenceExpression name="rs"/>
                              <methodInvokeExpression methodName="CreateDictionaryStream">
                                <parameters>
                                  <argumentReferenceExpression name="culture"/>
                                  <propertyReferenceExpression name="Empty">
                                    <typeReferenceExpression type="String"/>
                                  </propertyReferenceExpression>
                                  <primitiveExpression value="web.sitemap"/>
                                  <directionExpression direction="Out">
                                    <variableReferenceExpression name="list"/>
                                  </directionExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </assignStatement>
                            <methodInvokeExpression methodName="MergeStreams">
                              <parameters>
                                <variableReferenceExpression name="result"/>
                                <variableReferenceExpression name="rs"/>
                                <variableReferenceExpression name="dependencies"/>
                                <variableReferenceExpression name="list"/>
                              </parameters>
                            </methodInvokeExpression>
                            <!--<comment>try loading "*.master.CULTURE_NAME" files</comment>
                            <foreachStatement>
                              <variable type="System.String" name="f"/>
                              <target>
                                <methodInvokeExpression methodName="GetFiles">
                                  <target>
                                    <typeReferenceExpression type="Directory"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="root"/>
                                    <primitiveExpression value="*.master"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </target>
                              <statements>
                                <assignStatement>
                                  <variableReferenceExpression name="rs"/>
                                  <methodInvokeExpression methodName="CreateDictionaryStream">
                                    <parameters>
                                      <argumentReferenceExpression name="culture"/>
                                      <propertyReferenceExpression name="Empty">
                                        <typeReferenceExpression type="String"/>
                                      </propertyReferenceExpression>
                                      <methodInvokeExpression methodName="GetFileName">
                                        <target>
                                          <typeReferenceExpression type="Path"/>
                                        </target>
                                        <parameters>
                                          <variableReferenceExpression name="f"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                      <directionExpression direction="Out">
                                        <variableReferenceExpression name="list"/>
                                      </directionExpression>
                                    </parameters>
                                  </methodInvokeExpression>
                                </assignStatement>
                                <methodInvokeExpression methodName="MergeStreams">
                                  <parameters>
                                    <variableReferenceExpression name="result"/>
                                    <variableReferenceExpression name="rs"/>
                                    <variableReferenceExpression name="dependencies"/>
                                    <variableReferenceExpression name="list"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </statements>
                            </foreachStatement>-->
                            <comment>try loading "Controls\ControlName.ascx.CULTURE_NAME" files</comment>
                            <variableDeclarationStatement type="System.String" name="controlsPath">
                              <init>
                                <methodInvokeExpression methodName="Combine">
                                  <target>
                                    <typeReferenceExpression type="Path"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="root"/>
                                    <primitiveExpression value="Controls"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </init>
                            </variableDeclarationStatement>
                            <conditionStatement>
                              <condition>
                                <methodInvokeExpression methodName="Exists">
                                  <target>
                                    <typeReferenceExpression type="Directory"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="controlsPath"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </condition>
                              <trueStatements>
                                <foreachStatement>
                                  <variable type="System.String" name="f"/>
                                  <target>
                                    <methodInvokeExpression methodName="GetFiles">
                                      <target>
                                        <typeReferenceExpression type="Directory"/>
                                      </target>
                                      <parameters>
                                        <variableReferenceExpression name="controlsPath"/>
                                        <primitiveExpression value="*.ascx"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </target>
                                  <statements>
                                    <assignStatement>
                                      <variableReferenceExpression name="rs"/>
                                      <methodInvokeExpression methodName="CreateDictionaryStream">
                                        <parameters>
                                          <argumentReferenceExpression name="culture"/>
                                          <primitiveExpression value="Controls"/>
                                          <methodInvokeExpression methodName="GetFileName">
                                            <target>
                                              <typeReferenceExpression type="Path"/>
                                            </target>
                                            <parameters>
                                              <variableReferenceExpression name="f"/>
                                            </parameters>
                                          </methodInvokeExpression>
                                          <directionExpression direction="Out">
                                            <variableReferenceExpression name="list"/>
                                          </directionExpression>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </assignStatement>
                                    <methodInvokeExpression methodName="MergeStreams">
                                      <parameters>
                                        <variableReferenceExpression name="result"/>
                                        <variableReferenceExpression name="rs"/>
                                        <variableReferenceExpression name="dependencies"/>
                                        <variableReferenceExpression name="list"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </statements>
                                </foreachStatement>
                              </trueStatements>
                            </conditionStatement>
                            <comment>complete processing of combined shared resources</comment>
                            <assignStatement>
                              <propertyReferenceExpression name="Position">
                                <variableReferenceExpression name="result"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="0"/>
                            </assignStatement>
                            <assignStatement>
                              <argumentReferenceExpression name="files"/>
                              <methodInvokeExpression methodName="ToArray">
                                <target>
                                  <variableReferenceExpression name="dependencies"/>
                                </target>
                              </methodInvokeExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="result"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method MergeStreams(Stream, Stream, List<String>, string[]) -->
            <memberMethod name="MergeStreams">
              <attributes static="true" private="true"/>
              <parameters>
                <parameter type="Stream" name="result"/>
                <parameter type="Stream" name="source"/>
                <parameter type="List" name="dependencies">
                  <typeArguments>
                    <typeReference type="System.String"/>
                  </typeArguments>
                </parameter>
                <parameter type="System.String[]" name="list"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="source"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <!--<methodInvokeExpression methodName="CopyTo">
                      <target>
                        <variableReferenceExpression name="source"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="result"/>
                      </parameters>
                    </methodInvokeExpression>-->

                    <!-- 
 byte[] buffer = new byte[32768];
                int bytesRead = source.Read(buffer, 0, buffer.Length);
                while ((bytesRead) > 0)
                {
                    result.Write(buffer, 0, bytesRead);
                    bytesRead = source.Read(buffer, 0, buffer.Length);
                }                    -->
                    <variableDeclarationStatement type="System.Byte[]" name="buffer">
                      <init>
                        <arrayCreateExpression>
                          <createType type="System.Byte"/>
                          <sizeExpression>
                            <primitiveExpression value="32768"/>
                          </sizeExpression>
                        </arrayCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.Int32" name="bytesRead">
                      <init>
                        <methodInvokeExpression methodName="Read">
                          <target>
                            <argumentReferenceExpression name="source"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="buffer"/>
                            <primitiveExpression value="0"/>
                            <propertyReferenceExpression name="Length">
                              <variableReferenceExpression name="buffer"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <whileStatement>
                      <test>
                        <binaryOperatorExpression operator="GreaterThan">
                          <variableReferenceExpression name="bytesRead"/>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </test>
                      <statements>
                        <methodInvokeExpression methodName="Write">
                          <target>
                            <argumentReferenceExpression name="result"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="buffer"/>
                            <primitiveExpression value="0"/>
                            <propertyReferenceExpression name="Length">
                              <variableReferenceExpression name="buffer"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="bytesRead"/>
                          <methodInvokeExpression methodName="Read">
                            <target>
                              <argumentReferenceExpression name="source"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="buffer"/>
                              <primitiveExpression value="0"/>
                              <propertyReferenceExpression name="Length">
                                <variableReferenceExpression name="buffer"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </statements>
                    </whileStatement>
                    <methodInvokeExpression methodName="Close">
                      <target>
                        <variableReferenceExpression name="source"/>
                      </target>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="list"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddRange">
                          <target>
                            <variableReferenceExpression name="dependencies"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="list"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method CreateDictionary(string, string) -->
            <memberMethod returnType="LocalizationDictionary" name="CreateDictionary">
              <attributes static="true" public="true"/>
              <parameters>
                <parameter type="System.String" name="baseName"/>
                <parameter type="System.String" name="objectName"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="culture">
                  <init>
                    <propertyReferenceExpression name="Name">
                      <propertyReferenceExpression name="CurrentUICulture">
                        <propertyReferenceExpression name="CurrentThread">
                          <typeReferenceExpression type="Thread"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="fileName">
                  <init>
                    <methodInvokeExpression methodName="Format">
                      <target>
                        <typeReferenceExpression type="String"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="{a:project/a:namespace}.{{0}}.{{1}}.txt"/>
                        <argumentReferenceExpression name="objectName"/>
                        <variableReferenceExpression name="culture"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="LocalizationDictionary" name="dictionary">
                  <init>
                    <castExpression targetType="LocalizationDictionary">
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Cache">
                            <typeReferenceExpression type="HttpRuntime"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <variableReferenceExpression name="fileName"/>
                        </indices>
                      </arrayIndexerExpression>
                    </castExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityEquality">
                      <variableReferenceExpression name="dictionary"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="dictionary"/>
                      <objectCreateExpression type="LocalizationDictionary"/>
                    </assignStatement>
                    <variableDeclarationStatement type="System.String[]" name="files">
                      <init>
                        <primitiveExpression value="null"/>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="Stream" name="s">
                      <init>
                        <methodInvokeExpression methodName="CreateDictionaryStream">
                          <parameters>
                            <variableReferenceExpression name="culture"/>
                            <argumentReferenceExpression name="baseName"/>
                            <argumentReferenceExpression name="objectName"/>
                            <directionExpression direction="Out">
                              <variableReferenceExpression name="files"/>
                            </directionExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <binaryOperatorExpression operator="IdentityEquality">
                            <variableReferenceExpression name="s"/>
                            <primitiveExpression value="null"/>
                          </binaryOperatorExpression>
                          <methodInvokeExpression methodName="Contains">
                            <target>
                              <variableReferenceExpression name="culture"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="-"/>
                            </parameters>
                          </methodInvokeExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="culture"/>
                          <methodInvokeExpression methodName="Substring">
                            <target>
                              <variableReferenceExpression name="culture"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="0"/>
                              <methodInvokeExpression methodName="IndexOf">
                                <target>
                                  <variableReferenceExpression name="culture"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="-"/>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <assignStatement>
                          <variableReferenceExpression name="s"/>
                          <methodInvokeExpression methodName="CreateDictionaryStream">
                            <parameters>
                              <variableReferenceExpression name="culture"/>
                              <argumentReferenceExpression name="baseName"/>
                              <variableReferenceExpression name="objectName"/>
                              <directionExpression direction="Out">
                                <variableReferenceExpression name="files"/>
                              </directionExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="s"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="PopulateDictionary">
                          <parameters>
                            <variableReferenceExpression name="dictionary"/>
                            <methodInvokeExpression methodName="ReadToEnd">
                              <target>
                                <objectCreateExpression type="StreamReader">
                                  <parameters>
                                    <variableReferenceExpression name="s"/>
                                  </parameters>
                                </objectCreateExpression>
                              </target>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <methodInvokeExpression methodName="Close">
                          <target>
                            <variableReferenceExpression name="s"/>
                          </target>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <variableDeclarationStatement type="CacheDependency" name="dependency">
                      <init>
                        <primitiveExpression value="null"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="files"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="dependency"/>
                          <objectCreateExpression type="CacheDependency">
                            <parameters>
                              <variableReferenceExpression name="files"/>
                            </parameters>
                          </objectCreateExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="Insert">
                      <target>
                        <propertyReferenceExpression name="Cache">
                          <typeReferenceExpression type="HttpRuntime"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="fileName"/>
                        <variableReferenceExpression name="dictionary"/>
                        <variableReferenceExpression name="dependency"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="dictionary"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method PopulateDictionary(LocalizationDictionary, string) -->
            <memberMethod name="PopulateDictionary">
              <attributes static="true" private="true"/>
              <parameters>
                <parameter type="LocalizationDictionary" name="dictionary"/>
                <parameter type="System.String" name="text"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="Match" name="m">
                  <init>
                    <methodInvokeExpression methodName="Match">
                      <target>
                        <propertyReferenceExpression name="TokenRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="text"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <whileStatement>
                  <test>
                    <propertyReferenceExpression name="Success">
                      <variableReferenceExpression name="m"/>
                    </propertyReferenceExpression>
                  </test>
                  <statements>
                    <variableDeclarationStatement type="System.String" name="token">
                      <init>
                        <propertyReferenceExpression name="Value">
                          <arrayIndexerExpression>
                            <target>
                              <propertyReferenceExpression name="Groups">
                                <variableReferenceExpression name="m"/>
                              </propertyReferenceExpression>
                            </target>
                            <indices>
                              <primitiveExpression value="1"/>
                            </indices>
                          </arrayIndexerExpression>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <variableReferenceExpression name="token"/>
                          <propertyReferenceExpression name="Value">
                            <arrayIndexerExpression>
                              <target>
                                <propertyReferenceExpression name="Groups">
                                  <variableReferenceExpression name="m"/>
                                </propertyReferenceExpression>
                              </target>
                              <indices>
                                <primitiveExpression value="3"/>
                              </indices>
                            </arrayIndexerExpression>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <arrayIndexerExpression>
                            <target>
                              <argumentReferenceExpression name="dictionary"/>
                            </target>
                            <indices>
                              <variableReferenceExpression name="token"/>
                            </indices>
                          </arrayIndexerExpression>
                          <propertyReferenceExpression name="Value">
                            <arrayIndexerExpression>
                              <target>
                                <propertyReferenceExpression name="Groups">
                                  <variableReferenceExpression name="m"/>
                                </propertyReferenceExpression>
                              </target>
                              <indices>
                                <primitiveExpression value="2"/>
                              </indices>
                            </arrayIndexerExpression>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <assignStatement>
                      <variableReferenceExpression name="m"/>
                      <methodInvokeExpression methodName="NextMatch">
                        <target>
                          <variableReferenceExpression name="m"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                  </statements>
                </whileStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
