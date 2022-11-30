<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:config="http://www.codeontime.com/2008/codedom-configuration"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"  exclude-result-prefixes="msxsl"
>
  <xsl:param name="Namespace"/>
  <xsl:param name="CodedomProviderName"/>
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&lt;%@ Page CodeBehind="Site.aspx.</xsl:text>
    <xsl:choose>
      <xsl:when test="$CodedomProviderName='CSharp'">cs</xsl:when>
      <xsl:otherwise>vb</xsl:otherwise>
    </xsl:choose>
    <xsl:text>" Inherits="</xsl:text>
    <xsl:value-of select="$Namespace"/>
    <xsl:text>.Handlers.Site" ValidateRequest="false" %&gt;
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
