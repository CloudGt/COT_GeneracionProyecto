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
        <!-- class Action -->
        <typeDeclaration name="Action">
          <members>
            <!-- property Id -->
            <memberProperty type="System.String" name="Id">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property CommandName -->
            <memberProperty type="System.String" name="CommandName">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property CommandArgument -->
            <memberProperty type="System.String" name="CommandArgument">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property HeaderText -->
            <memberProperty type="System.String" name="HeaderText">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Description -->
            <memberProperty type="System.String" name="Description">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property CssClass -->
            <memberProperty type="System.String" name="CssClass">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Confirmation -->
            <memberProperty type="System.String" name="Confirmation">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property Notify -->
            <memberProperty type="System.String" name="Notify">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property WhenLastCommandName -->
            <memberProperty type="System.String" name="WhenLastCommandName">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property string WhenLastCommandArgument -->
            <memberProperty type="System.String" name="WhenLastCommandArgument">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property whenKeySelected -->
            <memberProperty type="System.Boolean" name="WhenKeySelected">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property WhenClientScript -->
            <memberProperty type="System.String" name="WhenClientScript">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property bool CausesValidation -->
            <memberProperty type="System.Boolean" name="CausesValidation">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property string WhenTag -->
            <memberProperty type="System.String" name="WhenTag">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property string WhenHRef -->
            <memberProperty type="System.String" name="WhenHRef">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property string WhenView -->
            <memberProperty type="System.String" name="WhenView">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- property string Key -->
            <memberProperty type="System.String" name="Key">
              <attributes public="true" final="true"/>
            </memberProperty>
            <!-- constructor Action() -->
            <constructor>
              <attributes public="true"/>
            </constructor>
            <!-- constructor Action(XPathNavigator, IXmlNamespaceResolver)-->
            <constructor>
              <attributes public="true"/>
              <parameters>
                <parameter type="XPathNavigator" name="action"/>
                <parameter type="IXmlNamespaceResolver" name="resolver"/>
              </parameters>
              <statements>
                <assignStatement>
                  <fieldReferenceExpression name="id">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
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
                  <fieldReferenceExpression name="commandName">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@commandName)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="commandName"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="commandArgument">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@commandArgument)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="commandArgument"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="headerText">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@headerText)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="headerText"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="description">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@description)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="description"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="cssClass">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@cssClass)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="cssClass"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="confirmation">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="confirmation"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="notify">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="notify"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="whenLastCommandName">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <!--<castExpression targetType="System.String">
                    <methodInvokeExpression methodName="Evaluate">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="string(@whenLastCommandName)"/>
                      </parameters>
                    </methodInvokeExpression>
                  </castExpression>-->
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="whenLastCommandName"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="whenLastCommandArgument">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="whenLastCommandArgument"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="causesValidation">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <binaryOperatorExpression operator="ValueInequality">
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="causesValidation"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <primitiveExpression value="false" convertTo="String"/>
                  </binaryOperatorExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="whenKeySelected">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <binaryOperatorExpression operator="ValueEquality">
                    <methodInvokeExpression methodName="GetAttribute">
                      <target>
                        <argumentReferenceExpression name="action"/>
                      </target>
                      <parameters>
                        <primitiveExpression value="whenKeySelected"/>
                        <propertyReferenceExpression name="Empty">
                          <typeReferenceExpression type="String"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <primitiveExpression value="true" convertTo="String"/>
                  </binaryOperatorExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="whenTag">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="whenTag"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="whenHRef">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="whenHRef"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="whenView">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="whenView"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="whenClientScript">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="whenClientScript"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
                <assignStatement>
                  <fieldReferenceExpression name="key">
                    <thisReferenceExpression/>
                  </fieldReferenceExpression>
                  <methodInvokeExpression methodName="GetAttribute">
                    <target>
                      <argumentReferenceExpression name="action"/>
                    </target>
                    <parameters>
                      <primitiveExpression value="key"/>
                      <propertyReferenceExpression name="Empty">
                        <typeReferenceExpression type="String"/>
                      </propertyReferenceExpression>
                    </parameters>
                  </methodInvokeExpression>
                </assignStatement>
              </statements>
            </constructor>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
