<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl a"
    xmlns:a="urn:schemas-codeontime-com:business-objects"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="DiscoveryDepth" select="3"/>
  <xsl:param name="DatabaseObjectGenerate"/>
  <xsl:param name="DataModel" select="'required2'"/>

  <msxsl:script language="C#" implements-prefix="a">
    <![CDATA[
        private System.Collections.Generic.List<string> _children = new System.Collections.Generic.List<string>();
        public bool Reset() {
            _children.Clear();
            return true;
        }
        public bool IsUsed(string name) {
            if (_children.Contains(name))
                return true;
            _children.Add(name);
            return false;
        }
        ]]>
  </msxsl:script>

  <xsl:variable name="Objects" select="//a:businessObject"/>

  <xsl:template match="/">
    <map>
      <xsl:if test="$DatabaseObjectGenerate != 'Controllers'">
        <xsl:for-each select="$Objects[not(@surrogateSchema=preceding-sibling::*/@surrogateSchema)]">
          <xsl:sort select="@timestamp"/>
          <xsl:variable name="dummy" select="a:Reset()"/>
          <xsl:call-template name="BuildLevel">
            <xsl:with-param name="Schema" select="@surrogateSchema"/>
            <xsl:with-param name="Parent"/>
            <xsl:with-param name="Depth">
              <xsl:choose>
                <xsl:when test="$DataModel='required'">
                  <xsl:value-of select="$DiscoveryDepth"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="0"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
    </map>
  </xsl:template>

  <xsl:template name="BuildLevel">
    <xsl:param name="Schema"/>
    <xsl:param name="Parent"/>
    <xsl:param name="Depth" select="0"/>
    <xsl:variable name="Peers" select="$Objects[@surrogateSchema=$Schema and (not($Parent) or .//a:field/a:items/@businessObject=$Parent/@name)]"/>
    <xsl:for-each select="$Peers">
      <xsl:sort select="count($Objects[@surrogateSchema=$Schema and .//a:field/a:items/@businessObject=current()/@name])" order="descending"/>
      <node name="{@name}" refs="{count($Objects[@surrogateSchema = $Schema and .//a:field/a:items/@businessObject=current()/@name])}" depth="{$Depth}" schema="{@surrogateSchema}" label="{@label}" schemaLabel="{@surrogateSchemaLabel}">
        <!--<xsl:if test="not($Parent) or @name!=$Parent/@name">-->
        <xsl:if test="not(.//a:field[@isPrimaryKey='true'])">
          <xsl:attribute name="parent">
            <xsl:text>Reports</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="(not($Parent) or not(a:IsUsed(@name))) and $Depth &lt; $DiscoveryDepth">
          <xsl:call-template name="BuildLevel">
            <xsl:with-param name="Schema" select="$Schema"/>
            <xsl:with-param name="Parent" select="self::*"/>
            <xsl:with-param name="Depth" select="$Depth + 1"/>
          </xsl:call-template>
        </xsl:if>
      </node>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
