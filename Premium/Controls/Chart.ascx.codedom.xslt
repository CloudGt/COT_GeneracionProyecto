<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"  xmlns:c="urn:schemas-codeontime-com:data-aquarium"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a app c"
>
  <xsl:output method="xml" indent="yes" />

  <xsl:param name="Namespace"/>
  <xsl:param name="Name"/>

  <xsl:template match="c:view">
    <xsl:variable name="XValue" select="c:dataFields/c:dataField[starts-with(@chart,'XValue')]"/>
    <xsl:variable name="YValueMembers" select="c:dataFields/c:dataField[@chart!='' and @fieldName!=$XValue/@fieldName]"/>
    <compileUnit>
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.DataVisualization.Charting"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
      </imports>
      <types>
        <!-- class Controls_XXXXX -->
        <typeDeclaration name="Controls_{$Name}" isPartial="true">
          <baseTypes>
            <typeReference type="System.Web.UI.UserControl"/>
          </baseTypes>
          <members>
            <!-- method Page_Load(object, EventArgs) -->
            <memberMethod name="Page_Load">
              <attributes family="true" final="true"/>
              <parameters>
                <parameter type="System.Object" name="sender"/>
                <parameter type="EventArgs" name="e"/>
              </parameters>
              <statements>
              </statements>
            </memberMethod>
            <xsl:if test="$XValue and $YValueMembers">
              <memberMethod name="DataBind">
                <attributes public="true" override="true"/>
                <statements>
                  <methodInvokeExpression methodName="DataBind">
                    <target>
                      <baseReferenceExpression/>
                    </target>
                  </methodInvokeExpression>
                  <xsl:for-each select="$YValueMembers[@aggregate!='']">
                    <xsl:variable name="Field" select="ancestor::c:dataController/c:fields/c:field[@name=$XValue/@fieldName]"/>
                    <xsl:choose>
                      <xsl:when test="starts-with($Field/@type, 'Date') or $Field/@type='Time'">
                        <methodInvokeExpression methodName="Group">
                          <target>
                            <propertyReferenceExpression name="DataManipulator">
                              <propertyReferenceExpression name="Chart1"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression>
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="@aggregate='Average'">
                                    <xsl:text>Ave</xsl:text>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="@aggregate"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <xsl:text>, X:Center</xsl:text>
                              </xsl:attribute>
                            </primitiveExpression>
                            <primitiveExpression>
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="$XValue/@chart='XValue,Weeks2'">
                                    <xsl:text>2</xsl:text>
                                  </xsl:when>
                                  <xsl:when test="$XValue/@chart='XValue,Quarters'">
                                    <xsl:text>3</xsl:text>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:text>1</xsl:text>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </primitiveExpression>
                            <propertyReferenceExpression>
                              <xsl:attribute name="name">
                                <xsl:choose>
                                  <xsl:when test="$XValue/@chart='XValue,Hours'">
                                    <xsl:text>Hours</xsl:text>
                                  </xsl:when>
                                  <xsl:when test="$XValue/@chart='XValue,Days'">
                                    <xsl:text>Days</xsl:text>
                                  </xsl:when>
                                  <xsl:when test="$XValue/@chart='XValue,Weeks'">
                                    <xsl:text>Weeks</xsl:text>
                                  </xsl:when>
                                  <xsl:when test="$XValue/@chart='XValue,Weeks2'">
                                    <xsl:text>Weeks</xsl:text>
                                  </xsl:when>
                                  <xsl:when test="$XValue/@chart='XValue,Months'">
                                    <xsl:text>Months</xsl:text>
                                  </xsl:when>
                                  <xsl:when test="$XValue/@chart='XValue,Quarters'">
                                    <xsl:text>Months</xsl:text>
                                  </xsl:when>
                                  <xsl:when test="$XValue/@chart='XValue,Years'">
                                    <xsl:text>Years</xsl:text>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:text>Months</xsl:text>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                              <typeReferenceExpression type="IntervalType"/>
                            </propertyReferenceExpression>
                            <primitiveExpression value="{@fieldName}"/>
                          </parameters>
                        </methodInvokeExpression>
                      </xsl:when>
                      <xsl:otherwise>
                        <methodInvokeExpression methodName="GroupByAxisLabel">
                          <target>
                            <propertyReferenceExpression name="DataManipulator">
                              <propertyReferenceExpression name="Chart1"/>
                            </propertyReferenceExpression>
                          </target>
                          <parameters>
                            <primitiveExpression>
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="@aggregate='Average'">
                                    <xsl:text>Ave</xsl:text>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="@aggregate"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </primitiveExpression>
                            <primitiveExpression value="{@fieldName}"/>
                          </parameters>
                        </methodInvokeExpression>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:for-each>
                  <xsl:for-each select="$YValueMembers[contains(@chart, '-')]">
                    <assignStatement>
                      <arrayIndexerExpression>
                        <target>
                          <arrayIndexerExpression>
                            <target>
                              <propertyReferenceExpression name="Series">
                                <propertyReferenceExpression name="Chart1"/>
                              </propertyReferenceExpression>
                            </target>
                            <indices>
                              <primitiveExpression value="{@fieldName}"/>
                            </indices>
                          </arrayIndexerExpression>
                        </target>
                        <indices>
                          <primitiveExpression value="DrawingStyle"/>
                        </indices>
                      </arrayIndexerExpression>
                      <primitiveExpression value="{substring-after(@chart,'-')}"/>
                    </assignStatement>
                  </xsl:for-each>
                </statements>
              </memberMethod>
            </xsl:if>
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
