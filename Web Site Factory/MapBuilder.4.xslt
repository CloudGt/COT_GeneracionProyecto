<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns="urn:codeontime:data-map"
    exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"  />


  <xsl:variable name="NumberOfTopLevelNodes" select="4"/>

  <xsl:variable name="AllSchemas" select="/map/node[not(preceding-sibling::node/@schema = @schema)]"/>
  <xsl:variable name="Schemas" select="$AllSchemas[not(@schema='dbo')]"/>
  <xsl:variable name="TopLevelNodes">
    <xsl:choose>
      <xsl:when test="count($Schemas)>1">
        <xsl:value-of select="count($AllSchemas)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$NumberOfTopLevelNodes"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <map>
      <xsl:choose>
        <xsl:when test="count($Schemas)>1 or (count($Schemas)=1 and count($AllSchemas[@schema='dbo']))>0">
          <xsl:for-each select="$AllSchemas">
            <node name="{@schema}_Home" schema="{@schema}" label="{@schemaLabel}" type="Content">
              <!--<xsl:for-each select="@*">
								<xsl:copy/>
							</xsl:for-each>
							<xsl:apply-templates select="//self::node[@schema=current()/@schema and @name!=current()/@name]" mode="SchemaMatching"/>-->
              <xsl:apply-templates select="/map/node[@schema=current()/@schema]" mode="SchemaMatching"/>
            </node>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="map/node[count(preceding-sibling::node)&lt;=$TopLevelNodes and not(@parent='Reports')]"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="ReportNodes" select="/map//node[@parent='Reports' and count($Schemas[not(contains(@name,'_'))])&lt;=1]"/>
      <xsl:if test="$ReportNodes">
        <node name="AllReports" label="^ReportsPath^Reports^ReportsPath^">
          <xsl:apply-templates select="$ReportNodes">
            <xsl:with-param name="IsReports" select="'true'"/>
          </xsl:apply-templates>
        </node>
      </xsl:if>
    </map>
  </xsl:template>

  <xsl:template match="node">
    <xsl:param name="IsReports" select="'false'"/>
      <node>
        <xsl:for-each select="@*">
          <xsl:copy/>
        </xsl:for-each>
        <xsl:apply-templates/>
        <xsl:if test="parent::map and count(preceding-sibling::node)=$TopLevelNodes and $IsReports='false'">
          <xsl:apply-templates select="/map/node[count(preceding-sibling::node)&gt;$TopLevelNodes and not(@parent)]"/>
        </xsl:if>
      </node>
  </xsl:template>

  <xsl:template match="node" mode="SchemaMatching">
    <xsl:if test="not(@parent='Reports')">
      <node>
        <xsl:for-each select="@*[name()!='schemaLabel']">
          <xsl:copy/>
        </xsl:for-each>
        <xsl:apply-templates mode="SchemaMatching"/>
      </node>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
