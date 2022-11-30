<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  exclude-result-prefixes="msxsl"
>
  <xsl:param name="Namespace"/>
  <xsl:param name="Host"/>
  <xsl:output method="text"/>
  <xsl:variable name="Provider" select="document('../_Config/CodeOnTime.CodeDom.xml')//config:provider[@name=parent::config:providers/@default]"/>

  <xsl:template match="/">
    <xsl:if test="$Host = 'SharePoint'">
      <xsl:text>&lt;%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %&gt;
</xsl:text>
    </xsl:if>
    <xsl:text>&lt;%@ WebHandler Language="</xsl:text>
    <xsl:value-of select="$Provider/@language"/>
    <xsl:text>" Class="</xsl:text>
    <xsl:value-of select="$Namespace"/>
    <xsl:if test="$Host = 'SharePoint'">
      <xsl:text>.WebParts</xsl:text>
    </xsl:if>
    <xsl:text>.Handlers.Export" %&gt;

</xsl:text>
  </xsl:template>
</xsl:stylesheet>
