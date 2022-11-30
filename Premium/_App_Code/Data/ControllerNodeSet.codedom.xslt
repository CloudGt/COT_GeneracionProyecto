<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ontime="urn:schemas-codeontime-com:extensions"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a ontime"
>
  <xsl:output method="xml" indent="yes"/>

  <msxsl:script language="C#" implements-prefix="ontime">
    <![CDATA[
  public string ToAttribute(string s) {
    return Char.ToLowerInvariant(s[0]) + s.Substring(1);
  }
  ]]>
  </msxsl:script>

  <xsl:param name="Namespace" select="a:project/a:namespace"/>
  <xsl:param name="IsPremium"/>

  <xsl:template match="/">
    <compileUnit namespace="{$Namespace}.Data">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Configuration"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Data.Common"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Reflection"/>
        <namespaceImport name="System.Xml"/>
        <namespaceImport name="System.Xml.XPath"/>
      </imports>
      <types>
        <typeDeclaration name="ControllerNodeSet">
          <members>
            <memberField type="XPathNavigator" name="navigator"/>
            <memberField type="XmlNamespaceManager" name="resolver"/>
            <memberField type="List" name="nodes">
              <typeArguments>
                <typeReference type="XPathNavigator"/>
              </typeArguments>
            </memberField>
            <!-- method ToString -->
            <memberMethod returnType="System.String" name="ToString">
              <attributes override="true" public="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="IdentityInequality">
                        <fieldReferenceExpression name="nodes"/>
                        <primitiveExpression value="null"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="Count">
                          <fieldReferenceExpression name="nodes"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <propertyReferenceExpression  name="Value">
                        <arrayIndexerExpression>
                          <target>
                            <fieldReferenceExpression name="nodes"/>
                          </target>
                          <indices>
                            <primitiveExpression value="0"/>
                          </indices>
                        </arrayIndexerExpression>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ToString">
                    <target>
                      <baseReferenceExpression/>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- property Nodes -->
            <memberProperty type="List" name="Nodes">
              <typeArguments>
                <typeReference type="XPathNavigator"/>
              </typeArguments>
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="nodes"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- constructor (ControllerNodeSet) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="ControllerNodeSet" name="nodeSet"/>
              </parameters>
              <chainedConstructorArgs>
                <fieldReferenceExpression name="navigator">
                  <argumentReferenceExpression name="nodeSet"/>
                </fieldReferenceExpression>
                <fieldReferenceExpression name="resolver">
                  <argumentReferenceExpression name="nodeSet"/>
                </fieldReferenceExpression>
              </chainedConstructorArgs>
            </constructor>
            <!-- constructor (XPathNavigator, XmlNamespaceManager) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="XPathNavigator" name="navigator"/>
                <parameter type="XmlNamespaceManager" name="resolver"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="navigator">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="navigator"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="resolver">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="resolver"/>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="nodes"/>
                  <objectCreateExpression type="List">
                    <typeArguments>
                      <typeReference type="XPathNavigator"/>
                    </typeArguments>
                  </objectCreateExpression>
                </assignStatement>
              </statements>
            </constructor>
            <!-- constructor (ControllerNodeSet, XPathNavigator node) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="ControllerNodeSet" name="nodeSet"/>
                <parameter type="XPathNavigator" name="node"/>
              </parameters>
              <chainedConstructorArgs>
                <argumentReferenceExpression name="nodeSet"/>
                <objectCreateExpression type="List">
                  <typeArguments>
                    <typeReference type="XPathNavigator"/>
                  </typeArguments>
                </objectCreateExpression>
              </chainedConstructorArgs>
              <statements>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="node"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </constructor>
            <!-- constructor (ControllerNodeSet, List<XPathNavigator>) -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="ControllerNodeSet" name="nodeSet"/>
                <parameter type="List" name="nodes">
                  <typeArguments>
                    <typeReference type="XPathNavigator"/>
                  </typeArguments>
                </parameter>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="navigator">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <fieldReferenceExpression name="navigator">
                    <argumentReferenceExpression name="nodeSet"/>
                  </fieldReferenceExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="resolver">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <fieldReferenceExpression name="resolver">
                    <argumentReferenceExpression name="nodeSet"/>
                  </fieldReferenceExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="nodes">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <argumentReferenceExpression name="nodes"/>
                </assignStatement>
              </statements>
            </constructor>
            <!-- method DoReplaceVariable(Match) -->
            <memberField type="System.Object[]" name="args"/>
            <memberField type="System.Int32" name="argIndex"/>
            <memberField type="Regex" name="variableRegex">
              <attributes static="true" private="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[\$\w+]]></xsl:attribute>
                    </primitiveExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <memberMethod returnType="System.String" name="DoReplaceVariable">
              <attributes private="true"/>
              <parameters>
                <parameter type="Match" name="m"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Object" name="o">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <fieldReferenceExpression name="args"/>
                      </target>
                      <indices>
                        <fieldReferenceExpression name="argIndex"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <fieldReferenceExpression name="argIndex"/>
                  <binaryOperatorExpression operator="Add">
                    <fieldReferenceExpression name="argIndex"/>
                    <primitiveExpression value="1"/>
                  </binaryOperatorExpression>
                </assignStatement>
                <methodReturnStatement>
                  <stringFormatExpression format="'{{0}}'">
                    <variableReferenceExpression name="o"/>
                  </stringFormatExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method DoReplaceElementName(Match) -->
            <memberField type="Regex" name="elementNameRegex">
              <attributes static="true" private="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[(?'String'"([\s\S]+?)")|(?'String'\'([\s\S]+?)\')|(?'AttrOrVar'(@|\$)\w+)|(?'Function'\w+\s*\()|(?'Element'(?'Axis'[\w-]+::)?(?'Namespace'\w+\:)?(([\w-]+::\*)|(?'Name'[a-z]\w*)))]]></xsl:attribute>
                    </primitiveExpression>
                    <propertyReferenceExpression name="IgnoreCase">
                      <typeReferenceExpression type="RegexOptions"/>
                    </propertyReferenceExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <memberField type="Regex" name="keywordRegex">
              <attributes static="true" private="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[^(or|and|mod|div|[\w-]+::\*)$]]></xsl:attribute>
                    </primitiveExpression>
                    <propertyReferenceExpression name="IgnoreCase">
                      <typeReferenceExpression type="RegexOptions"/>
                    </propertyReferenceExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <memberMethod returnType="System.String" name="DoReplaceElementName">
              <attributes private="true"/>
              <parameters>
                <parameter type="Match" name="m"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="name">
                  <init>
                    <propertyReferenceExpression name="Value">
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Groups">
                            <argumentReferenceExpression name="m"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="Name"/>
                        </indices>
                      </arrayIndexerExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="axis">
                  <init>
                    <propertyReferenceExpression name="Value">
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Groups">
                            <argumentReferenceExpression name="m"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="Axis"/>
                        </indices>
                      </arrayIndexerExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="ns">
                  <init>
                    <propertyReferenceExpression name="Value">
                      <arrayIndexerExpression>
                        <target>
                          <propertyReferenceExpression name="Groups">
                            <argumentReferenceExpression name="m"/>
                          </propertyReferenceExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="Namespace"/>
                        </indices>
                      </arrayIndexerExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="BooleanAnd">
                        <unaryOperatorExpression operator="IsNotNullOrEmpty">
                          <variableReferenceExpression name="name"/>
                        </unaryOperatorExpression>
                        <unaryOperatorExpression operator="IsNullOrEmpty">
                          <variableReferenceExpression name="ns"/>
                        </unaryOperatorExpression>
                      </binaryOperatorExpression>
                      <unaryOperatorExpression operator="Not">
                        <methodInvokeExpression methodName="IsMatch">
                          <target>
                            <fieldReferenceExpression name="keywordRegex"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Value">
                              <argumentReferenceExpression name="m"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <stringFormatExpression format="{{0}}c:{{1}}">
                        <variableReferenceExpression name="axis"/>
                        <variableReferenceExpression name="name"/>
                      </stringFormatExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <propertyReferenceExpression name="Value">
                    <variableReferenceExpression name="m"/>
                  </propertyReferenceExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Add(string, params object[]) -->
            <memberMethod returnType="ControllerNodeSet" name="Add">
              <comment>
                <![CDATA[
       /// <summary>
        /// Adds selected nodes to the current node set.
        /// </summary>
        /// <param name="selector">XPath expression evaluated against the definition of the data controller. May contain variables.</param>
        /// <param name="args">Optional values of variables. If variables are specified then the expression is evaluated for each variable or group of variables specified in the selector.</param>
        /// <example>field[@name=$name]</example>
        /// <returns>Returns a combined nodeset.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="selector"/>
                <parameter type="params System.Object[]" name="args"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="InternalSelect">
                    <parameters>
                      <primitiveExpression value="true"/>
                      <argumentReferenceExpression name="selector"/>
                      <argumentReferenceExpression name="args"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Select(string, params object[]) -->
            <memberField type="Regex" name="createElementRegex">
              <attributes private="true" static="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[\<(\w+)/?\>$]]></xsl:attribute>
                    </primitiveExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <memberMethod returnType="ControllerNodeSet" name="Select">
              <comment>
                <![CDATA[
        /// <summary>
        ///Selects a node set containing zero or more XML nodes from the data controller definition.
        ///</summary>
        /// <param name="selector">XPath expression evaluated against the definition of the data controller. May contain variables.</param>
        /// <param name="args">Optional values of variables. If variables are specified then the expression is evaluated for each variable or group of variables specified in the selector.</param>
        /// <example>field[@name=$name]</example>
        ///<returns>A node set containing selected data controller nodes.</returns>                
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="selector"/>
                <parameter type="params System.Object[]" name="args"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="Match" name="m">
                  <init>
                    <methodInvokeExpression methodName="Match">
                      <target>
                        <fieldReferenceExpression name="createElementRegex"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="selector"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="Success">
                      <variableReferenceExpression name="m"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="XmlDocument" name="document">
                      <init>
                        <objectCreateExpression type="XmlDocument"/>
                      </init>
                    </variableDeclarationStatement>
                    <methodInvokeExpression methodName="LoadXml">
                      <target>
                        <variableReferenceExpression name="document"/>
                      </target>
                      <parameters>
                        <stringFormatExpression format="&lt;{{0}}/&gt;">
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
                        </stringFormatExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <objectCreateExpression type="ControllerNodeSet">
                        <parameters>
                          <thisReferenceExpression/>
                          <methodInvokeExpression methodName="CreateNavigator">
                            <target>
                              <propertyReferenceExpression name="FirstChild">
                                <variableReferenceExpression name="document"/>
                              </propertyReferenceExpression>
                            </target>
                          </methodInvokeExpression>
                        </parameters>
                      </objectCreateExpression>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="InternalSelect">
                        <parameters>
                          <primitiveExpression value="false"/>
                          <argumentReferenceExpression name="selector"/>
                          <argumentReferenceExpression name="args"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method InternalSelect(bool, string, params object[]) -->
            <memberField type="Regex" name="namespaceRegex">
              <attributes private="true" static="true"/>
              <init>
                <objectCreateExpression type="Regex">
                  <parameters>
                    <primitiveExpression>
                      <xsl:attribute name="value"><![CDATA[^\w+::]]></xsl:attribute>
                    </primitiveExpression>
                  </parameters>
                </objectCreateExpression>
              </init>
            </memberField>
            <memberMethod returnType="ControllerNodeSet" name="InternalSelect">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.Boolean" name="add"/>
                <parameter type="System.String" name="selector"/>
                <parameter type="params System.Object[]" name="args"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="argIndex"/>
                  <primitiveExpression value="0"/>
                </assignStatement>
                <assignStatement>
                  <argumentReferenceExpression name="selector"/>
                  <methodInvokeExpression methodName="Replace">
                    <target>
                      <fieldReferenceExpression name="elementNameRegex"/>
                    </target>
                    <parameters>
                      <argumentReferenceExpression name="selector"/>
                      <addressOfExpression>
                        <methodReferenceExpression methodName="DoReplaceElementName"/>
                      </addressOfExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <variableDeclarationStatement type="List" name="list">
                  <typeArguments>
                    <typeReference type="XPathNavigator"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="XPathNavigator"/>
                      </typeArguments>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <argumentReferenceExpression name="add"/>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AddRange">
                      <target>
                        <variableReferenceExpression name="list"/>
                      </target>
                      <parameters>
                        <fieldReferenceExpression name="nodes"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="List" name="rootNodes">
                  <typeArguments>
                    <typeReference type="XPathNavigator"/>
                  </typeArguments>
                  <init>
                    <fieldReferenceExpression name="nodes"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="Count">
                          <variableReferenceExpression name="rootNodes"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                      <argumentReferenceExpression name="add"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="rootNodes"/>
                      <objectCreateExpression type="List">
                        <typeArguments>
                          <typeReference type="XPathNavigator"/>
                        </typeArguments>
                      </objectCreateExpression>
                    </assignStatement>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="rootNodes"/>
                      </target>
                      <parameters>
                        <fieldReferenceExpression name="navigator"/>
                      </parameters>
                    </methodInvokeExpression>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <methodInvokeExpression methodName="IsLetter">
                            <target>
                              <typeReferenceExpression type="Char"/>
                            </target>
                            <parameters>
                              <argumentReferenceExpression name="selector"/>
                              <primitiveExpression value="0"/>
                            </parameters>
                          </methodInvokeExpression>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="IsMatch">
                              <target>
                                <fieldReferenceExpression name="namespaceRegex"/>
                              </target>
                              <parameters>
                                <argumentReferenceExpression name="selector"/>
                              </parameters>
                            </methodInvokeExpression>
                          </unaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <argumentReferenceExpression name="selector"/>
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value="//"/>
                            <argumentReferenceExpression name="selector"/>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                  <falseStatements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <methodInvokeExpression methodName="IsLetter">
                            <target>
                              <typeReferenceExpression type="Char"/>
                            </target>
                            <parameters>
                              <argumentReferenceExpression name="selector"/>
                              <primitiveExpression value="0"/>
                            </parameters>
                          </methodInvokeExpression>
                          <unaryOperatorExpression operator="Not">
                            <methodInvokeExpression methodName="IsMatch">
                              <target>
                                <fieldReferenceExpression name="namespaceRegex"/>
                              </target>
                              <parameters>
                                <argumentReferenceExpression name="selector"/>
                              </parameters>
                            </methodInvokeExpression>
                          </unaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <argumentReferenceExpression name="selector"/>
                          <binaryOperatorExpression operator="Add">
                            <primitiveExpression value=".//"/>
                            <argumentReferenceExpression name="selector"/>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </falseStatements>
                </conditionStatement>
                <foreachStatement>
                  <variable type="XPathNavigator" name="root"/>
                  <target>
                    <variableReferenceExpression name="rootNodes"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="GreaterThan">
                          <propertyReferenceExpression name="Length">
                            <argumentReferenceExpression name="args"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <fieldReferenceExpression name="args"/>
                          <argumentReferenceExpression name="args"/>
                        </assignStatement>
                        <whileStatement>
                          <test>
                            <binaryOperatorExpression operator="LessThan">
                              <fieldReferenceExpression name="argIndex"/>
                              <propertyReferenceExpression name="Length">
                                <argumentReferenceExpression name="args"/>
                              </propertyReferenceExpression>
                            </binaryOperatorExpression>
                          </test>
                          <statements>
                            <variableDeclarationStatement type="System.String" name="xpath">
                              <init>
                                <methodInvokeExpression methodName="Replace">
                                  <target>
                                    <fieldReferenceExpression name="variableRegex"/>
                                  </target>
                                  <parameters>
                                    <argumentReferenceExpression name="selector"/>
                                    <addressOfExpression>
                                      <methodReferenceExpression methodName="DoReplaceVariable"/>
                                    </addressOfExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </init>
                            </variableDeclarationStatement>
                            <variableDeclarationStatement type="XPathNodeIterator" name="iterator">
                              <init>
                                <methodInvokeExpression methodName="Select">
                                  <target>
                                    <variableReferenceExpression name="root"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="xpath"/>
                                    <fieldReferenceExpression name="resolver"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </init>
                            </variableDeclarationStatement>
                            <whileStatement>
                              <test>
                                <methodInvokeExpression methodName="MoveNext">
                                  <target>
                                    <variableReferenceExpression name="iterator"/>
                                  </target>
                                </methodInvokeExpression>
                              </test>
                              <statements>
                                <methodInvokeExpression methodName="Add">
                                  <target>
                                    <variableReferenceExpression name="list"/>
                                  </target>
                                  <parameters>
                                    <methodInvokeExpression methodName="Clone">
                                      <target>
                                        <propertyReferenceExpression name="Current">
                                          <variableReferenceExpression name="iterator"/>
                                        </propertyReferenceExpression>
                                      </target>
                                    </methodInvokeExpression>
                                  </parameters>
                                </methodInvokeExpression>
                              </statements>
                            </whileStatement>
                          </statements>
                        </whileStatement>
                      </trueStatements>
                      <falseStatements>
                        <variableDeclarationStatement type="XPathNodeIterator" name="iterator">
                          <init>
                            <methodInvokeExpression methodName="Select">
                              <target>
                                <variableReferenceExpression name="root"/>
                              </target>
                              <parameters>
                                <argumentReferenceExpression name="selector"/>
                                <fieldReferenceExpression name="resolver"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <whileStatement>
                          <test>
                            <methodInvokeExpression methodName="MoveNext">
                              <target>
                                <variableReferenceExpression name="iterator"/>
                              </target>
                            </methodInvokeExpression>
                          </test>
                          <statements>
                            <methodInvokeExpression methodName="Add">
                              <target>
                                <variableReferenceExpression name="list"/>
                              </target>
                              <parameters>
                                <methodInvokeExpression methodName="Clone">
                                  <target>
                                    <propertyReferenceExpression name="Current">
                                      <variableReferenceExpression name="iterator"/>
                                    </propertyReferenceExpression>
                                  </target>
                                </methodInvokeExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </statements>
                        </whileStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="ControllerNodeSet">
                    <parameters>
                      <thisReferenceExpression/>
                      <variableReferenceExpression name="list"/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Delete() -->
            <memberMethod returnType="ControllerNodeSet" name="Delete">
              <comment>
                <![CDATA[        
                /// <summary>
                /// Deletes all nodes in the node set from the data controller definition.
                ///</summary>
                ///<returns>An empty node set.</returns>]]>
              </comment>
              <attributes public="true" final="true"/>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <methodInvokeExpression methodName="DeleteSelf">
                      <target>
                        <variableReferenceExpression name="node"/>
                      </target>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="ControllerNodeSet">
                    <parameters>
                      <fieldReferenceExpression name="navigator"/>
                      <fieldReferenceExpression name="resolver"/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Attr(string) -->
            <memberMethod returnType="ControllerNodeSet" name="Attr">
              <comment>
                <![CDATA[
              /// <summary>
              /// Selects the value of the attribute with the specified name from all nodes in the node set.
              /// </summary>
              /// <param name="name">The name of the XML attribute.</param>
              /// <returns>The collection of the XML nodes representing values of the specified attribute.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="InternalSelect">
                    <parameters>
                      <primitiveExpression value="false"/>
                      <binaryOperatorExpression operator="Add">
                        <primitiveExpression value="@"/>
                        <argumentReferenceExpression name="name"/>
                      </binaryOperatorExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Attr(string, object) -->
            <memberMethod returnType="ControllerNodeSet" name="Attr">
              <comment>
                <![CDATA[
        /// <summary>
        /// Assigns the value to the attribute with the specified name for all nodes in the node set.
        /// </summary>
        /// <param name="name">The name of the XML attribute.</param>
        /// <param name="value">The value of the XML attribute.</param>
        /// <returns></returns>
        ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
                <parameter type="System.Object" name="value"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="s">
                  <init>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <typeReferenceExpression type="Convert"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="value"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IsTypeOf">
                      <variableReferenceExpression name="value"/>
                      <typeReferenceExpression type="System.Boolean"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="s"/>
                      <methodInvokeExpression methodName="ToLower">
                        <target>
                          <variableReferenceExpression name="s"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <foreachStatement>
                  <variable type="XPathNavigator" name="nav"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="XPathNavigator" name="attrNav">
                      <init>
                        <methodInvokeExpression methodName="SelectSingleNode">
                          <target>
                            <variableReferenceExpression name="nav"/>
                          </target>
                          <parameters>
                            <binaryOperatorExpression operator="Add">
                              <primitiveExpression value="@"/>
                              <argumentReferenceExpression name="name"/>
                            </binaryOperatorExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="attrNav"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="SetValue">
                          <target>
                            <variableReferenceExpression name="attrNav"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="s"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                      <falseStatements>
                        <methodInvokeExpression methodName="CreateAttribute">
                          <target>
                            <variableReferenceExpression name="nav"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Empty">
                              <typeReferenceExpression type="String"/>
                            </propertyReferenceExpression>
                            <argumentReferenceExpression name="name"/>
                            <propertyReferenceExpression name="Empty">
                              <typeReferenceExpression type="String"/>
                            </propertyReferenceExpression>
                            <variableReferenceExpression name="s"/>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method AppendTo(ControllerNodeSet) -->
            <memberMethod returnType="ControllerNodeSet" name="AppendTo">
              <comment>
                <![CDATA[
       /// <summary>
        /// Appends a collection specified by the argument to each node in the node sets.
        /// </summary>
        /// <param name="nodeSet">The collection of child nodes.</param>
        /// <returns>The collection of child nodes after they were appended to the nodes in the original node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="ControllerNodeSet" name="nodeSet"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes">
                      <thisReferenceExpression/>
                    </fieldReferenceExpression>
                  </target>
                  <statements>
                    <foreachStatement >
                      <variable type="XPathNavigator" name="parentNode"/>
                      <target>
                        <fieldReferenceExpression name="nodes">
                          <argumentReferenceExpression name="nodeSet"/>
                        </fieldReferenceExpression>
                      </target>
                      <statements>
                        <methodInvokeExpression methodName="AppendChild">
                          <target>
                            <variableReferenceExpression name="parentNode"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="OuterXml">
                              <variableReferenceExpression name="node"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </statements>
                    </foreachStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <argumentReferenceExpression name="nodeSet"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method AppendTo(string, params object[]) -->
            <memberMethod returnType="ControllerNodeSet" name="AppendTo">
              <comment>
                <![CDATA[
        /// <summary>
        /// Appends a collection specified by the argument to each node in the node sets.
        /// </summary>
        ///<param name="selector">XPath expression evaluated against the definition of the data controller. May contain variables.</param>
        ///<param name="args">Optional values of variables. If variables are specified then the expression is evaluated for each variable or group of variables specified in the selector.</param>
        ///<example>field[@name=$name]</example>
        /// <returns>The collection of child nodes after they were appended to the nodes in the original node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="selector"/>
                <parameter type="params System.Object[]" name="args"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="AppendTo">
                    <parameters>
                      <methodInvokeExpression methodName="Select">
                        <target>
                          <objectCreateExpression type="ControllerNodeSet">
                            <parameters>
                              <fieldReferenceExpression name="navigator"/>
                              <fieldReferenceExpression name="resolver"/>
                            </parameters>
                          </objectCreateExpression>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="selector"/>
                          <argumentReferenceExpression name="args"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Arrange(string selector, params string[] sequence) -->
            <memberMethod returnType="ControllerNodeSet" name="Arrange">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="selector"/>
                <parameter type="params System.String[]" name="sequence"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.Int32" name="i">
                  <init>
                    <binaryOperatorExpression operator="Subtract">
                      <propertyReferenceExpression name="Length">
                        <argumentReferenceExpression name="sequence"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="1"/>
                    </binaryOperatorExpression>
                  </init>
                </variableDeclarationStatement>
                <whileStatement>
                  <test>
                    <binaryOperatorExpression operator="GreaterThanOrEqual">
                      <variableReferenceExpression name="i"/>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </test>
                  <statements>
                    <foreachStatement>
                      <variable type="XPathNavigator" name="node"/>
                      <target>
                        <fieldReferenceExpression name="nodes"/>
                      </target>
                      <statements>
                        <variableDeclarationStatement type="XPathNavigator" name="seqNav">
                          <init>
                            <methodInvokeExpression methodName="SelectSingleNode">
                              <target>
                                <variableReferenceExpression name="node"/>
                              </target>
                              <parameters>
                                <argumentReferenceExpression name="selector"/>
                                <fieldReferenceExpression name="resolver"/>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="BooleanAnd">
                              <binaryOperatorExpression operator="IdentityInequality">
                                <variableReferenceExpression name="seqNav"/>
                                <primitiveExpression value="null"/>
                              </binaryOperatorExpression>
                              <binaryOperatorExpression operator="ValueEquality">
                                <propertyReferenceExpression name="Value">
                                  <variableReferenceExpression name="seqNav"/>
                                </propertyReferenceExpression>
                                <arrayIndexerExpression>
                                  <target>
                                    <argumentReferenceExpression name="sequence"/>
                                  </target>
                                  <indices>
                                    <variableReferenceExpression name="i"/>
                                  </indices>
                                </arrayIndexerExpression>
                              </binaryOperatorExpression>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <variableDeclarationStatement type="XPathNavigator" name="sibling">
                              <init>
                                <methodInvokeExpression methodName="Clone">
                                  <target>
                                    <variableReferenceExpression name="node"/>
                                  </target>
                                </methodInvokeExpression>
                              </init>
                            </variableDeclarationStatement>
                            <methodInvokeExpression methodName="MoveToParent">
                              <target>
                                <variableReferenceExpression name="sibling"/>
                              </target>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="MoveToFirstChild">
                              <target>
                                <variableReferenceExpression name="sibling"/>
                              </target>
                            </methodInvokeExpression>
                            <conditionStatement>
                              <condition>
                                <unaryOperatorExpression operator="Not">
                                  <methodInvokeExpression methodName="IsSamePosition">
                                    <target>
                                      <variableReferenceExpression name="sibling"/>
                                    </target>
                                    <parameters>
                                      <variableReferenceExpression name="node"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </unaryOperatorExpression>
                              </condition>
                              <trueStatements>
                                <methodInvokeExpression methodName="InsertBefore">
                                  <target>
                                    <variableReferenceExpression name="sibling"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="node"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <methodInvokeExpression methodName="DeleteSelf">
                                  <target>
                                    <variableReferenceExpression name="node"/>
                                  </target>
                                </methodInvokeExpression>
                              </trueStatements>
                            </conditionStatement>
                            <breakStatement/>
                          </trueStatements>
                        </conditionStatement>
                      </statements>
                    </foreachStatement>
                    <comment>continue to the next value in sequence</comment>
                    <assignStatement>
                      <variableReferenceExpression name="i"/>
                      <binaryOperatorExpression operator="Subtract">
                        <variableReferenceExpression name="i"/>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </statements>
                </whileStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Elem(string) -->
            <memberMethod returnType="ControllerNodeSet" name="Elem">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="InternalSelect">
                    <parameters>
                      <primitiveExpression value="false"/>
                      <argumentReferenceExpression name="name"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Elem(string, object) -->
            <memberMethod returnType="ControllerNodeSet" name="Elem">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
                <parameter type="System.Object" name="value"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="s">
                  <init>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <typeReferenceExpression type="Convert"/>
                      </target>
                      <parameters>
                        <argumentReferenceExpression name="value"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="selector">
                  <init>
                    <binaryOperatorExpression operator="Add">
                      <primitiveExpression value="c:"/>
                      <argumentReferenceExpression name="name"/>
                    </binaryOperatorExpression>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="XPathNavigator" name="elemNav">
                      <init>
                        <methodInvokeExpression methodName="SelectSingleNode">
                          <target>
                            <variableReferenceExpression name="node"/>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="selector"/>
                            <fieldReferenceExpression name="resolver"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityEquality">
                          <variableReferenceExpression name="elemNav"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AppendChild">
                          <target>
                            <variableReferenceExpression name="node"/>
                          </target>
                          <parameters>
                            <stringFormatExpression format="&lt;{{0}}/>">
                              <argumentReferenceExpression name="name"/>
                            </stringFormatExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="elemNav"/>
                          <methodInvokeExpression methodName="SelectSingleNode">
                            <target>
                              <variableReferenceExpression name="node"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="selector"/>
                              <fieldReferenceExpression name="resolver"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="SetValue">
                      <target>
                        <variableReferenceExpression name="elemNav"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="s"/>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectInContext(string, string, params object[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectInContext">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.String" name="contextNode"/>
                <parameter type="System.String" name="selector"/>
                <parameter type="params System.Object[]" name="args"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Name">
                            <variableReferenceExpression name="node"/>
                          </propertyReferenceExpression>
                          <argumentReferenceExpression name="contextNode"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="MoveToParent">
                          <target>
                            <variableReferenceExpression name="node"/>
                          </target>
                        </methodInvokeExpression>
                        <methodReturnStatement>
                          <methodInvokeExpression methodName="InternalSelect">
                            <parameters>
                              <primitiveExpression value="false"/>
                              <argumentReferenceExpression name="selector"/>
                              <argumentReferenceExpression name="args"/>
                            </parameters>
                          </methodInvokeExpression>
                        </methodReturnStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="InternalSelect">
                    <parameters>
                      <primitiveExpression value="false"/>
                      <argumentReferenceExpression name="selector"/>
                      <argumentReferenceExpression name="args"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectField(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectField">
              <comment>
                <![CDATA[
        /// <summary>
        /// Select the data controller field node.
        /// </summary>
        /// <param name="name">The name of the field.</param>
        /// <returns></returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="InternalSelect">
                    <target>
                      <methodInvokeExpression methodName="NodeSet"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="false"/>
                      <stringFormatExpression format="/dataController/fields/field[@name='{{0}}']">
                        <argumentReferenceExpression name="name"/>
                      </stringFormatExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectCommand(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectCommand">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="InternalSelect">
                    <target>
                      <methodInvokeExpression methodName="NodeSet"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="false"/>
                      <stringFormatExpression format="/dataController/commands/command[@id='{{0}}']">
                        <argumentReferenceExpression name="id"/>
                      </stringFormatExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectViews(params string[])-->
            <memberMethod returnType="ControllerNodeSet" name="SelectViews">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="identifiers"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Length">
                        <argumentReferenceExpression name="identifiers"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Select">
                        <target>
                          <methodInvokeExpression methodName="NodeSet"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="/dataController/views/view"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.Boolean" name="searchByType">
                  <init>
                    <primitiveExpression value="false"/>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="System.String" name="s"/>
                  <target>
                    <arrayCreateExpression>
                      <createType type="System.String"/>
                      <initializers>
                        <primitiveExpression value="Grid"/>
                        <primitiveExpression value="Form"/>
                        <primitiveExpression value="DataSheet"/>
                        <primitiveExpression value="Chart"/>
                        <primitiveExpression value="Tree"/>
                      </initializers>
                    </arrayCreateExpression>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueInequality">
                          <methodInvokeExpression methodName="IndexOf">
                            <target>
                              <typeReferenceExpression type="Array"/>
                            </target>
                            <parameters>
                              <argumentReferenceExpression name="identifiers"/>
                              <variableReferenceExpression name="s"/>
                            </parameters>
                          </methodInvokeExpression>
                          <primitiveExpression value="-1"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="searchByType"/>
                          <primitiveExpression value="true"/>
                        </assignStatement>
                        <breakStatement/>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <conditionStatement>
                  <condition>
                    <variableReferenceExpression name="searchByType"/>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Select">
                        <target>
                          <methodInvokeExpression methodName="NodeSet"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="/dataController/views/view[@type=$type]"/>
                          <argumentReferenceExpression name="identifiers"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Select">
                    <target>
                      <methodInvokeExpression methodName="NodeSet"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="/dataController/views/view[@id=$id]"/>
                      <argumentReferenceExpression name="identifiers"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method NodeSet -->
            <memberMethod returnType="ControllerNodeSet" name="NodeSet">
              <comment>
                <![CDATA[
        /// <summary>
        /// Creates an empty data controller node set.
        /// </summary>
        /// <returns>Returns an empty data controller node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <objectCreateExpression type="ControllerNodeSet">
                    <parameters>
                      <thisReferenceExpression/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectView(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectView">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Select">
                    <target>
                      <methodInvokeExpression methodName="NodeSet"/>
                    </target>
                    <parameters>
                      <stringFormatExpression format="/dataController/views/view[@id='{{0}}']">
                        <argumentReferenceExpression name="id"/>
                      </stringFormatExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectDataFields(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectDataFields">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="fieldNames"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="List" name="list">
                  <typeArguments>
                    <typeReference type="XPathNavigator"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="XPathNavigator"/>
                      </typeArguments>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="ControllerNodeSet" name="nodeSet">
                      <init>
                        <objectCreateExpression type="ControllerNodeSet">
                          <parameters>
                            <thisReferenceExpression/>
                            <variableReferenceExpression name="node"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Length">
                            <variableReferenceExpression name="fieldNames"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AddRange">
                          <target>
                            <variableReferenceExpression name="list"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Nodes">
                              <methodInvokeExpression methodName="SelectInContext">
                                <target>
                                  <variableReferenceExpression name="nodeSet"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="dataField"/>
                                  <primitiveExpression value="dataField"/>
                                </parameters>
                              </methodInvokeExpression>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                      <falseStatements>
                        <methodInvokeExpression methodName="AddRange">
                          <target>
                            <variableReferenceExpression name="list"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="Nodes">
                              <methodInvokeExpression methodName="SelectInContext">
                                <target>
                                  <variableReferenceExpression name="nodeSet"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="dataField"/>
                                  <primitiveExpression value="dataField[@fieldName=$fieldName]"/>
                                  <argumentReferenceExpression name="fieldNames"/>
                                </parameters>
                              </methodInvokeExpression>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="ControllerNodeSet">
                    <parameters>
                      <thisReferenceExpression/>
                      <variableReferenceExpression name="list"/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectDataField(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectDataField">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectDataFields">
                    <parameters>
                      <argumentReferenceExpression name="fieldName"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectCategory(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectCategory">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectInContext">
                    <parameters>
                      <primitiveExpression value="category"/>
                      <stringFormatExpression format="category[@id='{{0}}']">
                        <argumentReferenceExpression name="id"/>
                      </stringFormatExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectAction(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectAction">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectInContext">
                    <parameters>
                      <primitiveExpression value="action"/>
                      <stringFormatExpression format="action[@id='{{0}}']">
                        <argumentReferenceExpression name="id"/>
                      </stringFormatExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectActions(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectActions">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="commandNames"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Length">
                        <argumentReferenceExpression name="commandNames"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="SelectInContext">
                        <parameters>
                          <primitiveExpression value="action"/>
                          <primitiveExpression value="action"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="List" name="commandNameList">
                  <typeArguments>
                    <typeReference type="System.String"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="System.String"/>
                      </typeArguments>
                      <parameters>
                        <argumentReferenceExpression name="commandNames"/>
                      </parameters>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Contains">
                      <target>
                        <argumentReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="CHANGE"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Remove">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="CHANGE"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Edit"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="BatchEdit"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="New"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Delete"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Update"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Insert"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Import"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Duplicate"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Contains">
                      <target>
                        <argumentReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="NEW"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Remove">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="NEW"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="New"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Insert"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Import"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Duplicate"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Contains">
                      <target>
                        <argumentReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="EDIT"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Remove">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="EDIT"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Edit"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="BatchEdit"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Update"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Contains">
                      <target>
                        <argumentReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="EXPORT"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Remove">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="EXPORT"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="ExportCsv"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="ExportRss"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="ExportRowset"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <methodInvokeExpression methodName="Contains">
                      <target>
                        <argumentReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="REPORT"/>
                      </parameters>
                    </methodInvokeExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Remove">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="REPORT"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="Report"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="ReportAsPdf"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="ReportAsImage"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="ReportAsExcel"/>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <variableReferenceExpression name="commandNameList"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="ReportAsWord"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectInContext">
                    <parameters>
                      <primitiveExpression value="action"/>
                      <primitiveExpression value="action[@commandName=$commandName]"/>
                      <methodInvokeExpression methodName="ToArray">
                        <target>
                          <argumentReferenceExpression name="commandNameList"/>
                        </target>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectCustomAction(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectCustomAction">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="commandArgument"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectCustomActions">
                    <parameters>
                      <argumentReferenceExpression name="commandArgument"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectCustomActions(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectCustomActions">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="commandArguments"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Length">
                        <argumentReferenceExpression name="commandArguments"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="SelectInContext">
                        <parameters>
                          <primitiveExpression value="action"/>
                          <primitiveExpression value="action[@commandName='Custom']"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectInContext">
                    <parameters>
                      <primitiveExpression value="action"/>
                      <primitiveExpression value="action[@commandName='Custom' and @commandArgument=$commandArgument]"/>
                      <argumentReferenceExpression name="commandArguments"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectActionGroups(param string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectActionGroups">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="scopes"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Length">
                        <argumentReferenceExpression name="scopes"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="SelectInContext">
                        <parameters>
                          <primitiveExpression value="actionGroup"/>
                          <primitiveExpression value="actionGroup"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                  <falseStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="SelectInContext">
                        <parameters>
                          <primitiveExpression value="actionGroup"/>
                          <primitiveExpression value="actionGroup[@scope=$scope]"/>
                          <argumentReferenceExpression name="scopes"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </falseStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
            <!-- method SelectActionGroup(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectActionGroup">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectInContext">
                    <parameters>
                      <primitiveExpression value="actionGroup"/>
                      <stringFormatExpression format="actionGroup[@id='{{0}}']">
                        <argumentReferenceExpression name="id"/>
                      </stringFormatExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetProperty(string, object, params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SetProperty">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
                <parameter type="System.Object" name="value"/>
                <parameter type="params System.String[]" name="requiresElement"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="ControllerNodeSet" name="nodeSet">
                      <init>
                        <objectCreateExpression type="ControllerNodeSet">
                          <parameters>
                            <thisReferenceExpression/>
                            <variableReferenceExpression name="node"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="GreaterThanOrEqual">
                          <methodInvokeExpression methodName="IndexOf">
                            <target>
                              <typeReferenceExpression type="Array"/>
                            </target>
                            <parameters>
                              <argumentReferenceExpression name="requiresElement"/>
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="node"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </methodInvokeExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Elem">
                          <target>
                            <variableReferenceExpression name="nodeSet"/>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="name"/>
                            <argumentReferenceExpression name="value"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                      <falseStatements>
                        <methodInvokeExpression methodName="Attr">
                          <target>
                            <variableReferenceExpression name="nodeSet"/>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="name"/>
                            <argumentReferenceExpression name="value"/>
                          </parameters>
                        </methodInvokeExpression>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetRoles(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Restricts access to the field or action to a list of comma-separated roles.
        /// </summary>
        /// <param name="roles">The list of comma-separated roles.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </xsl:with-param>
              <xsl:with-param name="Property" select="'Roles'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetWriteRoles(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Restricts 'write' access to the field to the list of comma-separated roles.
        /// </summary>
        /// <param name="writeRoles">The list of comma-separated roles.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </xsl:with-param>
              <xsl:with-param name="Property" select="'WriteRoles'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetTag(string tag) -->
            <memberMethod returnType="ControllerNodeSet" name="SetTag">
              <attributes public="true"/>
              <parameters>
                <parameter type="System.String" name="value"/>
              </parameters>
              <statements>
                <variableDeclarationStatement name="attributeName">
                  <init>
                    <primitiveExpression value="tag"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <binaryOperatorExpression operator="GreaterThan">
                        <propertyReferenceExpression name="Count">
                          <fieldReferenceExpression name="nodes"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="0"/>
                      </binaryOperatorExpression>
                      <binaryOperatorExpression operator="ValueEquality">
                        <propertyReferenceExpression name="Name">
                          <arrayIndexerExpression>
                            <target>
                              <fieldReferenceExpression name="nodes"/>
                            </target>
                            <indices>
                              <primitiveExpression value="0"/>
                            </indices>
                          </arrayIndexerExpression>
                        </propertyReferenceExpression>
                        <primitiveExpression value="view"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="attributeName"/>
                      <primitiveExpression value="tags"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="System.String" name="tagList">
                  <init>
                    <methodInvokeExpression methodName="Value">
                      <target>
                        <methodInvokeExpression methodName="Attr">
                          <parameters>
                            <variableReferenceExpression name="attributeName"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <unaryOperatorExpression operator="IsNotNullOrEmpty">
                        <variableReferenceExpression name="tagList"/>
                      </unaryOperatorExpression>
                      <unaryOperatorExpression operator="IsNotNullOrEmpty">
                        <argumentReferenceExpression name="value"/>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="tagList"/>
                      <binaryOperatorExpression operator="Add">
                        <variableReferenceExpression name="tagList"/>
                        <primitiveExpression value=" "/>
                      </binaryOperatorExpression>
                    </assignStatement>
                    <assignStatement>
                      <argumentReferenceExpression name="value"/>
                      <binaryOperatorExpression operator="Add">
                        <variableReferenceExpression name="tagList"/>
                        <argumentReferenceExpression name="value"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Attr">
                    <parameters>
                      <variableReferenceExpression name="attributeName"/>
                      <argumentReferenceExpression name="value"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetHeaderText(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'HeaderText'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Element1" select="'dataField'"/>
              <xsl:with-param name="Element2" select="'view'"/>
            </xsl:call-template>
            <!-- method SetFooterText(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'FooterText'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Element1" select="'dataField'"/>
              <xsl:with-param name="Element2" select="'view'"/>
            </xsl:call-template>
            <!-- method SetLabel(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Label'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetSortExpression(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'SortExpression'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetGroupExpression(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'GroupExpression'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetFilter(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Filter'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetGroup(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Group'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetShowInSelector(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'ShowInSelector'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
            </xsl:call-template>
            <!-- method SetReportFont(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'ReportFont'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetReportLabel(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'ReportLabel'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetReportOrientation(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'ReportOrientation'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetReportTemplate(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'ReportTemplate'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetHidden(bool) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Hidden'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
            </xsl:call-template>
            <!-- method SetReadOnly(bool) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'ReadOnly'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
            </xsl:call-template>
            <!-- method SetFormatOnClient(bool) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'FormatOnClient'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
            </xsl:call-template>
            <!-- method SetCommandName(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'CommandName'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetCommandArgument(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'CommandArgument'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetConfirmation(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Confirmation'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetType(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Type'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetScope(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Scope'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetFlat(bool) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Flat'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
            </xsl:call-template>
            <!-- method SetNewColumn(bool) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'NewColumn'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
            </xsl:call-template>
            <!-- method SetFloating(bool) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Floating'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
            </xsl:call-template>
            <!-- method SetTab(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Tab'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetDescription(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Description'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Element1" select="'category'"/>
            </xsl:call-template>
            <!-- method SetColumns(int) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Columns'"/>
              <xsl:with-param name="Type" select="'Int32'"/>
            </xsl:call-template>
            <!-- method SetLength(int) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Length'"/>
              <xsl:with-param name="Type" select="'Int32'"/>
            </xsl:call-template>
            <!-- method SetRows(int) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Rows'"/>
              <xsl:with-param name="Type" select="'Int32'"/>
            </xsl:call-template>
            <!-- method SetDataFormatString(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'DataFormatString'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetTextMode(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'TextMode'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetSearch(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Search'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetSearchOptions(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'SearchOptions'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetAccess(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Access'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetAggregate(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Aggregate'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetAutoCompletePrefixLength(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'AutoCompletePrefixLength'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetHyperlinkFormatString(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'HyperlinkFormatString'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetName(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'Name'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method SetFieldName(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'FieldName'"/>
              <xsl:with-param name="Type" select="'String'"/>
            </xsl:call-template>
            <!-- method WhenLastCommandName(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'WhenLastCommandName'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Allows action if the last command name executed in the data view matches the argument.
        /// </summary>
        /// <param name="lastCommandName">The name of the last command.</param>
        /// <returns>The node set containing the action.</returns>
              ]]>
              </xsl:with-param>
            </xsl:call-template>
            <!-- method WhenLastCommandArgument(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'WhenLastCommandArgument'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Allows action if the last command argument executed in the data view matches the argument.
        /// </summary>
        /// <param name="lastCommandArgument">The name of the last argument.</param>
        /// <returns>The node set containing the action.</returns>
              ]]>
              </xsl:with-param>
            </xsl:call-template>
            <!-- method WhenClientScript(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'WhenClientScript'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Allows action if the JavaScript expression specified in the argument evalues as true. The field values can be referenced in square brackets by name. For example, [Status] == 'Open'
        /// </summary>
        /// <param name="clientScript">The JavaScript expression.</param>
        /// <returns>The node set containing the action.</returns>
              ]]>
              </xsl:with-param>
            </xsl:call-template>
            <!-- method WhenHRef(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'WhenHRef'"/>
              <xsl:with-param name="Argument" select="'Href'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Allows action if the regular expression specified in the argument evalutes as a match against the URL in the address bar of the web browser.
        /// </summary>
        /// <param name="href">The regular expression.</param>
        /// <returns>The node set containing the action.</returns>
              ]]>
              </xsl:with-param>
            </xsl:call-template>
            <!-- method WhenTag(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'WhenTag'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Allows action if the regular expression specified in the argument evalutes as a match against the data view 'Tag' property.
        /// </summary>
        /// <param name="tag">The regular expression.</param>
        /// <returns>The node set containing the action.</returns>
              ]]>
              </xsl:with-param>
            </xsl:call-template>
            <!-- method WhenView(string) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'WhenView'"/>
              <xsl:with-param name="Argument" select="'ViewId'"/>
              <xsl:with-param name="Type" select="'String'"/>
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Allows action if the regular expression specified in the argument evalutes as a match against the ID of the view controller. For example, (grid1|grid2).
        /// </summary>
        /// <param name="viewId">The regular expression.</param>
        /// <returns>The node set containing the action.</returns>
              ]]>
              </xsl:with-param>
            </xsl:call-template>
            <!-- method WhenKeySelected(bool) -->
            <xsl:call-template name="CreateVirtualizationPlugin">
              <xsl:with-param name="Property" select="'WhenKeySelected'"/>
              <xsl:with-param name="Type" select="'Boolean'"/>
              <xsl:with-param name="Comment">
                <![CDATA[
        /// <summary>
        /// Allows action if a data row is selected in the data view.
        /// </summary>
        /// <param name="keySelected">The boolean value indicating if a data row is selected.</param>
        /// <returns>The node set containing the action.</returns>
              ]]>
              </xsl:with-param>
            </xsl:call-template>
            <!-- method CreateActionGroup() -->
            <memberMethod returnType="ControllerNodeSet" name="CreateActionGroup">
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateActionGroup">
                    <parameters>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateActionGroup(string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateActionGroup">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ControllerNodeSet" name="actionGroupNode">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <target>
                        <methodInvokeExpression methodName="AppendTo">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <target>
                                <objectCreateExpression type="ControllerNodeSet">
                                  <parameters>
                                    <fieldReferenceExpression name="navigator"/>
                                    <fieldReferenceExpression name="resolver"/>
                                  </parameters>
                                </objectCreateExpression>
                              </target>
                              <parameters>
                                <primitiveExpression value="&lt;actionGroup/>"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="/dataController/actions"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="/dataController/actions/actionGroup[last()]"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="id"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="actionGroupNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="id"/>
                        <argumentReferenceExpression name="id"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="actionGroupNode"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateAction() -->
            <memberMethod returnType="ControllerNodeSet" name="CreateAction">
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateAction">
                    <parameters>
                      <primitiveExpression value="null"/>
                      <primitiveExpression value="null"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateAction(string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateAction">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateAction">
                    <parameters>
                      <primitiveExpression value="null"/>
                      <primitiveExpression value="null"/>
                      <argumentReferenceExpression name="id"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateAction(string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateAction">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateAction">
                    <parameters>
                      <argumentReferenceExpression name="commandName"/>
                      <argumentReferenceExpression name="commandArgument"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateAction(string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateAction">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ControllerNodeSet" name="actionNode">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <target>
                        <methodInvokeExpression methodName="AppendTo">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <parameters>
                                <primitiveExpression value="&lt;action/>"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <methodInvokeExpression methodName="Select">
                              <target>
                                <thisReferenceExpression/>
                              </target>
                              <parameters>
                                <primitiveExpression value="ancestor-or-self::actionGroup"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="action[last()]"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="id"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="actionNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="id"/>
                        <argumentReferenceExpression name="id"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="commandName"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="actionNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="commandName"/>
                        <argumentReferenceExpression name="commandName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="commandArgument"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="actionNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="commandArgument"/>
                        <argumentReferenceExpression name="commandArgument"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="actionNode"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateView(string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateView">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateView">
                    <parameters>
                      <argumentReferenceExpression name="id"/>
                      <primitiveExpression value="Grid"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateView(string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateView">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
                <parameter type="System.String" name="type"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateView">
                    <parameters>
                      <argumentReferenceExpression name="id"/>
                      <argumentReferenceExpression name="type"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateView(string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateView">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
                <parameter type="System.String" name="type"/>
                <parameter type="System.String" name="commandId"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <argumentReferenceExpression name="commandId"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="XPathNavigator" name="commandIdNav">
                      <init>
                        <methodInvokeExpression methodName="SelectSingleNode">
                          <target>
                            <fieldReferenceExpression name="navigator"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="/c:dataController/c:commands/c:command/@id"/>
                            <fieldReferenceExpression name="resolver"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IdentityInequality">
                          <variableReferenceExpression name="commandIdNav"/>
                          <primitiveExpression value="null"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <argumentReferenceExpression name="commandId"/>
                          <propertyReferenceExpression name="Value">
                            <variableReferenceExpression name="commandIdNav"/>
                          </propertyReferenceExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Attr">
                    <target>
                      <methodInvokeExpression methodName="Attr">
                        <target>
                          <methodInvokeExpression methodName="Attr">
                            <target>
                              <methodInvokeExpression methodName="Select">
                                <target>
                                  <methodInvokeExpression methodName="AppendTo">
                                    <target>
                                      <methodInvokeExpression methodName="Select">
                                        <target>
                                          <objectCreateExpression type="ControllerNodeSet">
                                            <parameters>
                                              <fieldReferenceExpression name="navigator"/>
                                              <fieldReferenceExpression name="resolver"/>
                                            </parameters>
                                          </objectCreateExpression>
                                        </target>
                                        <parameters>
                                          <primitiveExpression value="&lt;view/>"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="/dataController/views"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </target>
                                <parameters>
                                  <primitiveExpression value="/dataController/views/view[last()]"/>
                                </parameters>
                              </methodInvokeExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="type"/>
                              <variableReferenceExpression name="type"/>
                            </parameters>
                          </methodInvokeExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="commandId"/>
                          <argumentReferenceExpression name="commandId"/>
                        </parameters>
                      </methodInvokeExpression>
                    </target>
                    <parameters>
                      <primitiveExpression value="id"/>
                      <argumentReferenceExpression name="id"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateCategory(string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateCategory">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateCategory">
                    <parameters>
                      <argumentReferenceExpression name="id"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateCategory(string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateCategory">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="id"/>
                <parameter type="System.String" name="headerText"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="ControllerNodeSet" name="parentNode">
                      <init>
                        <objectCreateExpression type="ControllerNodeSet">
                          <parameters>
                            <thisReferenceExpression/>
                            <variableReferenceExpression name="node"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="ControllerNodeSet" name="categoriesNode">
                      <init>
                        <variableReferenceExpression name="parentNode"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueInequality">
                          <propertyReferenceExpression name="Name">
                            <variableReferenceExpression name="node"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="categories"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="categoriesNode"/>
                          <methodInvokeExpression methodName="Select">
                            <target>
                              <variableReferenceExpression name="parentNode"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="categories|ancestor::categories[1]"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Count">
                                <propertyReferenceExpression name="Nodes">
                                  <variableReferenceExpression name="categoriesNode"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                              <primitiveExpression value="0"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="AppendTo">
                              <target>
                                <methodInvokeExpression methodName="Select">
                                  <parameters>
                                    <primitiveExpression value="&lt;categories/>"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="parentNode"/>
                              </parameters>
                            </methodInvokeExpression>
                            <assignStatement>
                              <variableReferenceExpression name="categoriesNode"/>
                              <methodInvokeExpression methodName="Select">
                                <target>
                                  <variableReferenceExpression name="parentNode"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="categories"/>
                                </parameters>
                              </methodInvokeExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Elem">
                        <target>
                          <methodInvokeExpression methodName="Attr">
                            <target>
                              <methodInvokeExpression methodName="Attr">
                                <target>
                                  <methodInvokeExpression methodName="Select">
                                    <target>
                                      <methodInvokeExpression methodName="AppendTo">
                                        <target>
                                          <methodInvokeExpression methodName="Select">
                                            <parameters>
                                              <primitiveExpression value="&lt;category/>"/>
                                            </parameters>
                                          </methodInvokeExpression>
                                        </target>
                                        <parameters>
                                          <variableReferenceExpression name="categoriesNode"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </target>
                                    <parameters>
                                      <primitiveExpression value="category[last()]"/>
                                    </parameters>
                                  </methodInvokeExpression>
                                </target>
                                <parameters>
                                  <primitiveExpression value="id"/>
                                  <argumentReferenceExpression name="id"/>
                                </parameters>
                              </methodInvokeExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="headerText"/>
                              <argumentReferenceExpression name="headerText"/>
                            </parameters>
                          </methodInvokeExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="dataFields"/>
                          <primitiveExpression value="null"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateDataField(string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateDataField">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateDataField">
                    <parameters>
                      <argumentReferenceExpression name="fieldName"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateDataField(string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateDataField">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
                <parameter type="System.String" name="aliasFieldName"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ControllerNodeSet" name="existingFieldNode">
                  <init>
                    <methodInvokeExpression methodName="SelectDataField">
                      <parameters>
                        <argumentReferenceExpression name="fieldName"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <propertyReferenceExpression name="Count">
                        <propertyReferenceExpression name="Nodes">
                          <variableReferenceExpression name="existingFieldNode"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <variableReferenceExpression name="existingFieldNode"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="ControllerNodeSet" name="parentNode">
                      <init>
                        <objectCreateExpression type="ControllerNodeSet">
                          <parameters>
                            <thisReferenceExpression/>
                            <variableReferenceExpression name="node"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="ControllerNodeSet" name="dataFieldsNode">
                      <init>
                        <variableReferenceExpression name="parentNode"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueInequality">
                          <propertyReferenceExpression name="Name">
                            <variableReferenceExpression name="node"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="dataFields"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="dataFieldsNode"/>
                          <methodInvokeExpression methodName="Select">
                            <target>
                              <variableReferenceExpression name="parentNode"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="dataFields|ancestor::dataFields[1]"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Count">
                                <propertyReferenceExpression name="Nodes">
                                  <variableReferenceExpression name="dataFieldsNode"/>
                                </propertyReferenceExpression>
                              </propertyReferenceExpression>
                              <primitiveExpression value="0"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="AppendTo">
                              <target>
                                <methodInvokeExpression methodName="Select">
                                  <parameters>
                                    <primitiveExpression value="&lt;dataFields/>"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="parentNode"/>
                              </parameters>
                            </methodInvokeExpression>
                            <assignStatement>
                              <variableReferenceExpression name="dataFieldsNode"/>
                              <methodInvokeExpression methodName="Select">
                                <target>
                                  <variableReferenceExpression name="parentNode"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="dataFields"/>
                                </parameters>
                              </methodInvokeExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                    <variableDeclarationStatement type="ControllerNodeSet" name="dataFieldNode">
                      <init>
                        <methodInvokeExpression methodName="Attr">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <target>
                                <methodInvokeExpression methodName="AppendTo">
                                  <target>
                                    <methodInvokeExpression methodName="Select">
                                      <parameters>
                                        <primitiveExpression value="&lt;dataField/>"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="dataFieldsNode"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <primitiveExpression value="dataField[last()]"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="fieldName"/>
                            <argumentReferenceExpression name="fieldName"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNotNullOrEmpty">
                          <argumentReferenceExpression name="aliasFieldName"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Attr">
                          <target>
                            <variableReferenceExpression name="dataFieldNode"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="aliasFieldName"/>
                            <argumentReferenceExpression name="aliasFieldName"/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodReturnStatement>
                      <variableReferenceExpression name="dataFieldNode"/>
                    </methodReturnStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Hide() -->
            <memberMethod returnType="ControllerNodeSet" name="Hide">
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SetHidden">
                    <parameters>
                      <primitiveExpression value="true"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Show() -->
            <memberMethod returnType="ControllerNodeSet" name="Show">
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SetHidden">
                    <parameters>
                      <primitiveExpression value="false"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ArrangeViews(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="ArrangeViews">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="sequence"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Arrange">
                  <target>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="/dataController/views/view"/>
                      </parameters>
                    </methodInvokeExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="@id"/>
                    <argumentReferenceExpression name="sequence"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ArrangeDataFields(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="ArrangeDataFields">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="sequence"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Arrange">
                  <target>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="dataField"/>
                      </parameters>
                    </methodInvokeExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="@fieldName"/>
                    <argumentReferenceExpression name="sequence"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ArrangeCategories(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="ArrangeCategories">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="sequence"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Arrange">
                  <target>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="category"/>
                      </parameters>
                    </methodInvokeExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="@id"/>
                    <argumentReferenceExpression name="sequence"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ArrangeActionGroups(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="ArrangeActionGroups">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="sequence"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Arrange">
                  <target>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="/dataController/actions/actionGroup"/>
                      </parameters>
                    </methodInvokeExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="@id"/>
                    <argumentReferenceExpression name="sequence"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ArrangeActions(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="ArrangeActions">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="sequence"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Arrange">
                  <target>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="action"/>
                      </parameters>
                    </methodInvokeExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="@id"/>
                    <argumentReferenceExpression name="sequence"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Move(ControllerNodeSet) -->
            <memberMethod returnType="ControllerNodeSet" name="Move">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="ControllerNodeSet" name="target"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueInequality">
                      <propertyReferenceExpression name="Count">
                        <propertyReferenceExpression name="Nodes">
                          <argumentReferenceExpression name="target"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="1"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <thisReferenceExpression/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="XPathNavigator" name="targetNode">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Nodes">
                          <argumentReferenceExpression name="target"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="0"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="System.Boolean" name="skip">
                      <init>
                        <primitiveExpression value="true"/>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <binaryOperatorExpression operator="BooleanOr">
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="targetNode"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="category"/>
                            </binaryOperatorExpression>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="targetNode"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="view"/>
                            </binaryOperatorExpression>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="ValueEquality">
                            <propertyReferenceExpression name="Name">
                              <variableReferenceExpression name="node"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="dataField"/>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="skip"/>
                          <primitiveExpression value="false"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="BooleanAnd">
                          <binaryOperatorExpression operator="ValueEquality">
                            <propertyReferenceExpression name="Name">
                              <variableReferenceExpression name="targetNode"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="actionGroup"/>
                          </binaryOperatorExpression>
                          <binaryOperatorExpression operator="ValueEquality">
                            <propertyReferenceExpression name="Name">
                              <variableReferenceExpression name="node"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="action"/>
                          </binaryOperatorExpression>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <variableReferenceExpression name="skip"/>
                          <primitiveExpression value="false"/>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <variableReferenceExpression name="skip"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <variableDeclarationStatement type="XPathNavigator" name="newParent">
                          <init>
                            <variableReferenceExpression name="targetNode"/>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="ValueEquality">
                              <propertyReferenceExpression name="Name">
                                <variableReferenceExpression name="targetNode"/>
                              </propertyReferenceExpression>
                              <primitiveExpression value="category"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <assignStatement>
                              <variableReferenceExpression name="newParent"/>
                              <methodInvokeExpression methodName="SelectSingleNode">
                                <target>
                                  <variableReferenceExpression name="targetNode"/>
                                </target>
                                <parameters>
                                  <primitiveExpression value="c:dataFields"/>
                                  <fieldReferenceExpression name="resolver"/>
                                </parameters>
                              </methodInvokeExpression>
                            </assignStatement>
                          </trueStatements>
                        </conditionStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityInequality">
                              <variableReferenceExpression name="newParent"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodInvokeExpression methodName="AppendChild">
                              <target>
                                <variableReferenceExpression name="newParent"/>
                              </target>
                              <parameters>
                                <variableReferenceExpression name="node"/>
                              </parameters>
                            </methodInvokeExpression>
                            <methodInvokeExpression methodName="DeleteSelf">
                              <target>
                                <variableReferenceExpression name="node"/>
                              </target>
                            </methodInvokeExpression>
                          </trueStatements>
                        </conditionStatement>
                      </trueStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="ControllerNodeSet">
                    <parameters>
                      <thisReferenceExpression/>
                      <variableReferenceExpression name="targetNode"/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Parent() -->
            <memberMethod returnType="ControllerNodeSet" name="Parent">
              <attributes public="true" final="true"/>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <methodInvokeExpression methodName="MoveToParent">
                      <target>
                        <variableReferenceExpression name="node"/>
                      </target>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <objectCreateExpression type="ControllerNodeSet">
                        <parameters>
                          <thisReferenceExpression/>
                          <variableReferenceExpression name="node"/>
                        </parameters>
                      </objectCreateExpression>
                    </methodReturnStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectFields(params string[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectFields">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.String[]" name="names"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Length">
                        <argumentReferenceExpression name="names"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Select">
                        <target>
                          <methodInvokeExpression methodName="NodeSet"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="/dataController/fields/field"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Select">
                    <target>
                      <methodInvokeExpression methodName="NodeSet"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="/dataController/fields/field[@name=$name]"/>
                      <argumentReferenceExpression name="names"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Use() -->
            <memberMethod returnType="ControllerNodeSet" name="Use">
              <attributes public="true" final="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="GreaterThan">
                      <propertyReferenceExpression name="Count">
                        <fieldReferenceExpression name="nodes"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="StringBuilder" name="sb">
                      <init>
                        <objectCreateExpression type="StringBuilder"/>
                      </init>
                    </variableDeclarationStatement>
                    <foreachStatement>
                      <variable type="XPathNavigator" name="node"/>
                      <target>
                        <fieldReferenceExpression name="nodes"/>
                      </target>
                      <statements>
                        <methodInvokeExpression methodName="Append">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <propertyReferenceExpression name="OuterXml">
                              <variableReferenceExpression name="node"/>
                            </propertyReferenceExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </statements>
                    </foreachStatement>
                    <variableDeclarationStatement type="System.String" name="nodeName">
                      <init>
                        <propertyReferenceExpression name="Name">
                          <arrayIndexerExpression>
                            <target>
                              <fieldReferenceExpression name="nodes"/>
                            </target>
                            <indices>
                              <primitiveExpression value="0"/>
                            </indices>
                          </arrayIndexerExpression>
                        </propertyReferenceExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="XPathNavigator" name="parentNode">
                      <init>
                        <methodInvokeExpression methodName="SelectSingleNode">
                          <target>
                            <arrayIndexerExpression>
                              <target>
                                <fieldReferenceExpression name="nodes"/>
                              </target>
                              <indices>
                                <primitiveExpression value="0"/>
                              </indices>
                            </arrayIndexerExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="parent::*"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <assignStatement>
                      <propertyReferenceExpression name="InnerXml">
                        <variableReferenceExpression name="parentNode"/>
                      </propertyReferenceExpression>
                      <methodInvokeExpression methodName="ToString">
                        <target>
                          <variableReferenceExpression name="sb"/>
                        </target>
                      </methodInvokeExpression>
                    </assignStatement>
                    <variableDeclarationStatement type="ControllerNodeSet" name="nodeSet">
                      <init>
                        <objectCreateExpression type="ControllerNodeSet">
                          <parameters>
                            <thisReferenceExpression/>
                            <variableReferenceExpression name="parentNode"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="List" name="list">
                      <typeArguments>
                        <typeReference type="XPathNavigator"/>
                      </typeArguments>
                      <init>
                        <objectCreateExpression type="List">
                          <typeArguments>
                            <typeReference type="XPathNavigator"/>
                          </typeArguments>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <methodInvokeExpression methodName="AddRange">
                      <target>
                        <variableReferenceExpression name="list"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Nodes">
                          <methodInvokeExpression methodName="SelectInContext">
                            <target>
                              <variableReferenceExpression name="nodeSet"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="nodeName"/>
                              <variableReferenceExpression name="nodeName"/>
                            </parameters>
                          </methodInvokeExpression>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodReturnStatement>
                      <objectCreateExpression type="ControllerNodeSet">
                        <parameters>
                          <thisReferenceExpression/>
                          <variableReferenceExpression name="list"/>
                        </parameters>
                      </objectCreateExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectFieldItemsNode() -->
            <memberMethod returnType="ControllerNodeSet" name="SelectFieldItemsNode">
              <attributes family="true" final="true"/>
              <statements>
                <variableDeclarationStatement type="List" name="list">
                  <typeArguments>
                    <typeReference type="XPathNavigator"/>
                  </typeArguments>
                  <init>
                    <objectCreateExpression type="List">
                      <typeArguments>
                        <typeReference type="XPathNavigator"/>
                      </typeArguments>
                    </objectCreateExpression>
                  </init>
                </variableDeclarationStatement>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="ControllerNodeSet" name="parentNode">
                      <init>
                        <objectCreateExpression type="ControllerNodeSet">
                          <parameters>
                            <thisReferenceExpression/>
                            <variableReferenceExpression name="node"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="ControllerNodeSet" name="itemsNode">
                      <init>
                        <methodInvokeExpression methodName="Select">
                          <target>
                            <variableReferenceExpression name="parentNode"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="items"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Count">
                            <propertyReferenceExpression name="Nodes">
                              <variableReferenceExpression name="itemsNode"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AppendTo">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <target>
                                <variableReferenceExpression name="parentNode"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="&lt;items/>"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="parentNode"/>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="itemsNode"/>
                          <methodInvokeExpression methodName="Select">
                            <target>
                              <variableReferenceExpression name="parentNode"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="items"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="AddRange">
                      <target>
                        <variableReferenceExpression name="list"/>
                      </target>
                      <parameters>
                        <propertyReferenceExpression name="Nodes">
                          <variableReferenceExpression name="itemsNode"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="ControllerNodeSet">
                    <parameters>
                      <thisReferenceExpression/>
                      <variableReferenceExpression name="list"/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsStyle(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsStyle">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the style of lookup presentation for the field.
        /// </summary>
        /// <param name="style">The style of the lookup presentation. Supported values are AutoComplete, CheckBox, CheckBoxList, DropDownList, ListBox, Lookup, RadioButtonList, UserIdLookup, and UserNameLookup.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="style"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="style"/>
                    <argumentReferenceExpression name="style"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsNewView(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsNewView">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the new data view that will allow creating lookup items in-place.
        /// </summary>
        /// <param name="viewId">The id of a form view.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="viewId"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="newDataView"/>
                    <argumentReferenceExpression name="viewId"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsItemsController(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsController">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the data controller providing dynamic items for the lookup field.
        /// </summary>
        /// <param name="controller">The name of a the lookup data controller.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="controller"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="dataController"/>
                    <argumentReferenceExpression name="controller"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsItemsTargetController(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsTargetController">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the target data controller of a many-to-many lookup field.
        /// </summary>
        /// <param name="controller">The name of a the data controller that serves as a target of many-to-many lookup field.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="controller"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="targetController"/>
                    <argumentReferenceExpression name="controller"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsView(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsView">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the view of a data controller providing dynamic items for the lookup field.
        /// </summary>
        /// <param name="viewId">The id of the view in the lookup data controller.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="viewId"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="dataView"/>
                    <argumentReferenceExpression name="viewId"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsDataValueField(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsDataValueField">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the name of the field in the lookup data controller that will provide the lookup value.
        /// </summary>
        /// <param name="fieldName">The name of the field in the lookup data controller.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="dataValueField"/>
                    <argumentReferenceExpression name="fieldName"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsDataTextField(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsDataTextField">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the name of the field in the lookup data controller that will provide the user-friendly text displayed when a lookup value is selected.
        /// </summary>
        /// <param name="fieldName">The name of the field in the lookup data controller.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="fieldName"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="dataTextField"/>
                    <argumentReferenceExpression name="fieldName"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsCopyMap(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsCopyMap">
              <comment>
                <![CDATA[
        /// <summary>
        /// Assigns a 'copy' map to the lookup field. The map will control, which fields from the lookup data controller will be copied when a lookup value is selected.
        /// </summary>
        /// <param name="map">The 'copy' map of the lookup field. Example: ShipName=ContactName,ShipAddress=Address,ShipRegion=Region</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="map"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="copy"/>
                    <argumentReferenceExpression name="map"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsDataTextField(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsDescription">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the text displayed in the header area of lookup window.
        /// </summary>
        /// <param name="description">The description of the lookup window.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="description"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="description"/>
                    <argumentReferenceExpression name="description"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsAutoSelect(bool) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsAutoSelect">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the flag that will cause the automatic display of a lookup window in 'edit' and 'new' modes when the lookup field is blank.
        /// </summary>
        /// <param name="enable">The value indicating if lookup window is activated in 'edit' and 'new' modes.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.Boolean" name="enable"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="autoSelect"/>
                    <methodInvokeExpression methodName="ToLower">
                      <target>
                        <methodInvokeExpression methodName="ToString">
                          <target>
                            <argumentReferenceExpression name="enable"/>
                          </target>
                        </methodInvokeExpression>
                      </target>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsSearchByFirstLetter(bool) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsSearchByFirstLetter">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the flag that will allow searching by first letter in the lookup window.
        /// </summary>
        /// <param name="enable">The value indicating if search by first letter is enabled in the lookup window.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.Boolean" name="enable"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="letters"/>
                    <methodInvokeExpression methodName="ToLower">
                      <target>
                        <methodInvokeExpression methodName="ToString">
                          <target>
                            <argumentReferenceExpression name="enable"/>
                          </target>
                        </methodInvokeExpression>
                      </target>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsSearchOnStart(bool) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsSearchOnStart">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the flag that will force the lookup window to display in 'search' mode instead of rendering the first page of lookup data rows.
        /// </summary>
        /// <param name="enable">The value indicating if the 'search' mode is enabled in the lookup window.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.Boolean" name="enable"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="searchOnStart"/>
                    <methodInvokeExpression methodName="ToLower">
                      <target>
                        <methodInvokeExpression methodName="ToString">
                          <target>
                            <argumentReferenceExpression name="enable"/>
                          </target>
                        </methodInvokeExpression>
                      </target>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SetItemsPageSize(int) -->
            <memberMethod returnType="ControllerNodeSet" name="SetItemsPageSize">
              <comment>
                <![CDATA[
        /// <summary>
        /// Sets the initial page size of the lookup window.
        /// </summary>
        /// <param name="size">The initial page size of the lookup window.</param>
        /// <returns>Returns the current node set.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.Int32" name="size"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="SelectFieldItemsNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="pageSize"/>
                    <argumentReferenceExpression name="size"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectItems(params object[]) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectItems">
              <comment>
                <![CDATA[
       /// <summary>
        /// Selects the items with the specified values.
        /// </summary>
        /// <param name="values">List of item values.</param>
        /// <returns>Returns a node set with items that were matched to the list of values.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="params System.Object[]" name="values"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Length">
                        <argumentReferenceExpression name="values"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <methodInvokeExpression methodName="Select">
                        <parameters>
                          <primitiveExpression value="item"/>
                        </parameters>
                      </methodInvokeExpression>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="Select">
                    <parameters>
                      <primitiveExpression value="item[@value=$value]"/>
                      <argumentReferenceExpression name="values"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateItem(object, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateItem">
              <comment>
                <![CDATA[
        /// <summary>
        /// Create a new static item for this field.
        /// </summary>
        /// <param name="value">Value of the item stored in the database.</param>
        /// <param name="text">Text of the item presented to the user.</param>
        /// <returns>The node set containing the field.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.Object" name="value"/>
                <parameter type="System.String" name="text"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ControllerNodeSet" name="itemsNode">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="items"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Count">
                        <propertyReferenceExpression name="Nodes">
                          <variableReferenceExpression name="itemsNode"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AppendTo">
                      <target>
                        <methodInvokeExpression methodName="Select">
                          <parameters>
                            <primitiveExpression value="&lt;items/>"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <thisReferenceExpression/>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <variableReferenceExpression name="itemsNode"/>
                      <methodInvokeExpression methodName="Attr">
                        <target>
                          <methodInvokeExpression methodName="Select">
                            <parameters>
                              <primitiveExpression value="items"/>
                            </parameters>
                          </methodInvokeExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="style"/>
                          <primitiveExpression value="DropDownList"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <methodInvokeExpression methodName="Select">
                          <target>
                            <methodInvokeExpression methodName="AppendTo">
                              <target>
                                <methodInvokeExpression methodName="Select">
                                  <parameters>
                                    <primitiveExpression value="&lt;item/>"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <argumentReferenceExpression name="itemsNode"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="item[last()]"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="value"/>
                        <argumentReferenceExpression name="value"/>
                      </parameters>
                    </methodInvokeExpression>
                  </target>
                  <parameters>
                    <primitiveExpression value="text"/>
                    <argumentReferenceExpression name="text"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method VisibleWhen(string, string, params object[]) -->
            <memberMethod returnType="ControllerNodeSet" name="VisibleWhen">
              <comment>
                <![CDATA[
        /// <summary>
        /// Defines a JavaScript expression to evaluate visibility of a data field or category at runtime.
        /// </summary>
        /// <param name="clientScript">The JavaScript expression evaluating the data field or category visibility.</param>
        /// <param name="args">The list of arguments referenced in the JavaScript expression.</param>
        /// <returns>The node set containing the data field or category.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="clientScript"/>
                <parameter type="params System.Object[]" name="args"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateExpression">
                    <parameters>
                      <primitiveExpression value="visibility"/>
                      <primitiveExpression value="test"/>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="clientScript"/>
                          <argumentReferenceExpression name="args"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method ReadOnlyWhen(string, string, params object[]) -->
            <memberMethod returnType="ControllerNodeSet" name="ReadOnlyWhen">
              <comment>
                <![CDATA[
        /// <summary>
        /// Defines a JavaScript expression to evaluate if the data field is read-only. If that is the case, then the client libraray will set the 'Mode' property of the data field to 'Static'.
        /// </summary>
        /// <param name="clientScript">The JavaScript expression evaluating if the data field is read-only.</param>
        /// <param name="args">The list of arguments referenced in the JavaScript expression.</param>
        /// <returns>The node set containing the data field.</returns>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="clientScript"/>
                <parameter type="params System.Object[]" name="args"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateExpression">
                    <parameters>
                      <primitiveExpression value="readOnly"/>
                      <primitiveExpression value="test"/>
                      <methodInvokeExpression methodName="Format">
                        <target>
                          <typeReferenceExpression type="String"/>
                        </target>
                        <parameters>
                          <argumentReferenceExpression name="clientScript"/>
                          <argumentReferenceExpression name="args"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateExpression(string, string, params object[]) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateExpression">
              <attributes family="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="rootElement"/>
                <parameter type="params System.String[]" name="attributes"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <variableDeclarationStatement type="ControllerNodeSet" name="nodeSet">
                      <init>
                        <objectCreateExpression type="ControllerNodeSet">
                          <parameters>
                            <thisReferenceExpression/>
                            <variableReferenceExpression name="node"/>
                          </parameters>
                        </objectCreateExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="ControllerNodeSet" name="rootNode">
                      <init>
                        <methodInvokeExpression methodName="Select">
                          <target>
                            <variableReferenceExpression name="nodeSet"/>
                          </target>
                          <parameters>
                            <argumentReferenceExpression name="rootElement"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Count">
                            <propertyReferenceExpression name="Nodes">
                              <variableReferenceExpression name="rootNode"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AppendTo">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <parameters>
                                <stringFormatExpression format="&lt;{{0}}/>">
                                  <argumentReferenceExpression name="rootElement"/>
                                </stringFormatExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="nodeSet"/>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="rootNode"/>
                          <methodInvokeExpression methodName="Select">
                            <target>
                              <variableReferenceExpression name="nodeSet"/>
                            </target>
                            <parameters>
                              <variableReferenceExpression name="rootElement"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <variableDeclarationStatement type="ControllerNodeSet" name="expressionNode">
                      <init>
                        <methodInvokeExpression methodName="Select">
                          <target>
                            <variableReferenceExpression name="nodeSet"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="expression[1]"/>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="ValueEquality">
                          <propertyReferenceExpression name="Count">
                            <propertyReferenceExpression name="Nodes">
                              <variableReferenceExpression name="expressionNode"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <primitiveExpression value="0"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="AppendTo">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <parameters>
                                <primitiveExpression value="&lt;expression/>"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="rootNode"/>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="expressionNode"/>
                          <methodInvokeExpression methodName="Select">
                            <target>
                              <variableReferenceExpression name="rootNode"/>
                            </target>
                            <parameters>
                              <primitiveExpression value="expression"/>
                            </parameters>
                          </methodInvokeExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <variableDeclarationStatement type="System.Int32" name="i">
                      <init>
                        <primitiveExpression value="0"/>
                      </init>
                    </variableDeclarationStatement>
                    <whileStatement>
                      <test>
                        <binaryOperatorExpression operator="LessThan">
                          <variableReferenceExpression name="i"/>
                          <propertyReferenceExpression name="Length">
                            <variableReferenceExpression name="attributes"/>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </test>
                      <statements>
                        <methodInvokeExpression methodName="Attr">
                          <target>
                            <variableReferenceExpression name="expressionNode"/>
                          </target>
                          <parameters>
                            <arrayIndexerExpression>
                              <target>
                                <argumentReferenceExpression name="attributes"/>
                              </target>
                              <indices>
                                <variableReferenceExpression name="i"/>
                              </indices>
                            </arrayIndexerExpression>
                            <arrayIndexerExpression>
                              <target>
                                <argumentReferenceExpression name="attributes"/>
                              </target>
                              <indices>
                                <binaryOperatorExpression operator="Add">
                                  <variableReferenceExpression name="i"/>
                                  <primitiveExpression value="1"/>
                                </binaryOperatorExpression>
                              </indices>
                            </arrayIndexerExpression>
                          </parameters>
                        </methodInvokeExpression>
                        <assignStatement>
                          <variableReferenceExpression name="i"/>
                          <binaryOperatorExpression operator="Add">
                            <variableReferenceExpression name="i"/>
                            <primitiveExpression value="2"/>
                          </binaryOperatorExpression>
                        </assignStatement>
                      </statements>
                    </whileStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectBusinessRules(string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectBusinessRules">
              <attributes family="true" public="true"/>
              <parameters>
                <parameter type="System.String" name="filter"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="selector">
                  <init>
                    <primitiveExpression value="/dataController/businessRules/rule"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression  operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="selector"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="selector"/>
                      <stringFormatExpression format="{{0}}[{{1}}]">
                        <variableReferenceExpression name="selector"/>
                        <argumentReferenceExpression name="filter"/>
                      </stringFormatExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="InternalSelect">
                    <target>
                      <methodInvokeExpression methodName="NodeSet"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="false"/>
                      <variableReferenceExpression name="selector"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateBusinessRuleFilter(string, string, string, string, string) -->
            <memberMethod returnType="System.String" name="CreateBusinessRuleFilter">
              <attributes private="true"/>
              <parameters>
                <parameter type="System.String" name="type"/>
                <parameter type="System.String" name="phase"/>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
                <parameter type="System.String" name="view"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="StringBuilder" name="sb">
                  <init>
                    <objectCreateExpression type="StringBuilder"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Boolean" name="first">
                  <init>
                    <primitiveExpression value="true"/>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="type"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AppendFormat">
                      <target>
                        <variableReferenceExpression name="sb"/>
                      </target>
                      <parameters>
                        <primitiveExpression value=" @type='{{0}}'"/>
                        <argumentReferenceExpression name="type"/>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <variableReferenceExpression name="first"/>
                      <primitiveExpression value="false"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="phase"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <variableReferenceExpression name="first"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Append">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=" and "/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="AppendFormat">
                      <target>
                        <variableReferenceExpression name="sb"/>
                      </target>
                      <parameters>
                        <primitiveExpression value=" @phase='{{0}}'"/>
                        <argumentReferenceExpression name="phase"/>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <variableReferenceExpression name="first"/>
                      <primitiveExpression value="false"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="commandName"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <variableReferenceExpression name="first"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Append">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=" and "/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="AppendFormat">
                      <target>
                        <variableReferenceExpression name="sb"/>
                      </target>
                      <parameters>
                        <primitiveExpression value=" @commandName='{{0}}'"/>
                        <argumentReferenceExpression name="commandName"/>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <variableReferenceExpression name="first"/>
                      <primitiveExpression value="false"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="commandArgument"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <variableReferenceExpression name="first"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Append">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=" and "/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="AppendFormat">
                      <target>
                        <variableReferenceExpression name="sb"/>
                      </target>
                      <parameters>
                        <primitiveExpression value=" @commandArgument='{{0}}'"/>
                        <argumentReferenceExpression name="commandArgument"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="view"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="Not">
                          <variableReferenceExpression name="first"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodInvokeExpression methodName="Append">
                          <target>
                            <variableReferenceExpression name="sb"/>
                          </target>
                          <parameters>
                            <primitiveExpression value=" and "/>
                          </parameters>
                        </methodInvokeExpression>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="AppendFormat">
                      <target>
                        <variableReferenceExpression name="sb"/>
                      </target>
                      <parameters>
                        <primitiveExpression value=" @view='{{0}}'"/>
                        <argumentReferenceExpression name="view"/>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <variableReferenceExpression name="first"/>
                      <primitiveExpression value="false"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="ToString">
                    <target>
                      <variableReferenceExpression name="sb"/>
                    </target>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectSqlBusinessRules(string, string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectSqlBusinessRules">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="phase"/>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
                <parameter type="System.String" name="view"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectBusinessRules">
                    <parameters>
                      <methodInvokeExpression methodName="CreateBusinessRuleFilter">
                        <parameters>
                          <primitiveExpression value="Sql"/>
                          <argumentReferenceExpression name="phase"/>
                          <argumentReferenceExpression name="commandName"/>
                          <argumentReferenceExpression name="commandArgument"/>
                          <argumentReferenceExpression name="view"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectEmailBusinessRules(string, string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectEmailBusinessRules">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="phase"/>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
                <parameter type="System.String" name="view"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectBusinessRules">
                    <parameters>
                      <methodInvokeExpression methodName="CreateBusinessRuleFilter">
                        <parameters>
                          <primitiveExpression value="Email"/>
                          <argumentReferenceExpression name="phase"/>
                          <argumentReferenceExpression name="commandName"/>
                          <argumentReferenceExpression name="commandArgument"/>
                          <argumentReferenceExpression name="view"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method SelectJavaScriptBusinessRules(string, string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="SelectJavaScriptBusinessRules">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="phase"/>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
                <parameter type="System.String" name="view"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="SelectBusinessRules">
                    <parameters>
                      <methodInvokeExpression methodName="CreateBusinessRuleFilter">
                        <parameters>
                          <primitiveExpression value="JavaScript"/>
                          <argumentReferenceExpression name="phase"/>
                          <argumentReferenceExpression name="commandName"/>
                          <argumentReferenceExpression name="commandArgument"/>
                          <argumentReferenceExpression name="view"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Value(object) -->
            <memberMethod returnType="ControllerNodeSet" name="Value">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="v"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <methodInvokeExpression methodName="SetValue">
                      <target>
                        <variableReferenceExpression name="node"/>
                      </target>
                      <parameters>
                        <convertExpression to="String">
                          <argumentReferenceExpression name="v"/>
                        </convertExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <thisReferenceExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- CreateBusinesRule(string, string, string, string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateBusinessRule">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="type"/>
                <parameter type="System.String" name="phase"/>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
                <parameter type="System.String" name="view"/>
                <parameter type="System.String" name="script"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateBusinessRule">
                    <parameters>
                      <argumentReferenceExpression name="type"/>
                      <argumentReferenceExpression name="phase"/>
                      <argumentReferenceExpression name="commandName"/>
                      <argumentReferenceExpression name="commandArgument"/>
                      <argumentReferenceExpression name="view"/>
                      <argumentReferenceExpression name="script"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- CreateBusinesRule(string, string, string, string, string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateBusinessRule">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="type"/>
                <parameter type="System.String" name="phase"/>
                <parameter type="System.String" name="commandName"/>
                <parameter type="System.String" name="commandArgument"/>
                <parameter type="System.String" name="view"/>
                <parameter type="System.String" name="script"/>
                <parameter type="System.String" name="name"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ControllerNodeSet" name="businessRulesNode">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="/dataController/businessRules"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Count">
                        <propertyReferenceExpression name="Nodes">
                          <variableReferenceExpression name="businessRulesNode"/>
                        </propertyReferenceExpression>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="businessRulesNode"/>
                      <methodInvokeExpression methodName="Select">
                        <target>
                          <methodInvokeExpression methodName="AppendTo">
                            <target>
                              <methodInvokeExpression methodName="Select">
                                <parameters>
                                  <primitiveExpression value="&lt;businessRules/>"/>
                                </parameters>
                              </methodInvokeExpression>
                            </target>
                            <parameters>
                              <primitiveExpression value="/dataController"/>
                            </parameters>
                          </methodInvokeExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="businessRules"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ControllerNodeSet" name="ruleNode">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <target>
                        <methodInvokeExpression methodName="AppendTo">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <parameters>
                                <primitiveExpression value="&lt;rule/>"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <variableReferenceExpression name="businessRulesNode"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="rule[last()]"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <variableReferenceExpression name="ruleNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="id"/>
                    <stringFormatExpression format="crule{{0}}">
                      <methodInvokeExpression methodName="Evaluate">
                        <target>
                          <arrayIndexerExpression>
                            <target>
                              <propertyReferenceExpression name="Nodes">
                                <variableReferenceExpression name="businessRulesNode"/>
                              </propertyReferenceExpression>
                            </target>
                            <indices>
                              <primitiveExpression value="0"/>
                            </indices>
                          </arrayIndexerExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="count(child::*)+1"/>
                        </parameters>
                      </methodInvokeExpression>
                    </stringFormatExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <variableReferenceExpression name="ruleNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="type"/>
                    <argumentReferenceExpression name="type"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <variableReferenceExpression name="ruleNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="phase"/>
                    <argumentReferenceExpression name="phase"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Attr">
                  <target>
                    <variableReferenceExpression name="ruleNode"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="commandName"/>
                    <argumentReferenceExpression name="commandName"/>
                  </parameters>
                </methodInvokeExpression>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="commandArgument"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="ruleNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="commandArgument"/>
                        <argumentReferenceExpression name="commandArgument"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="view"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="ruleNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="view"/>
                        <argumentReferenceExpression name="view"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="name"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="ruleNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="name"/>
                        <argumentReferenceExpression name="name"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="Value">
                  <target>
                    <variableReferenceExpression name="ruleNode"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="script"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <variableReferenceExpression name="ruleNode"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- property IsEmpty -->
            <memberProperty type="System.Boolean" name="IsEmpty">
              <comment>
                <![CDATA[
        /// <summary>
        /// Returns true if the node set is empty.
        /// </summary>
              ]]>
              </comment>
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <binaryOperatorExpression operator="ValueEquality">
                    <propertyReferenceExpression name="Count">
                      <fieldReferenceExpression name="nodes"/>
                    </propertyReferenceExpression>
                    <primitiveExpression value="0"/>
                  </binaryOperatorExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method CreateField(string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateField">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
                <parameter type="System.String" name="type"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateField">
                    <parameters>
                      <argumentReferenceExpression name="name"/>
                      <argumentReferenceExpression name="type"/>
                      <primitiveExpression value="null"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateField(string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="CreateField">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="name"/>
                <parameter type="System.String" name="type"/>
                <parameter type="System.String" name="formula"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="ControllerNodeSet" name="fieldsNode">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="/dataController/fields"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="IsEmpty">
                      <variableReferenceExpression name="fieldsNode"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="AppendTo">
                      <target>
                        <methodInvokeExpression methodName="Select">
                          <parameters>
                            <primitiveExpression>
                              <xsl:attribute name="value"><![CDATA[<fields/>]]></xsl:attribute>
                            </primitiveExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="Select">
                          <parameters>
                            <primitiveExpression value="/dataController"/>
                          </parameters>
                        </methodInvokeExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <assignStatement>
                      <variableReferenceExpression name="fieldsNode"/>
                      <methodInvokeExpression methodName="Select">
                        <parameters>
                          <primitiveExpression value="/dataController/fields"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNullOrEmpty">
                      <argumentReferenceExpression name="type"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <argumentReferenceExpression name="type"/>
                      <primitiveExpression value="String"/>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ControllerNodeSet" name="fieldNode">
                  <init>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <methodInvokeExpression methodName="Attr">
                          <target>
                            <methodInvokeExpression methodName="Select">
                              <target>
                                <methodInvokeExpression methodName="AppendTo">
                                  <target>
                                    <methodInvokeExpression methodName="Select">
                                      <parameters>
                                        <primitiveExpression>
                                          <xsl:attribute name="value"><![CDATA[<field/>]]></xsl:attribute>
                                        </primitiveExpression>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="fieldsNode"/>
                                  </parameters>
                                </methodInvokeExpression>
                              </target>
                              <parameters>
                                <primitiveExpression value="field[last()]"/>
                              </parameters>
                            </methodInvokeExpression>
                          </target>
                          <parameters>
                            <primitiveExpression value="name"/>
                            <argumentReferenceExpression name="name"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="type"/>
                        <argumentReferenceExpression name="type"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <argumentReferenceExpression name="type"/>
                      <primitiveExpression value="String"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <variableReferenceExpression name="fieldNode"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="length"/>
                        <primitiveExpression value="250"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <argumentReferenceExpression name="formula"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Elem">
                      <target>
                        <methodInvokeExpression methodName="Attr">
                          <target>
                            <variableReferenceExpression name="fieldNode"/>
                          </target>
                          <parameters>
                            <primitiveExpression value="computed"/>
                            <primitiveExpression value="true"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="formula"/>
                        <argumentReferenceExpression name="formula"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <variableReferenceExpression name="fieldNode"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method StatusBar(string) -->
            <memberMethod returnType="ControllerNodeSet" name="StatusBar">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="statusMap"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="StatusBar">
                    <parameters>
                      <primitiveExpression value="null"/>
                      <primitiveExpression value="null"/>
                      <argumentReferenceExpression name="statusMap"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method StatusBar(string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="StatusBar">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="formula"/>
                <parameter type="System.String" name="statusMap"/>
              </parameters>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="StatusBar">
                    <parameters>
                      <argumentReferenceExpression name="formula"/>
                      <primitiveExpression value="null"/>
                      <argumentReferenceExpression name="statusMap"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method StatusBar(string, string, string) -->
            <memberMethod returnType="ControllerNodeSet" name="StatusBar">
              <attributes public="true" final="true"/>
              <parameters>
                <parameter type="System.String" name="formula"/>
                <parameter type="System.String" name="type"/>
                <parameter type="System.String" name="statusMap"/>
              </parameters>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <unaryOperatorExpression operator="IsNotNullOrEmpty">
                        <argumentReferenceExpression name="formula"/>
                      </unaryOperatorExpression>
                      <propertyReferenceExpression name="IsEmpty">
                        <methodInvokeExpression methodName="SelectField">
                          <parameters>
                            <primitiveExpression value="Status"/>
                          </parameters>
                        </methodInvokeExpression>
                      </propertyReferenceExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodInvokeExpression methodName="Attr">
                      <target>
                        <methodInvokeExpression methodName="CreateField">
                          <parameters>
                            <primitiveExpression value="Status"/>
                            <variableReferenceExpression name="type"/>
                            <argumentReferenceExpression name="formula"/>
                          </parameters>
                        </methodInvokeExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="readOnly"/>
                        <primitiveExpression value="true"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ControllerNodeSet" name="statusBarNode">
                  <init>
                    <methodInvokeExpression methodName="Select">
                      <parameters>
                        <primitiveExpression value="/dataController/statusBar"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <propertyReferenceExpression name="IsEmpty">
                      <variableReferenceExpression name="statusBarNode"/>
                    </propertyReferenceExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <variableReferenceExpression name="statusBarNode"/>
                      <methodInvokeExpression methodName="Select">
                        <target>
                          <methodInvokeExpression methodName="AppendTo">
                            <target>
                              <methodInvokeExpression methodName="Select">
                                <parameters>
                                  <primitiveExpression>
                                    <xsl:attribute name="value"><![CDATA[<statusBar/>]]></xsl:attribute>
                                  </primitiveExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </target>
                            <parameters>
                              <methodInvokeExpression methodName="Select">
                                <parameters>
                                  <primitiveExpression value="/dataController"/>
                                </parameters>
                              </methodInvokeExpression>
                            </parameters>
                          </methodInvokeExpression>
                        </target>
                        <parameters>
                          <primitiveExpression value="/dataController/statusBar"/>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="Value">
                  <target>
                    <variableReferenceExpression name="statusBarNode"/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="statusMap"/>
                  </parameters>
                </methodInvokeExpression>
                <methodReturnStatement>
                  <variableReferenceExpression name="statusBarNode"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method CreateStatusDataField() -->
            <memberMethod returnType="ControllerNodeSet" name="CreateStatusDataField">
              <attributes public="true" final="true"/>
              <statements>
                <methodReturnStatement>
                  <methodInvokeExpression methodName="CreateDataField">
                    <parameters>
                      <primitiveExpression value="Status"/>
                    </parameters>
                  </methodInvokeExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method Value(string) -->
            <memberMethod returnType="System.String" name="Value">
              <attributes public="true" final="true"/>
              <statements>
                <foreachStatement>
                  <variable type="XPathNavigator" name="node"/>
                  <target>
                    <fieldReferenceExpression name="nodes"/>
                  </target>
                  <statements>
                    <methodReturnStatement>
                      <propertyReferenceExpression name="Value">
                        <variableReferenceExpression name="node"/>
                      </propertyReferenceExpression>
                    </methodReturnStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <stringEmptyExpression/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- property Current -->
            <memberField type="Nullable" name="current">
              <typeArguments>
                <typeReference type="System.Int32"/>
              </typeArguments>
            </memberField>
            <memberProperty type="ControllerNodeSet" name="Current">
              <attributes public="true" final="true"/>
              <getStatements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <unaryOperatorExpression operator="Not">
                        <propertyReferenceExpression name="HasValue">
                          <fieldReferenceExpression name="current"/>
                        </propertyReferenceExpression>
                      </unaryOperatorExpression>
                      <binaryOperatorExpression operator="LessThanOrEqual">
                        <propertyReferenceExpression name="Count">
                          <fieldReferenceExpression name="nodes"/>
                        </propertyReferenceExpression>
                        <fieldReferenceExpression name="current"/>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="null"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="ControllerNodeSet">
                    <parameters>
                      <thisReferenceExpression/>
                      <arrayIndexerExpression>
                        <target>
                          <fieldReferenceExpression name="nodes"/>
                        </target>
                        <indices>
                          <propertyReferenceExpression name="Value">
                            <fieldReferenceExpression name="current"/>
                          </propertyReferenceExpression>
                        </indices>
                      </arrayIndexerExpression>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- method Reset() -->
            <memberMethod name="Reset">
              <attributes public="true" final="true"/>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="current"/>
                  <primitiveExpression value="null"/>
                </assignStatement>
              </statements>
            </memberMethod>
            <!-- method MoveNext() -->
            <memberMethod returnType="System.Boolean" name="MoveNext">
              <attributes public="true" final="true"/>
              <statements>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="ValueEquality">
                      <propertyReferenceExpression name="Count">
                        <fieldReferenceExpression name="nodes"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="0"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanAnd">
                      <propertyReferenceExpression name="HasValue">
                        <fieldReferenceExpression name="current"/>
                      </propertyReferenceExpression>
                      <binaryOperatorExpression operator="GreaterThanOrEqual">
                        <propertyReferenceExpression name="Value">
                          <fieldReferenceExpression name="current"/>
                        </propertyReferenceExpression>
                        <binaryOperatorExpression operator="Subtract">
                          <propertyReferenceExpression name="Count">
                            <fieldReferenceExpression name="nodes"/>
                          </propertyReferenceExpression>
                          <primitiveExpression value="1"/>
                        </binaryOperatorExpression>
                      </binaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <methodReturnStatement>
                      <primitiveExpression value="false"/>
                    </methodReturnStatement>
                  </trueStatements>
                </conditionStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="Not">
                      <propertyReferenceExpression name="HasValue">
                        <fieldReferenceExpression name="current"/>
                      </propertyReferenceExpression>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="current"/>
                      <primitiveExpression value="0"/>
                    </assignStatement>
                  </trueStatements>
                  <falseStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="current"/>
                      <binaryOperatorExpression operator="Add">
                        <fieldReferenceExpression name="current"/>
                        <primitiveExpression value="1"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </falseStatements>
                </conditionStatement>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method GetName() -->
            <xsl:call-template name="CreateGetAttributePlugin">
              <xsl:with-param name="Property" select="'Name'"/>
              <xsl:with-param name="Type" select="'System.String'"/>
            </xsl:call-template>
            <!-- method GetFieldName() -->
            <xsl:call-template name="CreateGetAttributePlugin">
              <xsl:with-param name="Property" select="'FieldName'"/>
              <xsl:with-param name="Type" select="'System.String'"/>
            </xsl:call-template>
            <!-- method GetLabel() -->
            <xsl:call-template name="CreateGetAttributePlugin">
              <xsl:with-param name="Property" select="'Label'"/>
              <xsl:with-param name="Type" select="'System.String'"/>
            </xsl:call-template>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>

  <xsl:template name="CreateGetAttributePlugin">
    <xsl:param name="Property"/>
    <xsl:param name="Type"/>
    <memberMethod returnType="{$Type}" name="Get{$Property}">
      <attributes public="true" final="true"/>
      <statements>
        <methodReturnStatement>
          <methodInvokeExpression methodName="Value">
            <target>
              <methodInvokeExpression methodName="Attr">
                <parameters>
                  <primitiveExpression value="{ontime:ToAttribute($Property)}"/>
                </parameters>
              </methodInvokeExpression>
            </target>
          </methodInvokeExpression>
        </methodReturnStatement>
      </statements>
    </memberMethod>
  </xsl:template>

  <xsl:template name="CreateVirtualizationPlugin">
    <xsl:param name="Property"/>
    <xsl:param name="Argument" select="ontime:ToAttribute($Property)"/>
    <xsl:param name="Type"/>
    <xsl:param name="Element1"/>
    <xsl:param name="Element2"/>
    <xsl:param name="Comment"/>
    <xsl:variable name="Prefix">
      <xsl:choose>
        <xsl:when test="starts-with($Property, 'When')">
          <xsl:text></xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Set</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="ArgumentName">
      <xsl:choose>
        <xsl:when test="starts-with($Argument, 'when')">
          <xsl:value-of select="substring-after($Argument, 'when')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$Argument"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <memberMethod returnType="ControllerNodeSet" name="{$Prefix}{$Property}">
      <xsl:if test="$Comment!=''">
        <comment>
          <xsl:value-of select="$Comment"/>
        </comment>
      </xsl:if>
      <attributes public="true" final="true"/>
      <parameters>
        <parameter type="System.{$Type}" name="{$ArgumentName}"/>
      </parameters>
      <statements>
        <methodReturnStatement>
          <methodInvokeExpression methodName="SetProperty">
            <parameters>
              <primitiveExpression value="{$Argument}">
                <xsl:attribute name="value">
                  <xsl:choose>
                    <xsl:when test="$Argument=ontime:ToAttribute($Property)">
                      <xsl:value-of select="$Argument"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="ontime:ToAttribute($Property)"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
              </primitiveExpression>
              <xsl:choose>
                <xsl:when test="$Type='Boolean'">
                  <methodInvokeExpression methodName="ToLower">
                    <target>
                      <methodInvokeExpression methodName="ToString">
                        <target>
                          <argumentReferenceExpression name="{$ArgumentName}"/>
                        </target>
                      </methodInvokeExpression>
                    </target>
                  </methodInvokeExpression>
                </xsl:when>
                <xsl:otherwise>
                  <argumentReferenceExpression name="{$ArgumentName}"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="$Element1!=''">
                <primitiveExpression value="{$Element1}"/>
              </xsl:if>
              <xsl:if test="$Element2!=''">
                <primitiveExpression value="{$Element2}"/>
              </xsl:if>
            </parameters>
          </methodInvokeExpression>
        </methodReturnStatement>
      </statements>
    </memberMethod>
    <xsl:if test="$Type!='String'">
      <memberMethod returnType="ControllerNodeSet" name="{$Prefix}{$Property}">
        <xsl:if test="$Comment!=''">
          <comment>
            <xsl:value-of select="$Comment"/>
          </comment>
        </xsl:if>
        <attributes public="true" final="true"/>
        <parameters>
          <parameter type="System.String" name="{$ArgumentName}"/>
        </parameters>
        <statements>
          <methodReturnStatement>
            <methodInvokeExpression methodName="{$Prefix}{$Property}">
              <parameters>
                <convertExpression to="{$Type}">
                  <argumentReferenceExpression name="{$ArgumentName}"/>
                </convertExpression>
              </parameters>
            </methodInvokeExpression>
          </methodReturnStatement>
        </statements>
      </memberMethod>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
