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
        <namespaceImport name="System.ComponentModel"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.Data.Common"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Text"/>
        <namespaceImport name="System.Text.RegularExpressions"/>
        <namespaceImport name="System.Xml"/>
        <namespaceImport name="System.Xml.XPath"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Caching"/>
        <namespaceImport name="System.Web.Configuration"/>
        <namespaceImport name="System.Web.Security"/>
      </imports>
      <types>
        <!-- class Category -->
        <typeDeclaration name="Category">
          <members>
            <!-- property Id -->
            <memberProperty type="System.String" name="Id">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Index -->
            <memberField type="System.Int32" name="index"/>
            <memberProperty type="System.Int32" name="Index">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="index"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property HeaderText -->
            <memberField type="System.String" name="headerText"/>
            <memberProperty type="System.String" name="HeaderText">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="headerText"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property Description -->
            <memberField type="System.String" name="description"/>
            <memberProperty type="System.String" name="Description">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="Description"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- property Flow -->
            <memberProperty type="System.String" name="Flow">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Wrap -->
            <memberProperty type="Nullable" name="Wrap">
              <typeArguments>
                <typeReference type="System.Boolean"/>
              </typeArguments>
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Tab -->
            <memberField type="System.String" name="tab"/>
            <memberProperty type="System.String" name="Tab">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="tab"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="tab"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Wizard -->
            <memberField type="System.String" name="wizard"/>
            <memberProperty type="System.String" name="Wizard">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="wizard"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="wizard"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Template -->
            <memberField type="System.String" name="template"/>
            <memberProperty type="System.String" name="Template">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="template"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="template"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Layout -->
            <!--<memberField type="System.String" name="layout"/>
            <memberProperty type="System.String" name="Layout">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="layout"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>-->
            <!-- property Floating -->
            <memberField type="System.Boolean" name="floating"/>
            <memberProperty type="System.Boolean" name="Floating">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="floating"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="floating"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- property Collapsed -->
            <memberField type="System.Boolean" name="collapsed"/>
            <memberProperty type="System.Boolean" name="Collapsed">
              <attributes public="true" final="true"/>
              <getStatements>
                <methodReturnStatement>
                  <fieldReferenceExpression name="collapsed"/>
                </methodReturnStatement>
              </getStatements>
              <setStatements>
                <assignStatement>
                  <fieldReferenceExpression name="collapsed"/>
                  <propertySetValueReferenceExpression/>
                </assignStatement>
              </setStatements>
            </memberProperty>
            <!-- constructor Category() -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- constructor Category(XPathNavigator, IXmlNamespaceResolver -->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="XPathNavigator" name="category"/>
                <parameter type="IXmlNamespaceResolver" name="resolver"/>
              </parameters>
              <statements>
                <assignStatement>
                  <propertyReferenceExpression name="Id">
                    <thisReferenceExpression/>
                  </propertyReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <variableReferenceExpression name="category"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="id"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="index">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="ToInt32">
                    <target>
                      <typeReferenceExpression type="Convert"/>
                    </target>
                    <parameters>
                      <methodInvokeExpression methodName="Evaluate">
                        <target>
                          <argumentReferenceExpression name="category"/>
                        </target>
                        <parameters>
                          <primitiveExpression value="count(preceding-sibling::c:category)"/>
                          <argumentReferenceExpression name="resolver"/>
                        </parameters>
                      </methodInvokeExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="headerText">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <castExpression targetType="System.String">
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <variableReferenceExpression name="category"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="headerText"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <!--<methodInvokeExpression methodName="Evaluate">
											<target>
												<argumentReferenceExpression name="category"/>
											</target>
											<parameters>
												<primitiveExpression value="string(@headerText)"/>
											</parameters>
										</methodInvokeExpression>-->
                  </castExpression>
                </assignStatement>
                <variableDeclarationStatement type="XPathNavigator" name="descriptionNav">
                  <init>
                    <methodInvokeExpression methodName="SelectSingleNode">
                      <target>
                        <argumentReferenceExpression name="category"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="c:description"/>
                        <argumentReferenceExpression name="resolver"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="descriptionNav"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="description">
                        <thisReferenceExpression/>
                      </fieldReferenceExpression>
                      <propertyReferenceExpression name="Value">
                        <variableReferenceExpression name="descriptionNav"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <assignStatement>
                  <fieldReferenceExpression name="tab"/>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="category"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="tab"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="wizard"/>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="category"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="wizard"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="flow"/>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="category"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="flow"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <!-- 
            string doWrap = category.GetAttribute("wrap", String.Empty);
            if (!String.IsNullOrEmpty(doWrap))
                _wrap = doWrap == "true";
                -->
                <variableDeclarationStatement type="System.String" name="doWrap">
                  <init>
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <argumentReferenceExpression name="category"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="wrap"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="doWrap"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="wrap"/>
                      <binaryOperatorExpression operator="ValueEquality">
                        <variableReferenceExpression name="doWrap"/>
                        <primitiveExpression value="true" convertTo="String"/>
                      </binaryOperatorExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="XPathNavigator" name="templateNav">
                  <init>
                    <methodInvokeExpression methodName="SelectSingleNode">
                      <target>
                        <argumentReferenceExpression name="category"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="c:template"/>
                        <argumentReferenceExpression name="resolver"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="templateNav"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="template">
                        <thisReferenceExpression/>
                      </fieldReferenceExpression>
                      <propertyReferenceExpression name="Value">
                        <variableReferenceExpression name="templateNav"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>
                <!--<variableDeclarationStatement type="XPathNavigator" name="layoutNav">
                  <init>
                    <methodInvokeExpression methodName="SelectSingleNode">
                      <target>
                        <argumentReferenceExpression name="category"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="c:layout"/>
                        <argumentReferenceExpression name="resolver"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="layoutNav"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <assignStatement>
                      <fieldReferenceExpression name="layout">
                        <thisReferenceExpression/>
                      </fieldReferenceExpression>
                      <propertyReferenceExpression name="Value">
                        <variableReferenceExpression name="layoutNav"/>
                      </propertyReferenceExpression>
                    </assignStatement>
                  </trueStatements>
                </conditionStatement>-->
                <assignStatement>
                  <fieldReferenceExpression name="floating"/>
                  <binaryOperatorExpression operator="ValueEquality">
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <argumentReferenceExpression name="category"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="floating"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <primitiveExpression value="true" convertTo="String"/>
                  </binaryOperatorExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="collapsed"/>
                  <binaryOperatorExpression operator="ValueEquality">
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <argumentReferenceExpression name="category"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="collapsed"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <primitiveExpression value="true" convertTo="String"/>
                  </binaryOperatorExpression>
                </assignStatement>
              </statements>
            </constructor>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
