<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
>
  <xsl:param name="Namespace"/>
  <xsl:param name="TargetFramework"/>
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
        <namespaceImport name="System.Web"/>
        <namespaceImport name="{$Namespace}.Data"/>
        <namespaceImport name="{$Namespace}.Services"/>
      </imports>
      <types>
        <!-- class Theme -->
        <typeDeclaration name="Theme" isPartial="true">
          <baseTypes>
            <typeReference type="GenericHandlerBase"/>
            <typeReference type="IHttpHandler"/>
            <typeReference type="System.Web.SessionState.IRequiresSessionState"/>
          </baseTypes>
          <members>
            <!-- property IsReusable -->
            <memberProperty type="System.Boolean" name="IsReusable" privateImplementationType="IHttpHandler">
              <attributes/>
              <getStatements>
                <methodReturnStatement>
                  <primitiveExpression value="true"/>
                </methodReturnStatement>
              </getStatements>
            </memberProperty>
            <!-- IHttpHandler.ProcessRequest(context)-->
            <memberMethod name="ProcessRequest" privateImplementationType="IHttpHandler">
              <attributes/>
              <parameters>
                <parameter type="HttpContext" name="context"/>
              </parameters>
              <statements>
                <variableDeclarationStatement type="System.String" name="theme">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="QueryString">
                          <propertyReferenceExpression name="Request">
                            <variableReferenceExpression name="context"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="theme"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="accent">
                  <init>
                    <arrayIndexerExpression>
                      <target>
                        <propertyReferenceExpression name="QueryString">
                          <propertyReferenceExpression name="Request">
                            <variableReferenceExpression name="context"/>
                          </propertyReferenceExpression>
                        </propertyReferenceExpression>
                      </target>
                      <indices>
                        <primitiveExpression value="accent"/>
                      </indices>
                    </arrayIndexerExpression>
                  </init>
                </variableDeclarationStatement>
                <conditionStatement>
                  <condition>
                    <binaryOperatorExpression operator="BooleanOr">
                      <unaryOperatorExpression operator="IsNullOrEmpty">
                        <variableReferenceExpression name="theme"/>
                      </unaryOperatorExpression>
                      <unaryOperatorExpression operator="IsNullOrEmpty">
                        <variableReferenceExpression name="accent"/>
                      </unaryOperatorExpression>
                    </binaryOperatorExpression>
                  </condition>
                  <trueStatements>
                    <throwExceptionStatement>
                      <objectCreateExpression type="HttpException">
                        <parameters>
                          <primitiveExpression value="400"/>
                          <primitiveExpression value="Bad Request"/>
                        </parameters>
                      </objectCreateExpression>
                    </throwExceptionStatement>
                  </trueStatements>
                </conditionStatement>
                <variableDeclarationStatement type="ApplicationServices" name="services">
                  <init>
                    <objectCreateExpression type="ApplicationServices"/>
                  </init>
                </variableDeclarationStatement>
                <variableDeclarationStatement type="System.String" name="css">
                  <init>
                    <methodInvokeExpression methodName="ToString">
                      <target>
                        <objectCreateExpression type="StylesheetGenerator">
                          <parameters>
                            <variableReferenceExpression name="theme"/>
                            <variableReferenceExpression name="accent"/>
                          </parameters>
                        </objectCreateExpression>
                      </target>
                    </methodInvokeExpression>
                  </init>
                </variableDeclarationStatement>
                <assignStatement>
                  <propertyReferenceExpression name="ContentType">
                    <propertyReferenceExpression name="Response">
                      <variableReferenceExpression name="context"/>
                    </propertyReferenceExpression>
                  </propertyReferenceExpression>
                  <primitiveExpression value="text/css"/>
                </assignStatement>
                <variableDeclarationStatement type="HttpCachePolicy" name="cache">
                  <init>
                    <propertyReferenceExpression name="Cache">
                      <propertyReferenceExpression name="Response">
                        <variableReferenceExpression name="context"/>
                      </propertyReferenceExpression>
                    </propertyReferenceExpression>
                  </init>
                </variableDeclarationStatement>
                <methodInvokeExpression methodName="SetCacheability">
                  <target>
                    <variableReferenceExpression name="cache"/>
                  </target>
                  <parameters>
                    <propertyReferenceExpression name="Public">
                      <typeReferenceExpression type="HttpCacheability"/>
                    </propertyReferenceExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="SetOmitVaryStar">
                  <target>
                    <variableReferenceExpression name="cache"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="SetExpires">
                  <target>
                    <variableReferenceExpression name="cache"/>
                  </target>
                  <parameters>
                    <methodInvokeExpression methodName="AddDays">
                      <target>
                        <propertyReferenceExpression name="Now">
                          <typeReferenceExpression type="System.DateTime"/>
                        </propertyReferenceExpression>
                      </target>
                      <parameters>
                        <primitiveExpression value="365"/>
                      </parameters>
                    </methodInvokeExpression>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="SetValidUntilExpires">
                  <target>
                    <variableReferenceExpression name="cache"/>
                  </target>
                  <parameters>
                    <primitiveExpression value="true"/>
                  </parameters>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="SetLastModifiedFromFileDependencies">
                  <target>
                    <variableReferenceExpression name="cache"/>
                  </target>
                </methodInvokeExpression>
                <methodInvokeExpression methodName="CompressOutput">
                  <target>
                    <typeReferenceExpression type="ApplicationServices"/>
                  </target>
                  <parameters>
                    <variableReferenceExpression name="context"/>
                    <variableReferenceExpression name="css"/>
                  </parameters>
                </methodInvokeExpression>
              </statements>
            </memberMethod>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
