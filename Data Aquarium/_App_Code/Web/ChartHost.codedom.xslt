<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="IsClassLibrary" select="'false'"/>
  <xsl:param name="Theme" select="'Aquarium'"/>

  <xsl:template match="/">
    <compileUnit namespace="{a:project/a:namespace}.Web">
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.IO"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.Security"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.HtmlControls"/>
        <namespaceImport name="System.Web.UI.DataVisualization.Charting"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
        <!--<namespaceImport name="AjaxControlToolkit"/>-->
      </imports>
      <types>

        <!-- class AquariumExtenderBase -->
        <typeDeclaration name="ChartHost">
          <attributes  public="true"/>
          <baseTypes>
            <typeReference type="System.Web.UI.Page"/>
          </baseTypes>
          <members>
            <!-- method OnInit(EventArgs) -->
            <memberMethod name="OnInit">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow: hidden">
]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="HtmlHead" name="head">
                  <init>
                    <objectCreateExpression type="HtmlHead"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="head"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[
<body>
    ]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="HtmlForm" name="form">
                  <init>
                    <objectCreateExpression type="HtmlForm"/>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="form"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="Add">
                  <target>
                    <propertyReferenceExpression name="Controls"/>
                  </target>
                  <parameters>
                    <objectCreateExpression type="LiteralControl">
                      <parameters>
                        <primitiveExpression>
                          <xsl:attribute name="value">
                            <xsl:text disable-output-escaping="yes"><![CDATA[
</body>
</html>
]]></xsl:text>
                          </xsl:attribute>
                        </primitiveExpression>
                      </parameters>
                    </objectCreateExpression>
                  </parameters>
                </methodInvokeExpression>
                <variableDeclarationStatement type="System.String" name="controlName">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Params">
                          <propertyReferenceExpression name="Request"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="c"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <unaryOperatorExpression operator="IsNotNullOrEmpty">
                      <variableReferenceExpression name="controlName"/>
                    </unaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="Control" name="c">
                      <init>
                        <methodInvokeExpression methodName="LoadControl">
                          <parameters>
                            <methodInvokeExpression methodName="Format">
                              <target>
                                <typeReferenceExpression type="String"/>
                              </target>
                              <parameters>
                                <primitiveExpression value="~/Controls/Chart_{{0}}.ascx"/>
                                <variableReferenceExpression name="controlName"/>
                              </parameters>
                            </methodInvokeExpression>
                          </parameters>
                        </methodInvokeExpression>
                      </init>
                    </variableDeclarationStatement>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <propertyReferenceExpression name="Controls">
                          <variableReferenceExpression name="form"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="c"/>
                      </parameters>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
                <methodInvokeExpression methodName="OnInit">
                  <target>
                    <baseReferenceExpression/>
                  </target>
                  <parameters>
                    <argumentReferenceExpression name="e"/>
                  </parameters>
                </methodInvokeExpression>
                <assignStatement>
                  <propertyReferenceExpression name="EnableViewState"/>
                  <primitiveExpression value="false"/>
                </assignStatement>
              </statements>
            </memberMethod>
            <!-- method FindChart(ControlCollecton)-->
            <memberMethod returnType="Chart" name="FindChart">
              <attributes private="true" />
              <parameters>
                <parameter type="ControlCollection" name="controls"/>
              </parameters>
              <statements>
                <foreachStatement>
                  <variable type="Control" name="c" var="false"/>
                  <target>
                    <argumentReferenceExpression name="controls"/>
                  </target>
                  <statements>
                    <conditionStatement>
                      <condition>
                        <binaryOperatorExpression operator="IsTypeOf">
                          <variableReferenceExpression name="c"/>
                          <typeReferenceExpression type="Chart"/>
                        </binaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <methodReturnStatement>
                          <castExpression targetType="Chart">
                            <variableReferenceExpression name="c"/>
                          </castExpression>
                        </methodReturnStatement>
                      </trueStatements>
                      <falseStatements>
                        <variableDeclarationStatement type="Chart" name="result">
                          <init>
                            <methodInvokeExpression methodName="FindChart">
                              <parameters>
                                <propertyReferenceExpression name="Controls">
                                  <variableReferenceExpression name="c"/>
                                </propertyReferenceExpression>
                              </parameters>
                            </methodInvokeExpression>
                          </init>
                        </variableDeclarationStatement>
                        <conditionStatement>
                          <condition>
                            <binaryOperatorExpression operator="IdentityInequality">
                              <variableReferenceExpression name="result"/>
                              <primitiveExpression value="null"/>
                            </binaryOperatorExpression>
                          </condition>
                          <trueStatements>
                            <methodReturnStatement>
                              <variableReferenceExpression name="result"/>
                            </methodReturnStatement>
                          </trueStatements>
                        </conditionStatement>
                      </falseStatements>
                    </conditionStatement>
                  </statements>
                </foreachStatement>
                <methodReturnStatement>
                  <primitiveExpression value="null"/>
                </methodReturnStatement>
              </statements>
            </memberMethod>
            <!-- method OnLoad(EventArgs) -->
            <memberMethod name="OnLoad">
              <attributes family="true" override="true"/>
              <parameters>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="Chart" name="c">
                  <init>
                    <methodInvokeExpression methodName="FindChart">
                      <parameters>
                        <propertyReferenceExpression name="Controls"/>
                      </parameters>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="IdentityInequality">
                      <variableReferenceExpression name="c"/>
                      <primitiveExpression value="null"/>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <variableDeclarationStatement type="System.Double" name="aspectRatio">
                      <init>
                        <binaryOperatorExpression operator="Divide">
                          <propertyReferenceExpression name="Value">
                            <propertyReferenceExpression name="Height">
                              <variableReferenceExpression name="c"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                          <propertyReferenceExpression name="Value">
                            <propertyReferenceExpression name="Width">
                              <variableReferenceExpression name="c"/>
                            </propertyReferenceExpression>
                          </propertyReferenceExpression>
                        </binaryOperatorExpression>
                      </init>
                    </variableDeclarationStatement>
                    <variableDeclarationStatement type="System.String" name="w">
                      <init>
                        <arrayIndexerExpression>
                          <target>
                            <propertyReferenceExpression name="Params">
                              <propertyReferenceExpression name="Request"/>
                            </propertyReferenceExpression>
                          </target>
                          <indices>
                            <primitiveExpression value="w"/>
                          </indices>
                        </arrayIndexerExpression>
                      </init>
                    </variableDeclarationStatement>
                    <conditionStatement>
                      <condition>
                        <unaryOperatorExpression operator="IsNotNullOrEmpty">
                          <variableReferenceExpression name="w"/>
                        </unaryOperatorExpression>
                      </condition>
                      <trueStatements>
                        <assignStatement>
                          <propertyReferenceExpression name="Width">
                            <variableReferenceExpression name="c"/>
                          </propertyReferenceExpression>
                          <objectCreateExpression type="Unit">
                            <parameters>
                              <variableReferenceExpression name="w"/>
                            </parameters>
                          </objectCreateExpression>
                        </assignStatement>
                        <assignStatement>
                          <propertyReferenceExpression name="Height">
                            <variableReferenceExpression name="c"/>
                          </propertyReferenceExpression>
                          <objectCreateExpression type="Unit">
                            <parameters>
                              <binaryOperatorExpression operator="Multiply">
                                <methodInvokeExpression methodName="ToDouble">
                                  <target>
                                    <typeReferenceExpression type="Convert"/>
                                  </target>
                                  <parameters>
                                    <variableReferenceExpression name="w"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <variableReferenceExpression name="aspectRatio"/>
                              </binaryOperatorExpression>
                            </parameters>
                          </objectCreateExpression>
                        </assignStatement>
                      </trueStatements>
                    </conditionStatement>
                    <methodInvokeExpression methodName="DataBindChildren"/>
                    <variableDeclarationStatement type="MemoryStream" name="image">
                      <init>
                        <objectCreateExpression type="MemoryStream"/>
                      </init>
                    </variableDeclarationStatement>
                    <methodInvokeExpression methodName="SaveImage">
                      <target>
                        <variableReferenceExpression name="c"/>
                      </target>
                      <parameters>
                        <variableReferenceExpression name="image"/>
                        <propertyReferenceExpression name="Png">
                          <typeReferenceExpression type="ChartImageFormat"/>
                        </propertyReferenceExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Clear">
                      <target>
                        <propertyReferenceExpression name="Response"/>
                      </target>
                    </methodInvokeExpression>
                    <assignStatement>
                      <propertyReferenceExpression name="ContentType">
                        <propertyReferenceExpression name="Response"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="image/png"/>
                    </assignStatement>
                    <methodInvokeExpression methodName="Write">
                      <target>
                        <propertyReferenceExpression name="OutputStream">
                          <propertyReferenceExpression name="Response"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <methodInvokeExpression methodName="ToArray">
                          <target>
                            <variableReferenceExpression name="image"/>
                          </target>
                        </methodInvokeExpression>
                        <primitiveExpression value="0"/>
                        <castExpression targetType="System.Int32">
                          <propertyReferenceExpression name="Length">
                            <variableReferenceExpression name="image"/>
                          </propertyReferenceExpression>
                        </castExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="End">
                      <target>
                        <propertyReferenceExpression name="Response"/>
                      </target>
                    </methodInvokeExpression>
                  </trueStatements>
                </conditionStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
