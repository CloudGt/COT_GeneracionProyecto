<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:param name="Namespace"/>
	<xsl:param name="TargetFramework"/>
	<xsl:param name="TargetFramework45Plus"/>
	<xsl:param name="ScriptOnly" select="'false'"/>
  <xsl:param name="Host"/>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">

    <compileUnit>
      <xsl:attribute name="namespace">
        <xsl:value-of select="$Namespace"/>
        <xsl:if test="$Host='SharePoint'">
          <xsl:text>.WebParts</xsl:text>
        </xsl:if>
        <xsl:text>.Handlers</xsl:text>
      </xsl:attribute>
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Data"/>
        <namespaceImport name="System.IO"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="Microsoft.Reporting.WebForms"/>
        <namespaceImport name="{$Namespace}.Data"/>
      </imports>
      <types>
        <!-- class Report -->
        <typeDeclaration name="Report" isPartial="true">
          <baseTypes>
            <typeReference type="ReportBase"/>
          </baseTypes>
          <members>
            <!-- method Render(PagerRequest, DataTable, string, string) -->
            <memberMethod returnType="ReportData" name="Render">
              <attributes override="true" family="true"/>
              <parameters>
                <parameter type="PageRequest" name="request"/>
                <parameter type="DataTable" name="table"/>
                <parameter type="System.String" name="reportTemplate"/>
                <parameter type="System.String" name="reportFormat"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="HttpContext" name="context">
                  <init>
                    <propertyReferenceExpression name="Current">
                      <typeReferenceExpression type="HttpContext"/>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="q">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="Request">
                          <variableReferenceExpression name="context"/>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="q"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <comment>render a report using Microsoft Report Viewer</comment>
                <variableDeclarationStatement type="System.String" name="mimeType">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="encoding">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="fileNameExtension">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String[]" name="streams">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="Warning[]" name="warnings">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.Byte[]" name="data">
                  <init>
                    <primitiveExpression value="null"/>
                  </init>
                </variableDeclarationStatement>
                <usingStatement>
                  <variable type="LocalReport" name="report">
                    <init>
                      <objectCreateExpression type="LocalReport"/>
                    </init>
                  </variable>
                  <statements>
                    <assignStatement>
                      <propertyReferenceExpression name="EnableHyperlinks">
                        <variableReferenceExpression name="report"/>
                      </propertyReferenceExpression>
                      <primitiveExpression value="true"/>
                    </assignStatement>
                    <xsl:if test="$TargetFramework45Plus = 'true' or $ScriptOnly='true'">
                      <assignStatement>
                        <propertyReferenceExpression name="EnableExternalImages">
                          <variableReferenceExpression name="report"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="true"/>
                      </assignStatement>
                    </xsl:if>
                    <xsl:if test="$TargetFramework='3.5'">
                      <methodInvokeExpression methodName="ExecuteReportInCurrentAppDomain">
                        <target>
                          <variableReferenceExpression name="report"/>
                        </target>
                        <parameters>
                          <propertyReferenceExpression name="Evidence">
                            <methodInvokeExpression methodName="GetExecutingAssembly">
                              <target>
                                <propertyReferenceExpression name="System.Reflection.Assembly"/>
                              </target>
                            </methodInvokeExpression>
                          </propertyReferenceExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </xsl:if>
                    <methodInvokeExpression methodName="LoadReportDefinition">
                      <target>
                        <variableReferenceExpression name="report"/>
                      </target>
                      <parameters>
                        <objectCreateExpression type="StringReader">
                          <parameters>
                            <variableReferenceExpression name="reportTemplate"/>
                          </parameters>
                        </objectCreateExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <methodInvokeExpression methodName="Add">
                      <target>
                        <propertyReferenceExpression name="DataSources">
                          <variableReferenceExpression name="report"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <objectCreateExpression type="ReportDataSource">
                          <parameters>
                            <propertyReferenceExpression name="Controller">
                              <variableReferenceExpression name="request"/>
                            </propertyReferenceExpression>
                            <variableReferenceExpression name="table"/>
                          </parameters>
                        </objectCreateExpression>
                      </parameters>
                    </methodInvokeExpression>
                    <xsl:if test="$TargetFramework!='3.5'">
                      <assignStatement>
                        <propertyReferenceExpression name="EnableExternalImages">
                          <variableReferenceExpression name="report"/>
                        </propertyReferenceExpression>
                        <primitiveExpression value="true"/>
                      </assignStatement>
                      <foreachStatement>
                        <variable type="ReportParameterInfo" name="p"/>
                        <target>
                          <methodInvokeExpression methodName="GetParameters">
                            <target>
                              <variableReferenceExpression name="report"/>
                            </target>
                          </methodInvokeExpression>
                        </target>
                        <statements>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="BooleanAnd">
                                <methodInvokeExpression methodName="Equals">
                                  <target>
                                    <propertyReferenceExpression name="Name">
                                      <variableReferenceExpression name="p"/>
                                    </propertyReferenceExpression>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="FilterDetails"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <unaryOperatorExpression operator="IsNotNullOrEmpty">
                                  <propertyReferenceExpression name="FilterDetails">
                                    <variableReferenceExpression name="request"/>
                                  </propertyReferenceExpression>
                                </unaryOperatorExpression>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <methodInvokeExpression methodName="SetParameters">
                                <target>
                                  <variableReferenceExpression name="report"/>
                                </target>
                                <parameters>
                                  <objectCreateExpression type="ReportParameter">
                                    <parameters>
                                      <primitiveExpression value="FilterDetails"/>
                                      <propertyReferenceExpression name="FilterDetails">
                                        <variableReferenceExpression name="request"/>
                                      </propertyReferenceExpression>
                                    </parameters>
                                  </objectCreateExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </trueStatements>
                          </conditionStatement>
                          <conditionStatement>
                            <condition>
                              <methodInvokeExpression methodName="Equals">
                                <target>
                                  <propertyReferenceExpression name="Name">
                                    <variableReferenceExpression name="p"/>
                                  </propertyReferenceExpression>
                                </target>
                                <parameters>
                                  <primitiveExpression value="BaseUrl"/>
                                </parameters>
                              </methodInvokeExpression>
                            </condition>
                            <trueStatements>
                              <!-- 
                        string baseUrl = context.Request.Url.Scheme + "://" + context.Request.Url.Authority + context.Request.ApplicationPath.TrimEnd('/');
-->
                              <variableDeclarationStatement type="System.String" name="baseUrl">
                                <init>
                                  <stringFormatExpression format="{{0}}://{{1}}{{2}}">
                                    <propertyReferenceExpression name="Scheme">
                                      <propertyReferenceExpression name="Url">
                                        <propertyReferenceExpression name="Request">
                                          <argumentReferenceExpression name="context"/>
                                        </propertyReferenceExpression>
                                      </propertyReferenceExpression>
                                    </propertyReferenceExpression>
                                    <propertyReferenceExpression name="Authority">
                                      <propertyReferenceExpression name="Url">
                                        <propertyReferenceExpression name="Request">
                                          <argumentReferenceExpression name="context"/>
                                        </propertyReferenceExpression>
                                      </propertyReferenceExpression>
                                    </propertyReferenceExpression>
                                    <methodInvokeExpression methodName="TrimEnd">
                                      <target>
                                        <propertyReferenceExpression name="ApplicationPath">
                                          <propertyReferenceExpression name="Request">
                                            <argumentReferenceExpression name="context"/>
                                          </propertyReferenceExpression>
                                        </propertyReferenceExpression>
                                      </target>
                                      <parameters>
                                        <primitiveExpression value="/" convertTo="Char"/>
                                      </parameters>
                                    </methodInvokeExpression>
                                  </stringFormatExpression>
                                </init>
                              </variableDeclarationStatement>
                              <methodInvokeExpression methodName="SetParameters">
                                <target>
                                  <variableReferenceExpression name="report"/>
                                </target>
                                <parameters>
                                  <objectCreateExpression type="ReportParameter">
                                    <parameters>
                                      <primitiveExpression value="BaseUrl"/>
                                      <variableReferenceExpression name="baseUrl"/>
                                    </parameters>
                                  </objectCreateExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </trueStatements>
                          </conditionStatement>
                          <conditionStatement>
                            <condition>
                              <binaryOperatorExpression operator="BooleanAnd">
                                <methodInvokeExpression methodName="Equals">
                                  <target>
                                    <propertyReferenceExpression name="Name">
                                      <variableReferenceExpression name="p"/>
                                    </propertyReferenceExpression>
                                  </target>
                                  <parameters>
                                    <primitiveExpression value="Query"/>
                                  </parameters>
                                </methodInvokeExpression>
                                <unaryOperatorExpression operator="IsNotNullOrEmpty">
                                  <variableReferenceExpression name="q"/>
                                </unaryOperatorExpression>
                              </binaryOperatorExpression>
                            </condition>
                            <trueStatements>
                              <methodInvokeExpression methodName="SetParameters">
                                <target>
                                  <variableReferenceExpression name="report"/>
                                </target>
                                <parameters>
                                  <objectCreateExpression type="ReportParameter">
                                    <parameters>
                                      <primitiveExpression value="Query"/>
                                      <methodInvokeExpression methodName="UrlEncode">
                                        <target>
                                          <typeReferenceExpression type="HttpUtility"/>
                                        </target>
                                        <parameters>
                                          <variableReferenceExpression name="q"/>
                                        </parameters>
                                      </methodInvokeExpression>
                                    </parameters>
                                  </objectCreateExpression>
                                </parameters>
                              </methodInvokeExpression>
                            </trueStatements>
                          </conditionStatement>
                        </statements>
                      </foreachStatement>
                      <methodInvokeExpression methodName="SetBasePermissionsForSandboxAppDomain">
                        <target>
                          <variableReferenceExpression name="report"/>
                        </target>
                        <parameters>
                          <objectCreateExpression type="System.Security.PermissionSet">
                            <parameters>
                              <propertyReferenceExpression name="Unrestricted">
                                <typeReferenceExpression type="System.Security.Permissions.PermissionState"/>
                              </propertyReferenceExpression>
                            </parameters>
                          </objectCreateExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </xsl:if>
                    <assignStatement>
                      <variableReferenceExpression name="data"/>
                      <methodInvokeExpression methodName="Render">
                        <target>
                          <variableReferenceExpression name="report"/>
                        </target>
                        <parameters>
                          <variableReferenceExpression name="reportFormat"/>
                          <propertyReferenceExpression name="DefaultDeviceInfo"/>
                          <directionExpression direction="Out">
                            <variableReferenceExpression name="mimeType"/>
                          </directionExpression>
                          <directionExpression direction="Out">
                            <variableReferenceExpression name="encoding"/>
                          </directionExpression>
                          <directionExpression direction="Out">
                            <variableReferenceExpression name="fileNameExtension"/>
                          </directionExpression>
                          <directionExpression direction="Out">
                            <variableReferenceExpression name="streams"/>
                          </directionExpression>
                          <directionExpression direction="Out">
                            <variableReferenceExpression name="warnings"/>
                          </directionExpression>
                        </parameters>
                      </methodInvokeExpression>
                    </assignStatement>
                  </statements>
                </usingStatement>
                <methodReturnStatement>
                  <objectCreateExpression type="ReportData">
                    <parameters>
                      <variableReferenceExpression name="data"/>
                      <variableReferenceExpression name="mimeType"/>
                      <variableReferenceExpression name="fileNameExtension"/>
                      <variableReferenceExpression name="encoding"/>
                    </parameters>
                  </objectCreateExpression>
                </methodReturnStatement>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
        <!-- class ReportBase -->
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
