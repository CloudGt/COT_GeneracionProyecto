<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.codeontime.com/2008/codedom-compiler"  xmlns:a="urn:schemas-codeontime-com:data-aquarium-project"
    xmlns:app="urn:schemas-codeontime-com:data-aquarium-application"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a app"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="Host" select="''"/>
  <xsl:param name="Namespace"/>
  <xsl:param name="Name"/>

  <xsl:template match="app:page">

    <compileUnit>
      <xsl:if test="$Host='DotNetNuke'">
        <xsl:attribute name="namespace">
          <xsl:value-of select="$Namespace"/>
          <xsl:text>.WebApp</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <imports>
        <namespaceImport name="System"/>
        <namespaceImport name="System.Collections.Generic"/>
        <namespaceImport name="System.Linq"/>
        <namespaceImport name="System.Web"/>
        <namespaceImport name="System.Web.UI"/>
        <namespaceImport name="System.Web.UI.WebControls"/>
      </imports>
      <types>
        <!-- class _Default -->
        <typeDeclaration name="Pages_{$Name}" isPartial="true">
          <baseTypes>
            <!--<typeReference type="System.Web.UI.Page"/>-->
            <typeReference>
              <xsl:attribute name="type">
                <xsl:value-of select="$Namespace"/>
                <xsl:choose>
                  <xsl:when test="$Host='DotNetNuke'">
                    <xsl:text>.Web.ControlBase</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>.Web.PageBase</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </typeReference>
          </baseTypes>
          <members>
            <xsl:if test="$Host!='DotNetNuke'">
              <!-- property CssClass -->
              <memberProperty type="System.String" name="CssClass">
                <attributes public="true" final="true"/>
                <getStatements>
                  <methodReturnStatement>
                    <primitiveExpression>
                      <xsl:attribute name="value">
                        <xsl:value-of select="@style"/>
                        <xsl:if test="@customStyle!=''">
                          <xsl:if test="@style!=''">
                            <xsl:text> </xsl:text>
                          </xsl:if>
                          <xsl:value-of select="@customStyle"/>
                        </xsl:if>
                        <xsl:if test="not(contains(@path,'|')) and (@style='Generic' or @style='')">
                          <xsl:text> HomePage</xsl:text>
                        </xsl:if>
                      </xsl:attribute>
                    </primitiveExpression>
                  </methodReturnStatement>
                </getStatements>
              </memberProperty>
              <!-- property Device -->
              <xsl:if test="@device!=''">
                <memberProperty type="System.String" name="Device">
                  <attributes public="true" override="true"/>
                  <getStatements>
                    <methodReturnStatement>
                      <primitiveExpression>
                        <xsl:attribute name="value">
                          <xsl:choose>
                            <xsl:when test="@device='Desktop'">
                              <xsl:text>desktop</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>touch</xsl:otherwise>
                          </xsl:choose>
                        </xsl:attribute>
                      </primitiveExpression>
                    </methodReturnStatement>
                  </getStatements>
                </memberProperty>
              </xsl:if>
            </xsl:if>
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
          </members>
        </typeDeclaration>
      </types>
    </compileUnit>
  </xsl:template>
</xsl:stylesheet>
